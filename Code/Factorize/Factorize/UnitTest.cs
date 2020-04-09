using System;
using System.Collections.Generic;
using System.Text;
using Utility;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Factorize
{
    class UnitTest
    {
        Func<long, long, long, (long, long)> BitFunc;
        IOperationFactory QuantumFactory;

        public void RunTest(long i1, long i2, long i3)
        {
            (long, long) bitres = BitFunc(i1, i2, i3);
            var qt = Test.Run(QuantumFactory, i1, i2, i3);
            qt.Wait();
            (long, long) qubres = qt.Result;
            if (qubres != bitres)
            {
                throw new Exception("Results from UnitTests are not the same");
            }
        }

        public UnitTest(Func<long, long, long, (long, long)> bfun, IOperationFactory fact)
        {
            QuantumFactory = fact;
            BitFunc = bfun;
        }

        public void RandomTests(long nr, long fix1 = -1, long fix2 = -1, long fix3 = -1)
        {
            for (int i = 0; i < nr; i++)
            {
                long i1 = fix1;
                long i2 = fix2;
                long i3 = fix3;
                if (i1 == -1) i1 = MathUtils.Random() % 256;
                if (i2 == -1) i2 = MathUtils.Random() % 256;
                if (i3 == -1) i3 = MathUtils.Random() % 256;
                RunTest(i1, i2, i3);
            }
        }
    }
}
