<?php

class Time
{
    public function getTime($time, $now = null, $tomorrow = null)
    {
        if ($now === null) {
            $now = time();
        }

        if ($tomorrow === null) {
            $tomorrow = strtotime('tomorrow');
        }

        $tomorrowTime = $tomorrow - $now;
        
        return min($tomorrowTime, $time);
    }
}
