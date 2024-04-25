using Microsoft.Owin;
using Serilog;
using System;
using System.Threading.Tasks;

namespace DaxStudio.Xmla
{
    public class UnhandledExceptionMiddleware : OwinMiddleware
    {
        public UnhandledExceptionMiddleware(OwinMiddleware next) : base(next)
        {
        }

        public override async Task Invoke(IOwinContext context)
        {
            try
            {
                await Next.Invoke(context).ConfigureAwait(false);
            }
            catch (Exception ex)
            {
                // your handling logic
                Log.Fatal(ex, "Unhandled exception in OWIN call");
            }
        }
    }
}
