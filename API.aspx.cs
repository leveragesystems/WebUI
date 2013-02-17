using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization;
using Newtonsoft.Json;

namespace WebUI {
  public partial class API : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {

      var _apiUrl = WebUI.Properties.Settings.Default.ApiUrl;

      _apiUrl += Page.Request.RawUrl.Replace("/API/", "");
      
      // Send a request asynchronously continue when complete 
      string name = Page.RouteData.Values["Name"] as string;

        // Create a New HttpClient object.
        HttpClient client = new HttpClient();

        HttpResponseMessage response = client.GetAsync(_apiUrl).Result;
        var result = response.Content.ReadAsStringAsync().Result;

      
      Response.Clear();
      Response.ContentType = "application/json; charset=utf-8";
      Response.Write(result);
      Response.End();

    }
  }
}