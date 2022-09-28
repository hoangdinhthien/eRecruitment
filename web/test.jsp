
<%-- 
    Document   : test
    Created on : Sep 27, 2022, 3:26:24 PM
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
        <form id="mainform" >
            <div id = "main">

            </div>
            <input type="button" class="add" value="add" onclick="add()"></input>
        </form>

        <script>
            function addchange(i) {
                add();
                addUpdate(i);

            }
            function add() {
                var main = document.getElementById("main");
                var x = document.createElement("INPUT");
                x.setAttribute("type", "text");
                x.setAttribute("placeholder", "Name");
                x.setAttribute("class", "someInput");
                main.appendChild(x);
                var y = document.createElement("INPUT");
                y.setAttribute("type", "button");
                y.setAttribute("value", "remove");
                y.setAttribute("onclick", "removeOne(2)");
                y.setAttribute("class", "remove");
                main.appendChild(y);
                var br = document.createElement("br");
                br.setAttribute("class", "br");
                main.appendChild(br);
                var add = "add(" + (i + 1) + ")";
                var mainform = document.getElementById("mainform");
                mainform.getElementsByClassName("add").onclick = add;
            }
            function addUpdate(i) {

                var add = "add(" + (i + 1) + ")";
                var mainform = document.getElementById("mainform");
                mainform.getElementsByClassName("add").onclick = add;
            }
            }


            function removeOne(i) {
                var main = document.getElementById("main");
                var childs = main.getElementsByClassName("someInput");
                var remove = main.getElementsByClassName("remove");
                var br = main.getElementsByClassName("br");
                if (childs.length > 0) {
                    main.removeChild(childs[i - 1]);
                    main.removeChild(remove[i - 1]);
                    main.removeChild(br[i - 1]);
                }
            }

        </script>
    </body>
</html>