using System;
using System.Collections.Generic;
using Factorize.Classical.Calculator;
using Factorize.Classical.Calculator.Modules;

namespace Factorize.Executable
{
	class Program
	{
		static void Main(string[] args)
		{
			long n = Convert.ToInt64(Console.ReadLine());

			Factorizer factorizer = new Factorizer(new MillerRabin(40), new QuantumOrderFinder());
			Dictionary<long, long> res = factorizer.Run(n);

			foreach (KeyValuePair<long,long> kvp in res)
			{
				Console.WriteLine(kvp.Key.ToString() + ": " + kvp.Value.ToString());
			}
		}
	}
}
