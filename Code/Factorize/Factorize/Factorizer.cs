using System;
using System.Collections.Generic;
using System.Text;
using Utility;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Factorize
{
    static class Factorizer
    {

        private static long RunQuantum(long x, IOperationFactory qsim)
        {
            if (qsim == null) qsim = new QuantumSimulator();
            var tsk = QuantumFactor.Run(qsim, x: x);
            tsk.Wait();
            long res = tsk.Result;
            return res;
        }

        private static long FindOrder(long x, long mod, IOperationFactory qsim)
        {
            int res = 1;
            for (; MathUtils.FastPowMod(x, res, mod) != 1; res++) { }
            return res;
        }

        public static long FindNonTrivialDivisor(long n, IOperationFactory qsim = null)
        {
            if (MathUtils.MillerRabin(n)) throw new Exception("Number is already prime, can't find any nontrivial divisor.");
            if ((n & 1) == 0) return 2;
            while (true)
            {
                long a = (MathUtils.Random() % (n - 2)) + 1;
                long g = MathUtils.GCD(n, a);
                if (g != 1) return g;
                long r = FindOrder(a, n, qsim);
                if ((r & 1) != 0) continue;
                if (MathUtils.FastPowMod(a, r/2, n) == n - 1) continue;
                long DivShare = MathUtils.FastPowMod(a, r/2, n) - 1;
                return MathUtils.GCD(n, DivShare);
            }
        }

        public static Dictionary<long, long> Factorize(long n, IOperationFactory qsim = null)
        {
            Dictionary<long,long> PrimeDecomposition = new Dictionary<long, long>();
            Queue<long> q = new Queue<long>();
            q.Enqueue(n);
            while (q.Count > 0)
            {
                long front = q.Dequeue();
                if (MathUtils.MillerRabin(front))
                {
                    if (!PrimeDecomposition.ContainsKey(front)) PrimeDecomposition.Add(front, 0);
                    PrimeDecomposition[front]++;
                    continue;
                }
                long div = FindNonTrivialDivisor(front, qsim);
                q.Enqueue(div);
                q.Enqueue(front / div);
            }
            return PrimeDecomposition;
        }
    }
}
