const amqp = require('amqplib');
const cron = require('node-cron');
const pool = require('../config/db'); // Assuming you have a db.js file for your database connection
const { differenceInDays, differenceInWeeks, differenceInMonths, addDays, addWeeks, addMonths } = require('date-fns');
const logger = require('../middlewares/logger')
const dayjs = require('dayjs');
const utc = require('dayjs/plugin/utc');
dayjs.extend(utc);
let channel;
(async () => {
  const connection = await amqp.connect(process.env.RABBITMQ_URL_AWS);
  channel = await connection.createChannel();
  await channel.assertQueue("notification_queue");
})();
// const trackMissedPayments = async () => {
//     // Cron job to run daily (you can adjust the frequency based on your requirement)
//    cron.schedule('0 0 * * *', async () => {
//         console.log('Checking for missed payments...');

//         // Get current date in UTC format
//         const today = new Date();
//         const todayUtc = today.toISOString().split('T')[0]; // Ensure UTC date format
//         console.log("datae")
//         try {
//             var sql1 = `SELECT I.id AS investment_id, I.userId, I.schemeId, I.chitId, 
//                 S.scheme_plan_type_id, C.payment_frequency as payment_frequency_id, I.dueDate as due_date, 
//                 C.AMOUNT as expected_amount, SP.name as schemeType, PF.name as payment_frequency,
//                 MAX(P.payment_date) AS lastPaymentDate 
//          FROM investments I
//          JOIN chits C ON I.chitId = C.id
//          JOIN schemes S ON I.schemeId = S.id
//          JOIN scheme_plan_types SP ON S.scheme_plan_type_id = SP.id
//          JOIN payment_frequencies PF ON C.payment_frequency = PF.id
//          LEFT JOIN payments P ON I.id = P.investment_id 
//          WHERE I.status = 'ACTIVE' group by I.id, I.userId, I.schemeId, I.chitId, S.scheme_plan_type_id, C.payment_frequency, I.dueDate, C.AMOUNT, SP.name, PF.name;`
//             const [investments] = await pool.execute(
//                 sql1
//             );
//             console.log("investments", investments)

//             const missedPayments = []; // Collect missed payments for batch insert
//             const allowedFrequencies = ['daily', 'weekly', 'monthly'];
//             // Iterate over investments to calculate missed payments
//             for (const investment of investments) {
//                 const { investment_id, userId, schemeId, chitId, scheme_plan_type_id, payment_frequency_id, due_date, expected_amount, lastPaymentDate, payment_frequency, schemeType } = investment;
//                 const isFixed = (investment.schemeType.toLowerCase() === 'fixed');
//                 if (schemeType.toLowerCase() === 'flexi') {
//                     console.log(`Skipping flexi plan for investment_id ${investment_id}`);
//                     continue; // Skip this record
//                 }

//                 // 🚨 Edge Case 2: Handle First-Time Users with No Payment Records
//                 if (!lastPaymentDate) {
//                     console.log(`First-time user detected for investment_id ${investment_id}. No missed payments to track.`);
//                     continue;
//                 }
//                 // Validate last payment date and payment frequency
//                 if (!payment_frequency) {
//                     console.log(`Skipping investment_id ${investment_id} due to missing lastPaymentDate or payment_frequency.`);
//                     continue; // Skip if essential data is missing
//                 }


//                 // Convert last payment date to Date object
//                 const lastPaymentDateObj = new Date(lastPaymentDate);
//                 console.log("lastpatae", lastPaymentDate)

//                 if (isNaN(lastPaymentDateObj.getTime())) {
//                     console.log(`Invalid last payment date for investment_id ${investment_id}.`);
//                     continue; // Skip if invalid last payment date
//                 }
//                 // Skip if last payment date is in the future
//                 if (lastPaymentDateObj > today) {
//                     console.log(`Future last payment date found for investment_id ${investment_id}. Skipping.`);
//                     continue;
//                 }

//                 // Validate payment frequency
//                 if (!payment_frequency || !allowedFrequencies.includes(payment_frequency.toLowerCase())) {
//                     console.log(`Invalid or unknown payment frequency for investment_id ${investment_id}. Skipping.`);
//                     continue;
//                 }

//                 // Skip if investment is already matured
//                 if (new Date(due_date) < today) {
//                     console.log(`Investment already matured for investment_id ${investment_id}. Skipping.`);
//                     continue;
//                 }

//                 // Skip if user already paid today
//                 if ((payment_frequency.toLowerCase() === 'daily') && (differenceInDays(today, lastPaymentDateObj) <= 0)) {
//                     console.log(`User already paid today for investment_id ${investment_id}. No missed payment.`);
//                     continue;
//                 }


//                 // Calculate missed payments based on frequency
//                 let periodsMissed = 0;


