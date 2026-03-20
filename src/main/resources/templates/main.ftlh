<#import "blocks/template.ftlh" as t>
<@t.template user>
    <#if user.isAdmin() || user.isModerator()>
        <form action="/moderator/create-forum" method="post" class="create-form">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="text" name="title" placeholder="Новый форум">
            <button type="submit">Создать</button>
        </form>
    </#if>
    
    <table class="forum-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Название</th>
                <th>Количество постов</th>
                <#if user.isAdmin() || user.isModerator()>
                    <th></th>
                </#if>
            </tr>
        </thead>
        <tbody>
            <#list forums as forum>
            <tr>
                <td>${forum.id}</td>
                <td><a href="/forum/${forum.id}">${forum.title}</a></td>
                <td>Постов: ${forum.posts?size}</td>
                <#if user.isAdmin() || user.isModerator()>
                    <td class="actions">
                        <form action="/moderator/delete-forum/${forum.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit">
                                <img src="/images/delete.svg" alt="delete">
                            </button>
                        </form>
                        <a href="/moderator/edit-forum/${forum.id}">
                            <img src="/images/edit.svg" alt="edit">
                        </a>
                    </td>
                </#if>
            </tr>
            <#else>
            <tr class="empty-message">
                <td colspan="4">Форумы еще не созданы</td>
            </tr>
            </#list>
        </tbody>
    </table>
</@t.template>