describe Fastlane do
  describe Fastlane::FastFile do
    describe "Swift-Doc" do
      it "default use case" do
        result = Fastlane::FastFile.new.parse("lane :test do
          swift_doc
        end").runner.execute(:test)

        expect(result).to eq("swift-doc generate")
      end

      describe "generate options" do # TODO: ask about repalcement for shared_examples...
        it "adds minimum access level" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              minimum_access_level: 'internal'
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc generate --minimum-access-level internal")
        end

        it "adds inputs" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              input_paths: ['~/path/one', '~/path/two with space']
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc generate --inputs \\~/path/one, \\~/path/two\\ with\\ space")
        end

        it "adds output path" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              output_path: '~/dev/stuff/'
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc generate --output \\~/dev/stuff/")
        end

        it "adds module name" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              module_name: 'SomeAppFrameworkModule'
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc generate --module-name SomeAppFrameworkModule")
        end

        it "adds format" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              output_format: :html
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc generate --format html")
        end

        it "adds base url" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              base_url: 'project_subfolder/'
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc generate --base-url project_subfolder/")
        end
      end

      describe "coverage options" do
        it "becomes coverage mode" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              mode: :coverage
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc coverage")
        end

        it "adds minimum access level" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              mode: :coverage,
              minimum_access_level: 'internal'
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc coverage --minimum-access-level internal")
        end

        it "adds inputs" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              mode: :coverage,
              input_paths: ['~/path/one', '~/path/two with space']
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc coverage --inputs \\~/path/one, \\~/path/two\\ with\\ space")
        end

        it "adds output path" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              mode: :coverage,
              output_path: '~/dev/stuff/'
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc coverage --output \\~/dev/stuff/")
        end
      end

      describe "diagram options" do
        it "becomes diagram mode" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              mode: :diagram
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc diagram")
        end

        it "adds minimum access level" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              mode: :diagram,
              minimum_access_level: 'internal'
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc diagram --minimum-access-level internal")
        end

        it "adds inputs" do
          result = Fastlane::FastFile.new.parse("lane :test do
            swift_doc(
              mode: :diagram,
              input_paths: ['~/path/one', '~/path/two with space']
            )
          end").runner.execute(:test)

          expect(result).to eq("swift-doc diagram --inputs \\~/path/one, \\~/path/two\\ with\\ space")
        end
      end
    end
  end
end
