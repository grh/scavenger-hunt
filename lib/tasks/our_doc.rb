module OurDoc
  class Comment
    attr_accessor :type, :content

    def initialize (type)
      @type = type
      @content = []
    end
  end

  def self.get_comments(t)
    # initialize empty comments array and grab all .rb files
    comments = []
    rbfiles = File.join('**', '*.rb')

    # iterate over every .rb file
    Dir.glob(rbfiles).each do |file|
      File.open(file) do |f|
        while line = f.gets
          # grab each line and remove leading whitespace and newline
          line.lstrip!; line.chomp!

          # similar to rdoc, a comment is signalled by '=begin'
          if line == '=begin'
            # read the next line and get the type
            type = f.gets.split[1].downcase.to_sym

            if type == t
              # create a new comment object of that type
              comment = Comment.new(type) if type == t

              while true
                # keep grabbing lines until '=end'
                line = f.gets.chomp; line.lstrip!

                case line[0..1]
                  when '=e' # end of comment
                    break
                  when '' # skip blank lines
                    next
                  when '= ' # h3 tags
                    comment.content << { h3: line.split[1] }
                  when '* ' # ul and li tags
                    li = []
                    while line[0..1] == '* '
                      li << line.split(' ', 2)[1]
                      line = f.gets.chomp; line.lstrip!
                    end
                    comment.content << { ul:  li }
                  else # p tags
                    str = ''
                    until line.empty?
                      str += line + ' '
                      line = f.gets.chomp; line.lstrip!
                    end
                    comment.content << { p: str }
                end
              end

              comments << comment if type == t
            end
          end
        end
      end
    end

    return comments
  end

  def self.write_comments(comments)
    type = comments.first.type.to_s
    basedir_str = 'app/views/html'
    provides_str = "<%= provide(:title, '#{type.capitalize}') %>"
    container_div = '<div class="container">'
    row_div = '<div class="row">'
    col_div = '<div class="col-md-9 col-centered">'
    div_close = '</div>'
    File.open("#{basedir_str}/#{type}_doc.html.erb", 'w') do |f|
      f.puts provides_str
      f.puts container_div

      # page title
      f.puts row_div
      f.puts col_div
      f.puts "<h3>#{type.capitalize}</h3>"

      # start iterating over the about comments...
      comments.each do |comment|
        comment.content.each do |item|
          for k, v in item
            case k
              when :h3
                f.puts div_close
                f.puts div_close
                f.puts row_div
                f.puts col_div
                f.puts ("<h3>" + v.capitalize + "</h3>")
              when :p
                f.puts ("<p>" + v + "</p>")
              when :ul
                f.puts '<ul>'
                v.each do |li|
                  f.puts "<li>#{li}</li>"
                end
                f.puts '</ul>'
            end
          end
        end
      end

      f.puts div_close
      f.puts div_close
      f.puts div_close
    end
  end
end
