# Import Minio library.
import os
import urllib3
from minio import Minio
from minio.error import (ResponseError, BucketAlreadyOwnedByYou,
                         BucketAlreadyExists)

minio_server='127.0.0.1:9000'
minio_access_key='AW8O3KYE7C1TZYV3QC4S'
minio_secret_key='a8vu1C5YPc9JNugyY2E6MWLprZdqkdIlsFmNrPMl'

# Initialize minioClient with an endpoint and access/secret keys.

minioClient = Minio('localhost:9000',
                    access_key=minio_access_key,
                    secret_key=minio_secret_key,
                    secure=False)

buckets = minioClient.list_buckets()
for bucket in buckets:
    print(bucket.name, bucket.creation_date)
    
try:
    minioClient.make_bucket("mybucket")
except ResponseError as err:
    print(err)
    
buckets = minioClient.list_buckets()
for bucket in buckets:
    print(bucket.name, bucket.creation_date)

# Put a file with default content-type, upon success prints the etag identifier computed by server.
try:
    with open('my-testfile', 'rb') as file_data:
        file_stat = os.stat('my-testfile')
        print(minioClient.put_object('mybucket', 'sub1/myobject',
                               file_data, file_stat.st_size))
except ResponseError as err:
    print(err)

# Put a file with 'application/csv'.
try:
    with open('my-testfile.csv', 'rb') as file_data:
        file_stat = os.stat('my-testfile.csv')
        minioClient.put_object('mybucket', 'sub2/myobject.csv', file_data,
                    file_stat.st_size, content_type='application/csv')

except ResponseError as err:
    print(err)