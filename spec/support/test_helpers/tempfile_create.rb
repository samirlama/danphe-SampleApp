require 'tempfile'
module TestHelpers
    module TempfileCreate
        def create_tempfile
            file = Tempfile.new(['hello', '.jpg'])
        end
        def generate_file_path
            file = create_tempfile
            file.read
            file.path
        end
    end
end