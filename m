Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
	[209.85.214.53])
	by mail.openembedded.org (Postfix) with ESMTP id 0D6A9788DF;
	Mon, 16 Jul 2018 20:38:09 +0000 (UTC)
Received: by mail-it0-f53.google.com with SMTP id w16-v6so22836683ita.0;
	Mon, 16 Jul 2018 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4M9KOKZbYXmBE3o1ClfKv7tzhN/EsfzIu2qk6nxZBGk=;
	b=V+ihcsPASoz1IL9vkDqiXqlwnxujMbi7W1SHJQXl7Lrd2jtmBk7vRFPPSR6srbnHcV
	lsR03nF7hJZBhpKgq8lz7fWPhlcS1tWpBDS63NpF03jFPTTOPII1VINBPMswVHesvqK/
	oZctoqZxUWLxbnBQLSGoSHoeAC/wP9qMnFe1Z659y2ilHuNKp6iBziaOHXprDUP4LfCQ
	sIr3Gr6wiMzvaqssxFmYVu21NyfgPMoW+fblGpZlSehUUOIj2LdOxvPCVitS5Un1gRgv
	1P4K50EkycHfQM6aPdAXE+yQ/2V4g314K4Qwwd1sDeP5uiwDoW7kt98oZd0AdDCbdSr2
	CD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4M9KOKZbYXmBE3o1ClfKv7tzhN/EsfzIu2qk6nxZBGk=;
	b=A8zFPp1zUyc6YHQMbtcyU/WWz//yFFG6gQNigl/6EEsq2OYhc/emcuc4rxnHmGKvSt
	0lXUBfuTXD/8BtLcQtdoQO/Kwxo97ZT46BmM5KKyP0KsIL1teR80qMdXSl157AoeTrnL
	lqxBNu7RLVUiEwi8xYzaPLmpw5y4rlkZjXbhQ6t0EHIWUqeS2DdeL4h+yoNqJser36Te
	Hj72YiI5RwLRtRZ6Mcvz9tInhboA3rHgpcA6gbqVwRZ7v6TruSvW5ivMRWhL6ZvEEf+e
	pSTwNhYJ5XpQX5TeSnmXS8nYq/asjL3qQMVT3sq0hV5a3rdCeMZ+VttzzZerujZW7z8K
	rpWw==
X-Gm-Message-State: AOUpUlHF2uGtSdWv2ixZxePdyJ1uLY0jWv0XpOkFPZJ+PxOw7+OWjzfe
	DML+yOuDZKjCxiQ+HK2M+0vOIdq1
X-Google-Smtp-Source: AAOMgpf+FhJzp6tk7w5yvfAkUxGah4/qJrztgSaFVS3omjOs7k7txhJChWsRaIN6hU2utiofUykAwg==
X-Received: by 2002:a24:e1c5:: with SMTP id
	n188-v6mr13212810ith.89.1531773490892; 
	Mon, 16 Jul 2018 13:38:10 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r199-v6sm8988222itb.8.2018.07.16.13.38.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 16 Jul 2018 13:38:10 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Mon, 16 Jul 2018 15:37:27 -0500
Message-Id: <20180716203728.23078-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716203728.23078-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
Subject: [RFC 8/9] hashserver: Add initial reference server
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 16 Jul 2018 20:38:10 -0000

Adds an initial reference implementation of the hash server.

NOTE: This is my first dive into HTTP & REST technologies. Feedback is
appreciated. Also, I don't think it will be necessary for this reference
implementation to live in bitbake, and it can be moved to it's own
independent project if necessary?

Also, this server has some concurrency issues that I haven't tracked
down and will occasionally fail to record a new POST'd task with an
error indicating the database is locked. Based on some reading, I
believe this is because the server is using a sqlite backend, and it
would go away with a more production worthy backend. Anyway, it is good
enough for some preliminary testing.

Starting the server is simple and only requires pipenv to be installed:

 $ pipenv shell
 $ ./app.py

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/contrib/hashserver/.gitignore |   2 +
 bitbake/contrib/hashserver/Pipfile    |  15 ++
 bitbake/contrib/hashserver/app.py     | 212 ++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 bitbake/contrib/hashserver/.gitignore
 create mode 100644 bitbake/contrib/hashserver/Pipfile
 create mode 100755 bitbake/contrib/hashserver/app.py

