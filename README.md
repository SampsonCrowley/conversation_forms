# ConversationForms
A Rails port of [conversational-form](https://github.com/SampsonCrowley/conversational-form) inspired by [SPACE10](https://space10-community.github.io/conversational-form/)

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

require the js:
```javascript
//= require conversation_forms
```

and require the css:
```css
*= require conversation_forms
```

## Usage

on any pages that you want to use a conversation form, simply set the form's ID to `convo-form`
conversation forms will automatically detect your form's method and action

```html
<form id="my-form-element" cf-form-element ...
```

That's It!


# DOM Element attributes

### cf-questions
* to map questions directly to a tag.
* seperate by | to allow for more questions, app will shuffle.
```html
<input type="text" cf-questions="What is your name?|Please tell me your name." ..
```

### {One way value-binding} with cf-questions:
For cui-questions, add {previous-answer} to insert the value from the previous user-answer.
```html
<input type="text" cf-questions="Hello {previous-answer}" ..
```
previous input could be firstname.

```html
<input type="text" cf-questions="So you want to travel to {previous-answer}" ..
```
previous input could be a select:option list with countries.

### cf-label
* set a label to the field, [type="radio"|"checkbox"]
```html
<input type="radio" cf-label="Subscribe to newsletter" ..
```

### cf-error
* to map error messages directly to a tag.
* seperate by | to allow for more error, app will shuffle.
```html
<input type="text" cf-error="Text is wrong wrong|Input is not right" ..
```


# Validations

###
* Checks user input against the supplied regex
```html
<input type="text" pattern="^[0-9a-zA-Z-']*$" ..
```

### cf-validation-contains
* Checks if the input value is one of a pipe-separated list of values
* e.g. the following will check if the input is equal to "a", "b", "c", or "d"
```html
<input type="text" cf-validation-contains="a|b|c|d" ..
```

### cf-validation-email
* Basic email regex check to ensure the value contains only 1 "@" symbol and at lease 1 "." after the "@"
```html
<input type="text" cf-validation-email ..
```

### pattern/cf-validation-matches
* This will check user input against the supplied regex
* Using "pattern" is recommended over cf-validation-matches when possible as it is a native HTML5 attribute
```html
<input type="text" pattern="^[0-9a-zA-Z-']*$" ..
<input type="text" cf-validation-matches="^[0-9a-zA-Z-']*$" ..
```

### max/cf-validation-max
* Ensure User input is less than or equal to a maximum
* Using "max" is recommended over cf-validation-max when possible as it is a native HTML5 attribute
```html
<input type="number" max=9 ..
<input type="text" cf-validation-max=9 ..
```

### min/cf-validation-min
* Ensure User input is greater than or equal to a minimum
* Using "min" is recommended over cf-validation-min when possible as it is a native HTML5 attribute
```html
<input type="number" min=1 ..
<input type="text" cf-validation-min=1 ..
```

### required
* to require a field set the required attribute as normal
```html
<input type="text" required ..
<input type="text" required="true" ..
<input type="text" required="required" ..
```

### cf-validation-custom
* Check input against a custom Javascript function before submitting
* OBS. eval is used.
* two parameters are passed to your custom method
	* value: String, the value of the input field
	* tag: ITag, the actual DOM tag
```html
<input type="text" cf-validation-custom="window.validateFunction" ..
```

# Advanced Initialization

**cf-context**  
If you want to have the ConversationalForm appended to a certain element (when auto-instantiating) then add attribute `cf-context` to an element, otherwise the ConversationalForm will be appended to the form's parent element.
```html
<div cf-context ...>
```

**cf-prevent-autofocus**  
If you don't want to have the UserInput to auto focus.

```html
<form id="my-form-element" cf-form-element cf-prevent-autofocus>
```

## Customization

For more control over the output exclude the attribute `cf-form-element` from the form element and instantiate either with vanilla JS or jQuery:

### Self-instantiate with vanilla JS

```javascript
new cf.ConversationalForm({
	formEl: <HTMLFormElement>,
	// dictionaryData?: {}, // empty will throw error, see Dictionaty.ts for values
	// dictionaryAI?: {}, // empty will throw error, see Dictionaty.ts for values
	// context?: // context of where to append the ConversationalForm (see also cf-context attribute)
	// tags?: tags, // pass in custom tags (when prevent the auto-instantiation of ConversationalForm)
	// submitCallback?: () => void | HTMLButtonElement // custom submit callback if button[type=submit] || form.submit() is not wanted..
	// userImage: "..." //base64 || image url
});
```


### Instantiate with jQuery

```javascript
$("form").conversationalForm();
```


## Parameters to pass the constructor of ConversationalForm: <<a name="ConversationalFormOptions"></a>ConversationalFormOptions>
* **formEl**: HTMLFormElement | string
* **context**?: HTMLElement | string
	* Set the context of where the ConversationalForm will be appended to
	* If not set then ConversationalForm will get appended to document.body
* **tags**?: Array<ITag>
	* [cf.Tag.createTag(element), ...]
* **dictionaryData**?: object
	* Possibility to overwrite the default [dictionary](https://github.com/space10-community/conversational-form/blob/master/src/scripts/cf/data/Dictionary.ts), empty will throw error, see [Dictionaty.ts](https://github.com/space10-community/conversational-form/blob/master/src/scripts/cf/data/Dictionary.ts) for values
* **dictionaryAI**?: object
	* Possibility to overwrite the default [dictionary](https://github.com/space10-community/conversational-form/blob/master/src/scripts/cf/data/Dictionary.ts), empty will throw error, see [Dictionaty.ts](https://github.com/space10-community/conversational-form/blob/master/src/scripts/cf/data/Dictionary.ts) for values
* **submitCallback**?: () => void | HTMLButtonElement
	* An alternative way to submit the form. Can be a Function or an HTMLButtonElement (click will be called). If not defined the component will search in the formEl after a button[type=”submit”] and call click() if not button is found final fallback will be to call submit() on formEl.
* **userImage**?: string
	* Set a different userImage. "..." //base64 || image url


## Map your own tags
The Conversational Form automatically detects the accepted tags in the passed in form element.
If this is not desired then you are able to define your own **tags**, and pass them into the constructor.:

```javascript
var fields = [].slice.call(formEl.querySelectorAll("input, select, button"), 0);
for (var i = 0; i < fields.length; i++) {
	var element = fields[i];
	tags.push(cf.Tag.createTag(element));
}
```

Tags can then be set in the instantiation object, see [ConversationalFormOptions](#ConversationalFormOptions)

# Public API
When instantiating ConversationalForm a reference to the instance will be available in window scope.

```javascript
window.ConversationalForm
```

using this reference you are able to remove the ConversationalForm by calling:

```javascript
window.ConversationalForm.remove();
```

# Overwrite styles
You can overwrite the UI with your own styles. Please see the source [styles](https://github.com/SampsonCrowley/conversational-form/tree/master/src/styles/cf) files for more info.


# Contribute to ConversationalForm

We welcome contributions in the form of bug reports, pull requests, or thoughtful discussions in the [GitHub issue tracker](https://github.com/SampsonCrowley/conversation_forms/issues).

ConversationalForm is a concept originally by [SPACE10](https://www.space10.io/). Brought to life by [Felix Nielsen](http://twitter.com/flexmotion), [RWATGG](http://rwatgg.com). Designed by [Charlie Isslander](https://twitter.com/charlieissland).

Ported By [Sampson Crowley](https://github.com/SampsonCrowley)

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
