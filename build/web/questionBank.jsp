<%-- 
    Document   : questionBank
    Created on : Sep 27, 2022, 3:12:55 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
        <body>
        <form id="mainform" onsubmit="return validateForm()">
            <div id = "main">
                <input type="radio" value="1" class="radoOption" name="correctOptions" required="true"/><input type="text" placeholder="Name" class="someInput" name="option1" required="true"/>
                <br>
                <input type="radio" value="2" class="radoOption" name="correctOptions" required="true"/><input type="text" placeholder="Name" class="someInput" name="option2" required="true"/>
                <br>
            </div>
            <input type="button" id="addButton" value="Add" onclick="add(2)" />
            <input type="button" id="removeButton" value="Remove" onclick="remove(2)" hidden="true"/>
            <input type="submit"/>
        </form>

        <script>
            function add(i) {
                var main = document.getElementById("main");
                var y = document.createElement("INPUT");
                y.setAttribute("type", "radio");
                y.setAttribute("value", i + 1);
                y.setAttribute("class", "radoOption");
                y.setAttribute("name", "correctOptions");
                y.setAttribute("required",true);
                var x = document.createElement("INPUT");
                x.setAttribute("type", "text");
                x.setAttribute("placeholder", "Name");
                x.setAttribute("class", "someInput");
                x.setAttribute("name", "option"+ (i + 1));
                x.setAttribute("required",true);
                var br = document.createElement("br");
                br.setAttribute("class", "br");
                main.appendChild(y);
//                main.createTextNode("\u00A0");
                main.appendChild(x);
                main.appendChild(br);
                var ad = "add(" + (i + 1) + ")";
                var addButton = document.getElementById("addButton");
                if (i == 9){
                    addButton.hidden = true;
                }
                addButton.setAttribute('onclick', ad);
//                addButton.value = ad;
                var rem = "remove(" + (i + 1) + ")";
                var removeButton = document.getElementById("removeButton");
                if(i == 2){
                    removeButton.hidden = false;
                }
                removeButton.setAttribute('onclick', rem);
//                removeButton.value = rem;
            }
            function remove(i) {
                var main = document.getElementById("main");
                var childs = main.getElementsByClassName("someInput");
                var radio = main.getElementsByClassName("radoOption");
                var br = main.getElementsByClassName("br");
                if (childs.length > 0) {
                    main.removeChild(childs[childs.length - 1]);
                    main.removeChild(br[br.length - 1]);
                    main.removeChild(radio[radio.length - 1]);
                }
                var ad = "add(" + (i - 1) + ")";
                var addButton = document.getElementById("addButton");
                if (i == 10){
                    addButton.hidden = false;
                }
                addButton.setAttribute('onclick', ad);
//                addButton.value = ad;
                var rem = "remove(" + (i - 1) + ")";
                var removeButton = document.getElementById("removeButton");
                if(i == 3){
                    removeButton.hidden = true;
                }
                removeButton.setAttribute('onclick', rem);
//                removeButton.value = rem;
            }
        </script>
    </body>
</html>