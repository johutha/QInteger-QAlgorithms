using Factorize.Classical.Utility;
using System;
using System.Collections.Generic;

namespace Factorize.Classical.Calculator.Modules
{
    public class BabyGiantOrderFinder : IOrderFinder
    {
        public long Find(long a, long n)
        {
            long bsize = (long)Math.Round(Math.Sqrt(n));

            Dictionary<long, long> babysteps = new Dictionary<long, long>();

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
