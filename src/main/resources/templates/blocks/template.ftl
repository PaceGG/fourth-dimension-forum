<#macro template user>
    <!doctype html>
    <html lang="ru">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="/static/css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <title>Fourth Dimension</title>
    </head>
    <body style="background-color: #222">
    <nav class="navbar navbar-dark bg-dark px-5">
            <a class="navbar-brand" href="/">
                <span class="navbar-brand mb-0 h1">Fourth Dimension</span>
            </a>
            <#if user.email??>
                
                <div class="dropdown text-end d-flex align-items-center gap-3">
                    <p style="color: white">${user.name}</p>
                    <a href="/profile">
                        <img src="/static/images/avatar.png" alt="mdo"
                             width="32" height="32" class="rounded-circle">
                    </a>
                    <form action="/logout" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <button type="submit" style="text-align: center; width: 100%" class="btn btn-danger">
                            Выйти
                        </button>
                    </form>
                    <#if user.isAdmin()>
                    <a class="btn btn-light" style="text-align: center;"
                    href="/admin">
                        Панель администратора
                    </a>
                    </#if>
                </div>
            <#else>
                <button class="btn btn-light my-2 my-sm-0" type="button"
                        onclick="window.location.href = '/login'">
                    Войти
                </button>
            </#if>
    </nav>
        <div class="mx-5"><#nested/></span>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
            integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
            ></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
            integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
            ></script>
    </body>
    </html>
</#macro>