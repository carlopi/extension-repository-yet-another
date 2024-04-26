## Experimental extension repository by carlopi

Repo: (https://github.com/carlopi/extension-template-fork)

Endpoint: (https://carlopi.github.io/extension-template-fork/)

### How to:
```bash
duckdb -unsigned
```
```sql
LOAD httpfs;
INSTALL quack FROM 'https://carlopi.github.io/extension-template-fork/';
LOAD quack;
SELECT quack('?');
```

