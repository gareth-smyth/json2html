# json2html
Ruby gem allowing json to be converted very simply to html

## Usage
If no configuration is passed you can simply pass in a json string and receive html.

    require 'json2html'  
    Json2Html.new.to_html(File.open(my_json_file).read)

See json2html_config_dsl.rb for the default configuration templates.

### Configuration
There are a number of templates which can be configured to allow the output of the to_html method to change.  The 
templates are interpreted as sprintf with the named parameters available shown below.  See 
[Kernel format](http://ruby-doc.org/core-2.2.0/Kernel.html#method-i-format) for more detail.  

####Configuration Elements  

1. node  
    a. key = the full hierarchical key   
    b. value = the node value  
    c. name = the "humanised" node name  
    
2. object_head  
    a. key = the full hierarchical key   
    b. object = the object (not sure how this can actually be used in a format string)  
    c. name = the "humanised" object name 
       
3. object_footer  
    a. key = the full hierarchical key   
    b. object = the object (not sure how this can actually be used in a format string)  
    c. name = the "humanised" object name 
         
4. array_head  
    a. key = the full hierarchical key     
    b. array = the array (not sure how this can actually be used in a format string)    
    c. name = the "humanised" array name   
    
5. array_footer  
    a. key = the full hierarchical key     
    b. array = the array (not sure how this can actually be used in a format string)    
    c. name = the "humanised" array name   
    
6. array_item_head  
    a. key = the full hierarchical key     
    b. array = the array (not sure how this can actually be used in a format string)    
    c. name = the "humanised" array name  
    d. item = the item in the array  
    e. index = the one based index into the array of the current item
    
7. array_item_footer  
    a. key = the full hierarchical key     
    b. array = the array (not sure how this can actually be used in a format string)    
    c. name = the "humanised" array name  
    d. item = the item in the array  
    e. index = the one based index into the array of the current item

## Examples
### Simple examples
Single json number mapping `{"name":value}` to `<div id="name_label">Name</div><div id='name'>value</div>`  
Single json string mapping `{"name":"value"}` to `<div id="name_label">Name</div><div id='name'>value</div>`  
Single json null mapping `{"name":null}` to `<div id="name_label">Name</div><div id='name'></div>`  
Single json true mapping `{"name":true}` to `<div id="name_label">Name</div><div id='name'>true</div>`  
Single json false mapping `{"name":false}` to `<div id="name_label">Name</div><div id='name'>false</div>`  

Array mapping `{"name":["a","b","c"]}` to  
  
    <div id="name_label">Name</div>
    <ul id='name'>  
      <li>  
        <div id='name_1'>a</div>  
      </li>  
      <li>  
        <div id='name_2'>b</div>  
      </li>  
      <li>  
        <div id='name_3'>c</div>  
      </li>  
    </ul>  
    
Object mapping `{"name":{"child1":"a", "child2":"b"}}` to

    <div id="name_label">Name</div>
    <div id='name'>
      <div id="name_child1_label">Child1</div><div id='name_child1'>a</div>
      <div id="name_child2_label">Child1</div><div id='name_child2'>b</div>
    </div>  
    
Complex example

    {
        "child1":{ "grandchild1":"value1", "grandchild2":[6,7,8]
        "child2":[ { "grandchild3":"value2" }]
    }
    
would become

    <div id="child1_label">Child1</div>
    <div id="child1">
        <div id="child1_grandchild1_label">Grandchild1</div><div id="child1_grandchild1">value1</div>
        <div id="child1_grandchild2_label">Grandchild2</div>
        <ul id="child1_grandchild2">
            <li><div id="child1_grandchild2_1>6</div></li>
            <li><div id="child1_grandchild2_2>7</div></li>
            <li><div id="child1_grandchild2_3>8</div></li>
        </ul>
    </div>
    <div id="child2_label">Child2</div>
    <ul id="child2">
        <li>
            <div id="child2_1>
                <div id="child2_1_grandchild3_label">Grandchild3</div>
                <div id="child2_1_grandchild3">value2</div>     
            </div>
        </li>
    </ul>
    
### Configuration Examples

    require 'json2html'  
    json2html = Json2Html.new do
        node '<div><span id="%<key>s_label">%<name>s</span><span id="%<key>s">%<value>s</span></div>'
    end
    
    json2html.to_html(File.open(my_json_file).read)
    
    
## TODO (in no particular order)
1. Allow configuration to be filtered by regexp - so you can have different templates for different nodes/objects/arrays
 based on the name

        config do  
            node '<div id=##identifier>$##value</div>', /cost/  
        end
        
2. Allow identifier naming scheme to be changed e.g. attach a prefix to all ids to stop clashes.

3. Optional html/partial switch so it can create a full html page from the json

4. Command line option

5. Convert the templates from printf to some more fully functional templating engine e.g. haml.
 
