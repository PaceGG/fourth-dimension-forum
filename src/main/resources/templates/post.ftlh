<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div style="color: white"><div>
        <h1>${forum.title}</h1>
        <a href="/">Главная</a>
        <span class="text-white">➤</span>
        <a href="/forum/${forum.id}">${forum.title}</a>
        <span class="text-white">➤</span>
        <a href="/forum/${forum.id}/post/${post.id}">${post.title}</a>
    </div>
    <div class="">
        <div class="d-flex justify-content-between align-items-center">
            <div><h2>${post.title}</h2>
            <p><a href="/user/${post.author.id}">${post.author.name}</a> - ${post.dateOfCreated}</p></div>
            <form action="/rating/${post.id}" method="post" class="d-flex">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" name="rate" value="-1" class="btn <#if userRating == -1>btn-danger<#else>btn-outline-danger</#if>" style="width: 50px; height: 50px">-</button>
                <div style="width: 50px; height: 50px; font-size: 30px; text-align: center; vertical-align: middle;">${rating}</div>
                <button type="submit" name="rate" value="1" class="btn <#if userRating == 1>btn-success<#else>btn-outline-success</#if>" style="width: 50px; height: 50px">+</button>
            </form>
        </div>
        <hr>
        <p>${post.text}</p>
        <hr>
    </div>
    <div>         
        <#if user.name??>
            <form action="/comment/${post.id}" method="post">             
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>             
                <div class="form-group mb-3">                 
                    <label for="text">Оставить комментарий:</label>                 
                    <textarea id="text" name="text" class="form-control bg-dark text-white" rows="5" placeholder="Введите текст комментария" required maxlength="900"></textarea>
                </div>             
                <button type="submit" class="btn btn-primary">Оставить комментарий</button>         
            </form>         
        <#else>         
            <p>Для того, чтобы оставить комментарий, необходимо <a href="/login">войти</a>.</p>
        </#if>     
    </div>
    <div class="mt-5">
        <h3>
            <#if comments?has_content>
                Комментарии: ${comments?size}
            <#else>
                Комментариев нет
            </#if>
        </h3>
        
        <#if comments?has_content>
            <#list comments as comment>
                <div class="d-flex bg-dark text-white mb-3 justify-content-between" style="width: 600px;">
                    <div><p><a href="/user/${comment.author.id}">${comment.author.name}</a> - ${comment.dateOfCreated}</p>
                    <p>${comment.text}</p></div>
                    <#if user.id??>
                        <#if user.id == comment.author.id || user.isAdmin() == true || (user.isModerator() == true && comment.author.isAdmin() == false)>
                            <div class="d-flex"><form action="/delete-comment/${comment.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-danger"><img src="/images/delete.svg" alt="delete"></button>
                            </form>
                            <a href="/edit-comment/${comment.id}" class="btn btn-primary"><img src="/images/edit.svg" alt="edit"></a></div>
                        </#if>
                    </#if>
                </div>
            </#list>
        </#if>
    </div></span>
</@t.template>