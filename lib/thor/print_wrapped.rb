# Based on issues with the long_desc method formatting
# https://github.com/erikhuda/thor/issues/398#issuecomment-237400762
class Thor
  module Shell
    class Basic
      def print_wrapped(message, options = {})
       stdout.puts message.squeeze(" ")
      end
    end
  end
end
