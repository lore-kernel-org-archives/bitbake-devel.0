Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6904EC5DF6D
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 13:47:39 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9196.1786801649527771685
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Aug 2026 06:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=IwSyQLpN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-202608151347263f03302b9b00020758-waksgz@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202608151347263f03302b9b00020758
        for <bitbake-devel@lists.openembedded.org>;
        Sat, 15 Aug 2026 15:47:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EJa+rFJHd+b8IRBuxWlquBJ1y7PKeOSmUlQyuNmQofs=;
 b=IwSyQLpNjiHLmjzGdFcTbCtklEizkLap/R30AyZUj0uPiF+32jfKmUxQyB2cMP8/RQq0ti
 xh7jZN4sYOUXkGMZUaE2BW4KUoaCOWH0jTppcUKZ/JfbQULgvGqiiy/j9TPkkt8rQMQ1R0wU
 pfPdweudez+jMdCqsy2MpDxo7uGxBsrqETfjG6plTQE59gxS/BcZ1W7Ct+HOLGUKz5Ja/kCu
 6ZrW/fys3Br8cA7fVcYK/3tpJoUBrGTvXqduOP1QmnaJvjYxtIi3Pe8hQ6YRtFK25q/UWbAt
 jDbADFALeeQgT3AiHZpAG7rHZjPXI4HpI2jwixuVkRGob5pBxvNeL+DA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 5/7] tinfoil: add a prepared task runner
Date: Sat, 15 Aug 2026 15:46:56 +0200
Message-ID: <20260815134722.497586-6-adrian.freihofer@siemens.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19950

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add run_prepared_task() to execute a single recipe task, and nothing
else. No dependencies are resolved and no other task of the recipe is
run, so everything the task consumes must already be in place. It uses
BitBake's normal worker path, retaining the standard dispatch for shell
and Python task bodies as well as fakeroot setup.

devtool ide-sdk needs to rerun an already prepared BitBake task after a
developer changes its source. A normal target build would create a
runqueue and resolve dependencies again, and even "bitbake -b" would
re-run the task's intra-recipe predecessors. That is wrong for this
workflow: the developer intentionally wants to rerun only the prepared
task against content the IDE has just produced. Expose the single-task
worker path so devtool can reuse it instead of maintaining a separate
task executor and pseudo-session setup.

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tinfoil.py | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 634d7796f..42385c879 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -826,20 +826,39 @@ class Tinfoil:
             else:
                 return None
 
-    def build_file(self, buildfile, task, internal=True):
+    def build_file(self, buildfile, task, internal=True, taskonly=False):
         """
         Runs the specified task for just a single recipe (i.e. no dependencies).
         This is equivalent to bitbake -b, except with the default internal=True
         no warning about dependencies will be produced, normal info messages
         from the runqueue will be silenced and BuildInit, BuildStarted and
         BuildCompleted events will not be fired.
+        With taskonly=True the recipe's own task ordering is dropped as well, so
+        only the requested task runs.
         """
-        return self.run_command('buildFile', buildfile, task, internal)
+        return self.run_command('buildFile', buildfile, task, internal, taskonly)
 
     @wait_for
     def build_file_sync(self, *args):
         self.build_file(*args)
 
+    def run_prepared_task(self, recipe, task):
+        """Run *task* for one parsed recipe, and nothing else.
+
+        No dependencies are resolved and no other task of the recipe is run,
+        so everything the task consumes must already be in place. The task
+        runs through the normal BitBake worker path, including fakeroot setup
+        and dispatch of shell or Python task bodies.
+
+        The task is forced to execute rather than being skipped as up to date.
+        Returns False if the task failed.
+        """
+        self.run_command('setConfig', 'force', True)
+        try:
+            return self.build_file_sync(self.get_recipe_file(recipe), task, True, True)
+        finally:
+            self.run_command('setConfig', 'force', False)
+
     def build_targets(self, targets, task=None, handle_events=True, extra_events=None, event_callback=None):
         """
         Builds the specified targets. This is equivalent to a normal invocation
-- 
2.55.0


