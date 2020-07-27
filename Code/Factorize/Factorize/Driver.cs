using System;
using System.Collections.Generic;
using Factorize.Utility;
using Factorize.Calculator;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using Markdig.Extensions.AutoIdentifiers;
using YamlDotNet.Core.Tokens;

namespace Factorize
{
    class Driver
    {
        static void Main(string[] args)
        {
            Factorizer factorizer = new Factorizer(new NaivePrimeChecker(), new NaiveOrderFinder());
            long ip = Convert.ToInt64(Console.ReadLine());

            Dictionary<long, long> res = factorizer.Run(ip);

            foreach (KeyValuePair<long, long> kvp in res)
            {
                Console.WriteLine(kvp.Key.ToString() + ": " + kvp.Value.ToString());
            }
        }
    }
}