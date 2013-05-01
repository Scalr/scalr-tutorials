#!/bin/bash
#coding:utf-8

"""
Deploy the support files to S3
Credentials should be passed through the Boto environment variables:
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
"""

import os

from boto.s3 import connection

BUCKET_NAME = "scalr-tutorials"
BUCKET_PREFIX = "solr"


def upload(path, bucket, prefix=None):
    """
    Upload the contents from `path` to `bucket` in the `prefix` folder.
    """
    for path, subfolders, filenames in os.walk(resources_path):
        for filename in filenames:
            local_path = os.path.join(path, filename)

            remote_path = local_path.split(resources_path, 1)[1]
            remote_path = remote_path.lstrip(os.sep)
            if prefix is not None:
                remote_path = os.path.join(prefix, remote_path)

            print 'Uploading', local_path, '>', remote_path
            key = bucket.new_key(remote_path)
            key.set_contents_from_filename(local_path, policy='public-read')


if __name__ == "__main__":
    conn = connection.S3Connection()  # Pass credentials in env vars
    bucket = conn.get_bucket(BUCKET_NAME)

    script_location = os.path.dirname(os.path.abspath(__file__))
    resources_path = os.path.join(script_location, 'resources')

    upload(resources_path, bucket, BUCKET_PREFIX)
