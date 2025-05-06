## Ist part: Bank Loan Report| SUMMARY

#PRIMARY KPI's

#1. Total Loan applications
SELECT COUNT(ID) AS Total_loan_applications 
FROM financial_loan;

#1a. MTD(Month to date) Loan applications
SELECT count(id) AS MTD_Total_loan_applications 
FROM financial_loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

#1b.Previous MTD Loan applications
SELECT count(id) AS PMTD_Total_loan_applications 
FROM financial_loan
WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

#2.Total Funded amount
SELECT SUM(loan_amount) AS Total_funded_amount 
FROM financial_loan;

#2a. MTD Funded amount
SELECT 
	SUM(loan_amount) AS MTD_Total_funded_amount 
FROM financial_loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

#2b. PMTD Funded amount
SELECT 
	SUM(loan_amount) AS PMTD_Total_funded_amount 
FROM financial_loan
WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

#3. Total Amount received
SELECT 
      SUM(total_payment) AS Total_amt_received 
FROM financial_loan;

#3a. MTD Total Amount received
SELECT 
      SUM(total_payment) AS MTD_Total_amt_received 
FROM financial_loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

#3b. PMTD Total Amount received
SELECT 
      SUM(total_payment) AS PMTD_Total_amt_received 
FROM financial_loan
WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

#4 Average Interest Rate
SELECT 
      ROUND(AVG(int_rate)*100,2)  AS Avg_int_rate
FROM financial_loan;

#4a.MTD Average Interest Rate
SELECT
      ROUND(AVG(int_rate)*100,2) AS MTD_Avg_int_rate 
FROM financial_loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

#4b. PMTD Average Interest Rate
SELECT 
      ROUND(AVG(int_rate)*100,2) AS PMTD_Avg_int_rate 
FROM financial_loan
WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021;

#5 Average DTI
SELECT 
      ROUND(AVG(dti)*100,2) AS Avg_dti 
FROM financial_loan; 

#5a. MTD  Average DTI
SELECT 
      ROUND(AVG(dti)*100,2) AS MTD_Avg_dti 
FROM financial_loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021;

#5b. PMTD Average DTI
SELECT 
      ROUND(AVG(dti)*100,2) AS PMTD_Avg_dti 
FROM financial_loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021; 


##GOOD LOAN
select distinct(loan_status) from financial_loan; 

#1). Good Loan Application Percentage:
SELECT 
      ROUND((COUNT(CASE WHEN loan_status IN ("Fully paid","current") THEN ID END )) /
      Count(id)*100,2) AS Good_loan_applications_percentage 
FROM financial_loan;

#2). Good Loan Applications:
SELECT 
      count(id) AS Total_Good_loan_applications 
FROM financial_loan
WHERE loan_status IN ("fully paid","current");

#3). Good Loan Funded Amount: 
SELECT 
       SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM financial_loan
WHERE loan_status IN ("fully paid","current");

#4).Good Loan Total Received Amount: 
SELECT 
      SUM(total_payment) AS Good_Loan_Total_Received_Amount 
FROM financial_loan
WHERE loan_status IN ("fully paid","current");

##Bad Loan KPIs:

#1.Bad Loan Application Percentage: 
SELECT  
       ROUND((COUNT(CASE WHEN loan_status='charged off' THEN id end)/
       count(id)*100),2)
AS Bad_Loan_Applications_percentage 
FROM financial_loan;

#2.Bad Loan Applications:
SELECT 
      COUNT(ID) AS Bad_Loan_Applications 
FROM financial_loan
WHERE loan_status='charged off';
 
#3.	Bad Loan Funded Amount: 
SELECT 
	SUM(loan_amount)  AS Bad_Loan_Funded_Amount 
FROM financial_loan
WHERE loan_status='charged off';

#4.Bad Loan Total Received Amount: 
SELECT 
	SUM(total_payment) AS Bad_Loan_Total_Received_Amount
FROM financial_loan
WHERE loan_status='charged off';

##Loan Status Grid View
SELECT loan_status,count(id) AS Total_loan_applications,
	   SUM(loan_amount) AS Total_funded_amount,
	   SUM(total_payment) AS Total_amt_received,
	   ROUND(AVG(int_rate)*100,2)  AS Avg_int_rate,
       ROUND(AVG(dti)*100,2) AS Avg_dti
        FROM financial_loan
	    GROUP BY loan_status;
        
SELECT loan_status,
       SUM(loan_amount) AS MTD_Total_funded_amount,
       SUM(total_payment) AS MTD_Total_amt_received
       FROM financial_loan
       WHERE MONTH(issue_date)=12
	   GROUP BY loan_status;


       
## Dashboard 2--OVERVIEW

#1).Monthly Trends by Issue Date:
SELECT MONTH(issue_date),
       MONTHNAME(issue_date),
       COUNT(ID) AS Total_loan_applications,
       SUM(loan_amount) AS Total_funded_amount,
       SUM(total_payment) AS Total_amt_received FROM financial_loan
GROUP BY MONTH(issue_date),MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

#2).Regional Analysis by State:
SELECT address_state,
       COUNT(ID) AS Total_loan_applications,
       SUM(loan_amount) AS Total_funded_amount,
       SUM(total_payment) AS Total_amt_received 
FROM financial_loan
GROUP BY address_state
ORDER BY COUNT(ID) DESC;

#3).Loan Term Analysis:
SELECT term,
       COUNT(ID) AS Total_loan_applications,
       SUM(loan_amount) AS Total_funded_amount,
       SUM(total_payment) AS Total_amt_received FROM financial_loan
GROUP BY term;

#4).Employee Length Analysis:
SELECT emp_length,
       COUNT(ID) AS Total_loan_applications,
       SUM(loan_amount) AS Total_funded_amount,
       SUM(total_payment) AS Total_amt_received 
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

#5).Loan Purpose Breakdown:
SELECT purpose,
       COUNT(ID) AS Total_loan_applications,
       SUM(loan_amount) AS Total_funded_amount,
       SUM(total_payment) AS Total_amt_received 
FROM financial_loan
GROUP BY purpose;

#6). Home Ownership Analysis:
SELECT home_ownership,
	   COUNT(ID) AS Total_loan_applications,
       SUM(loan_amount) AS Total_funded_amount,
       SUM(total_payment) AS Total_amt_received 
FROM financial_loan
GROUP BY home_ownership;