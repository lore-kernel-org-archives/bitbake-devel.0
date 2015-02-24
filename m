Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id CD0ED73643
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:09 +0000 (UTC)
Received: by pdev10 with SMTP id v10so34765632pde.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=vgNJk1ZJf7up8AGXlJ+JEZxdka5r4qNtr0Cul5s5yYk=;
	b=XiaubA7ThMx8OWSrOh7tkEpzBVtU1mOLu/XG2EJeOhH40nrgaayph7OWo3gSlkNGjv
	mi3SaDZPzG0sldJtY5IgOxhzegYu35I9xBTrR2Q3w87KMQ23iNVBSx6heHA20mql/SIw
	g9XWYdunc7hxaZOdSkaoBBqs4Gj6JNP29jzAnU2YWvHWk2cpZUFsZlmpGRciHzpQhtee
	0czdc6VKWr9MjlAg2+tTohIhrfi5U0Q/AlQrpHP/ql14smw2Js38pkdM4Mfzjjbr1WlQ
	JrF19Jt06x0V5yZ2j98nGAw7lD9M604zu5DPBCR7tLlNjnPcF9+tR8LjUNzxgKXyTDfI
	uKXQ==
X-Gm-Message-State: ALoCoQn4jfaKWtjJJUZlYB1e8gkqiPv52YQZNbaImpeuHm7eX8dAfB+t9H3ZUSY+DrkN/4hrR3Es
X-Received: by 10.66.221.227 with SMTP id qh3mr30516605pac.1.1424798470748;
	Tue, 24 Feb 2015 09:21:10 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id kn4sm6483540pab.48.2015.02.24.09.21.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:09 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 9C11D561A3D; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:57 +0000
Message-Id: <f91119324ae60f0cba6cab017d6ee63cf27fe7f2.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 09/12] toasterui: disable autocommit for build logging
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:11 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch disables autocommit for inserting build data,
effectively updating all build data in a single transaction.

This is a purely performance improvement patch, as the transaction
will always be commited.

Similar manual transaction handling in the layer source update
method. Added feedback messages during update method.

