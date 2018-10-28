# /*
#  *  Environment Definition
#  *  Development: 
#  */

# data "template_file" "docker" {
#   template = "${file("${path.module}/templates/Dockerrun.aws.json.tpl")}"

#   vars {
#     docker_tag       = "${var.docker_tag}"
#     docker_image     = "${var.docker_image}"
#     docker_ports     = "[ ${join(",\n",formatlist("{ \"ContainerPort\": \"%s\" }", var.docker_ports))} ]"
#     application_name = "${var.tags["ApplicationName"]}"
#   }
# }

# data "archive_file" "zip" {
#   type = "zip"

#   source_content = "${data.template_file.docker.rendered}"

#   source_content_filename = "Dockerrun.aws.json"

#   output_path = "./${var.tags["ApplicationName"]}-Dockerrun.zip"
# }

# resource "aws_s3_bucket" "default" {
#   bucket = "${var.tags["ApplicationName"]}-beanstalk-deployments"
# }

# resource "aws_s3_bucket_object" "default" {
#   bucket = "${aws_s3_bucket.default.bucket}"
#   key    = "${var.tags["ApplicationName"]}-Dockerrun"
#   source = "./${var.tags["ApplicationName"]}-Dockerrun.zip"
#   etag   = "${data.archive_file.zip.output_md5}"
# }

# # Beanstalk Application


# resource "aws_elastic_beanstalk_application_version" "default" {
#   name        = "${var.tags["ApplicationName"]}-${var.tags["Version"]}"
#   application = "${var.tags["ApplicationName"]}"
#   description = "application version created by terraform"
#   bucket      = "${aws_s3_bucket.default.id}"
#   key         = "${aws_s3_bucket_object.default.id}"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "aws_elastic_beanstalk_application" "default" {
  name        = "${var.tags["ApplicationName"]}"
}
resource "aws_elastic_beanstalk_environment" "default" {
  name                = "${var.tags["ApplicationName"]}${var.tags["Version"]}"
  application         = "${var.tags["ApplicationName"]}"
  solution_stack_name = "${var.solution_stack}"
  # version_label       = "${aws_elastic_beanstalk_application_version.default.name}"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    # value     = "${aws_iam_instance_profile.ec2.name}"
    value = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${data.terraform_remote_state.env.vpc_id}"
    # value = "vpc-77200511"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${join(",",data.terraform_remote_state.env.private_subnets)}"
    # value = "subnet-1131a677"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MinInstancesInService"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MaxBatchSize"
    value     = "1"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Fixed"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "1"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "Rolling"
  }


  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "public"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "${var.instance_type}"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = "Any 2"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "${var.scale_min}"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "${var.scale_max}"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = "CPUUtilization"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = "10"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = "80"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = "Percent"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "basic"
  }

  # setting {
  #   namespace = "aws:elasticbeanstalk:healthreporting:system"
  #   name      = "ConfigDocument"
  #   value     = "{\"CloudWatchMetrics\": { \"Environment\": { \"InstancesOk\": 60, \"ApplicationRequestsTotal\": 60, \"ApplicationRequests5xx\": 60 }, \"Instance\": { } }, \"Version\": 1 }"
  # }



  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    # value     = "${aws_iam_role.service.name}"
    value = "aws-elasticbeanstalk-service-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "environment"
    value     = "${var.tags["Environment"]}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "LOGGING_APPENDER"
    value     = "GRAYLOG"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "basic"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MinInstancesInService"
    value     = "${var.minimum_instances_in_service}"
  }

 
  setting {
    namespace = "aws:elbv2:listener:default"
    name      = "Protocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elbv2:listener:80"
    name      = "Protocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "Protocol"
    value     = "HTTPS"
  }



  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    # value     = "${data.aws_acm_certificate.dns_cname.arn}"
    value = "arn:aws:acm:eu-west-1:933186250239:certificate/1851de8f-c18d-4b27-ab6a-83cfbdf3a9be"
  }

  
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MaxBatchSize"
    value     = "1"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Percentage"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "100"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "AllAtOnce"
  }


  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "${aws_security_group.default.id}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "${var.instance_key}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "StickinessEnabled"
    value     = "false"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SERVER_PORT"
    value     = "${var.server_port}"
  }

 

  tags = "${var.tags}"
}
