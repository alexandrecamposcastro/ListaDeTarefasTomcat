<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Enterprise Task Control | v2.1</title>
    <style>
        :root { --bg: #0b0e14; --card: #151921; --primary: #3b82f6; --accent: #8b5cf6; --success: #10b981; --danger: #ef4444; --text: #e2e8f0; }
        body { background: var(--bg); color: var(--text); font-family: sans-serif; margin: 0; padding: 40px; display: flex; flex-direction: column; align-items: center; }
        .header { width: 100%; max-width: 1000px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; border-bottom: 1px solid #2d3748; padding-bottom: 20px; }
        .header h1 { margin: 0; font-size: 28px; background: linear-gradient(to right, var(--primary), var(--accent)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .dashboard { display: grid; grid-template-columns: 350px 1fr; gap: 30px; width: 100%; max-width: 1000px; }
        .glass-card { background: var(--card); padding: 25px; border-radius: 16px; border: 1px solid #2d3748; height: fit-content; }
        input { width: 100%; background: #1a202c; border: 1px solid #2d3748; padding: 12px; border-radius: 10px; color: white; margin-bottom: 20px; box-sizing: border-box; }
        .btn-main { width: 100%; background: var(--primary); color: white; border: none; padding: 14px; border-radius: 10px; font-weight: 700; cursor: pointer; }
        .task-grid { display: grid; grid-template-columns: 1fr; gap: 15px; }
        .task-item { background: #1a202c; border-radius: 12px; padding: 18px; display: flex; justify-content: space-between; align-items: center; border-left: 5px solid var(--primary); }
        .task-item.done { border-left-color: var(--success); opacity: 0.6; }
        .task-actions { display: flex; gap: 10px; }
        .btn-icon { background: #2d3748; border: none; color: white; padding: 8px 12px; border-radius: 8px; cursor: pointer; }
    </style>
</head>
<body>

    <div class="header">
        <h1>TaskCore Pro</h1>
        <div style="text-align: right">
            <div style="color: var(--success); font-weight: bold; font-size: 12px;">● SERVER ONLINE</div>
            <div style="color: #4a5568; font-size: 11px;">Port: <%= request.getServerPort() %></div>
        </div>
    </div>

    <div class="dashboard">
        <div class="glass-card">
            <label style="display:block; margin-bottom:8px; color:#94a3b8; font-size:12px;">O QUE VOCÊ VAI EXECUTAR?</label>
            <input type="text" id="taskInput" placeholder="Ex: Deploy de microserviços...">
            <button class="btn-main" onclick="addTask()">ADICIONAR TASK</button>
        </div>

        <div id="taskList" class="task-grid"></div>
    </div>

    <script>
        let tasks = [];

        function render() {
            const list = document.getElementById('taskList');
            list.innerHTML = '';

            tasks.forEach((task, index) => {
                const item = document.createElement('div');
                item.className = 'task-item' + (task.done ? ' done' : '');
                
                // USANDO CONCATENAÇÃO SIMPLES PARA O TOMCAT NÃO BUGAR
                let html = '<div class="task-text" style="' + (task.done ? 'text-decoration: line-through' : '') + '">';
                html += task.title; // O texto da task entra aqui
                html += '</div>';
                html += '<div class="task-actions">';
                html += '<button class="btn-icon" onclick="toggleTask(' + index + ')">✔</button>';
                html += '<button class="btn-icon" onclick="editTask(' + index + ')">✎</button>';
                html += '<button class="btn-icon" onclick="deleteTask(' + index + ')">✕</button>';
                html += '</div>';
                
                item.innerHTML = html;
                list.appendChild(item);
            });
        }

        function addTask() {
            const input = document.getElementById('taskInput');
            if (!input.value.trim()) return;
            tasks.push({ title: input.value, done: false });
            input.value = '';
            render();
        }

        function toggleTask(index) {
            tasks[index].done = !tasks[index].done;
            render();
        }

        function deleteTask(index) {
            tasks.splice(index, 1);
            render();
        }

        function editTask(index) {
            const newTitle = prompt("Atualizar:", tasks[index].title);
            if (newTitle) { tasks[index].title = newTitle; render(); }
        }

        render();
    </script>
</body>
</html>