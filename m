Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 64731723AA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:14 +0000 (UTC)
Received: by mail-wg0-f43.google.com with SMTP id l18so7041959wgh.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HdbHTM0ohBcko+8IniiIu7D/oFwL9t23os3wCFJTt9U=;
	b=KPfcYsek/ZAm0MT+9HCeIq2wnvGwvzht8ZK+eTbg2QUFUU5eQXo6k0oZVaRuxcRVXd
	GKr8AqaUhQozIkedjmmv0CWf5Edd09pXwRmqBYjHmi/83/H1DRw4E/APRvi4Z+y4jADp
	dwA1wm4vhqgLyJrP1uNRxkLhqKWfgqYOaFjJlWvZQem5Y2EytaAeUxHDHiNE/Mb84czI
	btyYwPF/lBM9s24f41RJ/nzGfQ2AHgADLfyzCkz4+Ol8iw+nsL+nuCgnG9K+hajfyfqX
	xezBXPl2iXl7TrexEJJFpDWJnZ1ZFF661l0DdGONPtQCVibjqXPcXhl5uHFEAepoDydn
	XN6w==
X-Gm-Message-State: ALoCoQl/7Pz99ZFCCrnw/CuQ7w8p7vk+Q3/Jh6AU5MdYrt/7lT4UY/6bQoCJ6yxQsMqLAWBPfe4K
X-Received: by 10.194.103.232 with SMTP id fz8mr61529481wjb.110.1417108094494; 
	Thu, 27 Nov 2014 09:08:14 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id h14sm12421159wic.8.2014.11.27.09.08.10
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:11 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0F1765641E5; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:08:03 +0000
Message-Id: <8d75e28e0688a6520311afce36543175f36910b3.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 12/14] toasterui: Compatibility patch for daisy and dizzy
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings in changes that allow a toasterUI coming in
from 'master' branch to record data from a 'daisy' or 'dizzy'
bitbake server.

This is needed to allow Toaster to record builds running
on older branch releases.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 43 ++++++++++++++++++++++++++-----------------
 lib/bb/ui/toasterui.py       |  3 +--
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index e428e4c..9aa8fe3 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -695,10 +695,19 @@ class BuildInfoHelper(object):
 
     ################################
     ## external available methods to store information
+    @staticmethod
+    def _get_data_from_event(event):
+        evdata = None
+        if '_localdata' in vars(event):
+            evdata = event._localdata
+        elif 'data' in vars(event):
+            evdata = event.data
+        else:
+            raise Exception("Event with neither _localdata or data properties")
+        return evdata
 
     def store_layer_info(self, event):
-        assert '_localdata' in vars(event)
-        layerinfos = event._localdata
+        layerinfos = BuildInfoHelper._get_data_from_event(event)
         self.internal_state['lvs'] = {}
         for layer in layerinfos:
             self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)] = layerinfos[layer]['version']
@@ -732,15 +741,16 @@ class BuildInfoHelper(object):
         return self.brbe
 
 
-
     def update_target_image_file(self, event):
         image_fstypes = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
+        evdata = BuildInfoHelper._get_data_from_event(event)
+
         for t in self.internal_state['targets']:
             if t.is_image == True:
-                output_files = list(event._localdata.viewkeys())
+                output_files = list(evdata.viewkeys())
                 for output in output_files:
                     if t.target in output and output.split('.rootfs.')[1] in image_fstypes:
-                        self.orm_wrapper.save_target_image_file_information(t, output, event._localdata[output])
+                        self.orm_wrapper.save_target_image_file_information(t, output, evdata[output])
 
     def update_build_information(self, event, errors, warnings, taskfailures):
         if 'build' in self.internal_state:
@@ -748,8 +758,8 @@ class BuildInfoHelper(object):
 
 
     def store_license_manifest_path(self, event):
