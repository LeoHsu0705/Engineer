#!/bin/bash

for nginx in $(kubectl  get pods -l app=dev-nginx -o=name -n nginx); do
  kubectl exec -it $nginx -n nginx -- nginx -s reload;
done
