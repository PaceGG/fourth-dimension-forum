<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="breadcrumb">
        <h1>${forum.title}</h1>
        <div class="breadcrumb-links">
            <a href="/">Главная</a>
            <span>➤</span>
            <a href="/forum/${forum.id}">${forum.title}</a>
        </div>
    </div>

    <a href="/create/${forum.id}" class="create-post-btn">Написать пост</a>

    <table class="forum-table">
        <#list posts as post>
            <tr class="post-row" onclick="location.href='/forum/${forum.id}/post/${post.id}'">
                <td class="post-id">${post.id}</td>
                <td class="post-content">
                    <p class="post-title">${post.title}</p>
                    <p class="post-preview">${post.text}</p>
                </td>
                <td class="post-rating">
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
                <td class="post-author">
                    Автор: <a href="/user/${post.author.id}">${post.author.name}</a>
                </td>
                <#if user.id??>
                    <#if user.id == post.author.id || user.isAdmin() == true || (user.isModerator() == true && post.author.isAdmin() == false)>
                        <td class="actions">
                            <form action="/delete/${post.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button type="submit">
                                    <img src="/images/delete.svg" alt="delete">
                                </button>
                            </form>
                            <a href="/moderator/edit-post/${post.id}">
                                <img src="/images/edit.svg" alt="edit">
                            </a>
                        </td>
                    <#else>
                        <td class="actions"></td>
                    </#if>
                </#if>
            </tr>
        <#else>
            <tr class="empty-message">
                <td colspan="5">Постов еще нет, напишите первым!</td>
            </tr>
        </#list>
    </table>
</@t.template>