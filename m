Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCBFC5DF74
	for <webhook@archiver.kernel.org>; Sun, 16 Aug 2026 22:15:20 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18662.1786918513787792485
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Aug 2026 15:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=XCX5hBcK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20260816221511a2d9ae8261000207c4-v4ewgi@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260816221511a2d9ae8261000207c4
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 17 Aug 2026 00:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=N1l4n262KqRN8BUlD795V5kG6BfqJ1qcsaC3kwKrVwI=;
 b=XCX5hBcKJTh+eLURTVryjW8dyWtq9HdjX9XnHqwPRVCV2RhQcCEsjY+3PcbDqR07gP0mG3
 wpDy4zeS5m/2XriZnhtj3LXwcU8wcKNgsX+dxDcwz7YzXSPf51LEaI22wwQHvsUeY2ykCLyE
 /H9ugDPBLnLJNqsPVKLvX9KIjZSiorPdhHNTQATnWypjAmHW/4F4fFl/KFAagl8zVAVic4hW
 HRDI+xB07bgfWtVf2HgJ+6OBv1zx/fq1/ATLusfIru1ATa5cDhWCrWo9hmZbt++F1JzkdRXW
 YREmiIG6p+MW27CEHWAovUtt2mHPfFqhIocQ6jGkkTHLFIvBQ9oC4FVg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 2/8] tests/cooker: add a shared bitbake-subprocess test base class
Date: Mon, 17 Aug 2026 00:14:41 +0200
Message-ID: <20260816221507.155861-3-adrian.freihofer@siemens.com>
In-Reply-To: <20260816221507.155861-1-adrian.freihofer@siemens.com>
References: <20260816221507.155861-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Aug 2026 22:15:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19963

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Tests that run bitbake or tinfoil in a subprocess against a temporary
build directory can leave behind a memory-resident bitbake server (and,
if BB_HASHSERVE=auto, a hashserv) rooted at TOPDIR. That server must
release the directory before the caller's TemporaryDirectory context
manager can safely remove it, or cleanup can race a still-running
server holding files open there.

Add _BitbakeSubprocessTestCase with _run_subprocess()/_shutdown() to
provide this consistently, so the tests added on top of it in the next
commits don't each have to hand-roll the subprocess/wait boilerplate -
and, more importantly, don't get a chance to forget the wait.

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/cooker.py | 52 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index 9e524ae34..c49375ed8 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -7,12 +7,62 @@
 #
 
 import unittest
+import contextlib
 import os
+import subprocess
+import sys
+import tempfile
+import time
 import bb, bb.cooker
 import re
 import logging
 
-# Cooker tests
+
+class _BitbakeSubprocessTestCase(unittest.TestCase):
+    """Common helpers for tests that run bitbake/tinfoil in a subprocess.
+
+    Shared because every such subprocess can start a memory-resident bitbake
+    server (and, if BB_HASHSERVE=auto, a hashserv) rooted at TOPDIR, and both
+    must release that directory before the caller's TemporaryDirectory can be
+    safely removed.
+    """
+
+    def _run_subprocess(self, cmd, env, cwd):
+        proc = subprocess.run(
+            cmd,
+            env=env,
+            stdout=subprocess.PIPE,
+            stderr=subprocess.STDOUT,
+            universal_newlines=True,
+            cwd=cwd,
+        )
+        if proc.returncode:
+            self.fail('%s failed: %s' % (cmd, proc.stdout))
+        return proc.stdout
+
+    def _shutdown(self, builddir):
+        """Wait for the bitbake server and hashserv to release builddir.
+
+        Must run before the caller's TemporaryDirectory is removed, so it
+        cannot be a tearDown().
+        """
+        deadline = time.monotonic() + 30
+        while time.monotonic() < deadline:
+            if not any(os.path.exists(os.path.join(builddir, p))
+                       for p in ('hashserve.sock', 'bitbake.lock')):
+                return
+            time.sleep(0.5)
+
+    @contextlib.contextmanager
+    def _build_dir(self, prefix='tinfoiltest'):
+        """TemporaryDirectory that also waits out _shutdown() before removal."""
+        with tempfile.TemporaryDirectory(prefix=prefix) as builddir:
+            try:
+                yield builddir
+            finally:
+                self._shutdown(builddir)
+
+
 class CookerTest(unittest.TestCase):
     def setUp(self):
         # At least one variable needs to be set
-- 
2.55.0


