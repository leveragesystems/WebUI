using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace WebUI {
  public class RouteConfig {
    public static void RegisterRoutes(RouteCollection routes) {

  
      routes.MapPageRoute("AllAPICalls",     // Route name
         "API/{name}",      // Route URL
         "~/API.aspx" // Web page to handle route
      );

    }
  }
}
