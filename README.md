# JsTextRails

Transform text files into strings on a global JavaScript object.

Why do this?  Your Rails application might serve up a single-page web
application, which requires text assets (like SVGs).  You need these assets to
render your application, and you don't want to fetch them via AJAX (to avoid
lag), nor embed them in the returned HTML (to keep the HTML response small).

Especially in the case of SVGs, their contents are needed so they can be
inserted into the document inline, so they can be styled with CSS.

Support is currently available for the following text file types:

- .svg files

If you'd like more, please submit a PR.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'js-text-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install js-text-rails

## Usage

### Ruby on Rails

After adding the gem to your Gemfile, clear your cache:

```sh
rake tmp:clear
```

To disable it just remove transformer:

```ruby
JsTextRails.uninstall(Rails.application.assets)
```

### Sprockets

If you use Sinatra or other non-Rails frameworks with Sprockets,
just connect your Sprockets environment with it:

```ruby
assets = Sprockets::Environment.new do |env|
  # Your assets settings
end

require 'js-text-rails'
JsTextRails.install(assets)
```

### In your application

`require` your files, e.g. in `app/assets/javascripts/application.js`:

```js
//= require_tree ../images/icons
```

Where `app/assets/images/icons` contains the file `envelope.svg`.

Anywhere in your application's JavaScript code, access the text file contents
via the global `SVG` variable:

```js
var envelopeIcon = SVG['icons/envelope'];
// Do something with `envelopeIcon`...
```

Here is a practical example of inserting an SVG inline:

```js
document.querySelector('#email-icon').innerHTML = SVG['icons/envelope'];
```

Or, in a JST template:

```html
<span id="email-icon"><%= SVG['icons/envelope'] %></span> Email me at <%- @email %>!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/cloversites/js-text-rails.

## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).

