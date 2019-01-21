# frozen_string_literal: true

module Gem2exe
  module Cli
    class SetupCommand < Clamp::Command
      option "--sudo", :flag, "use sudo"

      def execute
        $stderr.puts "installing rubyc ..."
        Gem2exe.download_rubyc
        $stderr.puts "... done"

        if Gem2exe.platform == "darwin"
          runner_opts = {
            shell: true, output: true, prepend: {
              stdboth: "  brew: "
            }
          }

          $stderr.puts "installing dependencies with brew ..."
          Runner.run! "brew install squashfs || brew upgrade squashfs || true", runner_opts
          Runner.run! "brew install openssl || brew upgrade openssl || true", runner_opts
          Runner.run! "curl -sL https://curl.haxx.se/ca/cacert.pem > /usr/local/etc/openssl/cacert.pem", runner_opts
        else
          runner_opts = {
            sudo: sudo?, shell: true, output: true, prepend: {
              stdboth: "  apt-get: "
            }
          }
          $stderr.puts "installing dependencies with apt-get ..."

          Runner.run! "apt-get update", runner_opts
          Runner.run! "apt-get install -y squashfs-tools build-essential bison curl", runner_opts
        end

        puts "... done"
      end
    end
  end
end
