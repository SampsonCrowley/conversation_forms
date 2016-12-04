# ConversationForms
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'conversation_forms'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install conversation_forms
```

Finally require the js:
```bash
//= require conversation_forms
```

## Usage

on any pages that you want to use a conversation form, simply set the form's ID to `convo-form`
conversation forms will automatically detect your form's method and action

```
<form id="convo-form">
  <input type="text" id="test-input" name="test">
</form>
```

That's It!

## Advanced options (recommended)

to set the question for an input, add the `data-question` attribute
```
<input type="text" name="name" data-question="What is your name?">
<input type="text" name="birthday" data-question="What is your birthday? (please enter DD/MM/YYYY)">
<input type="text" name="email" data-question="Thanks! What is the best email for me to reach you at?">
```

obscure the display of user input to the screen, add `data-secure="true"`
```
<input type="text" name="secure-input" data-secure="true">
```
instead of displaying what they submitted, it will dislay the text `[SECURITY FILTERED INPUT]`

NOTE: any fields with `type="password"` or `name="password"` will automatically have the secure flag set. For security purposes, this is not an option you can override.

```
<input type="text" id="password" name="password" data-question="Please enter the password you would to use for your account. (Don't worry, I'm a robot, no one will see it)">
```


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
