using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace JsonParser
{
    internal class Program
    {
        static void Main(string[] args)
        {
            try
            {
                var reader = new StreamReader("../../response.json");
                var jsonString = reader.ReadToEnd();
                var words = JsonConvert.DeserializeObject<Word[]>(jsonString).ToList();

                var path = "../../response.txt";

                if (File.Exists(path))
                {
                    File.Delete(path);
                }

                var f = File.Create(path);
                f.Close();

                words.Remove(words.First());
                while (words.Count > 0)
                {
                    var lineWords = words.Where(x => x.boundingPoly.vertices.FirstOrDefault().y < words.FirstOrDefault().boundingPoly.vertices.FirstOrDefault().y + 10);
                    var line = "";
                    foreach (var word in new List<Word>(lineWords))
                    {
                        line = line + word.description + " ";
                        words.Remove(word);
                    }
                    File.AppendAllText(path, line.Trim() + Environment.NewLine);
                }

            }
            catch(Exception ex)
            {
                Console.WriteLine("Bilinmeyen Hata oluştu." + ex.StackTrace);
            }
            
        }

    }
}
