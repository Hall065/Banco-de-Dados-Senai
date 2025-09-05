<?php

echo "Hello, World!";

?>

import mysql.connector

# Connect to the MySQL server
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="senaisp",
    database="BD_Fornecimento"
)

 cursor = conn.cursor()

 # Run a query
    cursor.execute("SELECT * FROM fornecedores")