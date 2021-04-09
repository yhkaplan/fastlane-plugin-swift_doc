require 'fastlane/action'

module Fastlane
  module Actions
    class SwiftDocAction < Action
      def self.run(params)
        if `which swift-doc`.to_s.length == 0 && params[:executable].nil? && !Helper.test?
          UI.user_error!("You have to install swift-doc using `brew install swiftdocorg/formulae/swift-doc` or specify the executable path with the `:executable` option.")
        end

        command = params[:executable] || "swift-doc"
        mode = params[:mode] || :generate
        command << " #{mode}"
        command << optional_flags(params, mode)

        Actions.sh(command)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Generate documentation, documentation coverage, or a class diagram using SwiftDoc"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :executable,
                                       env_name: "FL_SWIFT_DOC_EXECUTABLE",
                                       description: "Path to the `swift-doc` executable on your machine",
                                       type: String,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :mode,
                                       env_name: "FL_SWIFT_DOC_MODE",
                                       description: "SwiftDoc mode: :generate, :coverage, or :diagram",
                                       type: Symbol,
                                       default_value: :generate,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :minimum_access_level,
                                       env_name: "FL_SWIFT_DOC_MINIMUM_ACCESS_LEVEL",
                                       description: "SwiftDoc minimum access level: public, internal, etc",
                                       type: String,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :input_paths,
                                       env_name: "FL_SWIFT_DOC_INPUT_PATHS",
                                       description: "SwiftDoc input paths for Swift files",
                                       type: Array,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :output_path,
                                       env_name: "FL_SWIFT_DOC_OUTPUT_PATH",
                                       description: "The output path for generated files",
                                       type: String,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :module_name,
                                       env_name: "FL_SWIFT_DOC_MODULE_NAME",
                                       description: "The module name to work on",
                                       type: String,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :output_format,
                                       env_name: "FL_SWIFT_DOC_OUTPUT_FORMAT",
                                       description: "The output format: :commonmark or :html",
                                       type: Symbol,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :base_url,
                                       env_name: "FL_SWIFT_DOC_BASE_URL",
                                       description: "The base url to work off of",
                                       type: String,
                                       optional: true)
        ]
      end

      def self.optional_flags(params, mode)
        command = ""
        command << " #{params[:input_paths].map(&:shellescape).join(' ')}" if params[:input_paths]
        command << " --minimum-access-level #{params[:minimum_access_level]}" if params[:minimum_access_level]

        case mode
        when :generate
          command << " --module-name #{params[:module_name]}" if params[:module_name]
          command << " --output #{params[:output_path].shellescape}" if params[:output_path]
          command << " --format #{params[:output_format]}" if params[:output_format]
          command << " --base-url #{params[:base_url].shellescape}" if params[:base_url]
        when :coverage
          command << " --output #{params[:output_path].shellescape}" if params[:output_path]
        when :diagram
          # No unique options here
        else
          UI.user_error!("Unexpected mode: #{mode}")
        end

        return command
      end

      def self.output
      end

      def self.return_value
      end

      def self.authors
        ["Joshua Kaplan"]
      end

      def self.example_code
        [
          'swift_doc',
          'swift_doc(mode: :coverage)',
          'swift_doc(module_name: "FooModule")'
        ]
      end

      def self.category
        :documentation
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
