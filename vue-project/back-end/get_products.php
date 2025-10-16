<?php
// Database Connection Sitting
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "De Pillen All-stars";

//* Header for JSON respnse
//header('Content-Type: application/json; charest=utf-8');
//header('Access-Contol-Allow-Origin: *'); // Allows all domains to access

// Git category from URL 
$category = isset($_GET['category']) ? $_GET['category'] : '';

//SQL Query Construction
$sql = "SELECT product_id, naam, beschrijving, prijs, afbeelding_url, categorie FROM product";
$params = []; //array to store parameters
$where_clauses = [];

// if a category is specified, add the filtering condition
if(!empty($category)) {
    $where_clauses[] = "categorie = ?";
    $params[] =  $category;
}

//Append the WHERE clause to the sql query
if(!empty($where_clauses)) {
    $sql .= " WHERE " . implode(" AND ", $where_clauses);
}

$products = [];
$error_message = '' ;

//connect to the database and execute the queryy
try{
    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        throw new Exception("Connection faild: " . $conn->connect_error);
    }
    $stmt = $conn->prepare($sql);
    if ($stmt === false) {
        throw new Exception("Prepare failed: " . $conn->error);
    }
    //parameters
    if(!empty($params)) { 
        $types = str_repeat('s', count($params));
        $stmt->bind_param($types, ...$params);
    }
  $stmt->execute();
    $result = $stmt->get_result();

    $products = [];
    if ($result->num_rows > 0) {
         while($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
    }
// close the statment
 $stmt->close();
    $conn->close();

    //return results as json
    //echo json_encode($products);
}catch (Exception $e) {
    //Error
    $error_message = "Fout bij de databaseverbinding: " . $e->getMessage();
    //http_response_code(500);
    // echo json_encode(['error' => $e->getMessage()]);
}