//                 if (isFixed) {
//                     if (payment_frequency.toLowerCase() === 'daily') {
//                         periodsMissed = differenceInDays(today, lastPaymentDateObj);
//                     } else if (payment_frequency.toLowerCase() === 'weekly') {
//                         periodsMissed = differenceInWeeks(today, lastPaymentDateObj);
//                     } else if (payment_frequency.toLowerCase() === 'monthly') {
//                         periodsMissed = differenceInMonths(today, lastPaymentDateObj);
//                     }
//                 }
//                 // If there are missed payments, collect data for batch insert
//                 if (periodsMissed > 0) {
//                     missedPayments.push({
//                         investment_id,
//                         user_id: userId,
//                         scheme_id: schemeId,
//                         chit_id: chitId,
//                         scheme_plan_type_id,
//                         payment_frequency_id,
//                         due_date,
//                         expected_amount,
//                         payment_frequency,
//                         missedDate: todayUtc
//                     });
//                     console.log(`Missed payment for investment_id: ${investment_id}, missed periods: ${periodsMissed}`);
//                 }
//             }
//             console.log("missedPayments", missedPayments)
//             // Insert missed payments into missed_payments table if any exist
//             if (missedPayments.length > 0) {
//                 const insertValues = missedPayments.map(payment => [
//                     payment.investment_id,
//                     payment.user_id,
//                     payment.scheme_id,
//                     payment.chit_id,
//                     payment.scheme_plan_type_id,
//                     payment.payment_frequency_id,
//                     payment.due_date,
//                     payment.expected_amount,
//                     payment.payment_frequency,
//                     'missed',
//                     payment.missedDate
//                 ]);

//                 await pool.query(
//                     `INSERT INTO missed_payments (investment_id, user_id, scheme_id, chit_id, scheme_plan_type_id, 
//              payment_frequency_id, due_date, expected_amount, payment_frequency, status, missedDate)
//              VALUES ?`,
//                     [insertValues]
//                 );

//                 console.log(`Inserted ${missedPayments.length} missed payment(s) into the database.`);
//             }
//         } catch (error) {
//             logger.error(error)
//             console.error('Error checking missed payments:', error);
//         }
//     });
// };

