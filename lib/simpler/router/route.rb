module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = make_regexp(path)
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        @method == method && path.match(@path)
      end

      def parse_params(path)
        @params = path.match(@path).named_captures.transform_keys!(&:to_sym)
      end

      private

      def make_regexp(path)
        path.gsub(/(:([a-z0-9]+))/i, '(?<\2>[a-z0-9]+)')
      end

    end
  end
end
