using System;
using Utility;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Factorize
{
    class Driver
    {
        static (long, long) CN(long i1, long i2, long i3)
        {
            for (int i = 0; i < 8; i++)
            {
                if ((i1 & (1<<i)) != 0)
                {
                    i2 = i2 ^ (1 << i);
                }
            }
            return (i1, i2);
        }

        static void Main(string[] args)
        {
            long ip = Convert.ToInt64(Console.ReadLine());

            var res = Factorizer.Factorize(ip);
            foreach (var p in res)
            {
                Console.WriteLine(p.Key.ToString() + "^" + p.Value.ToString());
            }

            var qs = new QuantumSimulator();
            UnitTest ut = new UnitTest(CN, qs);
            ut.RandomTests(100, fix3 : 0);

            /*
            using (var qsim = new QuantumSimulator())
            {
                var tsk = Factorize.Run(qsim, x: ip);
                tsk.Wait();
                long res = tsk.Result;
                Console.WriteLine(res);
            }*/
        }
    }
}