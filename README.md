Script for migration databases from one server to other

**Usage:**

1. Create /root/.my.cnf on local server with local credentials
```
[client]
user=root
password=password
```
2. Set execute permissions on script
chmox +x migrate.sh

3. Run script
