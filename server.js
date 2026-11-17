const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');

const root = __dirname;
const port = Number(process.env.PORT || 4173);

http.createServer((request, response) => {
  const pathname = new URL(request.url, `http://${request.headers.host}`).pathname;
  const filename = pathname === '/' ? 'index.html' : path.basename(pathname);
  const filepath = path.join(root, filename);

  fs.readFile(filepath, (error, content) => {
    if (error) {
      response.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' });
      response.end('Soubor nebyl nalezen.');
      return;
    }
    response.writeHead(200, {
      'Content-Type': filename.endsWith('.html') ? 'text/html; charset=utf-8' : 'application/octet-stream',
      'Cache-Control': 'no-store',
    });
    response.end(content);
  });
}).listen(port, '127.0.0.1', () => {
  console.log(`Obrat běží na http://127.0.0.1:${port}`);
});
