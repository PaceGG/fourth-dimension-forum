<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="auth-container">
        <h1>Регистрация</h1>
        <hr>
        
        <form action="/registration" method="post" class="auth-form">
            <div class="form-field">
                <label for="name">Имя пользователя</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-field">
                <label for="email">Электронная почта</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-field">
                <label for="password">Пароль</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="auth-submit">Зарегистрироваться</button>
        </form>
        
        <#if errorMessage??>
            <div class="error-message">${errorMessage}</div>
        </#if>
    </div>
</@t.template>