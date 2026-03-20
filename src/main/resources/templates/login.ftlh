<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="auth-container">
        <h1>Авторизация</h1>
        <#if RequestParameters.error??>
            <div class="error-message">Неверная почта или пароль</div>
        </#if>
        <hr>
        
        <form action="/login" method="post" class="auth-form">
            <div class="form-field">
                <label for="email">Электронная почта</label>
                <input type="email" id="email" name="username" class="<#if RequestParameters.error??>error</#if>">
            </div>
            
            <div class="form-field">
                <label for="password">Пароль</label>
                <input type="password" id="password" name="password" class="<#if RequestParameters.error??>error</#if>">
            </div>
            
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="auth-submit">Войти</button>
        </form>
        
        <hr>
        <p class="register-link">Нет аккаунта? <a href="/registration">Зарегистрируйся!</a></p>
    </div>
</@t.template>