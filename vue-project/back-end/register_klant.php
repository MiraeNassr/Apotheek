<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Log file for debugging
$logFile = __DIR__ . '/register_debug.log';
function logDebug($message) {
    global $logFile;
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($logFile, "[$timestamp] $message\n", FILE_APPEND);
}

// Include database configuration
require_once 'db_config.php';

logDebug('Registration endpoint called');

// Set CORS headers (allow dev server origins)
$allowed_origins = [
    'http://localhost:5173',
    'http://localhost:5174'
];

$origin = isset($_SERVER['HTTP_ORIGIN']) ? $_SERVER['HTTP_ORIGIN'] : '';
if (in_array($origin, $allowed_origins)) {
    header("Access-Control-Allow-Origin: $origin");
}

header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Credentials: true');

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header('HTTP/1.1 200 OK');
    exit();
}

// Set JSON response type
header('Content-Type: application/json');

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit();
}

try {
    // Get JSON data from request body
    $json = file_get_contents('php://input');
    logDebug("Received data: " . $json);
    
    $data = json_decode($json, true);

    if (!$data) {
        logDebug("JSON decode failed: " . json_last_error_msg());
        throw new Exception('Invalid JSON data');
    }
    
    logDebug("Decoded data: " . print_r($data, true));

    // Validate required fields
    $required_fields = ['naam', 'email', 'wachtwoord'];
    foreach ($required_fields as $field) {
        if (empty($data[$field])) {
            throw new Exception("Missing required field: $field");
        }
    }

    // Validate email format
    if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
        throw new Exception('Invalid email format');
    }

    // Get database connection
    $conn = getDBConnection();

    // Check if email already exists
    $stmt = $conn->prepare("SELECT klant_id FROM klant WHERE email = ?");
    $stmt->bind_param("s", $data['email']);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        throw new Exception('Email already registered');
    }

    // Hash password
    $hashed_password = password_hash($data['wachtwoord'], PASSWORD_DEFAULT);

    // Prepare insert statement
    $stmt = $conn->prepare("INSERT INTO klant (naam, email, wachtwoord, adres) VALUES (?, ?, ?, ?)");
    
    // Fix for bind_param reference issue
    $naam = $data['naam'];
    $email = $data['email'];
    $adres = isset($data['adres']) ? $data['adres'] : '';
    
    $stmt->bind_param("ssss", 
        $naam,
        $email,
        $hashed_password,
        $adres
    );
    
    logDebug("Attempting to insert user: $naam, $email");

    // Execute insert
    if (!$stmt->execute()) {
        logDebug("Insert failed: " . $stmt->error);
        throw new Exception('Failed to register user: ' . $stmt->error);
    }

    logDebug("User successfully registered with ID: " . $conn->insert_id);

    // Return success response
    http_response_code(201);
    echo json_encode([
        'success' => true,
        'message' => 'Registration successful',
        'userId' => $conn->insert_id
    ]);

} catch (Exception $e) {
    // Return error response
    http_response_code(400);
    echo json_encode([
        'error' => $e->getMessage()
    ]);
}