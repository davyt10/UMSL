#!/usr/bin/env python

import boto3
import pprint

'''def runtask():

    client = boto3.client('ecs')
    response = client.run_task(
        cluster='usml_cluster',
        launchType='FARGATE',
        taskDefinition='usmlservice',
        platformVersion='LATEST',
        networkConfiguration={
            'awsvpcConfiguration': {
                'subnets': ['subnet-8b3f36ee'],
                'assignPublicIp': 'ENABLED',
                'securityGroups': ['sg-0b26558a65fa955b7'],
            }
        }
    )
    print (response)
    return str(response)
'''

def updateservice():

    client = boto3.client('ecs')
    response = client.update_service(
        cluster='usml_cluster',
        desiredCount = 1,
        service='usmlservice',
        taskDefinition='usmltaskdef',# taskDefinition (string) -- The family and revision (family:revision ) or full ARN of the task definition to run in your service. If a revision is not specified, the latest ACTIVE revision is used. If you modify the task definition with UpdateService , Amazon ECS spawns a task with the new version of the task definition and then stops an old task after the new version is running.
        platformVersion='LATEST',
        forceNewDeployment=True
        #If your updated Docker image uses the same tag as what is in the existing task definition for your service
        # (for example, my_image:latest ), you do not need to create a new revision of your task definition. You can
        # update the service using the forceNewDeployment option. The new tasks launched by the deployment pull the current image/tag combination from your repository when they start.
     )
    pp = pprint.PrettyPrinter(indent=4)
    pp.pprint(response)
    return str(response)

if __name__ == "__main__":
    #runtask()
    updateservice()
