# Cloud Resume Challenge

Welcome to my Cloud Resume Challenge project! This project is part of the AWS Cloud Resume Challenge, where I demonstrate my cloud computing skills by building a personal portfolio website using various AWS services.

## Project Overview

In this project, I have created a personal resume website and deployed it using AWS services. The challenge involves using AWS to handle both the frontend (website) and the backend (services such as databases and Lambda functions) while keeping the costs low. 

For my frontend, I use S3, CloudFront, and Route53. I have hosted my website using S3 as my origin and CloudFront for content delivery. Since I wanted a unique domain, I used Route53 to register and host my domain [asetcloud.com](https://www.asetcloud.com). 

To create a vistor count tracker, I needed to configure a backend, so I used Lambda, API Gateway, and DynamoDB. Javascript in the files for my website would speak to the API Gateway which would handle the requests and send it to the Lambda function. From here, the Lambda function reads the views from DynamoDB and increments the view count by 1. Of course, the DynamoDB retains the view count to maintain persistent storage.

## Project Architecture

Here is a visual diagram of the architecture:

## Lessons Learned

The first novel thing that I learned was CI/CD, especially with Github Actions. Prior to this project, it was mostly manual configuration, but the automation provided by CI/CD has opened my eyes to a new side of development.
Moreover, I gained hands on experience with Terraform. Instead of clicking around in the console, I learned how to write infrastructure as code using Terraform. This especially was fascinating to me since watching all the resource deploy is a satisfying feeling after spending a long time trying to code.
Also, I grew significantly in terms of coding/scripting ability. In ths project, I spent a lot of time coding in HTML, CSS, Javscript, Python, and HCL. As for scripting, I configured everything in PowerShell environment and used aws, git, and terraform cli tools.
Finally, my knowledge of AWS architecture grew massively as a result of this challenge. Integrating all of the resources together, following AWS suggested best practices, configuring different environments, etc. taught me greatly about AWS services and the way they interact.

###### License
This project is licensed under the [MIT License](LICENSE.md).
