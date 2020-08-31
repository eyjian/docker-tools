#!/bin/sh
# Writed by yijian on 2020/8/31
# 批量删除指定 repository 所有镜像工具
# 运行时需要指定一个参数：
# 1）参数1：必选参数，repository 名，即“docker images”的第一列值

function usage()
{
  echo "Remove all images with the given repository."
  echo "Usage: `basename $0` repository"
  echo "Example1: `basename $0` \"<none>\""
  echo "Example2: `basename $0` \"redis\""
}

# 参数检查
if test $# -ne 1; then
  usage
  exit 1
fi

repository="$1"
images=(`docker images|awk -v repository=$repository '{ if ($1==repository) print $3 }'`)
for ((i=0; i<${#images[@]}; ++i))
do
  image="${images[$i]}"
  echo "[$i] docker rmi \"$image\""
  docker rmi "$image"
done
