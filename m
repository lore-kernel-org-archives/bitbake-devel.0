Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 58BE260DFA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 18:47:42 +0000 (UTC)
Received: by mail-wg0-f47.google.com with SMTP id x12so11776699wgg.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 11:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=kW2NoO6ZHVIlRaFTZkFgihhF3SFSEqXMkYz4+dBupGQ=;
	b=DX1Gu1PJFJxfJk2vk30kBaozKVfH6cZpK2+8VtuP5nxNF6r+Mdc9Z1AW66tcShk4rY
	iSqxB9JixzyraaANng8BIGQSEvsDVKyj158/tNr9MjVbhMc5M54yYfDOTa6EaGrpoPzy
	u8nw/Mc/qcnpyjFxQIhYwavIN4EDaFIpYeqUP27Yh1HShbubqlCXhbABuXIwlYcFPEvx
	js7PGr77lOrpoQ/SQAFAGVa29dHFEDMx9Aok/JZ6FcitBCH8uLQ90N0ppC3CpbI5q9gm
	B3IdKEu8p0NjGm/aDVkgbwTjzlx/jvOpX9KyMh/0zs611m9WjOdjntf9UpWJJKFOyLDv
	UuLw==
X-Gm-Message-State: ALoCoQnMOqWgzpDpyjb4QSKhADL6NMpEWZMBYPQkm7dflfTFu+8iRz0Gbh394Aa0hrSEI5nC/J4J
X-Received: by 10.180.97.37 with SMTP id dx5mr8627919wib.53.1394650063563;
	Wed, 12 Mar 2014 11:47:43 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ci4sm71849350wjc.21.2014.03.12.11.47.42 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 12 Mar 2014 11:47:42 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id AFBBD5605D0; Wed, 12 Mar 2014 18:47:43 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Mar 2014 18:47:40 +0000
Message-Id: <788d00b60ea1b8f42adbcdc8f6e95f4b75e9dbca.1394649860.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f1ccf1eb81e7ba89b9e540a19c839a3dfdef234b.1394649860.git.alexandru.damian@intel.com>
References: <y>
	<f1ccf1eb81e7ba89b9e540a19c839a3dfdef234b.1394649860.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394649860.git.alexandru.damian@intel.com>
References: <cover.1394649860.git.alexandru.damian@intel.com>
Subject: [PATCH 2/4] toaster: add license manifest path to database
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
X-List-Received-Date: Wed, 12 Mar 2014 18:47:46 -0000

From: Cristiana Voicu <cristiana.voicu@intel.com>

Based on image_name, the target is obtained, and the path
is added to the database.

[YOCTO #5649]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 14 ++++++++++++++
 lib/bb/ui/toasterui.py       |  8 +++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 1b17c1f..8f091e8 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -93,6 +93,10 @@ class ORMWrapper(object):
         build.outcome = outcome
         build.save()
 
+    def update_target_object(self, target, license_manifest_path):
+
+        target.license_manifest_path = license_manifest_path
+        target.save()
 
     def get_update_task_object(self, task_information, must_exist = False):
         assert 'build' in task_information
@@ -616,6 +620,16 @@ class BuildInfoHelper(object):
         if 'build' in self.internal_state:
             self.orm_wrapper.update_build_object(self.internal_state['build'], errors, warnings, taskfailures)
 
+
+    def store_license_manifest_path(self, event):
+        deploy_dir = event.data['deploy_dir_image']
+        image_name =  event.data['image_name']
+        path = deploy_dir + "/licenses/" + image_name + "/"
+        for target in self.internal_state['targets']:
+            if target.target in image_name:
+                self.orm_wrapper.update_target_object(target, path)
+
+
     def store_started_task(self, event):
         assert isinstance(event, (bb.runqueue.sceneQueueTaskStarted, bb.runqueue.runQueueTaskStarted, bb.runqueue.runQueueTaskSkipped))
         assert 'taskfile' in vars(event)
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 04e0f99..b2c084c 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -235,14 +235,16 @@ def main(server, eventHandler, params ):
             if isinstance(event, bb.event.MetadataEvent):
                 if event.type == "SinglePackageInfo":
                     buildinfohelper.store_build_package_information(event)
-                if event.type == "LayerInfo":
+                elif event.type == "LayerInfo":
                     buildinfohelper.store_layer_info(event)
-                if event.type == "BuildStatsList":
+                elif event.type == "BuildStatsList":
                     buildinfohelper.store_tasks_stats(event)
-                if event.type == "ImagePkgList":
+                elif event.type == "ImagePkgList":
                     buildinfohelper.store_target_package_data(event)
                 elif event.type == "ImageFileSize":
                     buildinfohelper.update_target_image_file(event)
+                elif event.type == "LicenseManifestPath":
+                    buildinfohelper.store_license_manifest_path(event)
                 continue
 
             # ignore
-- 
1.8.3.2


