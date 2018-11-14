Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id A1BCC6C3EE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 01:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 71EBF18441
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id C0JG_EvILsp2 for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 67F0C18348
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DC1D1A0C0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31C7D1A0BF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 237D226A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id wAE1AK2b000929
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 02:10:20 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id wAE1AKHS000928
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Nov 2018 02:10:20 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Nov 2018 02:10:18 +0100
Message-Id: <20181114011019.878-1-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Subject: [PATCH 1/2] bitbake-dumpsig: Make --task work again
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
X-List-Received-Date: Wed, 14 Nov 2018 01:10:22 -0000

This corresponds to commit fdcea991 that fixed the --task option for
bitbake-diffsigs.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/bin/bitbake-dumpsig | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-dumpsig
index 95ebd93546..40e08e0439 100755
--- a/bitbake/bin/bitbake-dumpsig
+++ b/bitbake/bin/bitbake-dumpsig
@@ -3,7 +3,8 @@
 # bitbake-dumpsig
 # BitBake task signature dump utility
 #
-# Copyright (C) 2013 Intel Corporation
+# Copyright (C) 2013, 2017 Intel Corporation
+# Copyright (C) 2017-2018 Axis Communications AB
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -33,17 +34,38 @@ import bb.msg
 
 logger = bb.msg.logger_create('bitbake-dumpsig')
 
+def find_siginfo(tinfoil, pn, taskname, sigs=None):
+    result = None
+    tinfoil.set_event_mask(['bb.event.FindSigInfoResult',
+                            'logging.LogRecord',
+                            'bb.command.CommandCompleted',
+                            'bb.command.CommandFailed'])
+    ret = tinfoil.run_command('findSigInfo', pn, taskname, sigs)
+    if ret:
+        while True:
+            event = tinfoil.wait_event(1)
+            if event:
+                if isinstance(event, bb.command.CommandCompleted):
+                    break
+                elif isinstance(event, bb.command.CommandFailed):
+                    logger.error(str(event))
+                    sys.exit(2)
+                elif isinstance(event, bb.event.FindSigInfoResult):
+                    result = event.result
+                elif isinstance(event, logging.LogRecord):
+                    logger.handle(event)
+    else:
+        logger.error('No result returned from findSigInfo command')
+        sys.exit(2)
+    return result
+
 def find_siginfo_task(bbhandler, pn, taskname):
     """ Find the most recent signature file for the specified PN/task """
 
-    if not hasattr(bb.siggen, 'find_siginfo'):
-        logger.error('Metadata does not support finding signature data files')
-        sys.exit(1)
-
     if not taskname.startswith('do_'):
         taskname = 'do_%s' % taskname
 
-    filedates = bb.siggen.find_siginfo(pn, taskname, None, bbhandler.config_data)
+    filedates = find_siginfo(bbhandler, pn, taskname)
     latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-1:]
     if not latestfiles:
         logger.error('No sigdata files found matching %s %s' % (pn, taskname))
-- 
2.12.0


