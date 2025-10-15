<?php
// Database Connection Sitting
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "De Pillen All-stars";

// Header for JSON respnse
header('Content-Type: application/json; charest=utf-8');
header('Access-Contol-Allow-Origin: *'); // Allows all domains to access

// Git category from URL 
$category = isset($_GET['category']) ? $_GET['category'] : '';

//SQL Query Construction
$sql = "SELECT product_id, naam, bescrijving, prijs, afbeelding_url, category FROM product";
$params = []; //array to store parameters
$where_clauses = [];