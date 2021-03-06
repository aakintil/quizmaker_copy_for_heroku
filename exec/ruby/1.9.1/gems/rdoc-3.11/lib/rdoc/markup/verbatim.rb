##
# A section of verbatim text

class RDoc::Markup::Verbatim < RDoc::Markup::Raw

  ##
  # Format of this verbatim section

  attr_accessor :format

  def initialize *parts # :nodoc:
    super

    @format = nil
  end

  ##
  # Calls #accept_verbatim on +visitor+

  def accept visitor
    visitor.accept_verbatim self
  end

  ##
  # Collapses 3+ newlines into two newlines

  def normalize
    parts = []

    newlines = 0

    @parts.each do |part|
      case part
      when /^\s*\n/ then
        newlines += 1
        parts << part if newlines == 1
      else
        newlines = 0
        parts << part
      end
    end

    parts.pop if parts.last =~ /\A\r?\n\z/

    @parts = parts
  end

  ##
  # Is this verbatim section ruby code?

  def ruby?
    @format == :ruby
  end

  ##
  # The text of the section

  def text
    @parts.join
  end

end

