module Nanoc::CLI

  class HelpCommand < Command

    def name
      'help'
    end

    def aliases
      []
    end

    def short_desc
      'show help for a command'
    end

    def long_desc
      'blah.'
    end

    def usage
      "nanoc help [command]"
    end

    def run(options, arguments)
      # Check arguments
      if arguments.size > 1
        puts "usage: #{usage}"
        exit 1
      end

      if arguments.length == 0
        # Build help text
        text = ''

        # Add title
        text << "nanoc, a static site compiler written in Ruby.\n"

        # Add available commands
        text << "\n"
        text << "Available commands:\n"
        text << "\n"
        @base.commands.sort.each do |command|
          text << sprintf("    %-20s %s\n", command.name, command.short_desc)
        end

        # Add global options
        text << "\n"
        text << "Global options:\n"
        text << "\n"
        @base.global_option_definitions.sort { |x,y| x[:long] <=> y[:long] }.each do |opt_def|
          text << sprintf("    -%1s --%-15s %s\n", opt_def[:short], opt_def[:long], opt_def[:desc])
        end
 
        # Display text
        puts text
      elsif arguments.length == 1
        command = @base.command_named(arguments[0])
        puts command.help
      end
    end

  end

end
