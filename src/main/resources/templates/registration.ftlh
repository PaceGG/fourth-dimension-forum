<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Регистрация</h1>
    <hr>
    <form action="/registration" method="post">
        <div class="form-group mb-3">
            <label for="name" style="color: white;">Имя пользователя</label>
            <input type="text" class="text-light bg-dark form-control" required id="name" name="name">
        </div>
        <div class="form-group mb-3">
            <label for="email" style="color: white;">Электронная почта</label>
            <input type="email" class="text-light bg-dark form-control" id="email" required name="email">
        </div>
        <div class="form-group mb-3">
            <label for="password" style="color: white;">Пароль</label>
            <input type="password" class="text-light bg-dark form-control" id="password" required name="password">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" style="width: 100%" class="btn btn-dark">Зарегистрироваться</button>
    </form>
    <#if errorMessage??>
        <h2 style="color: red">${errorMessage}</h2>
    </#if>
</@t.template>