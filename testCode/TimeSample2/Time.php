<?php

class Time
{
    public function getTime($time)
    {
        $tomorrowTime = $this->getTomrrow() - $this->getNow();
        
        return min($tomorrowTime, $time);
    }

    public function getTomrrow()
    {
        return strtotime('tomorrow');
    }

    public function getNow()
    {
        return time();
    }
}
