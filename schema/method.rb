module CIM
  module Schema
    class Method < CIM::Meta::Feature
      attr_reader :parameters
      def initialize type,name,qualifiers,parameters
	@parameters = parameters
	super type,name,qualifiers
      end
      def to_s
	p = @parameters.join(", ") if @parameters
	"#{super}(#{p})"
      end
    end
  end
end