diff --git a/bitbake/contrib/hashserver/.gitignore b/bitbake/contrib/hashserver/.gitignore
new file mode 100644
index 00000000000..030640a2b21
--- /dev/null
+++ b/bitbake/contrib/hashserver/.gitignore
@@ -0,0 +1,2 @@
+hashes.db
+Pipfile.lock
diff --git a/bitbake/contrib/hashserver/Pipfile b/bitbake/contrib/hashserver/Pipfile
new file mode 100644
index 00000000000..29cfb41a907
--- /dev/null
+++ b/bitbake/contrib/hashserver/Pipfile
@@ -0,0 +1,15 @@
+[[source]]
+url = "https://pypi.org/simple"
+verify_ssl = true
+name = "pypi"
+
+[packages]
+flask = "*"
+flask-sqlalchemy = "*"
+marshmallow-sqlalchemy = "*"
+flask-marshmallow = "*"
+
+[dev-packages]
+
+[requires]
+python_version = "3.6"
diff --git a/bitbake/contrib/hashserver/app.py b/bitbake/contrib/hashserver/app.py
new file mode 100755
index 00000000000..4fd2070fe92
--- /dev/null
+++ b/bitbake/contrib/hashserver/app.py
@@ -0,0 +1,212 @@
+#! /usr/bin/env python3
+#
+# BitBake Hash Server Reference Implementation
+#
+# Copyright (C) 2018 Garmin International
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from flask import Flask, request, jsonify
+from flask_sqlalchemy import SQLAlchemy
+from flask_marshmallow import Marshmallow
+from sqlalchemy import desc, case, func
+import sqlalchemy
+import sqlite3
+import hashlib
+import datetime
+
+app = Flask(__name__)
+app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///hashes.db'
+app.config['SQLALCHEMY_TIMEOUT'] = 15
+
+# Order matters: Initialize SQLAlchemy before Marshmallow
+db = SQLAlchemy(app)
+ma = Marshmallow(app)
+
+@sqlalchemy.event.listens_for(sqlalchemy.engine.Engine, "connect")
+def set_sqlite_pragma(dbapi_connection, connection_record):
+    cursor = dbapi_connection.cursor()
+    cursor.execute("PRAGMA journal_mode=WAL")
+    cursor.close()
+
+class TaskModel(db.Model):
+    __tablename__ = 'tasks'
+
+    id = db.Column(db.Integer, primary_key=True)
+    taskhash = db.Column(db.String(), nullable=False)
+    method = db.Column(db.String(), nullable=False)
+    outhash = db.Column(db.String(), nullable=False)
+    depid = db.Column(db.String(), nullable=False)
+    owner = db.Column(db.String())
+    created = db.Column(db.DateTime)
+    PN = db.Column(db.String())
+    PV = db.Column(db.String())
+    PR = db.Column(db.String())
+    task = db.Column(db.String())
+    outhash_siginfo = db.Column(db.Text())
+
+    __table_args__ = (
+            db.UniqueConstraint('taskhash', 'method', 'outhash', name='unique_task'),
+            # Make an index on taskhash and method for fast lookup
+            db.Index('lookup_index', 'taskhash', 'method'),
+            )
+
+    def __init__(self, taskhash, method, outhash, depid, owner=None):
+        self.taskhash = taskhash
+        self.method = method
+        self.outhash = outhash
+        self.depid = depid
+        self.owner = owner
+        self.created = datetime.datetime.utcnow()
+        self.task = None
+        self.outhash_siginfo = None
+
+schemas = {}
+
+class TaskFullSchema(ma.ModelSchema):
+    class Meta:
+        model = TaskModel
+
+task_full_schema = TaskFullSchema()
+tasks_full_schema = TaskFullSchema(many=True)
+schemas['full'] = tasks_full_schema
+
+class TaskSchema(ma.ModelSchema):
+    class Meta:
+        fields = ('id', 'taskhash', 'method', 'outhash', 'depid', 'owner', 'created', 'PN', 'PV', 'PR', 'task')
+
+task_schema = TaskSchema()
+tasks_schema = TaskSchema(many=True)
+schemas['default'] = tasks_schema
+
+class DepIDSchema(ma.ModelSchema):
+    class Meta:
+        fields = ('taskhash', 'method', 'depid')
+
+depid_schema = DepIDSchema()
+depids_schema = DepIDSchema(many=True)
+schemas['depid'] = depids_schema
+
+def get_tasks_schema():
+    return schemas.get(request.args.get('output', 'default'), tasks_schema)
+
+def get_count_column(column, min_count):
+    count_column = func.count(column).label('count')
+    query = (db.session.query(TaskModel)
+            .with_entities(column, count_column)
+            .group_by(column))
+
+    if min_count > 1:
+        query = query.having(count_column >= min_count)
+
+    col_name = column.name
+
+    result = [{'count': data.count, col_name: getattr(data, col_name)} for data in query.all()]
+
+    return jsonify(result)
+
+def filter_query_from_request(query, request):
+    for key in request.args:
+        if hasattr(TaskModel, key):
+            vals = request.args.getlist(key)
+            query = (query
+                    .filter(getattr(TaskModel, key).in_(vals))
+                    .order_by(TaskModel.created.asc()))
+    return query
+
+@app.route("/v1/count/outhashes", methods=["GET"])
+def outhashes():
+    return get_count_column(TaskModel.outhash, int(request.args.get('min', 1)))
+
+@app.route("/v1/count/taskhashes", methods=["GET"])
+def taskhashes():
+    return get_count_column(TaskModel.taskhash, int(request.args.get('min', 1)))
+
+@app.route("/v1/equivalent", methods=["GET", "POST"])
+def equivalent():
+    if request.method == 'GET':
+        task = (db.session.query(TaskModel)
+            .filter(TaskModel.method == request.args['method'])
+            .filter(TaskModel.taskhash == request.args['taskhash'])
+            .order_by(
+                # If there are multiple matching task hashes, return the oldest
+                # one
+                TaskModel.created.asc())
+            .limit(1)
+            .one_or_none())
+
+        return depid_schema.jsonify(task)
+
+    # TODO: Handle authentication
+
+    data = request.get_json()
+    # TODO handle when data is None. Currently breaks
+
+    # Find an appropriate task.
+    new_task = (db.session.query(TaskModel)
+            .filter(
+                # The output hash and method must match exactly
+                TaskModel.method == data['method'],
+                TaskModel.outhash == data['outhash'])
+            .order_by(
+                # If there is a matching taskhash, it will be sorted first, and
+                # thus the only row returned.
+                case([(TaskModel.taskhash == data['taskhash'], 1)], else_=2))
+            .order_by(
+                # Sort by date, oldest first. This only really matters if there
+                # isn't an exact match on the taskhash
+                TaskModel.created.asc())
+            # Only return one row
+            .limit(1)
+            .one_or_none())
+
+    # If no task was found that exactly matches this taskhash, create a new one
+    if not new_task or new_task.taskhash != data['taskhash']:
+        # Capture the dependency ID. If a matching task was found, then change
+        # this tasks dependency ID to match.
+        depid = data['depid']
+        if new_task:
+            depid = new_task.depid
+
+        new_task = TaskModel(data['taskhash'], data['method'], data['outhash'], depid)
+        db.session.add(new_task)
+
+    if new_task.taskhash == data['taskhash']:
+        # Add or update optional attributes
+        for o in ('outhash_siginfo', 'owner', 'task', 'PN', 'PV', 'PR'):
+            v = getattr(new_task, o, None)
+            if v is None:
+                setattr(new_task, o, data.get(o, None))
+
+    db.session.commit()
+
+    return depid_schema.jsonify(new_task)
+
+# TODO: Handle errors. Currently, everything is a 500 error
+@app.route("/v1/tasks", methods=["GET"])
+def tasks():
+    query = db.session.query(TaskModel)
+    query = filter_query_from_request(query, request)
+    return get_tasks_schema().jsonify(query.all())
+
+@app.route("/v1/tasks/overridden", methods=["GET"])
+def overridden():
+    query = db.session.query(TaskModel).filter(TaskModel.depid != TaskModel.taskhash)
+    query = filter_query_from_request(query, request)
+    return get_tasks_schema().jsonify(query.all())
+
+if __name__ == '__main__':
+    db.create_all()
+    app.run(debug=True)
+
-- 
2.17.1


