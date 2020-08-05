namespace QTypes.QInteger
{
	open Microsoft.Quantum.Canon;
	open Microsoft.Quantum.Intrinsic;
	open QTypes.QInteger.Addition;
	open QTypes.QInteger.MultiplyExpMod;
	open QTypes.QInteger.QFT;

	operation Add(Summand : QInt, Target : QInt) : Unit is Adj+Ctl
	{
		Add2nQFT(Summand, Target);
	}

	operation AddCQ(Summand : Int, Target : QInt) : Unit is Adj+Ctl
	{
		Add2nQFTCQ(Summand, Target);
	}

	operation AddMod(iSummand : QInt, iTarget : QInt, iMod : QInt) : Unit is Adj+Ctl
	{
		using (an = Qubit[4])
		{
			let c = an[3];
			let Summand = QInt(iSummand::Size + 1, iSummand::Number + [an[0]]);
			let Target = QInt(iTarget::Size + 1, iTarget::Number + [an[1]]);
			let Mod = QInt(iMod::Size + 1, iMod::Number + [an[2]]);
			Add(Summand, Target);
			GreaterOrEq(Target, Mod, c);
			(Controlled (Adjoint Add))([c], (Mod, Target));
			GreaterThan(Summand, Target, c);
		}
	}

	operation AddModQQC(iSummand : QInt, iTarget : QInt, Mod : Int) : Unit is Adj+Ctl
	{
		using (an = Qubit[3])
		{
			let c = an[2];
			let Summand = QInt(iSummand::Size + 1, iSummand::Number + [an[0]]);
			let Target = QInt(iTarget::Size + 1, iTarget::Number + [an[1]]);
			Add(Summand, Target);
			LessOrEqCQ(Mod, Target, c);
			(Controlled (Adjoint AddCQ))([c], (Mod, Target));
			GreaterThan(Summand, Target, c);
		}
	}

	operation AddModCQC(Summand : Int, iTarget : QInt, Mod : Int) : Unit is Adj+Ctl
	{
		using (an = Qubit[2])
		{
			let c = an[1];
			let Target = QInt(iTarget::Size + 1, iTarget::Number + [an[0]]);
			AddCQ(Summand, Target);
			LessOrEqCQ(Mod, Target, c);
			(Controlled (Adjoint AddCQ))([c], (Mod, Target));
			GreaterThanCQ(Summand, Target, c);
		}
	}

	operation AddModCQQ(Summand : Int, iTarget : QInt, iMod : QInt) : Unit is Adj+Ctl
	{
		using (an = Qubit[3])
		{
			let c = an[2];
			let Target = QInt(iTarget::Size + 1, iTarget::Number + [an[0]]);
			let Mod = QInt(iMod::Size + 1, iMod::Number + [an[1]]);
			AddCQ(Summand, Target);
			LessOrEq(Mod, Target, c);
			(Controlled (Adjoint Add))([c], (Mod, Target));
			GreaterThanCQ(Summand, Target, c);
		}
	}

	operation MulModAdd(a : Int, b : QInt, Target : QInt, Mod : Int) : Unit is Adj+Ctl
	{
		_MulModAdd(a, b, Target, Mod);
	}

	operation MulMod(Factor : Int, Target : QInt, Mod : Int) : Unit is Adj+Ctl
	{
		_MulMod(Factor, Target, Mod);
	}

	operation ModExp(Base : Int, Expn : QInt, Target : QInt, Mod : Int) : Unit is Adj+Ctl
	{
		__ModExp(Base, Expn, Target, Mod);
	}

	operation QFTQInt(qn : QInt) : Unit is Adj+Ctl
	{
		PerformQFT(qn);
	}
}
