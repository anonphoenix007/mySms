<?php

$botApiToken = '7728570474:AAFa2KV2mHpi-8vMPm_g1Eioe4CaTpN3txs';
$channelId = '1901603603';

// ⚠️ CHANGE THIS TO THE PATH OF YOUR TEXT DOCUMENT
$filePath = 'file.txt';

// Check if the file exists and is readable
if (!file_exists($filePath) || !is_readable($filePath)) {
    die("Error: The specified text file was not found or is not readable.");
}

// Read the content of the file into a string
$fileContent = file_get_contents($filePath);

// Check if the file content is empty
if ($fileContent === false || empty($fileContent)) {
    die("Error: The file is empty or could not be read.");
}

// Telegram API endpoint for sending a text message
$url = "https://api.telegram.org/bot{$botApiToken}/sendMessage";

// Prepare the data for the GET request
$query = http_build_query([
    'chat_id' => $channelId,
    'text' => $fileContent,
]);

$fullUrl = $url . '?' . $query;

$curl = curl_init();
curl_setopt_array($curl, array(
    CURLOPT_URL => $fullUrl,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_CUSTOMREQUEST => 'GET',
));

$response = curl_exec($curl);
curl_close($curl);

// Output the Telegram API response for debugging
echo $response;
?>
