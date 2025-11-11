# Docs

Dependency: argon2  
`sudo apt install argon2`

Create 2 Random Value:  
`openssl rand -base64 32`

Genearete ADMIN_TOKEN:  
`echo "Random Value 1" | argon2 "Random Value 2"`

Example Output:
```
Type:           Argon2i
Iterations:     3
Memory:         4096 KiB
Parallelism:    1
Hash:           a8a5b911dcc8d683f29fd5368337a7049d9a54fa702bca23558957e353ccb9b6
Encoded:        $argon2i$v=19$m=4096,t=3,p=1$Q1JHRmNzcEpsN08zM3pSdDBEWE9iQWdvMkZsU1pHM3hLeVdYQXk5WUErZz0$qKW5EdzI1oPyn9U2gzenBJ2aVPpwK8ojVYlX41PMubY
0.011 seconds
Verification ok
```
