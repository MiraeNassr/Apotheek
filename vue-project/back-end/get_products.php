<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Set CORS headers (allow dev server origin)
header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, Cache-Control, Accept');
header('Access-Control-Allow-Credentials: true');

// Handle preflight OPTIONS request early
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header('HTTP/1.1 200 OK');
    exit();
}

// Response headers
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-cache, no-store, must-revalidate');

// Include database configuration
require_once 'db_config.php';

// Get category from URL
$category = isset($_GET['category']) ? $_GET['category'] : '';

// SQL Query Construction
$sql = "SELECT product_id, naam, beschrijving, prijs, afbeelding_url, categorie FROM product";
$params = []; // array to store parameters
$where_clauses = [];

// if a category is specified, add the filtering condition
if (!empty($category)) {
    $where_clauses[] = "categorie = ?";
    $params[] = $category;
    error_log("Searching for category: " . $category); // Debug log
}

// Append the WHERE clause to the sql query
if (!empty($where_clauses)) {
    $sql .= " WHERE " . implode(" AND ", $where_clauses);
}

$products = [];

// connect to the database and execute the query
try {
    $conn = getDBConnection();

    error_log("Executing SQL: " . $sql);
    $stmt = $conn->prepare($sql);
    if ($stmt === false) {
        throw new Exception("Prepare failed: " . $conn->error);
    }

    // parameters
    if (!empty($params)) {
        $types = str_repeat('s', count($params));
        $stmt->bind_param($types, ...$params);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
    }

    // close the statement
    $stmt->close();

    // return results as json
    echo json_encode($products);

} catch (Exception $e) {
    // Error
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
