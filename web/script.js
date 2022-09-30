/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function add(i) {
    var main = document.getElementById("main");
    var y = document.createElement("INPUT");
    y.setAttribute("type", "radio");
    y.setAttribute("value", i + 1);
    y.setAttribute("class", "radoOption");
    y.setAttribute("name", "correctOptions");
    y.setAttribute("required", true);
    var x = document.createElement("INPUT");
    x.setAttribute("type", "text");
    x.setAttribute("placeholder", "Name");
    x.setAttribute("class", "someInput");
    x.setAttribute("name", i + 1);
    x.setAttribute("required", true);
    var br = document.createElement("br");
    br.setAttribute("class", "br");
    main.appendChild(y);
    main.appendChild(x);
    main.appendChild(br);
    var ad = "add(" + (i + 1) + ")";
    var addButton = document.getElementById("addButton");
    if (i == 9) {
        addButton.hidden = true;
    }
    addButton.setAttribute('onclick', ad);
//                addButton.value = ad;
    var rem = "remove(" + (i + 1) + ")";
    var removeButton = document.getElementById("removeButton");
    if (i == 2) {
        removeButton.hidden = false;
    }
    removeButton.setAttribute('onclick', rem);
//                removeButton.value = rem;
    document.getElementById("countInput").value = (i + 1);
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
    if (i == 10) {
        addButton.hidden = false;
    }
    addButton.setAttribute('onclick', ad);
//                addButton.value = ad;
    var rem = "remove(" + (i - 1) + ")";
    var removeButton = document.getElementById("removeButton");
    if (i == 3) {
        removeButton.hidden = true;
    }
    removeButton.setAttribute('onclick', rem);
//                removeButton.value = rem;
    document.getElementById("countInput").value = (i - 1);
}

