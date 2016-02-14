$( document ).ready(function() {
    setTimeout(function(){
        $('.packeryContainer').packery({
            itemSelector: '.packeryItem',
            gutter: 20
        });
    }, 10);

});