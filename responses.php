<?php
    // start the session
    session_start();

    // get the session varible if it exists
    $counter = $_SESSION['counter'];

    // if it doesnt, set the default
    if(!strlen($counter)) {
        $counter = 0;
    }

    if($counter > 10) {
		$counter = 0;
	}

    // increment it
    $counter++;

    // save it
    $_SESSION['counter'] = $counter;

	$respmessage = "";
	
	if (empty($_REQUEST["FromCity"])) {
		$user_name = '';
	} else {
		$user_name = $_REQUEST["FromCity"];
	}

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
    	$respmessage = "Traffickers, whether from the village or from outside the village, cannot operate anymore. Enter 1- completely true; 2- partially true; 3- completely untrue ";
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
    }
	
	


    // output the counter response
    header("content-type: text/xml");
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
?>
<Response>
    <SMS><?php echo $respmessage ?> <?php echo $counter ?> times</SMS>
</Response>