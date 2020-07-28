namespace QTypes.QInteger
{

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Add(Summand : QInt, Target : QInt) : Unit is Adj+Ctl
    {
    
	}

    operation Add3(A : QInt, B : QInt, Target : QInt) : Unit is Adj+Ctl
    {
        
	}

    operation AddCQ(Summand : Int, Target : QInt) : Unit is Adj+Ctl
    {
    
	}

    operation Add3CQQ(A : Int, B : QInt, Target : QInt) : Unit is Adj+Ctl
    {
        
	}

    operation AddMod(Summand : QInt, Target : QInt, Mod : QInt) : Unit is Adj+Ctl
    {
        
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
}
