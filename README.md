# GeoClue Ruby Client

This library allows you to interact with GeoClue via D-Bus. This allows you to get the physical location of your computer just based on your WiFi connection.

For further reference:

* [GeoClue Project Description](https://gitlab.freedesktop.org/geoclue/geoclue/wikis/home)
* [The GeoClue D-Bus API](https://www.freedesktop.org/software/geoclue/docs/)

This project is currently only developed and tested on Arch Linux, with plans to port to Ubuntu in the near future. It exists on Arch first because the Ubuntu GeoClue provider is so easy to use, I originally used it from [a simple bash script](https://github.com/shreve/dotfiles/blob/master/bin/location).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'geoclue'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geoclue

Make sure that you have GeoClue installed and running:

    $ sudo systemctl status geoclue

If not, it should be available from your distro's package manager:

    $ pacman -S geoclue

## Usage

Run the executable to get your coordinates

    $ geoclue
    42.12345,-83.12345

Use the `--help` flag for more details

    $ geoclue --help
    Usage: geoclue [option flags]
      Running with no options will print comma-separated coordinates.

      -h --help              print this message

    INFORMATION OPTIONS
      -f --full              fetch all location information
      -a --address           fetch address information (requires fetching coordinates)
      -c --coordinates       fetch your coordinates from GeoClue

    CONFIGURATION OPTIONS
      -t --timeout [int]     set the timeout for each operation
      -n --no-cache          don't use the cache
      -d --print-config      print out all configuration
         --format [fmt]      output format of data in named printf format
                             named options include "tab" and "pipe"
                             default is "%<key>s: %<val>s\n"

## Development

I recommend having a D-Bus debugger tool like [d-feet](https://wiki.gnome.org/Apps/DFeet) in order to inspect the service API. This tool relies entirely on the `org.freedesktop.GeoClue2` system service.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shreve/geoclue-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
