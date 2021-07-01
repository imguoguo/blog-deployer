# Usage
1. Clone this project.

   ```
   git clone https://github.com/imguoguo/blog-deployer
   ```

2. Enter it, open .env and set the following:

   ```
   cd blog-deployer
   ```

   ```
   vim .env
   SSH_USER=your_username
   SSH_PASSWORD=your_password
   ```

3. (Optional) Change the ssh port(2233) to any value if you like.

   ```
   vim docker-compose.yml
       ports:
         - "2233:22"
   ```

4. Run it!

   ```
   docker-compose up -d
   ```

   