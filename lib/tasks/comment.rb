class Comment
  attr_accessor :type, :content

  def initialize (type)
    @type = type
    @content = []
  end
end