-        deploy_dir = event._localdata['deploy_dir']
-        image_name =  event._localdata['image_name']
+        deploy_dir = BuildInfoHelper._get_data_from_event(event)['deploy_dir']
+        image_name = BuildInfoHelper._get_data_from_event(event)['image_name']
         path = deploy_dir + "/licenses/" + image_name + "/"
         for target in self.internal_state['targets']:
             if target.target in image_name:
@@ -797,7 +807,7 @@ class BuildInfoHelper(object):
 
 
     def store_tasks_stats(self, event):
-        for (taskfile, taskname, taskstats, recipename) in event._localdata:
+        for (taskfile, taskname, taskstats, recipename) in BuildInfoHelper._get_data_from_event(event):
             localfilepath = taskfile.split(":")[-1]
             assert localfilepath.startswith("/")
 
@@ -812,7 +822,8 @@ class BuildInfoHelper(object):
             task_information['task_name'] = taskname
             task_information['cpu_usage'] = taskstats['cpu_usage']
             task_information['disk_io'] = taskstats['disk_io']
-            task_information['elapsed_time'] = taskstats['elapsed_time']
+            if 'elapsed_time' in taskstats:
+                task_information['elapsed_time'] = taskstats['elapsed_time']
             task_obj = self.orm_wrapper.get_update_task_object(task_information, True)  # must exist
 
     def update_and_store_task(self, event):
@@ -870,7 +881,7 @@ class BuildInfoHelper(object):
 
 
     def store_missed_state_tasks(self, event):
-        for (fn, taskname, taskhash, sstatefile) in event._localdata['missed']:
+        for (fn, taskname, taskhash, sstatefile) in BuildInfoHelper._get_data_from_event(event)['missed']:
 
             identifier = fn + taskname + "_setscene"
             recipe_information = self._get_recipe_information_from_taskfile(fn)
@@ -888,7 +899,7 @@ class BuildInfoHelper(object):
 
             self.orm_wrapper.get_update_task_object(task_information)
 
-        for (fn, taskname, taskhash, sstatefile) in event._localdata['found']:
+        for (fn, taskname, taskhash, sstatefile) in BuildInfoHelper._get_data_from_event(event)['found']:
 
             identifier = fn + taskname + "_setscene"
             recipe_information = self._get_recipe_information_from_taskfile(fn)
@@ -904,15 +915,14 @@ class BuildInfoHelper(object):
 
 
     def store_target_package_data(self, event):
-        assert '_localdata' in vars(event)
         # for all image targets
         for target in self.internal_state['targets']:
             if target.is_image:
                 try:
-                    pkgdata = event._localdata['pkgdata']
-                    imgdata = event._localdata['imgdata'][target.target]
+                    pkgdata = BuildInfoHelper._get_data_from_event(event)['pkgdata']
+                    imgdata = BuildInfoHelper._get_data_from_event(event)['imgdata'][target.target]
                     self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata, pkgdata, self.internal_state['recipes'])
-                    filedata = event._localdata['filedata'][target.target]
+                    filedata = BuildInfoHelper._get_data_from_event(event)['filedata'][target.target]
                     self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
                 except KeyError:
                     # we must have not got the data for this image, nothing to save
@@ -1026,8 +1036,7 @@ class BuildInfoHelper(object):
 
 
     def store_build_package_information(self, event):
-        assert '_localdata' in vars(event)
-        package_info = event._localdata
+        package_info = BuildInfoHelper._get_data_from_event(event)
         self.orm_wrapper.save_build_package_information(self.internal_state['build'],
                             package_info,
                             self.internal_state['recipes'],
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 9bd04df..3a6104b 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -296,10 +296,9 @@ def main(server, eventHandler, params ):
             pass
         except Exception as e:
             # print errors to log
-            logger.error(e)
             import traceback
             exception_data = traceback.format_exc()
-            print(exception_data)
+            logger.error("%s\n%s" % (e, exception_data))
 
             # save them to database, if possible; if it fails, we already logged to console.
             try:
-- 
1.9.1


