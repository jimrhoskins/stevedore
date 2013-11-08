require 'fog'

class Layer
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

  end
end
