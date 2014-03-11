Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 0CC1F6F7B2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 15:49:54 +0000 (UTC)
Received: by mail-wi0-f176.google.com with SMTP id hr14so1097242wib.15
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=DOyig6k1YTnmrFYl74pywKYwe5yVMIXL+VzJfLK++GM=;
	b=Owtwjb4iESpgkNKQesbXGW5W1Zwagw7fCbrAv3skOGYxIbosvgewjq1Lv/iYMhWxiP
	L3loRZUrMTmWtWFYcx82sf3UMP+VVmKTaprgaEtpTkzkZx/C7znywl1uCz4CxrdaIfYG
	gTGkXdH2tVVrifFIjtllt7Urz2venWP+TghZ6EM6EB6GjLLFhClrVqZi2OxQ8vRXh570
	P4rjPT1xIMeb8/5QPFehOgH8OBWemsmrxscxHtbIZdhYZc2C+t72YVaX+SIror3er6UZ
	XJknJE29FaWFScudXZKXGLZukGAOdSkVPzCsVM5+m2YHVZP6JGErEl0AuWrbMizCVoA0
	9wUQ==
X-Gm-Message-State: ALoCoQmljacZMQfX+qBBFY4rt4xw02L5XynAZk4lb/hAARbXjZgu4Ts1+7PS00UN4R1P1UoT15Vg
X-Received: by 10.194.6.8 with SMTP id w8mr37954447wjw.16.1394552995083;
	Tue, 11 Mar 2014 08:49:55 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id r1sm7630062wia.5.2014.03.11.08.49.52
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 11 Mar 2014 08:49:53 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 31A625605C6; Tue, 11 Mar 2014 15:49:54 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 15:49:46 +0000
Message-Id: <f3a69ef7cc536a4b879d60936199a1002584c4f4.1394552757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
References: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394552757.git.alexandru.damian@intel.com>
References: <cover.1394552757.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/8] toaster: write files-in-image to the database
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
X-List-Received-Date: Tue, 11 Mar 2014 15:49:57 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding code to write files-in-image data from the metadata
event to the database.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 115 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index d7b526a..f9b067f 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -27,7 +27,7 @@ os.environ.setdefault("DJANGO_SETTINGS_MODULE", "toaster.toastermain.settings")
 import toaster.toastermain.settings as toaster_django_settings
 from toaster.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
 from toaster.orm.models import Variable, VariableHistory
-from toaster.orm.models import Package, Package_File, Target_Installed_Package
+from toaster.orm.models import Package, Package_File, Target_Installed_Package, Target_File
 from toaster.orm.models import Task_Dependency, Package_Dependency
 from toaster.orm.models import Recipe_Dependency
 from bb.msg import BBLogFormatter as format
@@ -181,6 +181,113 @@ class ORMWrapper(object):
 
         return layer_object
 
+    def save_target_file_information(self, build_obj, target_obj, filedata):
+        assert isinstance(build_obj, Build)
+        assert isinstance(target_obj, Target)
+        dirs = filedata['dirs']
+        files = filedata['files']
+        syms = filedata['syms']
+
+        # we insert directories, ordered by name depth
+        for d in sorted(dirs, key=lambda x:len(x[-1].split("/"))):
+            (user, group, size) = d[1:4]
+            permission = d[0][1:]
+            path = d[4].lstrip(".")
+            if len(path) == 0:
+                # we create the root directory as a special case
+                path = "/"
+                tf_obj = Target_File.objects.create(
+                        target = target_obj,
+                        path = path,
+                        size = size,
+                        inodetype = Target_File.ITYPE_DIRECTORY,
+                        permission = permission,
+                        owner = user,
+                        group = group,
+                        )
+                tf_obj.directory = tf_obj
+                tf_obj.save()
+                continue
+            parent_path = "/".join(path.split("/")[:len(path.split("/")) - 1])
+            if len(parent_path) == 0:
+                parent_path = "/"
+            parent_obj = Target_File.objects.get(target = target_obj, path = parent_path, inodetype = Target_File.ITYPE_DIRECTORY)
+            tf_obj = Target_File.objects.create(
+                        target = target_obj,
+                        path = path,
+                        size = size,
+                        inodetype = Target_File.ITYPE_DIRECTORY,
+                        permission = permission,
+                        owner = user,
+                        group = group,
+                        directory = parent_obj)
+
+
+        # we insert files
+        for d in files:
+            (user, group, size) = d[1:4]
+            permission = d[0][1:]
+            path = d[4].lstrip(".")
+            parent_path = "/".join(path.split("/")[:len(path.split("/")) - 1])
+            inodetype = Target_File.ITYPE_REGULAR
+            if permission.startswith('b'):
+                inodetype = Target_File.ITYPE_BLOCK
+            if permission.startswith('c'):
+                inodetype = Target_File.ITYPE_CHARACTER
+            if permission.startswith('p'):
+                inodetype = Target_File.ITYPE_FIFO
+
+            tf_obj = Target_File.objects.create(
+                        target = target_obj,
+                        path = path,
+                        size = size,
+                        inodetype = inodetype,
+                        permission = permission,
+                        owner = user,
+                        group = group)
+            parent_obj = Target_File.objects.get(target = target_obj, path = parent_path, inodetype = Target_File.ITYPE_DIRECTORY)
+            tf_obj.directory = parent_obj
+            tf_obj.save()
+
+        # we insert symlinks
+        for d in syms:
+            (user, group, size) = d[1:4]
+            permission = d[0][1:]
+            path = d[4].lstrip(".")
+            filetarget_path = d[6]
+
+            parent_path = "/".join(path.split("/")[:len(path.split("/")) - 1])
+            if not filetarget_path.startswith("/"):
+                # we have a relative path, get a normalized absolute one
+                filetarget_path = parent_path + "/" + filetarget_path
+                fcp = filetarget_path.split("/")
+                fcpl = []
+                for i in fcp:
+                    if i == "..":
+                        fcpl.pop()
+                    else:
+                        fcpl.append(i)
+                filetarget_path = "/".join(fcpl)
+
+            try:
+                filetarget_obj = Target_File.objects.get(target = target_obj, path = filetarget_path)
+            except Exception as e:
+                # we might have an invalid link; no way to detect this. just set it to None
+                filetarget_obj = None
+
+            parent_obj = Target_File.objects.get(target = target_obj, path = parent_path, inodetype = Target_File.ITYPE_DIRECTORY)
+
+            tf_obj = Target_File.objects.create(
+                        target = target_obj,
+                        path = path,
+                        size = size,
+                        inodetype = Target_File.ITYPE_REGULAR,
+                        permission = permission,
+                        owner = user,
+                        group = group,
+                        directory = parent_obj,
+                        sym_target = filetarget_obj)
+
 
     def save_target_package_information(self, build_obj, target_obj, packagedict, pkgpnmap, recipes):
         assert isinstance(build_obj, Build)
@@ -613,6 +720,10 @@ class BuildInfoHelper(object):
                 pkgdata = event.data['pkgdata']
                 imgdata = event.data['imgdata'][target.target]
                 self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata, pkgdata, self.internal_state['recipes'])
+                filedata = event.data['filedata'][target.target]
+                self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
+
+
 
     def store_dependency_information(self, event):
         assert '_depgraph' in vars(event)
@@ -692,7 +803,7 @@ class BuildInfoHelper(object):
             task_info['task_name'] = taskname
             task_obj = self.orm_wrapper.get_update_task_object(task_info)
             return task_obj
- 
+
         # create tasks
         tasks = {}
         for taskdesc in event._depgraph['tdepends']:
-- 
1.8.3.2


