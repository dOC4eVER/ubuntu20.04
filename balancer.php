<?php
include "/home/xtreamcodes/iptv_xtream_codes/admin/functions.php";
$directory = "/home/xtreamcodes/iptv_xtream_codes/adtools/balancer/";
$file = glob($directory . "*.json");
foreach($file as $filew)
{
echo shell_exec("/bin/bash /home/xtreamcodes/iptv_xtream_codes/pytools/balancer.sh" . $filew . " " . $_INFO["db_user"] . " " . $_INFO["db_pass"] . " " . $_INFO["db_port"] . " " . $_INFO["db_name"] . "");
}
?>
