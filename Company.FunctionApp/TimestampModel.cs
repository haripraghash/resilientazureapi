using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Company.FunctionApp
{
    public class TimestampModel
    {
        public DateTime Timestamp { get; set; }

        public string Name { get; set; } = "TimeStamp";

        public string Id { get; set; } = Guid.NewGuid().ToString();
    }
}
