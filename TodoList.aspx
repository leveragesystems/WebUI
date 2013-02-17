<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="TodoList.aspx.cs" Inherits="WebUI.TodoList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container">
    
<p data-bind="css: { error: Title.hasError }"> Todo
    <input data-bind='value: Title, valueUpdate: "afterkeydown"' />
    <span data-bind='visible: Title.hasError, text: Title.validationMessage'> </span>
</p>

    <p>Due Date: <input data-bind='value: DueDate' /></p>
   
    </div>
     <script type="text/javascript">
        
         //Note this must link to resouce from api to pull definition to populate model, and then to pull down info from api 
         //and dynamically construct the following

         function Sprinkle(modelName) {
             $.getJSON("API/"+modelName+"?Resource", function (dataModelResource) {
                 
                 jQuery.globalEval(CreateResource(dataModelResource, modelName));

                 $.getJSON("API/" + modelName, function (data) {
                     $.each(data, function (i, item) {
                         for (name in dataModel) {
                             eval("dataModel." + name + "(item[name])")
                         }
                     })
                    
                 }).success(function () {
                     var viewModel = ko.mapping.fromJS(dataModel);
                     ko.applyBindings(viewModel);
                 })
                  .error(function () { alert("error"); })
             })
             

             function CreateResource(dataModelResource) {
                 var strData = "";
                 $.each(dataModelResource, function (i, item) {
                     if (i > 0) { strData += "," }
                     strData += item["Property"] + ": ko.observable('')";
                     if (item["Validations"] != null) {
                         $.each(item["Validations"], function (j, validationItem) {
                             strData += ".extend({ required: '" + validationItem["Message"] + "' })";
                         })
                         strData += " "
                     }
                 })

                 strData = "var dataModel = { " + strData + "}";
                 return strData;
             }
         }

        
         Sprinkle("ToDoLists")

       

    </script>
</asp:Content>
