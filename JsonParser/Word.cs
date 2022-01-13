using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JsonParser
{
    public class Word
    {
        public string locale { get; set; }
        public string description { get; set; }
        public Boundingpoly boundingPoly { get; set; }
    }

    public class Boundingpoly
    {
        public Vertex[] vertices { get; set; }
    }

    public class Vertex
    {
        public int x { get; set; }
        public int y { get; set; }
    }

}
