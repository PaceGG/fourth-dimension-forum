<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="">
        <h1>${forum.title}</h1>
        <a href="/">Главная</a>
        <span class="text-white">➤</span>
        <a href="/forum/${forum.id}">${forum.title}</a>
    </div>


    <a href="/create/${forum.id}" class="btn btn-primary my-3">Написать пост</a>


    <table class="table table-striped">
        <#list posts as post>
            <tr class="bg-dark text-white" style="vertical-align: middle; cursor: pointer;" onclick="location.href='/forum/${forum.id}/post/${post.id}'">
                <td>${post.id}</td>
                <td style=""><p>${post.title}</p><p style="color: gray; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden">${post.text}</p></td>
                <td style="white-space: nowrap;">
                    <#if post.ratings?has_content>
                        <#assign totalRating = 0>
                        <#list post.ratings as r>
                            <#assign totalRating = totalRating + r.rate>
                        </#list>
                        Рейтинг: ${totalRating}
                    <#else>
                        Рейтинг: 0
                    </#if>
                </td>
                <td>Автор: <a href="/user/${post.author.id}" style="white-space: nowrap;">${post.author.name}</a></td>
                <#if user.id??>
                    <#if user.id == post.author.id || user.isAdmin() == true || (user.isModerator() == true && post.author.isAdmin() == false)>
                    <td class="d-flex">
                        <form action="/delete/${post.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit" class="btn btn-danger"><img src="/images/delete.svg" alt="delete"></button>
                        </form>
                        <a href="/moderator/edit-post/${post.id}" class="btn btn-primary"><img src="/images/edit.svg" alt="edit"></a>
                    </td>
                    <#else>
                        <td></td>
                    </#if>
                </#if>
            </tr>
        <#else>
            <h1 style="text-align: center">Постов еще нет, напишите первым!</h1>
        </#list>
    </table>
</@t.template>

