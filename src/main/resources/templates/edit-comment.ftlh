<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="">
        <h1>Редактировать комментарий</h1>
        <a href="/">Главная</a>
        <span class="text-white">➤</span>
        <a href="/forum/${forum.id}">${forum.title}</a>
        <span class="text-white">➤</span>
        <a href="/forum/${forum.id}/post/${post.id}">${post.title}</a>
    </div>
    <form action="/edit-comment/${comment.id}" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">

        <div class="form-group">
            <label for="text">Текст комментария:</label>
            <textarea
                id="text"
                name="text"
                class="form-control bg-dark text-white"
                rows="5"
                placeholder="Введите текст комментария"
                required
                value="${comment.text}"
                maxlength="900">${comment.text}</textarea>
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-primary mt-4">Сохранить изменения</button>
            <a href="/forum/${forum.id}/post/${post.id}" class="btn btn-secondary mt-4">Отменить</a>
        </div>
    </form>
</@t.template>
