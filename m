Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171])
	by mail.openembedded.org (Postfix) with ESMTP id 1CC616F647
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 18:47:43 +0000 (UTC)
Received: by mail-we0-f171.google.com with SMTP id t61so11703360wes.16
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 11:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=2GCC44UHSH0RY2Ve6/cDopTowm2piQlRu5la8ToY16g=;
	b=OWKJUJ3dxjToXY6p+L7+ULPDpNq/UWRvAIWTrXf/UZl12wOC4iBpeyNk/Dkj4vhV9n
	8q0z1/1oPQ55FVtjfuziMEghoYmgi79p3uyQIEXpftWJqWCoRox0qYp1bnkhQk8IYOqv
	vhJPSk2a84ap/iSVQUAkN8d1zpZGkqQFuXYXTe3he7ViBWWOGUdHoN/qH//EW/7aqNiD
	8T8Sh5P55/byw8ibLkfHD+qF5udkVMlUV8Vei1yA/wsEmDuOwBwlBKKHGfWQOFlfcbly
	ZxIxlbpeZb68e5X8Vvo2BjZGvKitZqTe0FPnShnpeK+I91hy8bVZN+D1KvT8fq869HTe
	cXcQ==
X-Gm-Message-State: ALoCoQl3BW0SJDQ0X+VHrzJ7bO+kPrVws8oHd7PIeAKTntTaclD7q2DMMfwfV/NzPnLht23LGver
X-Received: by 10.194.59.226 with SMTP id c2mr14166734wjr.6.1394650064267;
	Wed, 12 Mar 2014 11:47:44 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id z1sm71838071wjq.19.2014.03.12.11.47.42
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 12 Mar 2014 11:47:42 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id AE21E5605BD; Wed, 12 Mar 2014 18:47:43 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Mar 2014 18:47:39 +0000
Message-Id: <f1ccf1eb81e7ba89b9e540a19c839a3dfdef234b.1394649860.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <y>
References: <y>
In-Reply-To: <cover.1394649860.git.alexandru.damian@intel.com>
References: <cover.1394649860.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/4] toaster: populate target image file table
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
X-List-Received-Date: Wed, 12 Mar 2014 18:47:47 -0000

From: Cristiana Voicu <cristiana.voicu@intel.com>

Using ImageFileSize Metadata event, the image output file and its
size are populated into target_image_file table.

	[YOCTO #5189]
	[YOCTO #5228]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py   | 13 +++++++++++++
 lib/bb/ui/toasterui.py         |  2 ++
 lib/toaster/bldviewer/api.py   |  1 +
 lib/toaster/bldviewer/views.py |  3 ++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index f9b067f..1b17c1f 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -26,6 +26,7 @@ os.environ.setdefault("DJANGO_SETTINGS_MODULE", "toaster.toastermain.settings")
 
 import toaster.toastermain.settings as toaster_django_settings
 from toaster.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
+from toaster.orm.models import Target_Image_File
 from toaster.orm.models import Variable, VariableHistory
 from toaster.orm.models import Package, Package_File, Target_Installed_Package, Target_File
 from toaster.orm.models import Task_Dependency, Package_Dependency
@@ -344,6 +345,11 @@ class ORMWrapper(object):
         if (len(errormsg) > 0):
             raise Exception(errormsg)
 
+    def save_target_image_file_information(self, target_obj, file_name, file_size):
+        target_image_file = Target_Image_File.objects.create( target = target_obj,
+                            file_name = file_name,
+                            file_size = file_size)
+        target_image_file.save()
 
     def create_logmessage(self, log_information):
         assert 'build' in log_information
@@ -598,6 +604,13 @@ class BuildInfoHelper(object):
         # Save build configuration
         self.orm_wrapper.save_build_variables(build_obj, self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0])
 
+    def update_target_image_file(self, event):
+        for t in self.internal_state['targets']:
+            if t.is_image == True:
+                output_files = list(event.data.viewkeys())
+                for output in output_files:
+                    if t.target in output:
+                        self.orm_wrapper.save_target_image_file_information(t, output, event.data[output])
 
     def update_build_information(self, event, errors, warnings, taskfailures):
         if 'build' in self.internal_state:
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index e469d93..04e0f99 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -241,6 +241,8 @@ def main(server, eventHandler, params ):
                     buildinfohelper.store_tasks_stats(event)
                 if event.type == "ImagePkgList":
                     buildinfohelper.store_target_package_data(event)
+                elif event.type == "ImageFileSize":
+                    buildinfohelper.update_target_image_file(event)
                 continue
 
             # ignore
diff --git a/lib/toaster/bldviewer/api.py b/lib/toaster/bldviewer/api.py
index 654864e..76d45c7 100644
--- a/lib/toaster/bldviewer/api.py
+++ b/lib/toaster/bldviewer/api.py
@@ -25,6 +25,7 @@ from django.conf.urls import patterns, include, url
 urlpatterns = patterns('bldviewer.views',
         url(r'^builds$', 'model_explorer',  {'model_name':'build'}, name='builds'),
         url(r'^targets$', 'model_explorer',  {'model_name':'target'}, name='targets'),
+        url(r'^target_image_file$', 'model_explorer',  {'model_name':'target_image_file'}, name='target_image_file'),
         url(r'^tasks$', 'model_explorer', {'model_name':'task'}, name='task'),
         url(r'^task_dependencies$', 'model_explorer',  {'model_name':'task_dependency'}, name='task_dependencies'),
         url(r'^packages$', 'model_explorer',  {'model_name':'package'}, name='package'),
diff --git a/lib/toaster/bldviewer/views.py b/lib/toaster/bldviewer/views.py
index 435bc8e..6f86379 100644
--- a/lib/toaster/bldviewer/views.py
+++ b/lib/toaster/bldviewer/views.py
@@ -25,7 +25,7 @@ from django.db.models import Q
 from django.shortcuts import render
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable, Target_Installed_Package
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
-from orm.models import Target_Installed_Package, VariableHistory
+from orm.models import Target_Installed_Package, VariableHistory, Target_Image_File
 from django.views.decorators.cache import cache_control
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 
@@ -159,6 +159,7 @@ def model_explorer(request, model_name):
     model_mapping = {
         'build': Build,
         'target': Target,
+        'target_image_file': Target_Image_File,
         'task': Task,
         'task_dependency': Task_Dependency,
         'package': Package,
-- 
1.8.3.2


