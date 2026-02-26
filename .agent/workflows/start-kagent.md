---
description: Start kagent dashboard and expose all MCP port-forwards (tools:8084, grafana-mcp:8000)
---

# Start Kagent + MCP Port-Forwards

// turbo
1. Open the kagent dashboard (exposes UI on :8082 and controller API on :8083):
```bash
kagent dashboard &
```

// turbo
2. Expose the kagent-tools MCP server on port 8084:
```bash
kubectl port-forward -n default svc/kagent-tools 8084:8084 &
```

// turbo
3. Expose the kagent-grafana-mcp MCP server on port 8000:
```bash
kubectl port-forward -n default svc/kagent-grafana-mcp 8000:8000 &
```

4. Verify all endpoints are reachable:
```bash
sleep 3
curl -s -o /dev/null -w "ui(8082):         %{http_code}\n" http://localhost:8082
curl -s -o /dev/null -w "controller(8083): %{http_code}\n" http://localhost:8083/health
curl -s -o /dev/null -w "tools(8084):      %{http_code}\n" http://localhost:8084/mcp
curl -s -o /dev/null -w "grafana-mcp(8000):%{http_code}\n" http://localhost:8000/mcp
```

All endpoints should return **200**.

// turbo
5. Verify kagent agents are registered and healthy:
```bash
kagent get agents
```

All listed agents should appear. You are now ready to use the MCP tools from any AI coding assistant (cursor, gemini, etc.) via the `kagent-tools` MCP server.
