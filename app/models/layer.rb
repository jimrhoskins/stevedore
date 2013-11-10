require 'fog'

class Layer
  class <<self
    attr_accessor :storage_options
    attr_accessor :storage_bucket

    def storage
      @storage ||= Fog::Storage.new(storage_options)
    end

    def directory
      @directory ||= storage.directories.create(
        key: storage_bucket,
        public: false
      )
    end

    def put(id, stream)
      directory.files.create(
        key: id,
        body: stream,
        public: false
      )
      true
    end

    def head(id)
      directory.files.head(id)
    end

    def get(id, &block)
      directory.files.get(id, &block)
    end

    def size(id)
      head = directory.files.head(id)
      head ? head.content_length : 0
    end

  end
end
