<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="TodoList.aspx.cs" Inherits="WebUI.TodoList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    Todo
<p data-bind="css: { error: todo.hasError }">
    <input data-bind='value: todo, valueUpdate: "afterkeydown"' />
    <span data-bind='visible: todo.hasError, text: todo.validationMessage'> </span>
</p>

    <p><input data-bind='value: numUsers' /></p>

    <script type="text/javascript">
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

    </script>
   
     <script type="text/javascript">
        
         //Note this must link to resouce from api to pull definition to populate model, and then to pull down info from api 
         //and dynamically construct the following
        var data = {
            todo: ko.observable('').extend({ required: "Please enter a todo" }),
            numUsers: 3
        }
        
        //map this directly to view model
        var viewModel = ko.mapping.fromJS(data);
        //apply  it mofo
        ko.applyBindings(viewModel);

    </script>
</asp:Content>
