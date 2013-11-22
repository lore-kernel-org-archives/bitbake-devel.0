Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D24D66C73C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2013 09:32:03 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 22 Nov 2013 01:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,751,1378882800"; d="scan'208";a="412937841"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
	by orsmga001.jf.intel.com with ESMTP; 22 Nov 2013 01:32:02 -0800
Received: from irsmsx152.ger.corp.intel.com (163.33.192.66) by
	IRSMSX103.ger.corp.intel.com (163.33.3.157) with Microsoft SMTP Server
	(TLS) id 14.3.123.3; Fri, 22 Nov 2013 09:32:01 +0000
Received: from irsmsx105.ger.corp.intel.com ([169.254.7.215]) by
	IRSMSX152.ger.corp.intel.com ([169.254.6.169]) with mapi id
	14.03.0123.003; Fri, 22 Nov 2013 09:32:00 +0000
From: "Voicu, Cristiana" <cristiana.voicu@intel.com>
To: "Popa, Valentin" <valentin.popa@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/1] HOB: Show warnings in Issues tab
Thread-Index: AQHO5rByKf6FDlQRXkGALtRTNvpMxJow/fFQ
Date: Fri, 22 Nov 2013 09:32:01 +0000
Message-ID: <BE68E9C8E0850C43B0F0B0B7D57FA5AE2E8B4697@IRSMSX105.ger.corp.intel.com>
References: <cover.1385034591.git.valentin.popa@intel.com>
	<3766a4d9a15a56261fe139a9b332f9afbae966f0.1385034591.git.valentin.popa@intel.com>
In-Reply-To: <3766a4d9a15a56261fe139a9b332f9afbae966f0.1385034591.git.valentin.popa@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] HOB: Show warnings in Issues tab
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
X-List-Received-Date: Fri, 22 Nov 2013 09:32:03 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Looks good to me.
Cristiana

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Valentin Popa
Sent: Thursday, November 21, 2013 1:55 PM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] [PATCH 1/1] HOB: Show warnings in Issues tab

Proper update of warnings view during build.

[YOCTO #3496]

Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/ui/crumbs/runningbuild.py | 48 ++++++++++++++++++++++------=
----
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/c=
rumbs/runningbuild.py
index abd3300..0a48a6b 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -174,6 +174,15 @@ class RunningBuild (gobject.GObject):
                       color,
                       0))
=20
+            # if there are warnings, mark the task with warning
+            # color;
+            # in case there are errors, the updates will be
+            #  handled on TaskFailed.
+            if color =3D=3D HobColors.WARNING:
+                self.model.set(parent, self.model.COL_COLOR, color)
+                if task: #then we have a parent, and update it's color
+                    self.model.set(self.tasks_to_iter[(package, None)],=20
+ self.model.COL_COLOR, color)
+
         elif isinstance(event, bb.build.TaskStarted):
             (package, task) =3D (event._package, event._task)
=20
@@ -201,9 +210,10 @@ class RunningBuild (gobject.GObject):
=20
             # Because this parent package now has an active child mark it =
as
             # such.
-            # @todo if parent is already in error, don't mark it green
-            self.model.set(parent, self.model.COL_ICON, "gtk-execute",
-                           self.model.COL_COLOR, HobColors.RUNNING)
+            self.model.set(parent, self.model.COL_ICON, "gtk-execute")
+            parent_color =3D self.model.get(parent, self.model.COL_COLOR)[=
0]
+            if parent_color !=3D HobColors.ERROR and parent_color !=3D Hob=
Colors.WARNING:
+                self.model.set(parent, self.model.COL_COLOR,=20
+ HobColors.RUNNING)
=20
             # Add an entry in the model for this task
             i =3D self.model.append (parent, (None, @@ -246,20 +256,28 @@ =
class RunningBuild (gobject.GObject):
                     self.model.set(i, self.model.COL_ICON, icon,
                                    self.model.COL_COLOR, color)
             else:
-                icon =3D None
-                color =3D HobColors.OK
+                # Mark the parent package and the task as inactive,
+                # but make sure to preserve error, warnings and active
+                # states
+                parent_color =3D self.model.get(parent, self.model.COL_COL=
OR)[0]
+                task_color =3D self.model.get(current,=20
+ self.model.COL_COLOR)[0]
=20
                 # Mark the task as inactive
-                self.model.set(current, self.model.COL_ICON, icon,
-                               self.model.COL_COLOR, color)
-
-                # Mark the parent package as inactive, but make sure to
-                # preserve error and active states
-                i =3D self.tasks_to_iter[(package, None)]
-                if self.model.get(parent, self.model.COL_ICON) !=3D 'dialo=
g-error':
-                    self.model.set(parent, self.model.COL_ICON, icon)
-                    if num_active =3D=3D 0:
-                        self.model.set(parent, self.model.COL_COLOR, HobCo=
lors.OK)
+                self.model.set(current, self.model.COL_ICON, None)
+                if task_color !=3D HobColors.ERROR:
+                    if task_color =3D=3D HobColors.WARNING:
+                        self.model.set(current, self.model.COL_ICON, 'dial=
og-warning')
+                    else:
+                        self.model.set(current, self.model.COL_COLOR,=20
+ HobColors.OK)
+
+                # Mark the parent as inactive
+                if parent_color !=3D HobColors.ERROR:
+                    if parent_color =3D=3D HobColors.WARNING:
+                        self.model.set(parent, self.model.COL_ICON, "dialo=
g-warning")
+                    else:
+                        self.model.set(parent, self.model.COL_ICON, None)
+                        if num_active =3D=3D 0:
+                            self.model.set(parent,=20
+ self.model.COL_COLOR, HobColors.OK)
=20
             # Clear the iters and the pids since when the task goes away t=
he
             # pid will no longer be used for messages
--
1.8.3.2

_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

