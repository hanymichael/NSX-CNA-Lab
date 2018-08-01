#!/bin/bash
echo 'kubectl get po -o wide --all-namespaces' > kp
echo 'kubectl get no -o wide --all-namespaces' > kn
echo 'kubectl get svc -o wide --all-namespaces' > ks
echo 'kubectl get ing -o wide --all-namespaces' > ki

echo 'watch kubectl get po -o wide --all-namespaces' > kk
echo 'watch kubectl get po -o wide --all-namespaces' > kkp
echo 'watch kubectl get no -o wide --all-namespaces' > kkn
echo 'watch kubectl get svc -o wide --all-namespaces' > kks
echo 'watch kubectl get ing -o wide --all-namespaces' > kki

chmod +x k*
cp k* /usr/bin
