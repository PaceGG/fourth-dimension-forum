<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Редактирование форума ${forum.title}</h1><hr>
    <form action="/moderator/edit-forum/${forum.id}" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <div class="form-group">
            <label for="title">Название форума:</label>
            <input type="text" class="form-control" id="title" name="title" value="${forum.title}">
        </div>
        <button type="submit" class="btn btn-primary">Сохранить</button>
    </form>
</@t.template>