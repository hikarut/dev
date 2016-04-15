<?php

class Time
{
    /*
     * 翌日0時までと指定した時間の短い方を取得 
     *
     * @param int $time 時間(sec)
     */
    public function getTime($time, $now = null, $tomorrow = null)
    {
        // 引数が空なら現在時間を取得
        if ($now === null) {
            $now = time();
        }
        
        // 引数が空なら翌日0時の時間を取得
        if ($tomorrow === null) {
            $tomorrow = strtotime('tomorrow');
        }

        // 翌日0時と現在時刻の差分
        $tomorrowTime = $tomorrow - $now;
        
        // 指定した時間と比べて短い方を返す
        return min($tomorrowTime, $time);
    }
}
