# What is this
My experiments with minio, trino and delta lake. It is supporting material for my published article

[Manipulating Delta Lake tables on MinIO with Trino](https://fithis2001.medium.com/manipulating-delta-lake-tables-on-minio-with-trino-74b25f7ad479)

Start it with

```
export UID=${UID}
export GID=${GID}
docker-compose up
```

end it with


```
docker-compose down -v
```


Tested on Macos x64 Ventura 13.5.2 with Colima 0.5.5 .