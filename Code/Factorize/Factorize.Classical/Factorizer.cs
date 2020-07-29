using System;
using System.Collections.Generic;
using Factorize.Classical.Utility;
using System.Diagnostics;

namespace Factorize.Classical.Calculator
{
    public class Factorizer
    {
        IPrimeChecker PrimeChecker;
        IOrderFinder OrderFinder;

        long FindDivisor(long n)
        {
            if (PrimeChecker.Prime(n)) throw new Exception("Number is already prime, can't find any nontrivial divisor.");
            if ((n & 1) == 0) return 2;

            while (true)
            {
                long a = (MathUtils.Random() % (n - 2)) + 1;
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
