var updateDivs = document.getElementsByClassName("clickable");

for (var i = 0; i < updateDivs.length; i++) {
    updateDivs[i].addEventListener('click', (event) => {
        if (!event.target.createdInput) {
            var initialValue = event.target.firstElementChild.innerText;
            var paramName = event.target.id;
            event.target.innerHTML = "";
            if (paramName == "date") {
                initialValue = "dd-mm-yyyy HH:mm";
                appendTooltip(event.target, "Format: dd-mm-yyyy hh:mm   Use 24-hour system");
            }
            var element = document.createElement('input');
            element.className = 'update_field';
            element.type = 'text';
            element.value = initialValue;
            element.name = paramName;
            event.target.appendChild(element);
            element.focus();
            element.select();
        }
        event.target.createdInput = true;
    })
}

function appendTooltip(element, text) {
    var paragraph = document.createElement('p');
    paragraph.className = "toolTip";
    paragraph.innerHTML = text;
    element.appendChild(paragraph);
}