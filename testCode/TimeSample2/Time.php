<?php

class Time
{
    /*
     * 翌日0時までと指定した時間の短い方を取得 
     *
     * @param int $time 時間(sec)
     */
    public function getTime($time)
    {
        // 翌日0時と現在時刻の差分
        $tomorrowTime = $this->getTomrrow() - $this->getNow();
        
        // 指定した時間と比べて短い方を返す
        return min($tomorrowTime, $time);
    }

    /*
     * 翌日0時の時間を取得
     *
     */
    public function getTomrrow()
    {
        return strtotime('tomorrow');
    }

    /*
     * 現在時間を取得
     *
     */
    public function getNow()
    {
        return time();
    }
}
