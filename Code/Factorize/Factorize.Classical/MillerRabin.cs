using Factorize.Classical.Utility;
using Microsoft.VisualBasic.CompilerServices;

namespace Factorize.Classical.Calculator.Modules
{
	public class MillerRabin : IPrimeChecker
	{
		long it = 100;

		public bool Prime(long n)
		{
			if (n == 1) return false;
			if (n == 2 || n == 3) return true;

			long r = 0;
			long d = n - 1;

			for (; (d & 1) == 0; d /= 2) r++;

			for (long rn = 0; rn < it; rn++)
			{
				long a = (MathUtils.Random() % (n - 3)) + 2;
				long x = MathUtils.FastPowMod(a, d, n);
				if (x == 1 || x == n - 1) continue;
				bool ok = false; ;
				for (long i = 0; i < r - 1; i++)
				{
					x = (x * x) % n;
					if (x == n - 1)
					{
						ok = true;
						break;
					}
				}
				if (!ok) return false;
			}
			return true;
		}

		public MillerRabin(long NrIterations = 100)
		{
			it = NrIterations;
		}
	}
}
