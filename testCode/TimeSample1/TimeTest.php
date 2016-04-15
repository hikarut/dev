<?php

require_once 'TimeBad.php';

class TimeTest extends PHPUnit_Framework_TestCase
{
    /**
     * @covers Time::getTime
     * @test
     * @dataProvider getTimeDataProvider
     */
    public function getTimeTest($time, $now, $tomorrow, $expected)
    {
        $obj = new Time();
        $this->assertEquals($expected, $obj->getTime($time, $now, $tomorrow));
    }

    public function getTimeDataProvider()
    {
        return array(
                    array(600, strtotime('2016-04-15 23:40:59'), strtotime('2016-04-16 00:00:00'), 600),
                    array(600, strtotime('2016-04-15 23:50:01'), strtotime('2016-04-16 00:00:00'), 599),
                    array(600, strtotime('2016-04-15 23:59:59'), strtotime('2016-04-16 00:00:00'), 1),
                    );
    }


}
