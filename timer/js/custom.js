$(function(){
    $('.timer').startTimer({
        onComplete: function() {
            $('.timer').html('終了です');
        }
    }
    );
});
