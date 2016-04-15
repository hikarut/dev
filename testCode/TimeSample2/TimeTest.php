<?php

require_once 'Time.php';

class TimeTest extends PHPUnit_Framework_TestCase
{
    /**
     * @covers Time::getTime
     * @test
     */
    public function getTimeTest()
    {

        // Timeクラスのモックを作成
        $mock = $this->getMockBuilder('Time')
                     ->setMethods(['getNow', 'getTomrrow'])
                     ->getMock();

        // getNowメソッドのモック
        $mock->method('getNow')
             ->will($this->onConsecutiveCalls(strtotime('2016-04-15 23:40:59'),
                                              strtotime('2016-04-15 23:50:01'),
                                              strtotime('2016-04-15 23:59:59')));
        // getTomrrowメソッドのモック
        $mock->method('getTomrrow')
             ->will($this->onConsecutiveCalls(strtotime('2016-04-16 00:00:00'),
                                              strtotime('2016-04-16 00:00:00'),
                                              strtotime('2016-04-16 00:00:00')));

        $this->assertEquals(600, $mock->getTime(600));
        $this->assertEquals(599, $mock->getTime(600));
        $this->assertEquals(1, $mock->getTime(600));

    }


}
