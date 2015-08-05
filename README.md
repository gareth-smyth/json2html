# json2html
Ruby gem allowing json to be converted very simply to html

## Usage
Does not handle anything beyond a single level of JSON
No configuration available as yet - simply pass in a json string and receive html.

## Currently Handles
Single json number mapping `{"name":value}` to `<div id='name'>value</div>`  
Single json string mapping `{"name":"value"}` to `<div id='name'>value</div>`  
Single json null mapping `{"name":null}` to `<div id='name'></div>`  
Single json true mapping `{"name":true}` to `<div id='name'>true</div>`  
Single json false mapping `{"name":false}` to `<div id='name'>false</div>`  

Array mapping `{"name":["a","b","c"]}` to  
  
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

    <div id='name'>
      <div id='name_child1'>a</div>
      <div id='name_child2'>b</div>
    </div>  
    
Complex example

    {
        "child1":{ "grandchild1":"value1", "grandchild2":[6,7,8]
        "child2":[ { "grandchild3":"value2" }]
    }
    
would become

    <div id="child1">
        <div id="child1_grandchild1">value1</div>
        <ul id="child1_grandchild2">
            <li><div id="child1_grandchild2_1>6</div></li>
            <li><div id="child1_grandchild2_2>7</div></li>
            <li><div id="child1_grandchild2_3>8</div></li>
        </ul>
    </div>
    <ul id="child2">
        <li>
            <div id="child2_1>
               <div id="child2_1_grandchild3">value2</div>     
            </div>
        </li>
    </ul>

## TODO
1. Hierarchies of objects

2. Allow custom configuration for different types, including selecting which elements the custom config applies to. E.g. if
you wanted all numbers whose identifier is "cost" to be preceded by a dollar sign it might be something like...  

        config do  
            number '<div id=##identifier>$##value</div>', /cost/  
        end
        
3. Allow identifier naming scheme to be changed e.g. attach a prefix to all ids to stop clashes.
 
