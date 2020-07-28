namespace Factorize.Quantum
{

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;

    newtype QInt = (Size : Int, Number : Qubit[]);


    operation Add(Summand : QInt, Target : QInt) : Unit is Adj+Ctl
    {
    
	}

    operation Add3(A : QInt, B : QInt, Target : QInt) : Unit is Adj+Ctl
    {
        
	}

    operation AddCQ(Summand : Int, Target : QInt) : Unit is Adj+Ctl
    {
    
	}

    operation Add3QCQ(A : QInt, B : Int, Target : QInt) : Unit is Adj+Ctl
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

    operation MulModQQC(Factor : QInt, Target : QInt, Mod : Int) : Unit is Adj+Ctl
    {
        
	}

    operation MulModCQC(Factor : Int, Target : QInt, Mod : Int) : Unit is Adj+Ctl
    {
        
	}

    operation MulModCQQ(Factor : Int, Target : QInt, Mod : QInt) : Unit is Adj+Ctl
    {
        
	}
}
