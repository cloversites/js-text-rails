# JsTextRails

Transform text files into strings on the global JavaScript `TEXT` object.

Why do this?  Your Rails application might serve up a single-page web
application, which requires text assets (like SVGs).  You need these assets to
render your application, and you don't want to fetch them via AJAX (to avoid
lag), nor embed them in the returned HTML (to keep the HTML response small).

Especially in the case of SVGs, their contents are needed so they can be
inserted into the document inline, so they can be styled with CSS.

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

### Ruby

If you need to call it from plain Ruby code, it’s very easy:

```ruby
require 'js-text-rails'
string = JsTextRails.transform("What's up?") # => "'What\\'s up?'"
# As JavaScript source code, the above Ruby string will become: 'What\'s up?'
# Then, when printed to the screen, the text will again look like: What's up?
```

### In your application

`require` your files, e.g. in `app/assets/javascripts/application.js`:

```js
//= require_tree ./icons
```

Where `app/assets/javascripts/icons` contains the file `envelope.jstext.svg`.

Anywhere in your application, access the text file contents via the global
`TEXT` variable:

```js
var envelopeIcon = TEXT['icons/envelope.jstext.svg'];
// Do something with `envelopeIcon`...
```

Here is a practical example of inserting an SVG inline:

```js
function stripXmlDeclaration (content) {
  return content.replace(/^\s*<\?xml(\s)+version=[\'\"](\d)*.(\d)*[\'\"](\s)*\?>/im, '');
}
function getIcon (path) {
  var icon = TEXT['icons/' + path + '.jstext.svg'];
  return stripXmlDeclaration(icon);
}
document.querySelector('#email-icon').innerHTML = getIcon('envelope');
```

Or, in a JST template:

```html
<span id="email-icon"><%= getIcon('envelope') %></span> Email me at <%- @email %>!
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
https://github.com/jacksonrayhamilton/js-text-rails.

## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).

