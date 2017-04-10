Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A5B1F77DA2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 05:16:53 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v3A5GsXd027897
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 9 Apr 2017 22:16:54 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.216.91) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Sun, 9 Apr 2017 22:16:53 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 9 Apr 2017 22:07:21 -0700
Message-ID: <07c4805b646e9c2ff9d9f75febdabcf1c4c3a485.1491800468.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1491800468.git.David.Reyna@windriver.com>
References: <cover.1491800468.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.216.91]
Subject: [PATCH 1/1] toaster: fix SDK artifact capture
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
X-List-Received-Date: Mon, 10 Apr 2017 05:16:53 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Use the TaskArtifacts event to scan the SDK and ESDK manifests
to cleanly collect the respective artifact files.

The previous method was broken when the SDK file deployment moved
from the do_populate_sdk[_ext] tasks to their sstate tasks. That
method is disabled (but not yet removed) in preparation for the
rest of refactor work for the parent #10283 work.

[YOCTO #10850]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 30 ++++++++++++++++++++++++++++++
 bitbake/lib/bb/ui/toasterui.py       |  4 +---
 meta/classes/toaster.bbclass         | 21 ++++++++++++++++-----
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 92d1a1c..46be5a5 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -1663,6 +1663,36 @@ class BuildInfoHelper(object):
                 break
         return endswith
 
+    def scan_task_artifacts(self, event):
+        """
+        The 'TaskArtifacts' event passes the manifest file content for the
+        tasks 'do_deploy', 'do_image_complete', 'do_populate_sdk', and
+        'do_populate_sdk_ext'. The first two will be implemented later.
+        """
+        task_vars = BuildInfoHelper._get_data_from_event(event)
+        task_name = task_vars['task'][task_vars['task'].find(':')+1:]
+        task_artifacts = task_vars['artifacts']
+
+        if task_name in ['do_populate_sdk', 'do_populate_sdk_ext']:
+            targets = [target for target in self.internal_state['targets'] \
+                if target.task == task_name[3:]]
+            if not targets:
+                logger.warning("scan_task_artifacts: SDK targets not found: %s\n", task_name)
+                return
+            for artifact_path in task_artifacts:
+                if not os.path.isfile(artifact_path):
+                    logger.warning("scan_task_artifacts: artifact file not found: %s\n", artifact_path)
+                    continue
+                for target in targets:
+                    # don't record the file if it's already been added
+                    # to this target
+                    matching_files = TargetSDKFile.objects.filter(
+                        target=target, file_name=artifact_path)
+                    if matching_files.count() == 0:
+                        artifact_size = os.stat(artifact_path).st_size
+                        self.orm_wrapper.save_target_sdk_file(
+                            target, artifact_path, artifact_size)
+
     def _get_image_files(self, deploy_dir_image, image_name, image_file_extensions):
         """
         Find files in deploy_dir_image whose basename starts with the
diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index 1729902..71f04fa 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -438,9 +438,7 @@ def main(server, eventHandler, params):
                 elif event.type == "SetBRBE":
                     buildinfohelper.brbe = buildinfohelper._get_data_from_event(event)
                 elif event.type == "TaskArtifacts":
-                    # not implemented yet
-                    # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=10283 for details
-                    pass
+                    buildinfohelper.scan_task_artifacts(event)
                 elif event.type == "OSErrorException":
                     logger.error(event)
                 else:
diff --git a/meta/classes/toaster.bbclass b/meta/classes/toaster.bbclass
index 4de380b..296e476 100644
--- a/meta/classes/toaster.bbclass
+++ b/meta/classes/toaster.bbclass
@@ -328,8 +328,18 @@ python toaster_artifacts() {
     if e.taskname in ["do_deploy", "do_image_complete", "do_populate_sdk", "do_populate_sdk_ext"]:
         d2 = d.createCopy()
         d2.setVar('FILE', e.taskfile)
-        d2.setVar('SSTATE_MANMACH', d2.expand("${MACHINE}"))
+        # Use 'stamp-extra-info' if present, else use workaround
+        # to determine 'SSTATE_MANMACH'
+        extrainf = d2.getVarFlag(e.taskname, 'stamp-extra-info')
+        if extrainf:
+            d2.setVar('SSTATE_MANMACH', extrainf)
+        else:
+            if "do_populate_sdk" == e.taskname:
+                d2.setVar('SSTATE_MANMACH', d2.expand("${MACHINE}${SDKMACHINE}"))
+            else:
+                d2.setVar('SSTATE_MANMACH', d2.expand("${MACHINE}"))
         manifest = oe.sstatesig.sstate_get_manifest_filename(e.taskname[3:], d2)[0]
+
         if os.access(manifest, os.R_OK):
             with open(manifest) as fmanifest:
                 artifacts = [fname.strip() for fname in fmanifest]
@@ -356,8 +366,9 @@ do_packagedata_setscene[vardepsexclude] += "toaster_package_dumpdata "
 do_package[postfuncs] += "toaster_package_dumpdata "
 do_package[vardepsexclude] += "toaster_package_dumpdata "
 
-do_populate_sdk[postfuncs] += "toaster_artifact_dumpdata "
-do_populate_sdk[vardepsexclude] += "toaster_artifact_dumpdata "
+#do_populate_sdk[postfuncs] += "toaster_artifact_dumpdata "
+#do_populate_sdk[vardepsexclude] += "toaster_artifact_dumpdata "
+
+#do_populate_sdk_ext[postfuncs] += "toaster_artifact_dumpdata "
+#do_populate_sdk_ext[vardepsexclude] += "toaster_artifact_dumpdata "
 
-do_populate_sdk_ext[postfuncs] += "toaster_artifact_dumpdata "
-do_populate_sdk_ext[vardepsexclude] += "toaster_artifact_dumpdata "
-- 
1.9.1


