Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id 1EBE47061F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 12:15:07 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id q58so4607589wes.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 05:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=z+2OxFwikzDLrfHiahVuqY9CLcNVDN3hnuGZjOa+JQ4=;
	b=XQAJjIi9L9JlH3m/vWXD6OzDSgUBpEV9/pTu4tXhebBJwhtlV16nJyhDHSZy9XuM1k
	YeyYBiAfUYa8cIW0QAmsGUaCtpwkFtVZO9B0afT1bM2xFPLioc3emELFz4yuI4lVVOPc
	UlQMFuGHiWEHvLQRub7fC6C9Z5WeKSaV7XO/KPQAU0+ATS7asgksOEEaB+ec5sym3oix
	MDgaY4e/Oh+1yutc9SKzOph4v1U+qpNWmxYrANx35ucmQ5ivrdik79+Az0WaGp20yLnV
	kxGs/3XHNPTG+W2N2oIi1R26HCzbjwMbARqz+4fkEaYUgaid+ul3xBtTPj+FKaYSh1ht
	pMTg==
X-Gm-Message-State: ALoCoQm+64UyOEFYM6fR/1IjT4B6j09nZI1Z64oUjoRoEjm3tkjuwr5awnR3x9QhhLLmFt84s13y
X-Received: by 10.180.74.142 with SMTP id t14mr6894115wiv.71.1405685706938;
	Fri, 18 Jul 2014 05:15:06 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id l2sm13810404wjw.31.2014.07.18.05.15.04
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 18 Jul 2014 05:15:05 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id DC382560429; Fri, 18 Jul 2014 13:15:02 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 18 Jul 2014 13:15:02 +0100
Message-Id: <80305c320af2e118915c561bd3f26e99c306fbea.1405685308.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
References: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1405685308.git.alexandru.damian@intel.com>
References: <cover.1405685308.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 8/8] toasterui: fixing event.data clash
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
X-List-Received-Date: Fri, 18 Jul 2014 12:15:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes a name collision on the event.data
in the MetadataEvent class. event.data is used in the
event system as a copy of "d" in certain situations,
and this collision triggered a bug leading to data loss.

[YOCTO #6332]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/event.py              |  2 +-
 lib/bb/ui/buildinfohelper.py | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 8b47ae5..e2f6b9c 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -594,7 +594,7 @@ class MetadataEvent(Event):
     def __init__(self, eventtype, eventdata):
         Event.__init__(self)
         self.type = eventtype
-        self.data = eventdata
+        self._localdata = eventdata
 
 class SanityCheck(Event):
     """
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 29cfc81..f64423b 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -596,8 +596,8 @@ class BuildInfoHelper(object):
     ## external available methods to store information
 
     def store_layer_info(self, event):
-        assert 'data' in vars(event)
-        layerinfos = event.data
+        assert '_localdata' in vars(event)
+        layerinfos = event._localdata
         self.internal_state['lvs'] = {}
         for layer in layerinfos:
             self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer])] = layerinfos[layer]['version']
@@ -636,10 +636,10 @@ class BuildInfoHelper(object):
         image_fstypes = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
         for t in self.internal_state['targets']:
             if t.is_image == True:
-                output_files = list(event.data.viewkeys())
+                output_files = list(event._localdata.viewkeys())
                 for output in output_files:
                     if t.target in output and output.split('.rootfs.')[1] in image_fstypes:
-                        self.orm_wrapper.save_target_image_file_information(t, output, event.data[output])
+                        self.orm_wrapper.save_target_image_file_information(t, output, event._localdata[output])
 
     def update_build_information(self, event, errors, warnings, taskfailures):
         if 'build' in self.internal_state:
@@ -647,8 +647,8 @@ class BuildInfoHelper(object):
 
 
     def store_license_manifest_path(self, event):
-        deploy_dir = event.data['deploy_dir']
-        image_name =  event.data['image_name']
+        deploy_dir = event._localdata['deploy_dir']
+        image_name =  event._localdata['image_name']
         path = deploy_dir + "/licenses/" + image_name + "/"
         for target in self.internal_state['targets']:
             if target.target in image_name:
@@ -696,7 +696,7 @@ class BuildInfoHelper(object):
 
 
     def store_tasks_stats(self, event):
-        for (taskfile, taskname, taskstats, recipename) in event.data:
+        for (taskfile, taskname, taskstats, recipename) in event._localdata:
             localfilepath = taskfile.split(":")[-1]
             assert localfilepath.startswith("/")
 
@@ -768,7 +768,7 @@ class BuildInfoHelper(object):
 
 
     def store_missed_state_tasks(self, event):
-        for (fn, taskname, taskhash, sstatefile) in event.data['missed']:
+        for (fn, taskname, taskhash, sstatefile) in event._localdata['missed']:
 
             identifier = fn + taskname + "_setscene"
             recipe_information = self._get_recipe_information_from_taskfile(fn)
@@ -787,7 +787,7 @@ class BuildInfoHelper(object):
 
             self.orm_wrapper.get_update_task_object(task_information)
 
-        for (fn, taskname, taskhash, sstatefile) in event.data['found']:
+        for (fn, taskname, taskhash, sstatefile) in event._localdata['found']:
 
             identifier = fn + taskname + "_setscene"
             recipe_information = self._get_recipe_information_from_taskfile(fn)
@@ -804,15 +804,15 @@ class BuildInfoHelper(object):
 
 
     def store_target_package_data(self, event):
-        assert 'data' in vars(event)
+        assert '_localdata' in vars(event)
         # for all image targets
         for target in self.internal_state['targets']:
             if target.is_image:
                 try:
-                    pkgdata = event.data['pkgdata']
-                    imgdata = event.data['imgdata'][target.target]
+                    pkgdata = event._localdata['pkgdata']
+                    imgdata = event._localdata['imgdata'][target.target]
                     self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata, pkgdata, self.internal_state['recipes'])
-                    filedata = event.data['filedata'][target.target]
+                    filedata = event._localdata['filedata'][target.target]
                     self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
                 except KeyError:
                     # we must have not got the data for this image, nothing to save
@@ -922,8 +922,8 @@ class BuildInfoHelper(object):
 
 
     def store_build_package_information(self, event):
-        assert 'data' in vars(event)
-        package_info = event.data
+        assert '_localdata' in vars(event)
+        package_info = event._localdata
         self.orm_wrapper.save_build_package_information(self.internal_state['build'],
                             package_info,
                             self.internal_state['recipes'],
-- 
1.9.1


