// Author: Christos Pappas
// All elements with clickable class, get an onClick listener.
// When clicked they transform to an input box with their contents as initial value

// With the clickable interface you can also add a button with the id 'clickableSubmit'.
// By default it should have "style=display:none;". If one of the clickable elements is clicked, 
// it will change to display: ''; and will therefore appear out of thin air.

let clickableElements = document.getElementsByClassName("clickable");
let submitButton = document.getElementById("clickableSubmit");

for (var i = 0; i < clickableElements.length; i++) {
    clickableElements[i].addEventListener('click', (event) => {
        if (!event.target.createdInput) {
            if (submitButton) {
                submitButton.style.display = ''; // Show submit button
            }
            var paramName = event.target.id;
            var initialValue = event.target.innerText;
            event.target.innerHTML = "";
            if (event.target.nodeName == 'IMG') {
                initialValue = event.target.src; // If it's an image, we use the img src as initial value
            }
            if (paramName == "date") {
                initialValue = "d-m-yyyy HH:mm";
                appendTooltip(event.target, "Format: d-M-yyyy HH:mm   Use 24-hour system");
            }
            var element = document.createElement('input');
            element.className = 'update_field';
            element.type = 'text';
            element.value = initialValue;
            element.name = paramName;
            if (event.target.nodeName == 'IMG') { // If it's an image, replace it with the input box
                event.target.parentNode.replaceChild(element, event.target);
            } else {
                event.target.appendChild(element);
            }
            element.focus();
            element.select();
        }
        event.target.createdInput = true;
    })
}

// Use this to append a tooltip to the element. Style is using class "toolTip"
function appendTooltip(element, text) {
    var paragraph = document.createElement('p');
    paragraph.className = "toolTip";
    paragraph.innerHTML = text;
    element.appendChild(paragraph);
}