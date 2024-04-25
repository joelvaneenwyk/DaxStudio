using System.Diagnostics;
using System.Web.Http.ExceptionHandling;

namespace DaxStudio.ExcelAddin.Xmla
{
    
    class TraceExceptionLogger : ExceptionLogger
    {
        public override void Log(ExceptionLoggerContext context)
        {
            Trace.TraceError(context.ExceptionContext.Exception.ToString());
            Serilog.Log.Error("OWIN Trace Exception: {Exception}", context.ExceptionContext.Exception.ToString());
        }
            
    }
    
}
