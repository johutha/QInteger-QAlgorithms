using Factorize.Classical.Calculator;
using Factorize.Classical.Calculator.Modules;
using Factorize.Classical.Utility;
using NUnit.Framework;
using System.Runtime.InteropServices.ComTypes;

namespace ModulesTester
{
	public class PrimeTests
	{
		public void TestPrimeChecker(IPrimeChecker primeChecker)
		{
			if (primeChecker.Prime(1)) Assert.Fail("PrimeChecker claims 1 is a prime");
			for (int p = 2; p < 10000; p++)
			{
				bool isPrime = primeChecker.Prime(p);
				int c = -1;
				for (int i = 2; i < p; i++)
				{
					if (p % i == 0) c = i;
				}
				if (isPrime && c != -1)
				{
					Assert.Fail("PrimeChecker claimed it's prime, but " + c.ToString() + " divides " + p.ToString(), p, c);
				}
				else if (c == -1 && !isPrime)
				{
					Assert.Fail("PrimeChecker claimed it's composite, but we didn't find any divisor", p);
				}
			}
		}

		[Test]
		public void NaivePrimeTest()
		{
			NaivePrimeChecker naivePrimeChecker = new NaivePrimeChecker();
			TestPrimeChecker(naivePrimeChecker);
			Assert.Pass();
		}

		[Test]
		public void MillerRabinTest()
		{
			MillerRabin millerRabin = new MillerRabin(100);
			TestPrimeChecker(millerRabin);
			Assert.Pass();
		}
	}
}