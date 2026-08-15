Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752DEC5DF6A
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 13:47:39 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9197.1786801649527839236
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Aug 2026 06:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=MJ4AuCW2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1329275-20260815134726018326367c000207a1-5ncxqi@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260815134726018326367c000207a1
        for <bitbake-devel@lists.openembedded.org>;
        Sat, 15 Aug 2026 15:47:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OEv6tFJRl4U/kYGr7+7L3KMeFAhUjQDCluBqS8sTTU0=;
 b=MJ4AuCW2UpB41nZXU6DXhIZkwzNogafHlfGcma1sg8bMne6rotBfGbPiXmM4/zHYCjoacv
 OXztL5YR/VbXLAZR9vwPW9adtZV1E15wcQANd7/9eeNJNa15bvNajsA7AL3Qn8JiJY/CBnnV
 LycdChJtXZcIPcR/5a1hEZcOD9ZXFbjsWs/it/oRkAl658vARdwCF51NNV1iNahxBsagUdFj
 XeShj/vshSXoCLVGfBOaGI4Dn1Ku6B+8Z1MZlZpUamKsobzji4ZRFxgvgkeleuHLFj5Zz6Sb
 wi/6SJgnXdV3V+oEQ5+lwcqJVwYKvmdOCfUEpJRfRhb7v2QkymJBfVPQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 4/7] cooker: add a buildFile mode that runs a single task
Date: Sat, 15 Aug 2026 15:46:55 +0200
Message-ID: <20260815134722.497586-5-adrian.freihofer@siemens.com>
In-Reply-To: <20260815134722.497586-1-adrian.freihofer@siemens.com>
References: <20260815134722.497586-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Aug 2026 13:47:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19955

From: Adrian Freihofer <adrian.freihofer@siemens.com>

devtool ide-sdk lets the IDE build directly (e.g. via cmake or meson,
outside of bitbake). do_install still needs bitbake: it needs pseudo,
and it usually does more than the underlying build tool's own install
step (e.g. `cmake --build --target install`) would - packaging-related
fixups the recipe or its classes add on top. It must run as only that
one already-prepared task against the source the developer just edited
- not the whole recipe: predecessors, if they ran again, would
rebuild/overwrite the very output the caller is about to inspect or has
already staged.

Add a taskonly argument to buildFileInternal(), plumbed through the
buildFile command, that also clears the intra-recipe task parents,
leaving the requested task as the runqueue's only entry. Default
unchanged, so "bitbake -b" behaviour is unaffected.

Note that for example:
- buildFileInternal() cannot do this: it drops external dependencies but
  keeps intra-recipe task ordering ('addtask X after Y'), so requesting
  do_install on an unbuilt recipe still pulls in do_fetch, do_unpack,
  do_patch, do_prepare_recipe_sysroot, do_configure and do_compile.
  That's the right default for "bitbake -b", but not here.
- --runonly can't express this either: mark_active() ignores its depth
  argument and recurses over depends, so the whole chain stays active
  regardless.

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/command.py | 6 +++++-
 lib/bb/cooker.py  | 8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index b57c5d4a3..1b16884fa 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -622,9 +622,13 @@ class CommandsAsync:
             internal = params[2]
         else:
             internal = False
+        if len(params) > 3:
+            taskonly = params[3]
+        else:
+            taskonly = False
 
         if internal:
-            command.cooker.buildFileInternal(bfile, task, fireevents=False, quietlog=True)
+            command.cooker.buildFileInternal(bfile, task, fireevents=False, quietlog=True, taskonly=taskonly)
         else:
             command.cooker.buildFile(bfile, task)
     buildFile.needcache = False
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 108551a60..0321478d3 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1368,7 +1368,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
 
         self.buildFileInternal(buildfile, task)
 
-    def buildFileInternal(self, buildfile, task, fireevents=True, quietlog=False):
+    def buildFileInternal(self, buildfile, task, fireevents=True, quietlog=False, taskonly=False):
         """
         Build the file matching regexp buildfile
         """
@@ -1418,6 +1418,12 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
         self.recipecaches[mc].rundeps[fn] = defaultdict(list)
         self.recipecaches[mc].runrecs[fn] = defaultdict(list)
 
+        if taskonly:
+            # Drop the intra-recipe task ordering too ('addtask X after Y'), so
+            # that task is the only entry left in the runqueue.
+            task_deps = self.recipecaches[mc].task_deps[fn]
+            task_deps['parents'] = {t: [] for t in task_deps['tasks']}
+
         bb.parse.siggen.setup_datacache(self.recipecaches)
 
         # Invalidate task for target if force mode active
-- 
2.55.0


