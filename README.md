# Auphonic (Ruby Gem)

A ruby wrapper and CLI for the Auphonic API.

* https://auphonic.com/api-docs/

Happily engineered while working on [VoiceRepublic](http://voicerepublic.com).


## Installation

Add this line to your application's Gemfile:

    gem 'auphonic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auphonic


## Setup

Create a file with your credentials

    echo "login: yourlogin\npasswd: secret" > ~/.auphonic


## Usage (as CLI)

### create, upload, start, wait, download

Creates a production based on the first (!) preset it will find,
uploads the file to it, starts the production, waits for the processing
to finish, and downloads all output files.

    auphonic process <audiofile>

The result might look like this...

    % auphonic process t42-u355-1393431156.flv 
    create new production
    upload t42-u355-1393431156.flv
    start production
    Status: Waiting
    Status: Audio Processing
    Status: Waiting
    Status: Audio Encoding
    Status: Done
    download output files
    t42-u355-1393431156.mp3
    t42-u355-1393431156.ogg


## Usage (as library)

### Query data

    Auphonic::Preset.all
    Auphonic::Production.all
    Auphonic::Service.all
    Auphonic::Info::ServiceType.all
    Auphonic::Info::Algorithm.all
    Auphonic::Info::OutputFile.all
    Auphonic::Info::ProductionStatus.all

These queries returns arrays of data entities. All data entities have
an accessor data which holds the hash returned by the API.

### Example

    preset = Preset.all.first
    production = preset.new_production
    production.save
    production.upload 'somefile.wav'
    production.start
    sleep 10 until production.reload.status == 'Done'
    production.download


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
