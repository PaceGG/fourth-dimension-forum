<#macro template user>
    <!doctype html>
    <html lang="ru">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="/static/css/style.css">
        <title>Fourth Dimension</title>
    </head>
    <body>
        <nav class="navbar">
            <a class="brand" href="/">
                <span>Fourth Dimension</span>
            </a>
            
            <#if user.email??>
                <div class="user-menu">
                    <p class="username">${user.name}</p>
                    <a href="/profile" class="avatar">
                        <img src="/static/images/avatar.png" alt="profile" width="32" height="32">
                    </a>
                    <form action="/logout" method="post" class="logout-form">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button type="submit">Выйти</button>
                    </form>
                    <#if user.isAdmin()>
                        <a href="/admin" class="admin-link">Панель администратора</a>
                    </#if>
                </div>
            <#else>
                <button class="login-btn" onclick="window.location.href = '/login'">
                    Войти
                </button>
            </#if>
        </nav>
        
        <main class="content">
            <#nested/>
        </main>
    </body>
    </html>
</#macro>