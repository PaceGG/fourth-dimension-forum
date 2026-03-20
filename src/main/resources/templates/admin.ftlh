<#import "blocks/template.ftlh" as t>  
<@t.template user>
    <h1 style="text-align: center">Панель администратора</h1>
    <hr>
    <table class="table table-hover table-dark" id="usersTable">
        <thead>
            <tr style="user-select: none;">
                <th scope="col">ID</th>
                <th scope="col" onclick="sortTable(0)" style="cursor: pointer;">Имя <span id="arrow-0"></span></th>
                <th scope="col" onclick="sortTable(1)" style="cursor: pointer;">Email <span id="arrow-1"></span></th>
                <th scope="col" onclick="sortTable(2)" style="cursor: pointer;">Активность <span id="arrow-2"></span></th>
                <th scope="col" onclick="sortTable(3)" style="cursor: pointer;">Роли <span id="arrow-3"></span></th>
                <th scope="col">Действия</th>
            </tr>
        </thead>
        <tbody>
            <#list users as user>
                <tr>
                    <td><a href="/user/${user.id}">${user.id}</a></td>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td><#if user.active>Активен<#else><span style="color: red;">Заблокирован</span></#if></td>
                    <td>
                        <button class="btn btn-light role" onclick="toggleRoleDropdown(${user.id})">${user.role}</button>
                        <div id="role-dropdown-${user.id}" class="role-dropdown" style="display:none;">
                            <form action="/admin/user/edit" method="post">
                                <input type="hidden" name="userId" value="${user.id}">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <select name="role" class="form-select">
                                    <option value="ROLE_ADMIN" <#if user.role == "ROLE_ADMIN">selected</#if>>Администратор</option>
                                    <option value="ROLE_MODERATOR" <#if user.role == "ROLE_MODERATOR">selected</#if>>Модератор</option>
                                    <option value="ROLE_USER" <#if user.role == "ROLE_USER">selected</#if>>Пользователь</option>
                                </select>
                                <input type="submit" class="btn btn-light mt-2" value="Сохранить">
                            </form>
                        </div>
                    </td>
                    <td>
                        <#if user.active>
                            <form action="/admin/user/ban/${user.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="submit" class="btn btn-light" value="Заблокировать">
                            </form>
                        <#else>
                            <form action="/admin/user/unban/${user.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="submit" class="btn btn-light" value="Разблокировать">
                            </form>
                        </#if>
                    </td>
                </tr>
            </#list>
        </tbody>
    </table>
    <script>
        var currentSortColumn = -1;
        var currentSortDirection = 'asc';
        resetArrows();

        function sortTable(columnIndex) {
            var table = document.getElementById("usersTable");
            var rows = table.rows;
            var switching = true;
            var shouldSwitch, i, x, y;
            var dir = currentSortDirection;

            resetArrows();

            if (columnIndex === currentSortColumn) {
                dir = dir === 'asc' ? 'desc' : 'asc';
            } else {
                currentSortColumn = columnIndex;
                dir = 'asc';
            }

            currentSortDirection = dir;
            updateArrow(columnIndex, dir);

            while (switching) {
                switching = false;
                var rowsArray = Array.from(rows).slice(1);
                for (i = 0; i < rowsArray.length - 1; i++) {
                    shouldSwitch = false;
                    x = rowsArray[i].getElementsByTagName("TD")[columnIndex];
                    y = rowsArray[i + 1].getElementsByTagName("TD")[columnIndex];

                    if (dir === "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir === "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rowsArray[i].parentNode.insertBefore(rowsArray[i + 1], rowsArray[i]);
                    switching = true;
                } else {
                    if (dir === "asc") {
                        dir = "desc";
                    } else {
                        break;
                    }
                }
            }
        }

        function updateArrow(columnIndex, direction) {
            var arrow = document.getElementById("arrow-" + columnIndex);
            if (direction === 'asc') {
                arrow.innerHTML = " ↿";
            } else {
                arrow.innerHTML = " ⇂";
            }
        }

        function resetArrows() {
            for (var i = 0; i < 4; i++) {
                document.getElementById("arrow-" + i).innerHTML = "⥮";
            }
        }

        function toggleRoleDropdown(userId) {
            var dropdown = document.getElementById("role-dropdown-" + userId);
            if (dropdown.style.display === "none" || dropdown.style.display === "") {
                dropdown.style.display = "block";
            } else {
                dropdown.style.display = "none";
            }
        }
    </script>
</@t.template>
