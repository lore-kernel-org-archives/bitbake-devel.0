Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id 9FAAB65D3C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Nov 2014 15:08:25 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id 2AFA3F811DF; Wed,  5 Nov 2014 08:08:26 -0700 (MST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from Zeus.chez-thomas.org (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id 0B406F811DD;
	Wed,  5 Nov 2014 08:08:25 -0700 (MST)
From: Gary Thomas <gary@mlbassoc.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Nov 2014 08:08:24 -0700
Message-Id: <1415200104-27160-1-git-send-email-gary@mlbassoc.com>
X-Mailer: git-send-email 1.9.1
Cc: Gary Thomas <gary@mlbassoc.com>
Subject: [PATCH] bitbake: Make printed 'runqueue' be consistently capitalized
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
X-List-Received-Date: Wed, 05 Nov 2014 15:08:30 -0000

This has always bothered me:
  NOTE: Preparing runqueue
  NOTE: Executing RunQueue Tasks

This patch changes the messages to be consistent.

Signed-off-by: Gary Thomas <gary@mlbassoc.com>
---
 bitbake/doc/bitbake-user-manual/bitbake-user-manual-hello.xml | 2 +-
 bitbake/lib/bb/runqueue.py                                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-hello.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-hello.xml
index 4ce7ed9..fd5a923 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-hello.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-hello.xml
@@ -471,7 +471,7 @@ ERROR: Unable to parse base: ParseError in configuration INHERITs: Could not inh
      Time: 00:00:00
      Parsing of 1 .bb files complete (0 cached, 1 parsed). 1 targets, 0 skipped, 0 masked, 0 errors.
      NOTE: Resolving any missing task queue dependencies
-     NOTE: Preparing runqueue
+     NOTE: Preparing RunQueue
      NOTE: Executing RunQueue Tasks
      ********************
      *                  *
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 6d9cf3f..22dd7a7 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -430,7 +430,7 @@ class RunQueueData:
             # Nothing to do
             return 0
 
-        logger.info("Preparing runqueue")
+        logger.info("Preparing RunQueue")
 
         # Step A - Work out a list of tasks to run
         #
-- 
1.9.1


