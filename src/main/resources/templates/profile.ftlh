<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div style="text-align: center; color: white">
        <img src="/static/images/avatar.png"
             style="border:2px solid black; border-radius: 20px" height="120">
        <br>
        <br>
        <h2>${user.name}</h2>
        <p>
            <#if user.isAdmin()>
                <span style="color: red">Администратор</span>
            </#if>
            <#if user.isModerator()>
                <span style="color: gold">Модератор</span>
            </#if>
        </p>
        Электоронная почта: <b>${user.email}</b>
        <h3>Посты:</h3>
        <#if posts??>
            <table class="table table-striped" style="text-align: start;">
                <#list posts as post>
                    <tr class="bg-dark text-white" style="vertical-align: middle; cursor: pointer;" onclick="location.href='/forum/${post.forum.id}/post/${post.id}'">
                        <td>${post.id}</td>
                        <td><p>${post.title}</p><p style="color: gray; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden">${post.text}</p></td>
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
                        <#if user.id??>
                            <#if user.id == post.author.id || user.admin == true || (user.moderator == true && post.author.admin == false)>
                            <td>
                                <form action="/delete/${post.id}" method="post">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <input type="submit" class="btn btn-danger" value="Удалить">
                                </form>
                            </td>
                            <#else>
                                <td></td>
                            </#if>
                        </#if>
                    </tr>
                <#else>
                    <h1 style="text-align: center">Вы ещё не писали постов</h1>
                </#list>
                </table>
        </#if>
    </div>
</@t.template>