using DaxStudio.Interfaces;
using Newtonsoft.Json;

namespace DaxStudio.ExcelAddin.Xmla
{
    public class StaticQueryResult:IStaticQueryResult
    {
        [JsonConverter(typeof(Newtonsoft.Json.Converters.DataTableConverter))]
        public System.Data.DataTable QueryResults {get;set;}

        public string TargetSheet { get; set; }
        
    }
}
