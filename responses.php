<?php
    // start the session
    session_start();

    // get the session varible if it exists
    $counter = $_SESSION['counter'];

    // if it doesnt, set the default
    if(!strlen($counter)) {
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

    if($user_name === "ATLANTA") {
    	$respmessage = "I GOT YOUR MESSAGE";
    } else {
    	$respmessage = $user_name . ' ' ."WHO EVEN ARE YOU";
    }

    // output the counter response
    header("content-type: text/xml");
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
?>
<Response>
    <SMS><?php echo $user_name ?> wants to know <?php echo $counter ?> times</SMS>
</Response>