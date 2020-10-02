require "dalli"

##
# Dalli uses `Marshal` as serializer by default. `Marshal` writes extra bytes
# around our data values making them harder to test so we implement a
# Serializer which just writes and reads the exact bytes we give it
#
class NullSerializer
  def self.dump(arg)
    arg
  end

  def self.load(arg)
    arg
  end
end

RSpec.describe "Commands" do
  let(:test_stdout) { StringIO.new }
  let(:test_stderr) { StringIO.new }

  context "when a command can complete without a memcached server" do
    describe "version" do
      it "works" do
        expected_output = "#{VERSION}\n"
        test_argv = ["version"]

        Main.main(argv: test_argv, stdout: test_stdout, stderr: test_stderr)

        expect(test_stdout.string).to eq(expected_output)
      end
    end

    describe "help" do
      it "works" do
        test_argv = ["help"]

        Main.main(argv: test_argv, stdout: test_stdout, stderr: test_stderr)

        expect(test_stdout.string).to match(/A memcached client for developers/)
      end
    end
  end

  context "when a command requires access to a memcached server" do
    let(:dalli_options) do
      { compress: false, serializer: NullSerializer }
    end
    let(:dalli_client) { Dalli::Client.new("localhost:11211", dalli_options) }

    around do |example|
      dalli_client
      example.run
      dalli_client.flush_all # Remove all values from memcached
    end

    describe "ls" do
      it "works" do
        keys = %w[abc def ghi]
        keys.each { |key| dalli_client.set(key, "anything") }
        expected_output = "#{keys.reverse.join("\n")}\n"

        sleep 1 # seems to be required or test cannot reliably see the keys

        test_argv = ["localhost:11211", "ls"]

        Main.main(argv: test_argv, stdout: test_stdout, stderr: test_stderr)

        expect(test_stdout.string).to eq(expected_output)
      end
    end

    describe "get" do
      let(:key) { "abc" }
      let(:value) { "hello there\nnext line\n" }

      it "works" do
        dalli_client.set(key, value)
        sleep 1 # seems to be required or test cannot reliably see the key

        test_argv = ["localhost:11211", "get", key]

        Main.main(argv: test_argv, stdout: test_stdout, stderr: test_stderr)

        expect(test_stdout.string).to eq(value)
      end
    end
  end
end
