$(function(){
    $('.start').click(function() {
        $('.start').html('');
        $('.timer').startTimer({
            onComplete: function() {
                $('.timer').html('終了です');
            }
        }
        );
    });
});