const trackMissedPaymentsNew = async () => {
    console.log("cronfunction is working")
  cron.schedule('* * * * *', async () => {
    console.log('Checking for missed payments...');
    const today = new Date();
    console.log("today",today)
    const todayUtc = today.toISOString().split('T')[0];
    const validUnits = ['daily', 'weekly', 'monthly'];
    const gracePeriodDays = 0;
    const MAX_ITERATIONS = 500;

    try {
      const [investments] = await pool.execute(`
        SELECT 
  I.id AS investment_id,
  I.userId,
  I.schemeId,
  I.chitId,
  I.end_date,
  S.scheme_plan_type_id,
  C.payment_frequency AS payment_frequency_id,
  I.dueDate AS due_date,
  I.firstMonthAmount AS expected_amount,
  SP.name AS schemeType,
  PF.name AS payment_frequency,
  PF.interval_unit,
  PF.interval_count,
  (
    SELECT MAX(P1.payment_date) 
    FROM payments P1 
    WHERE P1.investment_id = I.id
  ) AS lastPaymentDate,
  (
    SELECT MIN(P2.payment_date) 
    FROM payments P2 
    WHERE P2.investment_id = I.id
  ) AS firstPaymentDate,
  I.createdAt
FROM investments I
JOIN chits C ON I.chitId = C.id
JOIN schemes S ON I.schemeId = S.id
JOIN scheme_plan_types SP ON S.scheme_plan_type_id = SP.id
JOIN payment_frequencies PF ON C.payment_frequency = PF.id
WHERE I.status = 'ACTIVE';
`);

      const missedPayments = [];


      const getMissedPaymentDates = (startDate, endDate, unit, count) => {
        const dates = [];
        let nextDate = new Date(startDate);
        let counter = 0;
        switch (unit.toLowerCase()) {
          case 'daily':
            nextDate = addDays(nextDate, count);
            while (nextDate <= endDate && counter++ < MAX_ITERATIONS) {
              dates.push(new Date(nextDate));
              nextDate = addDays(nextDate, count);
            }
            break;
          case 'weekly':
            nextDate = addWeeks(nextDate, count);
            while (nextDate <= endDate && counter++ < MAX_ITERATIONS) {
              dates.push(new Date(nextDate));
              nextDate = addWeeks(nextDate, count);
            }
            break;
          case 'monthly':
            nextDate = addMonths(nextDate, count);
            while (nextDate <= endDate && counter++ < MAX_ITERATIONS) {
              dates.push(new Date(nextDate));
              nextDate = addMonths(nextDate, count);
            }
            break;
        }
        return dates;
      };

      for (const inv of investments) {
        const {
          investment_id, userId, schemeId, chitId,
          scheme_plan_type_id, payment_frequency_id, due_date,
          expected_amount, lastPaymentDate, payment_frequency,
          interval_unit, interval_count, schemeType, createdAt, firstPaymentDate,end_date
        } = inv;
            console.log("todaycheckin",today,new Date(due_date))
           
        if (!interval_unit || !interval_count || interval_count <= 0) {
          console.log(`Skipping investment_id ${investment_id} due to missing/invalid interval info.`);
          continue;
        }

        if (!validUnits.includes(interval_unit.toLowerCase())) {
          console.log(`Invalid interval_unit "${interval_unit}" for investment_id ${investment_id}, skipping.`);
          continue;
        }

        if (schemeType.toLowerCase() === 'flexi') {
          console.log(`Skipping flexi plan for investment_id ${investment_id}`);
          continue;
        }

        if (new Date(end_date) < today) {
          console.log(`Investment matured for investment_id ${investment_id}, skipping.`);
          continue;
        }

        const startDate = lastPaymentDate
          ? new Date(lastPaymentDate)
          : (firstPaymentDate
            ? new Date(firstPaymentDate)
            : new Date(createdAt));

        if (isNaN(startDate.getTime()) || startDate > today) {
          console.log(`Invalid start date for investment_id ${investment_id}, skipping.`);
          continue;
        }

        if (!expected_amount || expected_amount <= 0) {
          console.log(`Invalid expected amount (${expected_amount}) for investment_id ${investment_id}, skipping.`);
          continue;
        }

        const yesterday = new Date(today);
        yesterday.setDate(yesterday.getDate() - 1);

        const missedDates = getMissedPaymentDates(startDate, yesterday, interval_unit, interval_count);

        if (missedDates.length === 0) {
          console.log(`No missed payments for investment_id ${investment_id}`);
          continue;
        }

        const missedStart = new Date(missedDates[0]);
        missedStart.setDate(missedStart.getDate() - gracePeriodDays);

        const missedEnd = new Date(missedDates[missedDates.length - 1]);
        missedEnd.setDate(missedEnd.getDate() + gracePeriodDays);
      console.log("Last Payment Date:", lastPaymentDate);
      console.log("Payment Dates:", firstPaymentDate);
      console.log("Missed Dates:", missedDates);
      
        await pool.query(`
          DELETE mp FROM missed_payments mp
          JOIN payments p ON mp.investment_id = p.investment_id
          WHERE mp.investment_id = ? 
            AND mp.missedDate BETWEEN ? AND ?
            AND p.payment_date BETWEEN DATE_SUB(mp.missedDate, INTERVAL ? DAY) AND DATE_ADD(mp.missedDate, INTERVAL ? DAY)
        `, [
          investment_id,
          missedStart.toISOString().split('T')[0],
          missedEnd.toISOString().split('T')[0],
          gracePeriodDays,
          gracePeriodDays
        ]);

        for (const missedDateObj of missedDates) {
          const missedDateStr = dayjs(missedDateObj).startOf('day').format('YYYY-MM-DD')
          console.log("missed start in loop",missedDateStr)
          if (missedDateStr > dayjs(due_date).startOf('day').format('YYYY-MM-DD')) {
            console.log(`Missed date ${missedDateStr} is after due date ${due_date}, skipping.`);
            continue;
          }
          console.log("missedstr",missedDateStr)
          const [rows] = await pool.query(`
            SELECT 1 FROM payments
            WHERE investment_id = ?
              AND payment_date BETWEEN DATE_SUB(?, INTERVAL ? DAY) AND DATE_ADD(?, INTERVAL ? DAY)
            LIMIT 1
          `, [
            investment_id,
            missedDateStr,
            gracePeriodDays,
            missedDateStr,
            gracePeriodDays
          ]);

          if (rows.length > 0) {
            console.log(`Late payment found for investment_id ${investment_id} covering missed date ${missedDateStr}, skipping insertion.`);
            continue;
          }

          missedPayments.push([
            investment_id,
            userId,
            schemeId,
            chitId,
            scheme_plan_type_id,
            payment_frequency_id,
            due_date,
            expected_amount,
            payment_frequency,
            'missed',
            missedDateStr,
          ]);
          
       
          console.log(`Missed payment for investment_id: ${investment_id} on ${missedDateStr}`);
           const notification = {
            userId,
            investment_id,
            missedDateStr,
            title: 'Missed Payment Alert',
            body: `You missed a gold chit payment due on ${missedDateStr}. Please pay soon.`
          };

          if (channel) {
            channel.sendToQueue("notification_queue", Buffer.from(JSON.stringify(notification)));
            console.log(`Notification queued for user ${userId}`);
          }
      
        }
      }
     
      
      
      if (missedPayments.length > 0) {
        await pool.query(`
          INSERT INTO missed_payments (
            investment_id, user_id, scheme_id, chit_id, scheme_plan_type_id, 
            payment_frequency_id, due_date, expected_amount, payment_frequency, status, missedDate
          )
          VALUES ?
          ON DUPLICATE KEY UPDATE status = VALUES(status)
        `, [missedPayments]);

        console.log(`Inserted ${missedPayments.length} missed payment(s) into the database.`);
      } else {
        console.log('No missed payments found today.');
      }

      console.log(`Total active investments processed: ${investments.length}`);
    } catch (error) {
      logger.error('Error checking missed payments:', error)
      console.error('Error checking missed payments:', error);
    }
  });
};




module.exports = { 
  //trackMissedPayments,
  trackMissedPaymentsNew };
