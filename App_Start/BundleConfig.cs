using System.Web;
using System.Web.Optimization;


namespace WebUI {
  public class BundleConfig {
    public static void RegisterBundles(BundleCollection bundles) {
      bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                  "~/Scripts/jquery-{version}.js"));

      bundles.Add(new ScriptBundle("~/bundles/knockout").Include(
        "~/Scripts/knockout*"));
    }


  }
}