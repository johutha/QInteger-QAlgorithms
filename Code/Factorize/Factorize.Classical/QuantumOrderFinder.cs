using Factorize.Classical.Utility;
using System;
using System.Collections.Generic;
using Microsoft.Quantum.Simulation.Simulators;
using Factorize.Classical.QuantumLauncher;

namespace Factorize.Classical.Calculator.Modules
{
	public class QuantumOrderFinder : IOrderFinder
	{
        readonly CSHost hs;
		public long Find(long a, long n)
		{
			return hs.Launch(a, n);
		}

		public QuantumOrderFinder() { hs = new CSHost(); }
	}
}
