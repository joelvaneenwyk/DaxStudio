using DaxStudio.Interfaces;

namespace DaxStudio.ExcelAddin.Xmla
{
    public class LinkedQueryResult : ILinkedQueryResult
    {
        public string DaxQuery { get; set; }
        public string TargetSheet { get; set; }
        public string ConnectionString { get; set; }
    }
}
