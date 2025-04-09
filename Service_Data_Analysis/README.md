# Service Data Analysis Project

This project explores service-related data using SQL. By analyzing device returns, failures, and customer behaviors, we aim to uncover key insights that help improve product quality and customer satisfaction. The project uses SQL techniques like Common Table Expressions (CTEs), Window Functions, and Aggregations. Below, we'll explore a series of important questions we can answer using this data.

---

## Table of Contents
1. [Project Purpose](#project-purpose)
2. [Data Analysis Questions](#data-analysis-questions)
3. [SQL Queries & Purpose](#sql-queries--purpose)
4. [Technologies Used](#technologies-used)
5. [Future Plans](#future-plans)

---

## Project Purpose

The goal of this project is to transform raw operational data into meaningful insights that can guide business decisions. We aim to improve the quality of products, optimize repair processes, and reduce unnecessary returns by answering important data-driven questions about device failures, customer interactions, and operational efficiency.

---

## Data Analysis Questions

In this analysis, we seek to answer the following key questions. Each question is designed to provide insights into product quality, customer behavior, and operational processes:

---

### 1. **What is the "UIC" rate?**

A crucial question for understanding whether customers are returning devices without an actual fault. This helps identify possible inefficiencies in the return process and areas where customer education or product documentation might be needed.

#### SQL Query:
```sql
-- This query calculates the rate of "No Trouble Found" (NTF) returns
SELECT 
    COUNT(CASE WHEN rma_remarks = 'G - Regular Return-Zebra DOA' THEN 1 END) * 100.0 / COUNT(*) AS ntf_rate
FROM 
    db_bounce_1NF;