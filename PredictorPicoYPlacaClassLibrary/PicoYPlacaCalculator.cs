using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PredictorPicoYPlacaClassLibrary
{
    public class PicoYPlacaCalculator
    {
        /// <summary>
        /// GEts the PicoYPlaca rule
        /// </summary>
        /// <param name="platenumber"> license plate number</param>
        /// <param name="date">current date</param>
        /// <param name="time">current time</param>
        /// <returns>message to user indicating if his car can be or not in the road</returns>
        public string CalculatePicoyPlacaRule(string platenumber, string date, string time)
        {
   
            int lastdigit = Convert.ToInt32(platenumber.Substring(7, 1));
            int day = Convert.ToInt32(date.Substring(0, 2));
            int month = Convert.ToInt32(date.Substring(3, 2));
            int year = Convert.ToInt32(date.Substring(6, 4));

            DateTime dateValue = new DateTime(year, month, day);
            int dayofweek = (int)dateValue.DayOfWeek;

            TimeSpan hour = TimeSpan.Parse(time);
            int part = 0;
            string result = "";

            if (hour < TimeSpan.Parse("12:00"))
                part = 1;
            else
                part = 2;


            using (var db = new PicoyPlacaPredictorEntities())
            {
                var picoYPlacaRule = GetPicoYplacaRule(lastdigit, dayofweek, db);

                var sch = GetScheduleList(ref hour, part, db);

                if (picoYPlacaRule.Count() > 0 && sch.Count() > 0)

                    result = String.Format("It is {0} {1} in the {2}, so your car can't be on the road",
                        picoYPlacaRule[0].DayOfWeek.DayName.ToString(),
                        hour,
                        sch[0].ScheduleName.ToString());
                else
                {
                    var day1 = GetDayOfWeekList(dayofweek, db);
                    var sch1 = GetScheduleList(part, db);

                    result = String.Format("It is {0} {1} in the {2}, so your car can be on the road",
                        day1[0].DayName.ToString(),
                        hour,
                        sch1[0].ScheduleName.ToString());
                }
            }

            return result;

        }

        /// <summary>
        /// Get the schedule list
        /// </summary>
        /// <param name="part"> if its is before or  after noon</param>
        /// <param name="db">data base</param>
        /// <returns>list of schedule</returns>
        private static List<Schedule> GetScheduleList(int part, PicoyPlacaPredictorEntities db)
        {
            var sch1 = db.Schedule.Where(s => s.Id == part).ToList();
            return sch1;
        }


        /// <summary>
        /// Returns the days of week 
        /// </summary>
        /// <param name="dayofweek">id day of week</param>
        /// <param name="db">data base</param>
        /// <returns>list of days of week</returns>
        private static List<DayOfWeek> GetDayOfWeekList(int dayofweek, PicoyPlacaPredictorEntities db)
        {
            var day1 = db.DayOfWeek.Where(d => d.Id == dayofweek).ToList();
            return day1;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="hour"></param>
        /// <param name="part"></param>
        /// <param name="db"></param>
        /// <returns></returns>
        private static List<Schedule> GetScheduleList(ref TimeSpan hour, int part, PicoyPlacaPredictorEntities db)
        {
            TimeSpan param = new TimeSpan();
            param = hour;

            var sch = db.Schedule.Where(s => s.Id == part && (s.StartTime <= param && s.EndTime >= param)).ToList();
            return sch;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="lastdigit"></param>
        /// <param name="dayofweek"></param>
        /// <param name="db"></param>
        /// <returns></returns>
        private static List<PicoYPlaca> GetPicoYplacaRule(int lastdigit, int dayofweek, PicoyPlacaPredictorEntities db)
        {
            var picoYPlacaRule = db.PicoYPlaca.Where(p => p.LicensePlateNumber == lastdigit && p.IdDayOfWeek == dayofweek).ToList();
            return picoYPlacaRule;
        }
    }
}
