package HTML::LandingPages::Javascript;


use strict;

sub render {
	my ($class,$self) =@_;
	return <<JS;
	  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	 <script>
	var parameters;
	function addParameter(field, value)
	{
	 var name = field.name,
		 existingValue = parameters[name],
		 isArray = \$.isArray(existingValue);

	 if (existingValue)
	 {
	  if (!isArray)
	  {
	   parameters[name] = [existingValue];
	  }
	  else
	  {
	   existingValue[existingValue.length] = value;
	  }
	 }
	 else
	 {
	  addKeyValue(name,value);
	 }
	}

	function addKeyValue(name, value) {
		parameters[name] = value;
	}

	function prepareParameters(e)
	{
	 e.preventDefault();
	 parameters = {};
	 \$(e.target).find("input[name], select[name], textarea[name]").each( 
	  function ()
	  {
	   var tagName = this.tagName,
	   required = !!this.getAttribute("required"),
	   type =
			(tagName === "TEXTAREA"?
			  "text":
			 tagName === "SELECT"?
			  "select":
			  this.getAttribute("type")) ||
			"text",
	   value =
			tagName === "SELECT"?
			 this.options[this.selectedIndex].value || "":
			((type === "checkbox" || type === "radio") && !this.checked)?
			 "":
			 this.value,
	   pattern = this.getAttribute("pattern");

	   if (type === "image" || type === "button" ||
		   type === "submit" || type === "reset" || type === "file")
	   {
		return;
	   }

	   addParameter(this, value);
	  }

	  );
	 addKeyValue('template', '$self->{name}');
	 addKeyValue('submited', '1');

	 function success() {e.target.parentNode.innerHTML='$self->{onSuccess}'}
	 function onFailed() {e.target.parentNode.innerHTML='$self->{onFailed}'}
	 \$.ajax({url: e.target.action, data: parameters,type:"$self->{submitMethod}",success:success,error:onFailed});

	}
		\$("form").submit(prepareParameters);
	  </script>
JS

}




1;
