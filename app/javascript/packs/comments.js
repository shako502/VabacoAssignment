$(function(){
    $('.edit-comment').on('click', function(e){
        e.preventDefault();
        let single_comment = $(this).closest('.single-comment');
        let comment_body = single_comment.find('.comment-body');
        let comment_body_text = $(comment_body).children('.comment-body-text');
        let comment_actions = single_comment.find('.comment-actions');
        let actions_main = $(comment_actions).children('.comment-actions-main');
        let actions_edit = $(comment_actions).children('.comment-actions-edit');
        
        $(comment_body_text).addClass('d-none');
        $(comment_body).children('.comment-edit-form').removeClass('d-none');

        actions_main.addClass('d-none');
        actions_edit.removeClass('d-none');
    });

    $('.comment-actions-edit .exit-editing-comment').on('click', function(e){
        e.preventDefault();
        let single_comment = $(this).closest('.single-comment');
        let comment_body = single_comment.find('.comment-body');
        let comment_actions = single_comment.find('.comment-actions');
        let actions_main = $(comment_actions).children('.comment-actions-main');
        let actions_edit = $(comment_actions).children('.comment-actions-edit');

        $(comment_body).children('.comment-edit-form').addClass('d-none');
        $(comment_body).children('.comment-body-text').removeClass('d-none');

        actions_edit.addClass('d-none');
        actions_main.removeClass('d-none');
    });


    $('.comment-actions-edit .save-edit-comment').on('click', function(e){
        e.preventDefault();
        let single_comment = $(this).closest('.single-comment');
        let comment_body = single_comment.find('.comment-body');
        let comment_edit_form = $(comment_body).children('.comment-edit-form');
        let form = $(comment_edit_form).children('form');
        
        $(form).submit();

    });
});