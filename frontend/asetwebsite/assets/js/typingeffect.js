const words = ["Cloud Support Specialist", "AWS Professional", "IT Graduate", "Cloud Technology Enthusiast", "Technology Professional"]; 
let wordIndex = 0;  
let charIndex = 0;  
let typing = true;   

const typingSpeed = 100;    
const deletingSpeed = 50;   
const delayBetweenWords = 1500; 

function typeEffect() {
    const displayElement = document.getElementById("typewriter");
    const currentWord = words[wordIndex];

    if (typing) {
        displayElement.textContent = currentWord.slice(0, charIndex++);
        if (charIndex > currentWord.length) {
            typing = false;  
            setTimeout(typeEffect, delayBetweenWords); 
            return;
        }
    } else {
        displayElement.textContent = currentWord.slice(0, --charIndex);
        if (charIndex === 0) {
            typing = true;  
            wordIndex = (wordIndex + 1) % words.length;  
        }
    }

    setTimeout(typeEffect, typing ? typingSpeed : deletingSpeed);
}

window.onload = () => {
    typeEffect();
};
