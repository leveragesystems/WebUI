using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace WebUI {
  public class RouteConfig {
    public static void RegisterRoutes(RouteCollection routes) {

      // Register a route for Categories/All
      routes.MapPageRoute(
         "All API Calls",      // Route name
         "API/",      // Route URL
         "~/API.aspx" // Web page to handle route
      );

    }
  }
}