[YOCTO #7140]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 11 +++++++++++
 lib/toaster/orm/models.py    | 18 +++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 1096ccf..967e4bd 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -35,6 +35,7 @@ from bb.msg import BBLogFormatter as format
 from django.db import models
 import logging
 
+from django.db import transaction
 
 logger = logging.getLogger("BitBake")
 
@@ -606,7 +607,9 @@ class BuildInfoHelper(object):
         self.internal_state = {}
         self.internal_state['taskdata'] = {}
         self.task_order = 0
+        self.autocommit_step = 1
         self.server = server
+        transaction.set_autocommit(False)
         self.orm_wrapper = ORMWrapper()
         self.has_build_history = has_build_history
         self.tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
@@ -926,6 +929,12 @@ class BuildInfoHelper(object):
                 task_information['outcome'] = Task.OUTCOME_FAILED
                 del self.internal_state['taskdata'][identifier]
 
+        # we force a sync point here, to get the progress bar to show
+        if self.autocommit_step % 3 == 0:
+            transaction.set_autocommit(True)
+            transaction.set_autocommit(False)
+        self.autocommit_step += 1
+
         self.orm_wrapper.get_update_task_object(task_information, True) # must exist
 
 
@@ -1197,3 +1206,5 @@ class BuildInfoHelper(object):
                 # we have no build, and we still have events; something amazingly wrong happend
                 for event in self.internal_state['backlog']:
                    logger.error("UNSAVED log: %s", event.msg)
+
+        transaction.set_autocommit(True)
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 54cd535..9d4f4c9 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -664,6 +664,7 @@ class LayerIndexLayerSource(LayerSource):
         """
         assert self.apiurl is not None
         from django.db import IntegrityError
+        from django.db import transaction
 
         import httplib, urlparse, json
         import os
@@ -715,6 +716,7 @@ class LayerIndexLayerSource(LayerSource):
         # update branches; only those that we already have names listed in the Releases table
         whitelist_branch_names = map(lambda x: x.branch_name, Release.objects.all())
 
+        print "Fetching branches"
         branches_info = _get_json_response(apilinks['branches']
             + "?filter=name:%s" % "OR".join(whitelist_branch_names))
         for bi in branches_info:
@@ -727,6 +729,7 @@ class LayerIndexLayerSource(LayerSource):
 
         # update layers
         layers_info = _get_json_response(apilinks['layerItems'])
+        transaction.set_autocommit(False)
         for li in layers_info:
             l, created = Layer.objects.get_or_create(layer_source = self, name = li['name'])
             l.up_id = li['id']
@@ -738,11 +741,15 @@ class LayerIndexLayerSource(LayerSource):
             l.summary = li['summary']
             l.description = li['description']
             l.save()
+        transaction.set_autocommit(True)
 
         # update layerbranches/layer_versions
+        print "Fetching layer information"
         layerbranches_info = _get_json_response(apilinks['layerBranches']
                 + "?filter=branch:%s" % "OR".join(map(lambda x: str(x.up_id), [i for i in Branch.objects.filter(layer_source = self) if i.up_id is not None] ))
             )
+
+        transaction.set_autocommit(False)
         for lbi in layerbranches_info:
             lv, created = Layer_Version.objects.get_or_create(layer_source = self,
                     up_id = lbi['id'],
@@ -755,10 +762,12 @@ class LayerIndexLayerSource(LayerSource):
             lv.commit = lbi['actual_branch']
             lv.dirpath = lbi['vcs_subdir']
             lv.save()
+        transaction.set_autocommit(True)
 
         # update layer dependencies
         layerdependencies_info = _get_json_response(apilinks['layerDependencies'])
         dependlist = {}
+        transaction.set_autocommit(False)
         for ldi in layerdependencies_info:
             try:
                 lv = Layer_Version.objects.get(layer_source = self, up_id = ldi['layerbranch'])
@@ -777,23 +786,29 @@ class LayerIndexLayerSource(LayerSource):
             LayerVersionDependency.objects.filter(layer_version = lv).delete()
             for lvd in dependlist[lv]:
                 LayerVersionDependency.objects.get_or_create(layer_version = lv, depends_on = lvd)
+        transaction.set_autocommit(True)
 
 
         # update machines
+        print "Fetching machine information"
         machines_info = _get_json_response(apilinks['machines']
                 + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
             )
+        transaction.set_autocommit(False)
         for mi in machines_info:
             mo, created = Machine.objects.get_or_create(layer_source = self, up_id = mi['id'], layer_version = Layer_Version.objects.get(layer_source = self, up_id = mi['layerbranch']))
             mo.up_date = mi['updated']
             mo.name = mi['name']
             mo.description = mi['description']
             mo.save()
+        transaction.set_autocommit(True)
 
         # update recipes; paginate by layer version / layer branch
+        print "Fetching target information"
         recipes_info = _get_json_response(apilinks['recipes']
                 + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
             )
+        transaction.set_autocommit(False)
         for ri in recipes_info:
             try:
                 ro, created = Recipe.objects.get_or_create(layer_source = self, up_id = ri['id'], layer_version = Layer_Version.objects.get(layer_source = self, up_id = ri['layerbranch']))
@@ -809,8 +824,9 @@ class LayerIndexLayerSource(LayerSource):
                 ro.file_path = ri['filepath'] + "/" + ri['filename']
                 ro.save()
             except:
-                print "Duplicate Recipe, ignoring: ", vars(ro)
+                #print "Duplicate Recipe, ignoring: ", vars(ro)
                 pass
+        transaction.set_autocommit(True)
         pass
 
 class BitbakeVersion(models.Model):
-- 
1.9.1


