## Experimental extension repository by carlopi

GitHub Repository: [https://github.com/carlopi/extension-template-fork](https://github.com/carlopi/extension-template-fork)

Endpoint: [https://carlopi.github.io/extension-template-fork/](https://carlopi.github.io/extension-template-fork/)

A basic [DuckDB](https://duckdb.org) [extension](https://duckdb.org/docs/extensions/overview.html), direcly published via GitHub Pages.

Feedback on [Discord](https://discord.duckdb.org) or [Twitter](https://twitter.com/carlo_piovesan) is welcome.

### How to try this

Launch your DuckDB client in `unsigned` mode, e.g.: `duckdb -unsigned`

```sql
LOAD httpfs;
INSTALL quack FROM 'https://carlopi.github.io/extension-template-fork/';
LOAD quack;
SELECT quack('?');
```

As of v0.10.2, `LOAD httpfs` before install is compulsory, otherwise a misleading error message about local files will show up. To be improved.

