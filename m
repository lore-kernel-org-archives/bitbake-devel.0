Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f181.google.com (mail-we0-f181.google.com
	[74.125.82.181])
	by mail.openembedded.org (Postfix) with ESMTP id E5EB66EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:02 +0000 (UTC)
Received: by mail-we0-f181.google.com with SMTP id q58so2399886wes.40
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=0/NmYxW+EQol6uar2k/ZgcqPHveMfWkWZIk5EnntRSM=;
	b=mntH7o3DHBYLnlOtg1eLZ25iddXrfqGMfJ0YAl7duAkSdidL2JgOf3FrWPSc+40jyN
	QgX52+ma4Xxp+qNiEanT92Rrgrwlj4xNDHixQVJmNljJURhkAx+h2K62MyUVAN5tVew/
	ZQpGu+ztKOCLURp7B4CP6ZrisNy0DawF7SmUiDZlHZbZTza4sdeK9YRXkQg57NlnUGMV
	1L15fW0u39s6IPgontuZCY0+209IKhS+vbwqHtKiik5sDkL30VCqSreTP806TYVkQY00
	BTzrEVYsRijV92BAYei8hbr1qyOfh8F+II6sv6cynMx7fxr6rlTrcVq/nhCV9CJhjKKy
	WM+g==
X-Gm-Message-State: ALoCoQnOywyLRBL8h9J3FjwmqGElUWf/cKEsoSC5tAnk8blDOZGGy6eIzYWs0N9zMOP+vcFipTSE
X-Received: by 10.194.203.200 with SMTP id ks8mr2924243wjc.61.1394819942544;
	Fri, 14 Mar 2014 10:59:02 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fq16sm15576340wjc.3.2014.03.14.10.59.01 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:01 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0986C5605D0; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:43 +0000
Message-Id: <c350e4924abab8688c539608fd7f3af687d7265a.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 02/19] toaster: improve recipe matching for native tasks
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:03 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch improves the recipe matching algorithm for
for matching recipes for native tasks.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index b5e75d9..15bc069 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -33,6 +33,9 @@ from toaster.orm.models import Task_Dependency, Package_Dependency
 from toaster.orm.models import Recipe_Dependency
 from bb.msg import BBLogFormatter as format
 
+class NotExisting(Exception):
+    pass
+
 class ORMWrapper(object):
     """ This class creates the dictionaries needed to store information in the database
         following the format defined by the Django models. It is also used to save this
@@ -111,7 +114,8 @@ class ORMWrapper(object):
 
         if must_exist and created:
             task_information['debug'] = "build id %d, recipe id %d" % (task_information['build'].pk, task_information['recipe'].pk)
-            raise Exception("Task object created when expected to exist", task_information)
+            task_object.delete()
+            raise NotExisting("Task object created when expected to exist", task_information)
 
         for v in vars(task_object):
             if v in task_information.keys():
@@ -142,12 +146,14 @@ class ORMWrapper(object):
         assert 'layer_version' in recipe_information
         assert 'file_path' in recipe_information
 
+
         recipe_object, created = Recipe.objects.get_or_create(
                                          layer_version=recipe_information['layer_version'],
                                          file_path=recipe_information['file_path'])
 
         if must_exist and created:
-            raise Exception("Recipe object created when expected to exist", recipe_information)
+            recipe_object.delete()
+            raise NotExisting("Recipe object created when expected to exist", recipe_information)
 
         for v in vars(recipe_object):
             if v in recipe_information.keys():
@@ -639,7 +645,7 @@ class BuildInfoHelper(object):
         identifier = event.taskfile + ":" + event.taskname
 
         recipe_information = self._get_recipe_information_from_taskfile(event.taskfile)
-        recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
+        recipe = self.orm_wrapper.get_update_recipe_object(recipe_information, True)
 
         task_information = self._get_task_information(event, recipe)
         task_information['outcome'] = Task.OUTCOME_NA
@@ -679,9 +685,9 @@ class BuildInfoHelper(object):
             recipe_information = self._get_recipe_information_from_taskfile(taskfile)
             try:
                 recipe = self.orm_wrapper.get_update_recipe_object(recipe_information, True)
-            except Exception:
-                # we cannot find the recipe information for the task, we move on to the next task
-                continue
+            except NotExisting:
+                recipe = Recipe.objects.get(layer_version = recipe_information['layer_version'],
+                            file_path__endswith = recipe_information['file_path'])
 
             task_information = {}
             task_information['build'] = self.internal_state['build']
-- 
1.8.3.2


