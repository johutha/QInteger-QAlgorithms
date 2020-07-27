using Factorize.Utility;

namespace Factorize.Calculator
{
    public class NaiveOrderFinder : IOrderFinder
    {
        public long Find(long a, long n)
        {
            int res = 1;
            for (; MathUtils.FastPowMod(a, res, n) != 1; res++) { }
            return res;
        }

        public NaiveOrderFinder() { }
    }
}
