//required / validations
ko.extenders.required = function (target, overrideMessage) {
    //add some sub-observables to our observable
    target.hasError = ko.observable();
    target.validationMessage = ko.observable();

    //define a function to do validation
    function validate(newValue) {
        target.hasError(newValue ? false : true);
        target.validationMessage(newValue ? "" : overrideMessage || "This field is required");
    }

    //initial validation
    validate(target());

    //validate whenever the value changes
    target.subscribe(validate);

    //return the original observable
    return target;
};

function Sprinkle(model) {
    $.getJSON("API/" + model + "?Resource", function (dataModelResource) {

        jQuery.globalEval(CreateResource(dataModelResource, modelName));

        $.getJSON("API/" + model, function (dataModel) {
            for (i in dataModel) {
                for (name in data) {
                    eval("data." + name + "(dataModel[i][name])")
                }
            }

        }).success(function () {
            var viewModel = ko.mapping.fromJS(data);
            ko.applyBindings(viewModel);
        })
         .error(function () { alert("error"); })
    })


    function CreateResource(dataModelResource) {
        var strData = "";
        for (i in dataModelResource) {
            if (i > 0) { strData += "," }
            strData += dataModelResource[i]["Property"] + ": ko.observable('')";
            for (j in dataModelResource[i]["Validations"]) {
                strData += ".extend({ required: '" + dataModelResource[i]["Validations"][j]["Message"] + "' })";
            }
            strData += " "
        }
        strData = "var data = { " + strData + "}";
        return strData;
    }
}


