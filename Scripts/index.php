<?php

$cSession = curl_init(); 
curl_setopt($cSession,CURLOPT_URL,"http://54.191.254.133:5005/v2/keys/message");
curl_setopt($cSession,CURLOPT_RETURNTRANSFER,true);
curl_setopt($cSession,CURLOPT_HEADER, false); 
$result=curl_exec($cSession);
curl_close($cSession);

$obj = json_decode($result, true);


$servername = $obj['node']['value']; ;
$username = "root";
$password = "123";
$mydb = "dummy";

// Create connection
$conn = new mysqli($servername, $username, $password,$mydb);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
echo "Connected successfully " . "<br>";

echo $conn->host_info . "<br>";

echo " Query table dummy <br>";

$val = $conn->query("select dummy from dummy");

if ($val->num_rows > 0) {
    while($row = $val->fetch_assoc()) {
        echo "id: " . $row["dummy"]."<br>"; 
    }
} else {
    echo "0 results";
}


?>

