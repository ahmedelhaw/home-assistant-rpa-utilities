# Home Assistant RPA Utilities

A repository for automating utility meter readings using Robotic Process Automation (RPA) techniques with Home Assistant.

## Implementation Options

### Option 1: Using OpenRPA
- **Tutorial**: [YouTube Video](https://www.youtube.com/watch?v=I5dfFuoYgMg&t)
- Implementation using OpenRPA framework

### Option 2: Using Node-RED
- **Tutorial**: [YouTube Video](https://www.youtube.com/watch?v=I5dfFuoYgMg&t)
- Implementation using Node-RED flows

## Database Queries

### Water and Electricity Statistics
Use this SQL query to retrieve statistics for water and electricity usage:

```sql
SELECT 
    datetime(s.start_ts, 'unixepoch', 'localtime') AS start_iso,
    s.state, 
    s.sum 
FROM statistics s
WHERE s.metadata_id = (
    SELECT id 
    FROM statistics_meta 
    WHERE statistic_id = 'sensor:water_usage'
)
ORDER BY s.start_ts DESC;
```

## Chromium Setup for Home Assistant OS (I am not using this)

For users who want to set up Chromium on Home Assistant Operating System for web scraping:

### Installation Commands
```bash
apk add chromium
apk add xvfb
```

### Running Chromium in Headless Mode
```bash
# Start virtual display
Xvfb :99 -screen 0 1280x720x24 &

# Set display environment variable
export DISPLAY=:99

# Run Chromium with required flags
/usr/bin/chromium --no-sandbox \
                  --headless \
                  --disable-gpu \
                  --disable-dev-shm-usage \
                  --disable-software-rasterizer \
                  --disable-features=VizDisplayCompositor \
                  --screenshot https://www.home-assistant.io/
```

## Notes

This setup enables automated utility meter reading by leveraging RPA techniques to interact with utility provider websites and extract meter readings for integration with Home Assistant's energy monitoring capabilities.
