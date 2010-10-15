#
# cim/named_element.rb - class CIM::NamedElement
#
# A pure-Ruby implementation of the CIM meta model.
#
# Copyright (c) 2010 Klaus Kämpf <kkaempf@suse.de>
#
# Licensed under the Ruby license
#
module CIM
  #
  # The NamedElement is a basic building block for the CIM schema, acting as a base class
  # for Class and Property
  #
  # A NamedElement has a name (String) and qualifiers (Qualifiers)
  #
  class NamedElement
    attr_reader :name, :qualifiers
    #
    # Create a NamedElement with a name and qualifiers
    #
    def initialize name, qualifiers = nil
      raise "NamedElement must have a name" unless name
      @name = name.to_s
      unless qualifiers.nil?
	unless qualifiers.is_a?(QualifierSet)
	  if qualifiers.kind_of?(::Enumerable) && qualifiers.empty?
	    qualifiers = nil 
	  else
	    qualifiers = QualifierSet.new qualifiers
	  end
	end
      end
      @qualifiers = qualifiers
    end
    #
    # Add a Qualifier to the NamedElements qualifiers
    #
    def << qualifier
      @qualifiers << (normalize qualifier)
    end
    #
    # Check if a Qualifier is included 
    #
    def include? qualifier
      @qualifiers.include?(normalize qualifier)
    end
    alias includes? include?
    #
    # Returns a string representation of the NamedElement
    #
    def to_s
      s = ""
      s << "[#{@qualifiers.join(', ')}]\n " if @qualifiers
      s << "#{@name}"
    end
    private
    def normalize qualifier
      unless qualifier.is_a?(CIM::Qualifier)
	qualifier = Qualifier.new(qualifier)
      end
      qualifier
    end
  end
end
