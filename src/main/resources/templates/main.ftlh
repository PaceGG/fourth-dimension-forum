<#import "blocks/template.ftlh" as t>
<@t.template user>
    <#if user.isAdmin() || user.isModerator()>
        <form action="/moderator/create-forum" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div class="form-group d-flex">
                <input class="bg-dark text-white form-control" type="text" name="title" placeholder="Новый форум">
                <button class="btn btn-primary" type="submit">Создать</button>
            </div>
        </form>
    </#if>
    <table class="table table-striped">
            <tr class="text-white">
                <th scope="col">ID</th>
                <th scope="col">Название</th>
                <th scope="col">Количество постов</th>
                <#if user.isAdmin() || user.isModerator()>
                    <th></th>
                </#if>
            </tr>
        </thead>
        <tbody>
            <#list forums as forum>
            <tr class="bg-dark text-white">
                <td>${forum.id}</td>
                <td><a style="color: white; font-weight: bold;" href="/forum/${forum.id}">${forum.title}</a></td=>
                <td>Постов: ${forum.posts?size}</td>
                <#if user.isAdmin() || user.isModerator()>
                    <td class="d-flex" style="width: 64px;">
                        <form action="/moderator/delete-forum/${forum.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button class="btn btn-danger" type="submit"><img src="/images/delete.svg" alt="delete"></button>
                        </form>
                        <a href="/moderator/edit-forum/${forum.id}" class="btn btn-primary"><img src="/images/edit.svg" alt="edit"></a>
                    </td>
                </#if>
            </tr>
            <#else>
                <h1 style="text-align: center">Форумы еще не созданы</h1>
            </#list>
        </tbody>
    </table>
</@t.template>