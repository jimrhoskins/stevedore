require 'fog'

class Layer
  def initialize(file)
    @file = file
  end


  def content
    @file.body
  end

  class <<self

    def storage
      @storage ||= Fog::Storage.new(
        provider: 'Local',
        local_root: Rails.root.join('tmp')
      )
    end

    def directory
      @directory ||= storage.directories.create(
        key: "layer-storage",
        public: false
      )
    end

    def put(id, stream)
      directory.files.create(
        key: id,
        body: stream,
        public: false
      )
    end

    def find(id)
      file = directory.files.get(id)
      file ? new(file) : nil
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
