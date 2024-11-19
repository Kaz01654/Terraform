module.exports = {
  apps: [
    {
      name: 'backend-pm2',
      script: 'app.js',
      instances: 2,
      exec_mode: 'cluster',
      autorestart: true,
      max_memory_restart: '500M',
      out_file: './out.log',
      error_file: './error.log',
      merge_logs: true,
      log_date_format: 'DD-MM HH:mm:ss Z',
      log_type: 'json'
    }
  ]
}