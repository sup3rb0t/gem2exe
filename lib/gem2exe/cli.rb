require 'clamp'
Clamp.allow_options_after_parameters = true

require_relative "cli/version_command"
require_relative "cli/setup_command"
require_relative "cli/uninstall_command"

require_relative "cli/local_command"
require_relative "cli/remote_command"

require_relative "cli/root_command"
