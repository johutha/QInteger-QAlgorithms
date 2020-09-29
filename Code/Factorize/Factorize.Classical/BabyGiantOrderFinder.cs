using Factorize.Classical.Utility;
using System;
using System.Collections.Generic;

namespace Factorize.Classical.Calculator.Modules
{
	public class BabyGiantOrderFinder : IOrderFinder
	{
		// Finds the order of the number using a Baby-Step / Giant-Step algorithm
		// to achieve a performance of O(sqrt(n)log(n)). Could be optimized to
		// O(sqrt(n)) using a hashmap.
		//
		// Given a value b, the algorithm tries to find x < b and y <= (n / b), 
		// such that a^(yb - x) == 1, minimizing first y and then maximizing x.
		// Since a^(yb - x) == 1, we get a^(yb) = a^x, thus we can store the pairs
		// (a^x, x) in a Dictionary for all x < b., and then look for matches when
		// loop through the a^yb for all y <= n / b. This achieves the best per-
		// formance if b is in O(sqrt(n)).

		public long Find(long a, long n)
		{
			// Calculate b, here called bsize, to be in O(sqrt(n))
			long bsize = (long)Math.Round(Math.Sqrt(n));

			Dictionary<long, long> babysteps = new Dictionary<long, long>();

			// For each i < b, add (a^i, i) to the dictionary
			for (int i = 0; i < bsize; i++)
			{
				long k = MathUtils.FastPowMod(a, i, n);
				if (babysteps.ContainsKey(k))
				{
					babysteps[k] = i;
				}
				else
				{
					babysteps.Add(k, i);
				}
			}

			// For each i <= (n / b), look if a^(ib) is a key in the dictionary
			for (int i = 1; i <= (n / bsize) + 1; i++)
			{
				long ns = i * bsize;
				long k = MathUtils.FastPowMod(a, ns, n);
				if (babysteps.ContainsKey(k))
				{
					return ns - babysteps[k];
				}
			}
			return n - 1;
		}

		public BabyGiantOrderFinder() { }
	}
}
