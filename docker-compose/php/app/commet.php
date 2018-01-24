<?php

set_time_limit(0);

ob_implicit_flush();
echo "<!---------------- dumy ----------------->\n";
echo "<!---------------- dumy ----------------->\n";
echo "<!---------------- dumy ----------------->\n";
echo "<!---------------- dumy ----------------->\n";
ob_end_flush();


while(1){
    $i++;
    echo "<script>document.write('gid','".$i."')</script>\n";
    sleep(1);
}