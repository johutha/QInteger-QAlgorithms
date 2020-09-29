namespace Factorize.Classical.Calculator
{
	/// <summary>
	/// An interface for OrderFinders to allow other
	/// OrderFinders to be used in the Factorization Algorithm.
	/// </summary>
	public interface IOrderFinder
	{
		// The only function needed is the find(a, n) to find
		// the order of a modulo n.

		/// <summary>
		/// Finds the order of a modulo n, that is, the smallest d such that
		/// a^d == 1.
		/// </summary>
		/// <returns>The order of a modulo n</returns>
		long Find(long a, long n);
	}
}
