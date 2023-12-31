pragma circom 2.0.0;

template Multiplier2 () {  
   // Define signal inputs
   signal input a;
   signal input b;

   // Intermediate signals
   signal x;
   signal y;

   // Define final output signal
   signal output q;

   // Components to create gates
   component andGate = AND();
   component orGate = OR();
   component notGate = NOT();

   // Connect gates to form the circuit
   andGate.a <== a;
   andGate.b <== b;
   x <== andGate.out;

   notGate.in <== b;
   y <== notGate.out;

   orGate.a <== x;
   orGate.b <== y;
   q <== orGate.out;
}

template AND() {
   // Inputs for AND gate
   signal input a;
   signal input b;
   
   // Output of AND gate
   signal output out;

   // Logic for AND gate
   out <== a * b;
}

template OR() {
   // Inputs for OR gate
   signal input a;
   signal input b;
   
   // Output of OR gate
   signal output out;

   // Logic for OR gate
   out <== a + b - a*b;
}

template NOT() {
   // Input for NOT gate
   signal input in;
   
   // Output of NOT gate
   signal output out;

   // Logic for NOT gate
   out <== 1 + in - 2*in;
}

// Main component instance of Multiplier2 template
component main = Multiplier2();
