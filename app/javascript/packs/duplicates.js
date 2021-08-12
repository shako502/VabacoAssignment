
$(document).on('ajax:before', '#counter-form', function(){

    if($('.counted-results-container').is(':visible')){
        $('.counted-results-container').fadeOut();
    }

    $('#individual-char-list').html('');
    $('#counted-char-res').text('');

});

$(document).on('ajax:success', '#counter-form', function(event){
    const [_data, _status, xhr] = event.detail;
    var res = JSON.parse(xhr.responseText);

    $('#counted-char-res').text(res.count);
    const charObj = res.result;
    const sorted = Object.fromEntries(
        Object.entries(charObj).sort(([,a],[,b]) => b-a)
    );
    
    $.each(sorted, function(k,v){
        var htmlstring = `<li class="list-group-item d-flex justify-content-between align-items-center">
                                ${k}
                                <span class="badge bg-primary rounded-pill">${v}</span>
                          </li>`;

        $('#individual-char-list').append(htmlstring);
    });

    $('.counted-results-container').fadeIn();

});

$(document).on('ajax:error', '#counter-form', function(event){
    console.log(event);
});