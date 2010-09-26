// We're using jQuery to make cross browser events and the like simpler.
// Shown below, we're using our own code for a lot of things but instead
// of reinventing the wheel we've chosen to use jQuery to cover all of the
// edge cases.

var Rubyocracy = {};
(function($, r) {
  
  // Basic URL Regexp from http://www.go4expert.com/forums/showthread.php?t=2262
  r.urlRegex = /https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?/;
  
  // Helpers for getting elements.
  r.byID   = function(id)   { return document.getElementById(id) };
  r.byName = function(name) { return document.getElementsByName(name)[0]; };
  
  r.hasClass = function(element, c) {
    if(!element.getAttribute) return false
    var classNames = (element.getAttribute('class') || '').split(' ');
    for(var i = 0; i < classNames.length; i++) {
      if(classNames[i] == c) return true;
    }
    return false;
  };
  
  // Validation items.
  r.clearErrors       = function(element) {
    element.innerHTML = '';
  };
  
  r.errorContainerFor = function(element) {
    var parent = element.parentElement;
    for(var i = 0 ; i < parent.childNodes.length; i++) {
      var child = parent.childNodes[i];
      if(r.hasClass(child, 'field-errors')) {
        return child;
      }
    }
    // We didn't find it, so add a new one.
    errorContainer = document.createElement('p');
    errorContainer.setAttribute('class', 'field-errors');
    parent.appendChild(errorContainer);
    return errorContainer;
  };
  
  r.addValidatorFor   = function(name, validator) {
    if(!r.validators[name]) {
      r.validators[name] = [];
    }
    r.validators[name].push(validator);
  };
  
  r.validatorsFor     = function(name) {
    return r.validators[name] || [];
  };
  r.validate          = function(name, ignore_errors) {
    if(typeof(ignore_errors) == 'undefined')
      ignore_errors = false;
    var field = r.byName(name);
    if(!field) return true;
    var errors = r.errorContainerFor(field);
    if(!ignore_errors) r.clearErrors(errors);
    var validators = r.validatorsFor(name);
    var errorMessages = [];
    for(var i = 0; i < validators.length; i++) {
      var result = validators[i](field);
      if(result) errorMessages.push(result);
    }
    var isValid = errorMessages.length < 1;
    if(!ignore_errors) {
      if(isValid) {
        errors.style.display = 'none';
      } else {
        errors.innerText = errorMessages.join(', ');
        errors.style.display = 'block';
      }
    }
    return isValid;
  };
  
  r.validateAll = function() {
    var valid = true;
    for(key in r.validators) {
      if(r.validators.hasOwnProperty(key)) {
        valid = r.validate(key) && valid;
      }
    }
    return valid;
  };
  
  r.isBlank = function(value) {
    if(value === null) return true;
    if(value.length && value.length === 0) return true;
    return value.toString().replace(/^\s*/, '').replace(/\s*$/, '').length == 0;
  }
  
  r.setupValidators = function() {
    var forms = document.getElementsByTagName('form');
    for(var i = 0; i < forms.length; i++) {
      $(forms[i]).submit(function(e) {
        return r.validateAll();
      })
    }
  }
  
  r.validators = {};
  
  // Example use:
  
  r.addValidatorFor('blog[author]', function(field) {
    if(r.isBlank(field.value)) return 'Author name must be filled in';
  });
  
  r.addValidatorFor('blog[url]', function(field) {
    if(r.isBlank(field.value)) return 'URL must be filled in';
    if(!r.urlRegex.test(field.value)) {
      return 'The given url does not look like a valid address';
    }
  });
  
  r.addValidatorFor('comment[contents]', function(field) {
    if(r.isBlank(field.value)) return 'Comment must be filled in'
  });
  
  // The simple hide / show message on the home page.
  r.setupWelcomeMessage = function() {
    var welcomeContainer = r.byID('rubyocracy-introduction');
    if(!welcomeContainer) return;
    var hideWelcomeContainer = r.byID('hide-introduction');
    if(!hideWelcomeContainer) return;
    $(hideWelcomeContainer).click(function() {
      welcomeContainer.style.display = 'none';
      return false;
    });
  };
  
  r.conditionallyShowBlogPreview = function() {
    if(r.blogShowTimeout) {
      clearTimeout(r.blogShowTimeout)
      r.blogShowTimeout = null;
    };
    var blogPreview        = r.byID('blog-preview');
    var blogPreviewLoading = r.byID('blog-preview-loading');
    var innerBlogPreview   = r.byID('inner-blog-preview');
    if(!blogPreview) return;
    var isValid = r.validate('blog[url]', true);
    innerBlogPreview.innerText       = isValid ? 'Loading...' : 'Enter a valid url to preview.';
    blogPreviewLoading.style.display = 'block';
    blogPreview.style.display        = 'none';
    r.blogShowTimeout = setTimeout(function() {
      if(isValid) {
        blogPreviewLoading.style.display = 'none';
        blogPreview.style.display        = 'block';

      } else {
        blogPreviewLoading.style.display = 'block';
        blogPreview.style.display        = 'none';
      }
    }, 1000);
  }
  
  r.blogShowTimeout = null;
  
  r.setupExampleBlogViewer = function() {
    var blogURL = r.byName('blog[url]');
    if(!blogURL) return;
    $(blogURL).keyup(function() {
      r.conditionallyShowBlogPreview();
    })
    r.conditionallyShowBlogPreview();
  };

  r.setupAll = function() {
    r.setupWelcomeMessage();
    r.setupValidators();
    r.setupExampleBlogViewer();
  };
  
  $(document).ready(function() {
    r.setupAll();
  });
  
})(jQuery, Rubyocracy);
