using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using Factorize.Classical.Calculator;
using Factorize.Classical.Calculator.Modules;
using Microsoft.Quantum.Arrays;
using Microsoft.Quantum.Intrinsic;
using System.IO;

namespace PerformanceTester
{
    class Program
    {
        const string help_text =
            "Factorization - Performance Tester\n" + 
            "Usage: factortest [-h] [-of OrderFinder] [-pc PrimeChecker]\n" +
            "Measures performance of the factorizer by factorizing numbers from stdin\n" +
            "\n" +
            "Arguments:\n" +
            "-h: Prints this help message\n" +
            "-of OrdeFinder: Uses specified order finder (default is Quantum / Shor):\n" +
            "   naive: Finds order naively\n" +
            "   babygiant: Uses baby-giant technique to achieve O(sqrt(n))\n" +
            "   quantum: Uses Quantum / Shors-Algorithm\n" +
            "-pc PrimeChecker: Uses specified prime checker (default is MilelrRabin with 100 iterations):\n" +
            "   naive: Checks prime naively\n" +
            "   millerrabin k: Uses MillerRabin-Algorithm with k iterations\n" +
            "-f File: Also saves results to file\n" +
            "\n"
            ;

        static void Main(string[] args)
        {
            IOrderFinder of = new QuantumOrderFinder();
            IPrimeChecker pc = new MillerRabin();

            int n = args.Length;
            bool saveFile = false;
            string logfile = "";

            for (int i = 0; i < n; i++)
            {
                if (args[i] == "-of")
                {
                    if (i == n - 1)
                    {
                        Console.WriteLine("Error: Argument -of must be followed by the name of the OrderFinder.");
                        return;
                    }
                    string nofn = args[i + 1];
                    i++;
                    if (nofn.ToLower() == "naive")
                    {
                        of = new NaiveOrderFinder();
                    }
                    if (nofn.ToLower() == "babygiant")
                    {
                        of = new BabyGiantOrderFinder();
                    }
                    if (nofn.ToLower() == "quantum")
                    {
                        of = new QuantumOrderFinder();
                    }
                }
                if (args[i] == "-pc")
                {
                    if (i == n - 1)
                    {
                        Console.WriteLine("Error: Argument -pc must be followed by the name of the PrimeChecker.");
                        return;
                    }
                    string nofn = args[i + 1];
                    i++;
                    if (nofn.ToLower() == "naive")
                    {
                        pc = new NaivePrimeChecker();
                    }
                    if (nofn.ToLower() == "millerrabin")
                    {
                        if (i == n - 1)
                        {
                            Console.WriteLine("Error: MillerRabin must be followed by the number of iterations.");
                            return;
                        }
                        string vl = args[i + 1];
                        i++;
                        int it;
                        if (!int.TryParse(vl, out it))
                        {
                            Console.WriteLine("Error: MillerRabin must be followed by the number of iterations.");
                            return;
                        }
                        pc = new MillerRabin(it);
                    }
                }
                if (args[i] == "-h")
                {
                    Console.WriteLine(help_text);
                    return;
                }
                if (args[i] == "-f")
                {
                    if (i == n - 1)
                    {
                        Console.WriteLine("Error: -f Must be followed by valid file name");
                        return;
                    }
                    string fn = args[i + 1];
                    i++;
                    saveFile = true;
                    logfile = Path.GetFullPath(fn);
                }
            }

            PerformanceTimer.Init(pc, of);

            string st;
            while ((st = Console.ReadLine()) != null)
            {
                List<string> vals = st.Split(' ').ToList();
                List<long> inp = new List<long>();
                foreach (string s in vals)
                {
                    long r = 0;
                    if (!long.TryParse(s, out r))
                    {
                        Console.WriteLine("Error: Conversion to long failed");
                        return;
                    }
                    inp.Add(r);
                }
                foreach (long v in inp)
                {
                    TimeSpan ts = PerformanceTimer.Measure(v);
                    string message = "Factorized " + v.ToString() + " in " + ts.Days + "d " + ts.Hours + "h " + ts.Minutes + "m " + ts.Seconds + "s " + ts.Milliseconds + "ms.";
                    if (saveFile)
                    {
                        var sw = new StreamWriter(logfile, true);
                        sw.WriteLine(message);
                        sw.Close();
                    }
                    Console.WriteLine(message);
                }
            }
        }
    }
}
