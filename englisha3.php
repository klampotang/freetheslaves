<?php

if($_REQUEST == '1') 
        header("Location: text/xml");
    

elseif($_REQUEST == '2')
        header("Location: text/xml");

elseif($_REQUEST == '3') 
        header("Location: text/xml");

else
        header("Location: englishq3.php");
    

?>

<Response>
	<Say>Thanks for calling. Goodbye!</Say>
</Response>
