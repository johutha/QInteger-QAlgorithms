using System;
using System.Collections.Generic;
using Factorize.Classical.Utility;
using System.Diagnostics;
using Microsoft.Quantum.Intrinsic;

namespace Factorize.Classical.Calculator
{
	public class Factorizer
	{
		IPrimeChecker PrimeChecker;
		IOrderFinder OrderFinder;

		long FindRthRoot(long n, long rt)
        {
			long l = 0;
			long r = n;

			while (l + 1 < r)
            {
				long m = (l + r) / 2;
                try
                {
					long rs = MathUtils.FastPowMod(m, rt, long.MaxValue);
					if (rs > n)
                    {
						r = m;
                    }
					else
                    {
						l = m;
                    }
                }
				catch (OverflowException)
                {
					r = m;
                }
            }
			return l;
        }

		long FindRoot(long n)
        {
			long lg2 = (long)Math.Ceiling(Math.Log2(n));
			for (int i = 2; i < lg2; i++)
            {
				long rt = FindRthRoot(n, i);
				if (MathUtils.FastPowMod(rt, i, long.MaxValue) == n) return rt;
            }
			return -1;
        }

		long FindDivisor(long n)
		{
			if (PrimeChecker.Prime(n)) throw new Exception("Number is already prime, can't find any nontrivial divisor.");
			if ((n & 1) == 0) return 2;
			var rt = FindRoot(n);
			if (rt != -1) return rt;

			while (true)
			{
				long a = (MathUtils.Random() % (n - 1)) + 1;
				long g = MathUtils.GCD(n, a);
				if (g != 1) return g;
				long r = OrderFinder.Find(a, n);
				if ((r & 1) != 0) continue;
				if (MathUtils.FastPowMod(a, r / 2, n) == n - 1) continue;
				long DivShare = MathUtils.FastPowMod(a, r / 2, n) - 1;
				return MathUtils.GCD(n, DivShare);
			}
		}

		public Dictionary<long, long> Run(long n)
		{
			Dictionary<long,long> PrimeDecomposition = new Dictionary<long, long>();
			Queue<long> q = new Queue<long>();
			q.Enqueue(n);
			while (q.Count > 0)
			{
				long front = q.Dequeue();
				Debug.Assert(front != 1);
				if (PrimeChecker.Prime(front))
				{
					if (!PrimeDecomposition.ContainsKey(front)) PrimeDecomposition.Add(front, 0);
					PrimeDecomposition[front]++;
					continue;
				}
				long div = FindDivisor(front);
				q.Enqueue(div);
				q.Enqueue(front / div);
			}
			return PrimeDecomposition;
		}

		public Factorizer(IPrimeChecker primeChecker, IOrderFinder orderFinder)
		{
			PrimeChecker = primeChecker;
			OrderFinder = orderFinder;
		}
	}
}
