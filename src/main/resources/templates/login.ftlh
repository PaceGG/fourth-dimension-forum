<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="login-container">
        <h1>Авторизация</h1>
        <hr>
        
        <form action="/login" method="post" class="login-form">
            <div class="form-field">
                <label for="email">Электронная почта</label>
                <input type="email" id="email" name="username" class="<#if RequestParameters.error??>error</#if>">
                <#if RequestParameters.error??>
                    <div class="error-message">Неверная электронная почта</div>
                </#if>
            </div>
            
            <div class="form-field">
                <label for="password">Пароль</label>
                <input type="password" id="password" name="password" class="<#if RequestParameters.error??>error</#if>">
                <#if RequestParameters.error??>
                    <div class="error-message">Неверный пароль</div>
                </#if>
            </div>
            
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="login-submit">Войти</button>
        </form>
        
        <hr>
        <p class="register-link">Нет аккаунта? <a href="/registration">Зарегистрируйся!</a></p>
    </div>
</@t.template>