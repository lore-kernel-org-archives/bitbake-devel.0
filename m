Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id D419B72E53
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 14:33:02 +0000 (UTC)
Received: by wgdm6 with SMTP id m6so90963094wgd.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 07:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7TQOmJtDrxrHjypSEgSjvYBNc+MSLonXnYmucPw9+uY=;
	b=PvVDNhevS3YvMLRfJK1d3yeY5aaZBqE3O0ktdBNQTX1s3zKaX6ByrYUiKWTdHr6A/d
	mbBiHz91zEEKnVUzQugpJsiwvI4EvvI487dJUepg4kSbQYp4RSM1qKY5SQKC5tuZ8YaT
	1J5BnTIhOE8LpN43lebU6cPiCNbB55qr72wfe/lefJhy+2GqUCXDlb7dN2MQqZy9GXS6
	LCWXiDlfvyC9Bk9d8Q8VTu0KzmaCDshY0FOk+hAQkEd2Az8sO7VP3MBzicKi4WiQ+Z6i
	YiRtOGrOs/9fR1Ib54jq5f9Ns4rvvvEGk+l7ioAz4psmso11TCddBaLu0MAiB5plE1YL
	KbEg==
X-Gm-Message-State: ALoCoQlvd3tOxD5Am0sO0VGOdcxwWgJG8JelAQjcZAdNhvv1jptlGuzao0Pzard+qSzF6fjLDpeZ
X-Received: by 10.194.61.244 with SMTP id t20mr155346175wjr.83.1426861983476; 
	Fri, 20 Mar 2015 07:33:03 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ps4sm6605365wjc.31.2015.03.20.07.33.01
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 07:33:02 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 8BF7E562065; Tue, 17 Mar 2015 13:28:06 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Mar 2015 13:27:53 +0000
Message-Id: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 01/14] toasterui: improve info in the toaster_ui.log
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
X-List-Received-Date: Fri, 20 Mar 2015 14:33:06 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We improve logging and signalling of errors in the
toaster_ui.log to facilitate debugging on remote systems.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 12 ++++++++----
 lib/bb/ui/toasterui.py       |  8 ++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index cf8c444..b511abe 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -33,6 +33,7 @@ from toaster.orm.models import Task_Dependency, Package_Dependency
 from toaster.orm.models import Recipe_Dependency
 from bb.msg import BBLogFormatter as format
 from django.db import models
+from pprint import pformat
 import logging
 
 from django.db import transaction, connection
@@ -282,7 +283,6 @@ class ORMWrapper(object):
             # we might have a race condition here, as the project layers may change between the build trigger and the actual build execution
             # but we can only match on the layer name, so the worst thing can happen is a mis-identification of the layer, not a total failure
 
-            from pprint import pformat
             # note that this is different
             buildrequest = BuildRequest.objects.get(pk = br_id)
             for brl in buildrequest.brlayer_set.all():
@@ -467,7 +467,7 @@ class ORMWrapper(object):
             Package_Dependency.objects.bulk_create(packagedeps_objs)
 
         if (len(errormsg) > 0):
-            raise Exception(errormsg)
+            logger.warn("buildinfohelper: target_package_info could not identify recipes: \n%s" % errormsg)
 
     def save_target_image_file_information(self, target_obj, file_name, file_size):
         target_image_file = Target_Image_File.objects.create( target = target_obj,
@@ -885,9 +885,13 @@ class BuildInfoHelper(object):
             assert localfilepath.startswith("/")
 
             recipe_information = self._get_recipe_information_from_taskfile(taskfile)
-            recipe_object = Recipe.objects.get(layer_version = recipe_information['layer_version'],
+            try:
+                recipe_object = Recipe.objects.get(layer_version = recipe_information['layer_version'],
                             file_path__endswith = recipe_information['file_path'],
                             name = recipename)
+            except Recipe.DoesNotExist:
+                logger.error("Could not find recipe for recipe_information %s name %s" % (pformat(recipe_information), name))
+                raise
 
             task_information = {}
             task_information['build'] = self.internal_state['build']
@@ -1127,7 +1131,7 @@ class BuildInfoHelper(object):
         Task_Dependency.objects.bulk_create(taskdeps_objects)
 
         if (len(errormsg) > 0):
-            raise Exception(errormsg)
+            logger.warn("buildinfohelper: dependency info not identify recipes: \n%s" % errormsg)
 
 
     def store_build_package_information(self, event):
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index df9f362..db119ce 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -327,9 +327,17 @@ def main(server, eventHandler, params ):
         except Exception as e:
             # print errors to log
             import traceback
+            from pprint import pformat
             exception_data = traceback.format_exc()
             logger.error("%s\n%s" % (e, exception_data))
 
+            exc_type, exc_value, tb = sys.exc_info()
+            if tb is not None:
+                curr = tb
+                while curr is not None:
+                    logger.warn("Error data dump %s\n%s\n" % (traceback.format_tb(curr,1), pformat(curr.tb_frame.f_locals)))
+                    curr = curr.tb_next
+
             # save them to database, if possible; if it fails, we already logged to console.
             try:
                 buildinfohelper.store_log_exception("%s\n%s" % (str(e), exception_data))
-- 
1.9.1


