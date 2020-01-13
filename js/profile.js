// Author Christos Pappas
// For this to work you need a button with class "toggleBtn" named "More".
// When clicked, all items that have the same class with the id of the button will be toggled, hopefully...


// Gather all the buttons
let toggleButtons = document.getElementsByClassName("toggleBtn");

// Add event listener to every button
for (let i = 0; i < toggleButtons.length; i++) {
    toggleButtons[i].addEventListener('click', () => {

        // Update button name
        if (toggleButtons[i].innerHTML == "More") {
            toggleButtons[i].innerHTML = "Less";
        } else {
            toggleButtons[i].innerHTML = "More";
        }

        // Get elements associated with the current button
        let elements = document.getElementsByClassName(toggleButtons[i].id);

        // Toggle every associated element
        for (let j = 0; j < elements.length; j++) {
            elements[j].style.display = elements[j].style.display === 'none' ? '' : 'none';
        }
    })
}