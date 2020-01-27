#!/bin/bash
cd `dirname $0`
cd ../publish/Implem.Pleasanter/
dotnet Implem.Pleasanter.NetCore.dll --urls=http://0.0.0.0:80 --pathbase=/pleasanter
