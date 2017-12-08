#!/usr/bin/env bash
##
# Generated by Cloudera Manager and should not be modified directly
##

SELF="$(cd $(dirname $BASH_SOURCE) && pwd)"
if [ -z "$SPARK_CONF_DIR" ]; then
  export SPARK_CONF_DIR="$SELF"
fi
##
# Needs to be changed if parcel is implemented
##
CLOUDERA_HOME=/opt/cloudera/parcels
#export SPARK_HOME=$CLOUDERA_HOME/spark-2.0.0.cloudera2-bin-custom-spark-1
export SPARK_HOME=CUSTOM_SPARK_HOME
SPARK_LOG_DIR=/var/log/spark2/ts1
SPARK_PID_DIR=/var/log/spark2/ts1
SPARK_PYTHON_PATH=""
if [ -n "$SPARK_PYTHON_PATH" ]; then
  export PYTHONPATH="$PYTHONPATH:$SPARK_PYTHON_PATH"
fi

export HADOOP_HOME="/opt/cloudera/parcels/CDH/lib/hadoop"
export HADOOP_COMMON_HOME="$HADOOP_HOME"

if [ -n "$HADOOP_HOME" ]; then
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HADOOP_HOME}/lib/native
fi

SPARK_EXTRA_LIB_PATH=""
if [ -n "$SPARK_EXTRA_LIB_PATH" ]; then
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SPARK_EXTRA_LIB_PATH
fi

export LD_LIBRARY_PATH

HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-$SPARK_CONF_DIR/yarn-conf}
export HADOOP_CONF_DIR

PYLIB="$SPARK_HOME/python/lib"
if [ -f "$PYLIB/pyspark.zip" ]; then
  PYSPARK_ARCHIVES_PATH=
  for lib in "$PYLIB"/*.zip; do
    if [ -n "$PYSPARK_ARCHIVES_PATH" ]; then
      PYSPARK_ARCHIVES_PATH="$PYSPARK_ARCHIVES_PATH,local:$lib"
    else
      PYSPARK_ARCHIVES_PATH="local:$lib"
    fi
  done
  export PYSPARK_ARCHIVES_PATH
fi

# Spark uses `set -a` to export all variables created or modified in this
# script as env vars. We use a temporary variables to avoid env var name
# collisions.
# If PYSPARK_PYTHON is unset, set to CDH_PYTHON
TMP_PYSPARK_PYTHON=${PYSPARK_PYTHON:-'{{CDH_PYTHON}}'}
# If PYSPARK_DRIVER_PYTHON is unset, set to CDH_PYTHON
TMP_PYSPARK_DRIVER_PYTHON=${PYSPARK_DRIVER_PYTHON:-{{CDH_PYTHON}}}

if [ -n "$TMP_PYSPARK_PYTHON" ] && [ -n "$TMP_PYSPARK_DRIVER_PYTHON" ]; then
  export PYSPARK_PYTHON="$TMP_PYSPARK_PYTHON"
  export PYSPARK_DRIVER_PYTHON="$TMP_PYSPARK_DRIVER_PYTHON"
fi

export SPARK_DIST_CLASSPATH=$(paste -sd: "$SELF/classpath.txt")
