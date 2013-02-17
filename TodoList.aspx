﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="TodoList.aspx.cs" Inherits="WebUI.TodoList" %>
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

         function Sprinkle(model) {
             $.getJSON("API/"+model+"?Resource", function (dataModelResource) {
                 
                 jQuery.globalEval(CreateResource(dataModelResource));

                 $.getJSON("API/" + model, function (dataModel) {
                     for (i in dataModel) {
                         for (name in data) {
                             eval("data." + name + "(dataModel[i][name])")
                         }
                     }
                     //map this directly to view model
                     var viewModel = ko.mapping.fromJS(data);
                     //apply  it mofo
                     ko.applyBindings(viewModel);
                 })


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

        
         Sprinkle("ToDoLists")
       

    </script>
</asp:Content>
