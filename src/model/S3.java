package model;

import java.io.*;
import java.util.Iterator;
import java.util.List;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.ClasspathPropertiesFileCredentialsProvider;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.*;

public class S3 {
        private AWSCredentialsProvider credentialsProvider;
        private AmazonS3Client s3;
        private static String bucket = "babyshop";

        public S3() {
                try {
                        credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
                        s3 = new AmazonS3Client(credentialsProvider);
                        if (!s3.doesBucketExist(bucket)) {
                                s3.createBucket(bucket);
                        }
                } catch (Exception e) {
                        System.out.println(e.getMessage());
                }
        }

        public void add(String fileName, File fileData) {
                PutObjectRequest putObjectRequest = new PutObjectRequest(bucket, fileName, fileData);
                putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead);
                AccessControlList accessControlLis = new AccessControlList();
                CanonicalGrantee grantee = new CanonicalGrantee("Everyone");
                accessControlLis.grantPermission(grantee, Permission.Read);
                s3.putObject(putObjectRequest);
        }

        public boolean existName(String fileName) {
                ObjectListing list = s3.listObjects(bucket);
                List<S3ObjectSummary> objects = list.getObjectSummaries();
                Iterator<S3ObjectSummary> iter = objects.iterator();
                while (iter.hasNext()) {
                        S3ObjectSummary object = iter.next();
                        if (object.getKey().equals(fileName))
                                return true;
                }
                return false;
        }

        public void deleteObject(String fileName) {
                // delete a video from S3
                DeleteObjectRequest deleteObjectRequest = new DeleteObjectRequest(bucket, fileName);
                s3.deleteObject(deleteObjectRequest);
        }

}