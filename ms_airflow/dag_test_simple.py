#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

"""
Extending example from
https://airflow.apache.org/docs/apache-airflow/stable/_modules/airflow/example_dags/example_python_operator.html

"""
import logging
import shutil
from datetime import datetime, timedelta
from pprint import pprint

import time
from airflow import DAG
from airflow.decorators import task

log = logging.getLogger(__name__)

with DAG(
        dag_id='dag_virt_env_test',
        schedule_interval=timedelta(seconds=60),
        start_date=datetime(2022, 1, 1),
        catchup=False,
        tags=['metadata', 'postgres'],
) as dag:
    # [START print_the_context]
    @task(task_id="print_the_context")
    def print_context(ds=None, **kwargs):
        """Print the Airflow context and ds variable from the context."""
        pprint(kwargs)
        print(ds)
        return 'RUNNING POSTGRES CATALOGIZER'


    run_this = print_context()
    # [END print_the_context]
    
    # [START print_the_context]
    @task(task_id="test_libraries")
    def test_libraries(ds=None, **kwargs):
        """Print the Airflow context and ds variable from the context."""
        pprint(kwargs)
        print(ds)
        return 'RUNNING POSTGRES CATALOGIZER'


    testlib_task = test_libraries()
    # [END test_libraries]

    
