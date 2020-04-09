using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;

namespace Utility
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

        public static bool MillerRabin(long n, long it = 100)
        {
            if (n == 1) return false;
            if (n == 2 || n == 3) return true;

            long r = 0;
            long d = n - 1;

            for (; (d & 1) == 0; d /= 2) r++;

            for (long rn = 0; rn < it; rn++)
            {
                long a = (Random() % (n - 3)) + 2;
                long x = FastPowMod(a, d, n);
                if (x == 1 || x == n - 1) continue;
                bool ok = false; ;
                for (long i = 0; i < r - 1; i++)
                {
                    x = (x * x) % n;
                    if (x == n - 1)
                    {
                        ok = true;
                        break;
                    }
                }
                if (!ok) return false;
            }
            return true;
        }

        public static long GCD(long a, long b)
        {
            if (a > b) return GCD(b, a);
            if (a == 0) return b;
            return GCD(b % a, a);
        }
    }
}
