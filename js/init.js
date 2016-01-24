
// does not work yet in a useful manner
$( document ).ready(function() {
    setTimeout(function(){
        $('.skillrefs').packery({
            itemSelector: '.skillref',
            //layoutMode: 'fitRows'
            gutter: 10
        });
    }, 0);

});