namespace QTypes.QInteger
{
	open Microsoft.Quantum.Canon;
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Math;
	open Microsoft.Quantum.Convert;


	internal operation RotQ(k : Int, q : Qubit) : Unit is Adj+Ctl
	{
		R1(2.0 * PI() / IntAsDouble(PowI(2, k)), q);
	}


	internal operation PerformQFT(qn : QInt) : Unit is Adj+Ctl
	{
		ReverseBits(qn);
		let n = qn::Size;
		for (i in 0..n - 1)
		{
			H(qn::Number[i]);
			for (j in i + 1..n - 1)
			{
				(Controlled RotQ)([qn::Number[j]], (j - i + 1, qn::Number[i]));
			}
		}
	}
}
