module CIM
  # Array of CIM::Schema::Qualifier
  class Qualifiers < Array
    #
    # check if qualifier exists
    #
    alias array_include? include?
    def include? q,type=:null
      #	puts "#{self}.include? #{q}:#{type}"
      case q
      when CIM::Schema::Qualifier
	q = q.definition
      when CIM::Meta::Qualifier
	# nothing
      when String
	q = CIM::Meta::Qualifier.new(q,type)
      when Symbol
	q = CIM::Meta::Qualifier.new(q,type)
      else
	raise "Unknown parameter in #{self.class}.include?"
      end
      self.array_include? q
    end
    #
    # get qualifier by name and type
    #
    alias array_access []
    def [] q,type=:null
      case q
      when Fixnum
	return self.array_access[q]
      when CIM::Schema::Qualifier
	q = q.definition
      when CIM::Meta::Qualifier
	# nothing
      when String
	q = CIM::Meta::Qualifier.new(q,type)
      when Symbol
	q = CIM::Meta::Qualifier.new(q,type)
      else
	raise "Unknown parameter in #{self.class}.[]"
      end
      i = self.index(q)
      return self.array_access(i) if i
      i
    end
    def to_s
      return "" if self.empty?
      q = self.join(", ")
      return "[#{q}]"
    end
  end
end