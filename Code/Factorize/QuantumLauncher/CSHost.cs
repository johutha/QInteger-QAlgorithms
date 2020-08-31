using Factorize.Quantum.Launcher;
using Microsoft.Quantum.Simulation.Simulators;
using System.Threading.Tasks;

namespace Factorize.Classical.QuantumLauncher
{
    public class CSHost
    {
        public long Launch(long a, long mod)
        {
            using (var sim = new QuantumSimulator())
            {
                var v = Launcher.Run(sim, a, mod);
                return v.Result;
            }
        }
    }
}
