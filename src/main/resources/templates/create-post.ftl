<#import "blocks/template.ftlh" as t> 
<@t.template user>
    <div class="">
        <h1>Создать новый пост в форуме "${forum.title}"</h1>
        <a href="/">Главная</a>
        <span class="text-white">➤</span>
        <a href="/forum/${forum.id}">${forum.title}</a>
    </div>
    <form action="/create/${forum.id}" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        
        <div class="form-group">
            <label for="title">Заголовок:</label>
            <input type="text" id="title" name="title" class="form-control bg-dark text-white" placeholder="Введите заголовок" required>
        </div>
        
        <div class="form-group">
            <label for="text">Текст поста:</label>
            <textarea id="text" name="text" class="form-control bg-dark text-white" rows="10" placeholder="Введите текст поста" required maxlength="900"></textarea>
        </div>
        
        <div class="form-group">
            <button type="submit" class="btn btn-primary mt-4">Создать пост</button>
        </div>
    </form>
</@t.template>


