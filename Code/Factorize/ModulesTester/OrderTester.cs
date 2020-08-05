using Factorize.Classical.Calculator;
using Factorize.Classical.Calculator.Modules;
using Factorize.Classical.Utility;
using NUnit.Framework;

namespace ModulesTester
{
	public class OrderTests
	{
		public void TestOrderFinder(IOrderFinder orderFinder)
		{
			for (long n = 2; n < 500; n++)
			{
				for (long a = 1; a < n; a++)
				{
					if (MathUtils.GCD(a, n) != 1) continue;
					long res = orderFinder.Find(a, n);
					if (MathUtils.FastPowMod(a, res, n) != 1)
					{
						Assert.Fail("a^r is not congruent to one.", a, n, res, MathUtils.FastPowMod(a, res, n));
					}
					for (int rp = 1; rp < res; rp++)
					{
						if (MathUtils.FastPowMod(a, rp, n) == 1)
						{
							Assert.Fail("There is a smaller value r\' than r with a^r\' is congruent to one", a, n, res, rp);
						}
					}
				}
			}
		}

		[Test]
		public void NaiveOrderTest()
		{
			NaiveOrderFinder naiveOrderFinder = new NaiveOrderFinder();
			TestOrderFinder(naiveOrderFinder);
			Assert.Pass();
		}

		[Test]
		public void BabyGiantOrderTest()
		{
			BabyGiantOrderFinder babyGiantOrderFinder = new BabyGiantOrderFinder();
			TestOrderFinder(babyGiantOrderFinder);
			Assert.Pass();
		}
	}
}