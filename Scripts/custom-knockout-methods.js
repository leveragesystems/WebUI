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

function Sprinkle(modelName) {
    $.getJSON("API/" + modelName + "?Resource", function (dataModelResource) {

        var dataModel = CreateDataModel(dataModelResource)

        $.getJSON("API/" + modelName, function (data) {
            $.each(data, function (i, item) {
                for (name in dataModel) {
                    dataModel[name](item[name])
                }
            })
        }).success(function () {
            var viewModel = ko.mapping.fromJS(dataModel);
            ko.applyBindings(viewModel);
        }).error(function () { alert("error"); })

    }).error(function () { alert("error"); })

    function CreateDataModel(dataModelResource) {
        var dataModel = {}
        $.each(dataModelResource, function (i, item) {
            dataModel[item["Property"]] = ko.observable('');
            if (item["Validations"] != null) {
                $.each(item["Validations"], function (j, validationItem) {
                    dataModel[item["Property"]] = dataModel[item["Property"]].extend({ required: validationItem["Message"] })
                })
            }
        })
        return dataModel;
    }
}