namespace Factorize.Classical.Calculator.Modules
{
	public class NaivePrimeChecker : IPrimeChecker
	{
		public bool Prime(long n)
		{
			if (n == 1) return false;
			if (n == 2 || n == 3) return true;

			for (int i = 2; i*i <= n; i++)
			{
				if (n % i == 0) return false;
			}
			return true;
		}

		public NaivePrimeChecker() { }
	}
}
