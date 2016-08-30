using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using PredictorPicoYPlacaClassLibrary;

namespace PredictorPicoYPlacaUnitTest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public string TestMethod1()
        {
            PicoYPlacaCalculator PicoYPlacaRule = new PicoYPlacaCalculator();
            string message = PicoYPlacaRule.CalculatePicoyPlacaRule("PDA-8623", "30/08/2016", "07:34");
            return message;
        }


        [TestMethod]
        public string TestMethod2()
        {
            //Valid date
            PicoYPlacaCalculator PicoYPlacaRule = new PicoYPlacaCalculator();
            string message = PicoYPlacaRule.CalculatePicoyPlacaRule("PDA-8623", "30/98/2016", "07:34");
            return message;
        }

        [TestMethod]
        public string TestMethod3()
        {
            //invalid license plate number
            PicoYPlacaCalculator PicoYPlacaRule = new PicoYPlacaCalculator();
            string message = PicoYPlacaRule.CalculatePicoyPlacaRule("PDAE8623", "30/08/2016", "07:34");
            return message;
        }

        [TestMethod]
        public string TestMethod4()
        {
            //invalid hour
            PicoYPlacaCalculator PicoYPlacaRule = new PicoYPlacaCalculator();
            string message = PicoYPlacaRule.CalculatePicoyPlacaRule("PDA-8623", "30/08/2016", "07:90");
            return message;
        }



    }
}
