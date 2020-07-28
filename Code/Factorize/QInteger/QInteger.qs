namespace QTypes.QInteger
{
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    newtype QInt = (Size : Int, Number : Qubit[]);
}
