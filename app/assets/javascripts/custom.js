document.addEventListener("DOMContentLoaded", function() {
    var form = document.getElementById("order-form");
    
    form.addEventListener("submit", function(event) {
      var isValid = form.checkValidity();
      if (!isValid) {
        event.preventDefault();
        event.stopPropagation();
        alert("Please fill out all required fields correctly.");
      }
      form.classList.add("was-validated");
    });
  
    var inputs = form.querySelectorAll("input[required], select[required]");
    inputs.forEach(function(input) {
      input.addEventListener("input", function() {
        if (input.checkValidity()) {
          input.classList.add("is-valid");
          input.classList.remove("is-invalid");
        } else {
          input.classList.add("is-invalid");
          input.classList.remove("is-valid");
        }
      });
    });
  });
  