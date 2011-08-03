Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QoQA0-0006Dv-Rm
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 03:22:13 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 02 Aug 2011 18:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,307,1309762800"; d="scan'208";a="33627959"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by orsmga002.jf.intel.com with ESMTP; 02 Aug 2011 18:17:46 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Aug 2011 18:17:35 -0700
Message-Id: <b16663e1919fddbf63d0ca7f9ad3ffdc7d1121fd.1312334047.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312334047.git.josh@linux.intel.com>
References: <cover.1312334047.git.josh@linux.intel.com>
In-Reply-To: <cover.1312334047.git.josh@linux.intel.com>
References: <cover.1312334047.git.josh@linux.intel.com>
Subject: [PATCH 2/6] bb/ui/crumbs/runningbuild: optionally create list entries sequentially
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 03 Aug 2011 01:22:13 -0000

In b947e7aa405966262c0614cae02e7978ec637095 Bob changed the behaviour of
the RunningBuildModel such that the items are added to the model in a
non-sequential order.

The messages in the view being listed out of order from how they are
received is undesirable for users of the hob UI, therefore this patch adds
an optional sequential parameter to the RunningBuild initialiser which,
when set to True, will always append new messages so that the order shown
in the view is that the messages are received in. The parameter defaults to
to False such that the behaviour added by Bob is preserved.

Partially addresses [YOCTO #1311]

CC: Bob Foerster <robert@erafx.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/runningbuild.py |   37 +++++++++++++++++++++----------------
 1 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index bdab340..c4d6d33 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -63,9 +63,10 @@ class RunningBuild (gobject.GObject):
     pids_to_task = {}
     tasks_to_iter = {}
 
-    def __init__ (self):
+    def __init__ (self, sequential=False):
         gobject.GObject.__init__ (self)
         self.model = RunningBuildModel()
+        self.sequential = sequential
 
     def handle_event (self, event, pbar=None):
         # Handle an event from the event queue, this may result in updating
@@ -105,18 +106,18 @@ class RunningBuild (gobject.GObject):
 
             # if we know which package we belong to, we'll append onto its list.
             # otherwise, we'll jump to the top of the master list
-            if parent:
+            if self.sequential or not parent:
                 tree_add = self.model.append
             else:
                 tree_add = self.model.prepend
             tree_add(parent,
-                              (None,
-                               package,
-                               task,
-                               event.getMessage(),
-                               icon,
-                               color,
-                               0))
+                     (None,
+                      package,
+                      task,
+                      event.getMessage(),
+                      icon,
+                      color,
+                      0))
 
         elif isinstance(event, bb.build.TaskStarted):
             (package, task) = (event._package, event._task)
@@ -130,13 +131,17 @@ class RunningBuild (gobject.GObject):
             if ((package, None) in self.tasks_to_iter):
                 parent = self.tasks_to_iter[(package, None)]
             else:
-                parent = self.model.prepend(None, (None,
-                                                   package,
-                                                   None,
-                                                   "Package: %s" % (package),
-                                                   None,
-                                                   Colors.OK,
-                                                   0))
+                if self.sequential:
+                    add = self.model.append
+                else:
+                    add = self.model.prepend
+                parent = add(None, (None,
+                                    package,
+                                    None,
+                                    "Package: %s" % (package),
+                                    None,
+                                    Colors.OK,
+                                    0))
                 self.tasks_to_iter[(package, None)] = parent
 
             # Because this parent package now has an active child mark it as
-- 
1.7.6



