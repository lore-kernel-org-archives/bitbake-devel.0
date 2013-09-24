Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 006C16CB78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:13 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Sep 2013 09:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511917"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:14 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 6E3B4562D44; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:53:00 +0100
Message-Id: <7f44eff47ff6a513133a83c80a02fd439c7c3b39.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 91/94] bitbake: webhob: collect recipe licensing info
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Collecting licensing info from log data.
The logs are generated in insane.bbclass.

Modified Simple interface to display licensing file.

[YOCTO #5194]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py               | 7 +++++++
 bitbake/lib/bb/ui/dsi.py                           | 2 +-
 bitbake/lib/webhob/bldviewer/templates/recipe.html | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index c8820a5..a3a50a3 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -654,6 +654,13 @@ class BuildInfoHelper(object):
         self.orm_wrapper.create_logmessage(log_information)
 
     def store_log_event(self, event):
+        # look up license files info from insane.bbclass
+        m = re.match("([^:]*): md5 checksum matched for ([^;]*)", event.msg)
+        if m:
+            (pn, fn) = m.groups()
+            self.internal_state['recipes'][pn].licensing_info = fn
+            self.internal_state['recipes'][pn].save()
+
         if event.levelno < format.WARNING:
             return
         if not 'build' in self.internal_state:
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 22cff5d..434a6dd 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -322,6 +322,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, logging.LogRecord):
+                buildinfohelper.store_log_event(event)
                 if event.levelno >= format.ERROR:
                     errors = errors + 1
                     return_value = 1
@@ -333,7 +334,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 if event.taskpid != 0 and event.levelno <= format.NOTE:
                     continue
 
-                buildinfohelper.store_log_event(event)
                 logger.handle(event)
                 continue
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
index ec8a46d..a624370 100644
--- a/bitbake/lib/webhob/bldviewer/templates/recipe.html
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -18,6 +18,7 @@
             <th>Description</th>
             <th>Section</th>
             <th>License</th>
+            <th>License file</th>
             <th>Homepage</th>
             <th>Bugtracker</th>
             <th>Author</th>
@@ -34,6 +35,7 @@
             <td>{{recipe.description}}</td>
             <td>{{recipe.section}}</td>
             <td>{{recipe.license}}</td>
+            <td>{{recipe.licensing_info}}</td>
             <td>{{recipe.homepage}}</td>
             <td>{{recipe.bugtracker}}</td>
             <td>{{recipe.author}}</td>
-- 
1.8.1.2


