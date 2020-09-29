using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using Factorize.Classical;
using Factorize.Classical.Calculator;
using Factorize.Classical.Utility;

namespace PerformanceTester
{
    public static class PerformanceTimer
    {
        static Factorizer factorizer;

        public static void Init(IPrimeChecker primeChecker, IOrderFinder orderFinder)
        {
            factorizer = new Factorizer(primeChecker, orderFinder);
        }

        public static TimeSpan Measure(long n)
        {
            // Measures the time used to factorize the number n using System.Diagnostics.Stopwatch
            // and returns it as a TimeSpan.

            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            Dictionary<long, long> res = factorizer.Run(n);
            stopwatch.Stop();

            // Check the result, we need to make sure our Factorization-implementation returns the correct result
            long v = 1;
            foreach (KeyValuePair<long,long> p in res)
            {
                v *= MathUtils.FastPowMod(p.Key, p.Value, long.MaxValue);
            }
            if (v != n) throw new Exception("Wrong result: Factorization for " + n.ToString() + " multiplies to " + v.ToString() + ".");

            // Return the TimeSpan
            return stopwatch.Elapsed;
        }
    }
}
