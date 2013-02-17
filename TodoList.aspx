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

         function Sprinkle(modelName) {
             $.getJSON("API/"+modelName+"?Resource", function (dataModelResource) {
                 
                 var dataModel = CreateModel(dataModelResource)

                 $.getJSON("API/" + modelName, function (data) {
                     $.each(data, function (i, item) {
                         for (name in dataModel) {
                             dataModel[name](item[name])
                         }
                     })
                    
                 }).success(function () {
                     var viewModel = ko.mapping.fromJS(dataModel);
                     ko.applyBindings(viewModel);
                 })
                  .error(function () { alert("error"); })
             }).error(function () { alert("error"); })
             
             function CreateModel(dataModelResource) {
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

         Sprinkle("ToDoLists")

    </script>
</asp:Content>
