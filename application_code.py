#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jun 21 19:27:25 2023

@author: tanishidatta
"""

'''
CS3200 Final Project
Kaydence Lin and Tanishi Datta
'''
'''
CS3200 Final Project
Kaydence Lin and Tanishi Datta
'''
import pymysql
import random

# Prompt the user for MySQL username and password
username = input("Enter MySQL username: ")
password = input("Enter MySQL password: ")

try:
    # Connect to the database
    db = pymysql.connect(
        host="localhost",
        user=username,
        password=password,
        database="banking_system"
    )

    # Create a cursor object
    cursor = db.cursor()

except pymysql.Error as e:
    print("Error connecting to MySQL:", str(e))
    exit()

# Create a cursor object
cursor = db.cursor()

# Create a new tuple in the database, create a new account in customer_id and acct_info tables
def create_user():
    # Get the name from the user
    first_name = input("Enter your first name: ")
    last_name = input("Enter your last name: ")

    # Get the preferred language from the user
    preferred_lang = input("Enter your preferred language: ")

    # Get the account type from the user
    while True:
        acct_type = input("Enter the account type (Savings/Checking): ")
        if acct_type in ['Savings', 'Checking']:
            break
        else:
            print("Invalid account type. Please enter either 'Savings' or 'Checking'.")

    # Get the pin number from the user
    while True:
        pin_num = input("Enter a 4-digit PIN number: ")
        if len(pin_num) == 4 and pin_num.isdigit():
            break
        else:
            print("Invalid PIN number. Please enter a 4-digit numeric PIN.")

    # Get the account balance from the user
    while True:
        acct_balance = input('Enter the amount of money you would like to deposit into this new account: ')
        try:
            acct_balance = float(acct_balance)
            # Check if the account balance has exactly 2 digits after the decimal place
            if int(acct_balance * 100) % 1 == 0:
                break
            else:
                print("Invalid account balance. Please enter a numeric value with two digits after the decimal point.")
        except ValueError:
            print("Invalid account balance. Please enter a numeric value.")

    try:
        # Call the AddNewCustomer procedure
        #customer_id = 0
        #args = (first_name, last_name, preferred_lang, (int,0))
        #customer_id =1
        cursor.callproc('AddNewCustomer', (first_name,last_name,preferred_lang,0))
        cursor.execute("Select @_AddNewCustomer_0,@_AddNewCustomer_1,@_AddNewCustomer_2,@_AddNewCustomer_3")
        result = cursor.fetchall()
        customer_id = result[0][3]
        #print(customer_id)
        
        #for result in cursor.stored_results():
        #    print(result.fetchall())


        # Call the CreateNewAcct procedure
        #acct_num = 0
        cursor.callproc('CreateNewAcct', (acct_type, acct_balance, pin_num, customer_id, 0))
        cursor.execute("Select @_CreateNewAcct_4")
       #  result = cursor.fetchone()
        acc_result = cursor.fetchall()
        #print(acc_result)
        account_num = acc_result[0][0]
        #print(account_num)

        db.commit()

        print("Account created successfully.")
        print("Account Number:", account_num)

    except pymysql.Error as e:
        db.rollback()
        print("Error creating account:", str(e))


# Delete a user and associated account from the database
def delete_user():
    # Get the customer ID from the user
    customer_id = input("Enter the customer ID: ")

    try:
        # Delete the associated transactions from the 'transactions' table
        cursor.execute(f"DELETE FROM transactions WHERE customer_id = {customer_id}")

        # Delete the associated account from the 'account' table
        cursor.execute(f"DELETE FROM account WHERE customer_id = {customer_id}")

        # Delete the user from the 'customer' table
        cursor.execute(f"DELETE FROM customer WHERE customer_id = {customer_id}")

        db.commit()
        print("User and associated account deleted successfully.")

    except pymysql.Error as e:
        db.rollback()
        print("Error deleting user and associated account:", str(e))
        
# Read data from the database
def read_data():
    # Prompt for table name
    table_name = input("Enter the table name to read from (customer or account): ")

    try:
        # Execute the select query
        cursor.execute(f"SELECT * FROM {table_name}")
        rows = cursor.fetchall()

        if len(rows) == 0:
            print("No data found in the table.")
        else:
            for row in rows:
                print(row)
    except pymysql.Error as e:
        print("Error reading data:", str(e))

# Update a tuple in the database
def update_tuple():
    # Prompt for table name, primary key, field name, and new value
    table_name = input("Enter the table name to update (customer or account): ")
    primary_key = input(f"Enter the primary key value for {table_name}_id: ")
    field_name = input("Enter the field name to update: ")
    new_value = input("Enter the new value: ")

    try:
        # Execute the update query
        cursor.execute(f"UPDATE {table_name} SET {field_name} = %s WHERE {table_name}_id = %s", (new_value, primary_key))
        db.commit()
        print("Tuple updated successfully.")
    except pymysql.Error as e:
        db.rollback()
        print("Error updating tuple:", str(e))

# Main menu
def main_menu():
    while True:
        print("\n--- BANKING SYSTEM ---")
        print("1. Create a new account")
        print("2. Delete account")
        print("3. Read table")
        print("4. Update table")
        print("0. Exit")

        choice = input("Enter your choice: ")

        if choice == "1":
            create_user()
        elif choice == "2":
            delete_user()
        elif choice == "3":
            read_data()
        elif choice == "4":
            update_tuple()
        elif choice == "0":
            break
        else:
            print("Invalid choice. Please try again.")

    # Close the cursor and database connection
    cursor.close()
    db.close()
    print("Thank you for using the Banking System.")

# Run the main menu
main_menu()
