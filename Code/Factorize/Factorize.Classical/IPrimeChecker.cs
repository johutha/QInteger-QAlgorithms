namespace Factorize.Classical.Calculator
{
	/// <summary>
	/// An interface for the PrimeChecker to allow other
	/// PrimeChekers to be used in the factorization-algorithm
	/// </summary>
	public interface IPrimeChecker
	{
		/// <summary>
		/// Checks if a number is prime.
		/// </summary>
		/// <param name="p">The number to check</param>
		bool Prime(long p);
	}
}
