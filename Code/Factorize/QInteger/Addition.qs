﻿namespace QTypes.QInteger
{
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Convert;

	internal operation __carry(Ccurr : Qubit, Summand : Qubit, Target : Qubit, Cnext : Qubit) : Unit is Adj+Ctl
	{
		CCNOT(Summand, Target, Cnext);
		CNOT(Summand, Target);
		CCNOT(Ccurr, Target, Cnext);
	}

	internal operation __sum(Ccurr : Qubit, Summand : Qubit, Target : Qubit) : Unit is Adj+Ctl
	{
		CNOT(Summand, Target);
		CNOT(Ccurr, Target);
	}

	// Does not work! Needs to be looked at.
	internal operation __NotWorking_Add3nWoOFCheck(Summand : QInt, Target : QInt) : Unit is Adj+Ctl
	{
		let n = Target::Size;
		using (Carry = Qubit[n + 1])
		{
			for (i in 0..n - 1)
			{
				__carry(Carry[i], Summand::Number[i], Target::Number[i], Carry[i + 1]);
			}
			CNOT(Summand::Number[n - 1], Target::Number[n - 1]);
			__sum(Carry[n - 1], Summand::Number[n - 1], Target::Number[n - 1]);
			for (i in n - 2..-1..0)
			{
				(Adjoint __carry)(Carry[i], Summand::Number[i], Target::Number[i], Carry[i + 1]);
				__sum(Carry[i], Summand::Number[i], Target::Number[i]);
			}
		}
	}

	internal operation Add2nQFT(Summand : QInt, Target : QInt) : Unit is Adj+Ctl
	{
		let n = Target::Size;
		within
		{
			QFTQInt(Target);
		}
		apply
		{
			for (i in 0..n-1)
			{
				for (j in 0..n-1-i)
				{
					(Controlled RotQ)([Summand::Number[j]], (i + 1, Target::Number[i + j]));
				}
			}
		}
	}

	internal operation Add2nQFTCQ(Summand : Int, Target : QInt) : Unit is Adj+Ctl
	{
		let n = Target::Size;
		let bs = IntAsBoolArray(Summand, n);
		within
		{
			QFTQInt(Target);
		}
		apply
		{
			for (i in 0..n-1)
			{
				for (j in 0..n-1-i)
				{
					if (bs[j])
					{
						RotQ(i + 1, Target::Number[i + j]);
					}
				}
			}
		}
	}
}