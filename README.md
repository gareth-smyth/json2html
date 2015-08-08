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
Single json number mapping `Json2Html.new.to_html('{"name":1.2}')` to 
    
    <div class="json-node">
        <div class="json-node-name">Name</div>
        <div class="json-node-value">1.2</div>
    </div>  
    
Single json string mapping `Json2Html.new.to_html('{"name":"value"}')` to 
    
    <div class="json-node">
        <div class="json-node-name">Name</div>
        <div class="json-node-value">value</div>
    </div>  
    
Single json null mapping `Json2Html.new.to_html('{"name":null}')` to 
    
    <div class="json-node">
        <div class="json-node-name">Name</div>
        <div class="json-node-value"></div>
    </div>  
    
Single json true mapping `Json2Html.new.to_html('{"name":true}')` to 
    
    <div class="json-node">
        <div class="json-node-name">Name</div>
        <div class="json-node-value">true</div>
    </div>  
    
Single json false mapping `Json2Html.new.to_html('{"name":false}')` to 
    
    <div class="json-node">
        <div class="json-node-name">Name</div>
        <div class="json-node-value">false</div>
    </div>  

Array mapping `Json2Html.new.to_html('{"name":["a","b","c"]}')` to  
  
    <div class="json-array">
        <div class="json-array-name">Name</div>
        <div class="json-array-body">
            <div class="json-array-item">
                <div class="json-node">
                    <div class="json-node-name">1</div>
                    <div class="json-node-value">a</div>
                </div>
            </div>
            <div class="json-array-item">
                <div class="json-node">
                    <div class="json-node-name">2</div>
                    <div class="json-node-value">b</div>
                </div>
            </div>
            <div class="json-array-item">
                <div class="json-node">
                    <div class="json-node-name">3</div>
                    <div class="json-node-value">c</div>
                </div>
            </div>
        </div>
    </div>
    
Object mapping `Json2Html.new.to_html('{"name":{"child1":"a", "child2":"b"}}')` to

    <div class="json-object">
        <div class="json-object-name">Name</div>
        <div class="json-object-body">
            <div class="json-node">
                <div class="json-node-name">Child1</div>
                <div class="json-node-value">a</div>
            </div>
            <div class="json-node">
                <div class="json-node-name">Child2</div>
                <div class="json-node-value">b</div>
            </div>
        </div>
    </div>
    
Complex example

    Json2Html.new.to_html('{"child1":{ "grandchild1":"value1", "grandchild2":[6,7,8], "child2":[ { "grandchild3":"value2" }]}}')
    
would become

    <div class="json-object">
        <div class="json-object-name">Child1</div>
        <div class="json-object-body">
            <div class="json-node">
                <div class="json-node-name">Grandchild1</div>
                <div class="json-node-value">value1</div>
            </div>
            <div class="json-array">
                <div class="json-array-name">Grandchild2</div>
                <div class="json-array-body">
                    <div class="json-array-item">
                        <div class="json-node">
                            <div class="json-node-name">1</div>
                            <div class="json-node-value">6</div>
                        </div>
                    </div>
                    <div class="json-array-item">
                        <div class="json-node">
                            <div class="json-node-name">2</div>
                            <div class="json-node-value">7</div>
                        </div>
                    </div>
                    <div class="json-array-item">
                        <div class="json-node">
                            <div class="json-node-name">3</div>
                            <div class="json-node-value">8</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="json-array">
                <div class="json-array-name">Child2</div>
                <div class="json-array-body">
                    <div class="json-array-item">
                        <div class="json-node">
                            <div class="json-node-name">Grandchild3</div>
                            <div class="json-node-value">value2</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
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
 
