Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B1F1371C7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 16:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDC2N002522; Thu, 19 Jan 2017 16:13:30 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OtHhB82_ghXB; Thu, 19 Jan 2017 16:13:30 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDQCG002779
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Jan 2017 16:13:27 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cUFL4-0000mm-Cc; Thu, 19 Jan 2017 16:13:26 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2017 16:13:22 +0000
Message-Id: <1484842404-2960-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1484842404-2960-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1484842404-2960-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 3/5] event/ast: Add RecipeTaskPreProcess event before task finalisation
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
X-List-Received-Date: Thu, 19 Jan 2017 16:13:31 -0000

There are various pieces of code which need to run after the tasks are
finalised but before bitbake locks in on the task dependencies. This
adds such an event so dependency changes in anonymous python can
be accounted for and acted upon by these specific event handlers.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py     | 11 +++++++++++
 lib/bb/parse/ast.py |  1 +
 2 files changed, 12 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index e2ca33e..6d8493b 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -361,6 +361,17 @@ class RecipeEvent(Event):
 class RecipePreFinalise(RecipeEvent):
     """ Recipe Parsing Complete but not yet finialised"""
 
+class RecipeTaskPreProcess(RecipeEvent):
+    """
+    Recipe Tasks about to be finalised
+    The list of tasks should be final at this point and handlers
+    are only able to change interdependencies
+    """
+    def __init__(self, fn, tasklist):
+        self.fn = fn
+        self.tasklist = tasklist
+        Event.__init__(self)
+
 class RecipeParsed(RecipeEvent):
     """ Recipe Parsing Complete """
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 853dda8..8b5b366 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -358,6 +358,7 @@ def finalize(fn, d, variant = None):
     bb.data.update_data(d)
 
     tasklist = d.getVar('__BBTASKS', False) or []
+    bb.event.fire(bb.event.RecipeTaskPreProcess(fn, list(tasklist)), d)
     bb.build.add_tasks(tasklist, d)
 
     bb.parse.siggen.finalise(fn, d, variant)
-- 
2.7.4


