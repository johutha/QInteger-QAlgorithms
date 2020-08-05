namespace QTypes.QInteger
{

	open Microsoft.Quantum.Canon;
	open Microsoft.Quantum.Intrinsic;
	open QTypes.QInteger.Addition;
	open QTypes.QInteger.QFT;

	operation Add(Summand : QInt, Target : QInt) : Unit is Adj+Ctl
	{
		Add2nQFT(Summand, Target);
	}

	operation Add3(A : QInt, B : QInt, Target : QInt) : Unit is Adj+Ctl
	{
		Add(A, Target);
		Add(B, Target);
	}

	operation AddCQ(Summand : Int, Target : QInt) : Unit is Adj+Ctl
	{
		Add2nQFTCQ(Summand, Target);
	}

	operation Add3CQQ(A : Int, B : QInt, Target : QInt) : Unit is Adj+Ctl
	{
		AddCQ(A, Target);
		Add(B, Target);
	}

	operation AddMod(Summand : QInt, Target : QInt, Mod : QInt) : Unit is Adj+Ctl
	{
		using (anc = Qubit())
		{
			Add(Summand, Target);
			GreaterOrEq(Target, Mod, anc);
			(Controlled (Adjoint Add))([anc], (Mod, Target));
			GreaterThan(Summand, Target, anc);
		}
	}

	operation AddModQQC(Summand : QInt, Target : QInt, Mod : Int) : Unit is Adj+Ctl
	{
		
	}

	operation AddModCQC(Summand : Int, Target : QInt, Mod : Int) : Unit is Adj+Ctl
	{
		
	}

	operation AddModCQQ(Summand : Int, Target : QInt, Mod : QInt) : Unit is Adj+Ctl
	{
		
	}

	operation MulMod(Factor : QInt, Target : QInt, Mod : QInt) : Unit is Adj+Ctl
	{
		
	}

	operation ConMulMod(Control : Qubit, factor : QInt, Target : QInt, Mod : Int) : Unit is Adj
	{
		
	}

	operation ModExp(Base : Int, Expn : QInt, Mod : Int) : Unit is Adj+Ctl
	{
		
	}

	operation QFTQInt(qn : QInt) : Unit is Adj+Ctl
	{
		PerformQFT(qn);
	}
}
