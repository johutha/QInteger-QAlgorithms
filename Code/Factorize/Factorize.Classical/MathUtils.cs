using System;
using System.Security.Cryptography;

namespace Factorize.Classical.Utility
{
    static class MathUtils
    {
        private static RandomNumberGenerator rng = RandomNumberGenerator.Create();

        public static long Random()
        {
            long len = sizeof(long);
            byte[] res = new byte[len];
            rng.GetBytes(res);
            return Math.Abs(BitConverter.ToInt64(res));
        }

        public static long FastPowMod(long bs, long exp, long mod)
        {
            long res = 1;
            for (; exp != 0; exp /= 2)
            {
                if ((exp & 1) != 0) res = (res * bs) % mod;
                bs = (bs * bs) % mod;
            }
            return res;
        }

        public static long GCD(long a, long b)
        {
            if (a > b) return GCD(b, a);
            if (a == 0) return b;
            return GCD(b % a, a);
        }
    }
}
