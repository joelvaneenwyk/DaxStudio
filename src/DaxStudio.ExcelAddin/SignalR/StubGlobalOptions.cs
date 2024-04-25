using DaxStudio.Interfaces;
using System;

namespace DaxStudio.SignalR
{
    class StubGlobalOptions : IGlobalOptionsBase
    {
        public bool TraceDirectQuery
        {
            get => false;

            set => throw new NotImplementedException();
        }

    }
}
