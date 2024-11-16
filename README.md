# Cloud Resume Challenge

Welcome to my Cloud Resume Challenge project! This project is part of the AWS Cloud Resume Challenge, where I demonstrate my cloud computing skills by building a personal portfolio website using various AWS services.

## Project Overview
In this project, I have created a personal resume website and deployed it using AWS services. The challenge involves using AWS to handle both the frontend (website) and the backend (services such as databases and Lambda functions) while keeping the costs low. 

For my frontend, I use S3, CloudFront, and Route53. I have hosted my website using S3 as my origin and CloudFront for content delivery. Since I wanted a unique domain, I used Route53 to register and host my domain [asetcloud.com](https://www.asetcloud.com). 

To create a vistor count tracker, I needed to configure a backend, so I used Lambda, API Gateway, and DynamoDB. Javascript in the files for my website would speak to the API Gateway which would handle the requests and send it to the Lambda function. From here, the Lambda function reads the views from DynamoDB and increments the view count by 1. Of course, the DynamoDB retains the view count to maintain persistent storage.

## Project Architecture
Here is a visual diagram of the architecture:


## Lessons Learned


###### License
This project is licensed under the MIT License.
