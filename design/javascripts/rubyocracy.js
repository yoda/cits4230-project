// We're using jQuery to make cross browser events and the like simpler.
// Shown below, we're using our own code for a lot of things but instead
// of reinventing the wheel we've chosen to use jQuery to cover all of the
// edge cases.

var Rubyocracy = {};
(function($, r) {
  
  // Helpers for getting elements.
  r.byID   = function(id)   { return document.getElementById(id) };
  r.byName = function(name) { return document.getElementsByName(name)[0]; } 
  
  
  // Validation items.
  r.clearErrors       = function(element) {
    element.innerHTML = "";
  };
  r.errorContainerFor = function(element) {
    var parent = element.parentElement;
    var errorContainer = null;
    for(var i = 0 ; i < parent.childNodes.length; i++) {
      var child = parent.childNodes[i];
      var css_class = child.getAttribute && child.getAttribute("class").toString();
      if(css_class && css_class.indexOf("field-errors") > -1) {
        errorContainer = child;
        break;
      }
    }
    if(!errorContainer) {
      errorContainer = document.createElement("p");
      errorContainer.setAttribute("class", "fieldErrors");
      parent.appendChild(errorContainer);
    }
    return errorContainer;
  };
  r.addValidatorFor   = function(name, validator) {
    if(!r.validators[name])
      r.validators[name] = [];
    r.validators[name].push(validator);
  };
  r.validatorsFor     = function(name) {
    return r.validators[name] || [];
  };
  r.validate          = function(name) {
    var field = r.byName(name);
    if(!field) return true;
    var errors = r.errorContainerFor(field);
    r.clearErrors(errors);
    var validators = r.validatorsFor(name);
    var errorMessages = [];
    for(var i = 0; i < validators.length; i++) {
      var result = validators[i](field);
      if(result) errorMessages.push(result);
    }
    if(errorMessages.length < 1) {
      errors.style.display = "none";
      return true;
    } else {
      errors.innerText = errorMessages.join(", ");
      errors.style.display = "block";
      return false;
    }
  };
  
  r.validateAll = function() {
    var valid = true;
    for(key in r.validators) {
      if(r.validators.hasOwnProperty(key)) {
        valid = valid && r.validate(key);
      }
    }
  };
  
  r.setupValidators = function() {
    var forms = document.getElementsByName("form");
    for(var i = 0; i < forms.length; i++) {
      $(forms[i]).submit(function() {
        return r.validateAll();
      })
    }
  }
  
  r.validators = {};
  
  // Example use:
  
  r.addValidatorFor("blog[author]", function(field) {
    if(field.value == "") return "must be filled in";
  });
  
  // The simple hide / show message on the home page.
  r.setupWelcomeMessage = function() {
    var welcomeContainer = r.byID("rubyocracy-introduction");
    if(!welcomeContainer) return;
    var hideWelcomeContainer = r.byID("hide-introduction");
    if(!hideWelcomeContainer) return;
    $(hideWelcomeContainer).click(function() {
      welcomeContainer.style.display = "none";
      return false;
    });
  };

  r.setupAll = function() {
    r.setupWelcomeMessage();
    r.setupValidators();
  };
  
  $(document).ready(function() {
    r.setupAll();
  });
  
})(jQuery, Rubyocracy);
