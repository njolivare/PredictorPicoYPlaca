using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using PredictorPicoYPlacaClassLibrary;
using System.Text.RegularExpressions;

namespace PredictorPicoYPlaca
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Executes the prediction
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button1_Click(object sender, EventArgs e)
        {
            string message = "";
            PicoYPlacaCalculator rule = new PicoYPlacaCalculator();

            //Verifies the data before the prediction execution
            message = DataValidation();

            if (message != "")
                MessageBox.Show(message, "Pico y Placa Predictor", MessageBoxButtons.OK, MessageBoxIcon.Information);

            else
            {
                
                message = rule.CalculatePicoyPlacaRule(LicensePlateNumber.Text, Date.Text, Hour.Text);
                MessageBox.Show(message, "Pico y Placa Predictor", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

        }

        /// <summary>
        /// Data Validation
        /// </summary>
        /// <returns></returns>
        private string DataValidation()
        {
            string message = "";

            bool number = IsVAlidLicensePlateNumber(LicensePlateNumber.Text);
            bool date = IsValidDate(Date.Text);
            bool hour = IsValidTheHour(Hour.Text);

            if (!number)
                message = message + "Please check the license plate number. The correct format is AAA-9999";
            if (!date)
                message = message + "\nPlease check the date. The correct format is dd/mm/yyyy";
            if (!hour)
                message = message + "\nPlease check the hour. The correct format is 00:00 or 0:00";

            return message;

        }

        /// <summary>
        /// Validate se license plate number. Ensures this Format XXX-9999
        /// </summary>
        /// <param name="licensePlateNumber">license plate number</param>
        /// <returns></returns>
        private bool IsVAlidLicensePlateNumber(string licensePlateNumber)
        {
            //license number( XXX-9999)
            Regex rgxNumber = new Regex(@"^[a-zA-Z][a-zA-Z][a-zA-Z]-[0-9][0-9][0-9][0-9]$");
            bool number = rgxNumber.IsMatch(licensePlateNumber);
            return number;
        }

        /// <summary>
        /// Validate the date format and valid date dd/mm/yyyy
        /// </summary>
        /// <param name="day">date </param>
        /// <returns></returns>
        public bool IsValidDate(string day)
        {
            //DD/MM/YYYY
            DateTime temp;
            Regex rgxDate = new Regex(@"^[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]$");
            bool date = rgxDate.IsMatch(day);

            if (DateTime.TryParse(day, out temp))
                date = true;
            else
                date = false;

            return date;

        }

        /// <summary>
        /// Validates the hour in format 24H
        /// </summary>
        /// <param name="hour">hour from 00:00 to 23:59</param>
        /// <returns></returns>
        public bool IsValidTheHour(string hour)
        {
            //00:00 ||0:00
            Regex checktime = new Regex("^(?:0?[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$");
            if (!checktime.IsMatch(hour))
                return false;

            if (hour.Trim().Length < 5)
                hour = hour = "0" + hour;

            string hh = hour.Substring(0, 2);
            string mm = hour.Substring(3, 2);

            int h, m;
            if ((int.TryParse(hh, out h)) && (int.TryParse(mm, out m)))
            {
                if ((h >= 0 && h <= 23) && (m >= 0 && m <= 59))
                {
                    return true;
                }
            }
            return false;
        }
    }
}
