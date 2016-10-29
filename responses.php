<?php
	require_once  "vendor/autoload.php"; // Loads the library
	use Twilio\Rest\Client;
	$AccountSid = "ACc37ba068fc3bcacd005c3dc1b9e4a5f7";
    $AuthToken = "59979b14ac1806a124d391213f3182b3";
    $client = new Client($AccountSid, $AuthToken);

    // start the session
    session_start();

    // get the session varible if it exists
    $counter = $_SESSION['counter'];

    // if it doesnt, set the default
    if(!strlen($counter)) {
        $counter = 0;
    }

    // get the language varible if it exists
    if (!isset($_SESSION['language'])) {
    	$_SESSION['language'] = 1;
    	
	}
	$language = $_SESSION['language'];

    // if it doesnt, set the default
   // if(!strlen($language)) {
     //   $language = 1;
    //}

    if($counter > 11) {
		$counter = 0;
	}

    // increment it
    $counter++;

    // save it
    $_SESSION['counter'] = $counter;
    $_SESSION['language'] = $language;

	$respmessage = "";
	
	if (empty($_REQUEST["MessageSid"])) {
		$message_id = '';
	} else {
		$message_id = $_REQUEST["MessageSid"];
	}

	// Get an object from its sid. If you do not have a sid,
	// check out the list resource examples on this page
	$sms = $client
    ->messages($message_id)
    ->fetch();
    $last_message = $sms->body;
	//$response = http_get("https://8bb1f52d.ngrok.io/team-10/twilio/responses.php", array("timeout"=>1), $info);
	//print_r($info);

    //if($user_name === "ATLANTA") {
    //	$respmessage = "I GOT YOUR MESSAGE";
    //} else {
    //	$respmessage = $user_name . ' ' ."WHO EVEN ARE YOU";
    //}
    if($counter === 1) {
    	$respmessage = "Please choose your language. Enter 1- English; 2- Hindi; 3- French ";
    } elseif ($counter === 2) {
    	//check for language input
    	if($last_message === "1") {
    		$language = 1;
    		$respmessage = "Traffickers, whether from the village or from outside the village, cannot operate anymore. Enter 1- completely true; 2- partially true; 3- completely untrue ";	
    	} elseif ($last_message === "2") {
    		$language = 2;
    		$respmessage = "Message in Hindi";
    	} elseif ($last_message === "3") {
    		$language = 3;
    		$respmessage = "Message in French";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "Traffickers, whether from the village or from outside the village, cannot operate anymore. Enter 1- completely true; 2- partially true; 3- completely untrue ";	
    	}
    	
    } elseif ($counter === 3) {
    	$respmessage = "No one residing in this village is any form of slavery. Enter 1- completely true; 2- partially true; 3- completely untrue";
    } elseif ($counter === 4) {
    	$respmessage = "People who migrate from this community for work are NOT being trafficked. Enter 1- completely true; 2- partially true; 3- completely untrue";
    } elseif ($counter === 5) {
    	$respmessage = "None of the childrean in this village are being exploited for commercial sex. Enter 1- completely true; 2- partially true; 3- completely untrue";
    } elseif ($counter === 6) {
    	$respmessage = "None of the children in this village are performing hazardous labor. Enter 1- completely true; 2- partially true; 3- completely untrue";
    } elseif ($counter === 7) {
    	$respmessage = "Residents in this village know how to protect themselves from trafficking during migration for work. Enter 1- completely true; 2- partially true; 3- completely untrue";
    } elseif ($counter === 8) {
    	$respmessage = "Residents understand the risks of sending children to distant jobs, e.g. domestic work, mining, or stone quarries, and circuses. Enter 1- completely true; 2- partially true; 3- completely untrue";
    } elseif ($counter === 9) {
    	$respmessage = "Residents are able to identify and pressure known traffickers to leave when they appear in the community. Enter 1- completely true; 2- partially true; 3- completely untrue";
    } elseif ($counter === 10) {
    	$respmessage = "Residents in this village know how to avoid debt bondage. Enter 1- completely true; 2- partially true; 3- completely untrue";
    } elseif ($counter === 11) {
    	$respmessage = "Residents understand the risks of early or forced marriage and false offers of marriage. Enter 1- completely true; 2- partially true; 3- completely untrue";
    } else {
    	$respmessage = "wow";
    }
	
	


    // output the counter response
    header("content-type: text/xml");
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
?>
<Response>
    <SMS>LANGUAGE:<?php echo $language ?> LAST MESSAGE: <?php echo $last_message ?> <?php echo $respmessage ?> <?php echo $counter ?> times</SMS>
</Response>