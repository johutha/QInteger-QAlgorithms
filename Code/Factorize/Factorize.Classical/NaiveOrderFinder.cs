using Factorize.Classical.Utility;

namespace Factorize.Classical.Calculator.Modules
{
    public class NaiveOrderFinder : IOrderFinder
    {
        public long Find(long a, long n)
        {
            long res = 1;
            for (; MathUtils.FastPowMod(a, res, n) != 1; res++) { }
            return res;
        }

        public NaiveOrderFinder() { }
    }
}
