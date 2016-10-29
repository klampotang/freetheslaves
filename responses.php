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

    if($counter >= 11) {
		$counter = 0;
	}

    // increment it
    $counter++;

    // save it
    $_SESSION['counter'] = $counter;
    

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
    if($counter == 1) {
    	$respmessage = "Please choose your language. Enter 1- English; 2- Hindi हिंदी; 3- French français ";
    } elseif ($counter == 2) {
    	//check for language input
    	if($last_message == "1") {
    		$language = 1;
    		$respmessage = "Traffickers, whether from the village or from outside the village, cannot operate anymore. Enter 1- completely true; 2- partially true; 3- completely untrue ";	
    	} elseif ($last_message == "2") {
    		$language = 2;
    		$respmessage = "तस्कर, गांव से या गांव के बाहर से हैं, अब और काम नहीं कर सकते। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($last_message == "3") {
    		$language = 3;
    		$respmessage = "Les trafiquants, que ce soit du village ou de l'extérieur du village, ne peuvent plus fonctionner Entrez 1- complètement vrai;. 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, ask again
    	} else {
    		$respmessage = "Traffickers, whether from the village or from outside the village, cannot operate anymore. Enter 1- completely true; 2- partially true; 3- completely untrue ";	
    	}
    	
    } elseif ($counter == 3) {
    	
    	if($language == "1") {
    		$respmessage = "No one residing in this village is any form of slavery. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	} elseif ($language == "2") {
    		$respmessage = "कोई भी इस गांव में रहने वाले गुलामी के किसी भी रूप है। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($language == "3") {
    		$respmessage = "Personne résidant dans ce village est toute forme d'esclavage. Entrez 1- complètement vrai; 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "No one residing in this village is any form of slavery. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	}
    } elseif ($counter == 4) {
    	
    	if($language == "1") {
    		$respmessage = "People who migrate from this community for work are NOT being trafficked. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	} elseif ($language == "2") {
    		$respmessage = "जो लोग काम के लिए इस समुदाय से विस्थापित नहीं तस्करी की जा रही है। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($language == "3") {
    		$respmessage = "Les personnes qui migrent de cette communauté pour le travail ne sont PAS être victimes de la traite. Entrez 1- complètement vrai; 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "????????????People who migrate from this community for work are NOT being trafficked. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	}
    } elseif ($counter == 5) {
    	
    	if($language == "1") {
    		$respmessage = "None of the childrean in this village are being exploited for commercial sex. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	} elseif ($language == "2") {
    		$respmessage = "इस गांव में बच्चों में से कोई भी व्यावसायिक यौन शोषण के लिए किया जा रहा है। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($language == "3") {
    		$respmessage = "Aucun des enfants de ce village sont exploitées pour le commerce du sexe. Entrez 1- complètement vrai; 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "None of the childrean in this village are being exploited for commercial sex. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	}
    } elseif ($counter == 6) {
    	
    	if($language == "1") {
    		$respmessage = "None of the children in this village are performing hazardous labor. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	} elseif ($language == "2") {
    		$respmessage = "इस गांव में बच्चों में से कोई भी खतरनाक श्रम प्रदर्शन कर रहे हैं। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($language == "3") {
    		$respmessage = "Aucun des enfants dans ce village exécutent un travail dangereux. Entrez 1- complètement vrai; 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "None of the children in this village are performing hazardous labor. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	}
    } elseif ($counter == 7) {
    	
    	if($language == "1") {
    		$respmessage = "Residents in this village know how to protect themselves from trafficking during migration for work. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	} elseif ($language == "2") {
    		$respmessage = "इस गांव में निवासियों के काम के लिए प्रवास के दौरान अवैध व्यापार से खुद को बचाने के लिए कैसे पता है। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($language == "3") {
    		$respmessage = "Les habitants de ce village savent comment se protéger de la traite pendant la migration pour le travail. Entrez 1- complètement vrai; 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "Residents in this village know how to protect themselves from trafficking during migration for work. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	}
    } elseif ($counter == 8) {
    	
    	if($language == "1") {
    		$respmessage = "Residents understand the risks of sending children to distant jobs, e.g. domestic work, mining, or stone quarries, and circuses. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	} elseif ($language == "2") {
    		$respmessage = "निवासियों, दूर के नौकरियों के लिए बच्चों को भेजने के जोखिम को समझते हैं जैसे घरेलू काम, खनन, या पत्थर खदानों, और सर्कस। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($language == "3") {
    		$respmessage = "Les résidents comprennent les risques d'envoyer les enfants à des emplois éloignés, par exemple le travail domestique, l'exploitation minière, de pierre ou de carrières, et les cirques. Entrez 1- complètement vrai; 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "Residents understand the risks of sending children to distant jobs, e.g. domestic work, mining, or stone quarries, and circuses. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	}
    } elseif ($counter == 9) {
    	
    	if($language == "1") {
    		$respmessage = "Residents are able to identify and pressure known traffickers to leave when they appear in the community. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	} elseif ($language == "2") {
    		$respmessage = "निवासियों दबाव में जाना जाता है के तस्कर की पहचान करने और जब वे समुदाय में दिखाई छोड़ने के लिए सक्षम हैं। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($language == "3") {
    		$respmessage = "Les résidents sont en mesure d'identifier et de trafiquants de pression connue à partir quand ils apparaissent dans la communauté. Entrez 1- complètement vrai; 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "Residents are able to identify and pressure known traffickers to leave when they appear in the community. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	}
    } elseif ($counter == 10) {
    	
    	if($language == "1") {
    		$respmessage = "Residents in this village know how to avoid debt bondage. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	} elseif ($language == "2") {
    		$respmessage = "इस गांव में निवासियों ऋण बंधन से बचने के लिए कैसे पता है। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($language == "3") {
    		$respmessage = "Les habitants de ce village savent comment éviter la servitude pour dettes. Entrez 1- complètement vrai; 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "Residents in this village know how to avoid debt bondage. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	}
    } elseif ($counter == 11) {
    	
    	if($language == "1") {
    		$respmessage = "Residents understand the risks of early or forced marriage and false offers of marriage. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	} elseif ($language == "2") {
    		$respmessage = "निवासियों जल्दी या जबरन शादी और शादी के झूठे प्रस्तावों के जोखिम को समझते हैं। 1- पूरी तरह से सच दर्ज करें; 2- आंशिक रूप से सही; 3 पूरी तरह झूठ";
    	} elseif ($language == "3") {
    		$respmessage = "Les résidents comprennent les risques du mariage précoce ou forcé et les fausses offres de mariage. Entrez 1- complètement vrai; 2- partiellement vrai; 3- complètement faux";
    	//if none of the other languages were chosen, default to English
    	} else {
    		$respmessage = "Residents understand the risks of early or forced marriage and false offers of marriage. Enter 1- completely true; 2- partially true; 3- completely untrue";
    	}
    } else {
    	$respmessage = "wow";
    }
    $_SESSION['language'] = $language;
	
	


    // output the counter response
    header("content-type: text/xml");
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
?>
<Response>
    <SMS>LANGUAGE:<?php echo $language ?> LAST MESSAGE: <?php echo $last_message ?> <?php echo $respmessage ?> <?php echo $counter ?> times</SMS>
</Response>