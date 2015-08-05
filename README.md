# json2html
Ruby gem allowing json to be converted very simply to html

## Usage
Not configuration available as yet - simply pass in a json string and receive html.

## Currently Handles
Single json number mapping `{"name":value}` to `<div id='name'>value</div>`
Single json string mapping `{"name":"value"}` to `<div id='name'>value</div>`
Single json null mapping `{"name":"value"}` to `<div id='name'></div>`

## TODO
Array   => ul?
Object  => ul?

Allow custom configuration for different types, including selecting which elements the custom config applies to. E.g. if
you wanted all numbers whose identifier is cost preceded by a dollar sign it might be something like...

config do
    number '<div id=##identifier>$##value</div>', /cost/
end
