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
         Sprinkle("ToDoLists")
    </script>
</asp:Content>
