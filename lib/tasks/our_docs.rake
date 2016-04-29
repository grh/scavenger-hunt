require File.expand_path('../comment', __FILE__)

namespace :doc do
  desc 'Write documentation for about.html.erb'
  task :about do
    about = []

    ###########################
    ## READING FROM .rb FILES #
    ###########################

    rbfiles = File.join('**', '*.rb')
    Dir.glob(rbfiles).each do |filename|
      File.open(filename) do |f|
        while line = f.gets
          line.lstrip!; line.chomp!

          if line == '=begin'
            # read the next line and get the type
            type = f.gets.split[1].downcase.to_sym
            # create a new comment object of that type
            comment = Comment.new(type) if type == :about

            while true
              line = f.gets.chomp; line.lstrip!
              case line[0..1]
                when '=e'
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

            about << comment if type == :about
          end
        end
      end
    end

    ####################
    ## WRITING TO VIEW #
    ####################
    #
    ## i.e. about.html.erb
    basedir_str = 'app/views/html'
    provides_str = '<%= provide(:title, "About") %>'
    container_div = '<div class="container">'
    row_div = '<div class="row">'
    col_div = '<div class="col-md-9 col-centered">'
    div_close = '</div>'
    File.open("#{basedir_str}/about.html.erb", 'w') do |f|
      f.puts provides_str
      f.puts container_div

      # page title
      f.puts row_div
      f.puts col_div
      f.puts "<h3>#{about.first.type.to_s.capitalize}</h3>"

      # start iterating over the about comments...
      about.each do |comment|
        comment.content.each do |comment|
          for k, v in comment
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
  
  task :user do
  end 
  
  task :developer do
  end 
  
  task :all => [:about, :user, :developer] do
  end

end

