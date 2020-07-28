namespace Quantum.QIntTester {
    open QTypes.QInteger;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    
    @Test("QuantumSimulator")
    operation CopyMeasureTest() : Unit
    {
        using (qr = Qubit[8])
        {
            
		}
        
        Message("Test passed.");
    }
}
