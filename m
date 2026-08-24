Return-Path: <amery@apptly.co>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1DEC5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 22:04:38 +0000 (UTC)
Received: from v523.v5ed9ac7d.euw1.send.eu.mailgun.net (v523.v5ed9ac7d.euw1.send.eu.mailgun.net [141.193.32.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9046.1787609073640864170
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 15:04:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@e.apptly.co header.s=mta header.b=x5F2BpuD;
 spf=pass (domain: e.apptly.co, ip: 141.193.32.23, mailfrom: bounce+ec7242.b6604b-bitbake-devel=lists.openembedded.org@e.apptly.co)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=e.apptly.co; q=dns/txt; s=mta; t=1787609071; x=1787616271;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=GoKbiJnR4cJQnrABMKgQWGKGiLn61GnnCg6Mi1+9ZWg=;
 b=x5F2BpuDSoKXeDhUoLyWF3e6Z9iR1u+s84L+f7C2yI6dkVeIoFuyxRPX5rfz2Hy5AV4BASjzzVYBO1T8dS7ia1PPpm4BDkHbVGNReYRlNaUfnWc8kLOjNeSTAj3h6ChE2gRMofvQVhORT/uQ3eeSRk8BlYIXmaP4C9kTBwuG9CQ=
X-Mailgun-Sid: WyI5YTJmMyIsImJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyIsImI2NjA0YiJd
Received: from localhost (unknown [51.179.224.164]) by
 e6e7b238216ee9f3d6acd43b7d0a3467c039a51d7a119265d0e5f1e0d0364192 with SMTP id
 6a8cbfef50483608cd3943c7 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 24 Aug 2026 22:04:31 GMT
X-Mailgun-Sending-Ip: 141.193.32.23
Sender: amery=apptly.co@e.apptly.co
From: Alejandro Mery <amery@apptly.co>
To: bitbake-devel@lists.openembedded.org
Cc: Alejandro Mery <amery@apptly.co>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.18][PATCH] data: Return a list from exported_vars()
Date: Mon, 24 Aug 2026 22:04:31 +0000
Message-ID: <20260824220431.350438-1-amery@apptly.co>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 22:04:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20031

exported_vars() was a generator, so each value expanded when the result
was iterated rather than when it was called. bitbake-worker binds it
before bb.utils.empty_environment() and iterates it afterwards, so any
expansion deferred until iteration ran against the wiped environment
rather than the one bitbake started with.

The corruption is not uniform. The worker writes each variable into
os.environ as it goes, so only the first value expands against a fully
empty environment and the rest see it partially rebuilt, in
exported_keys() order.

Recipes whose exported variables expand a command during that loop hit
this. A gitver-style PV such as "${@get_git_pv(d, ...)}" runs git while
PATH is empty, so the git wrapper on PATH is bypassed and the real git
runs directly. Under pseudo this fakes uid 0 against a repository owned
by the real user, and git aborts with "detected dubious ownership",
failing do_package intermittently (only on reparse, when the value is
re-expanded rather than served from cache).

Build and return the list in exported_vars() itself, so the expansion is
complete before it returns and no caller has to know it was ever
deferred. A value that fails to expand now warns at that point rather
than during iteration, and a result nothing consumes is expanded anyway;
neither is a change for the one caller, which consumes all of it. Update
the comment at the worker's call site, which documented the generator
that is now gone, and add tests for the expansion timing and for the
warning that moved with it.

- v3: materialise in exported_vars() itself, not at the call site; two
  tests, using bb.utils.environment() rather than touching os.environ
  directly.
- v2: comment the ordering at the call site, and add the tests.
- v1: the list() wrap alone.

Signed-off-by: Alejandro Mery <amery@apptly.co>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c870f5bd96ad02efc02c58133c27bdae3a300e3e)
Signed-off-by: Alejandro Mery <amery@apptly.co>
---
 bin/bitbake-worker   |  6 ++++--
 lib/bb/data.py       | 10 +++++++++-
 lib/bb/tests/data.py | 28 ++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index aa14ef191..ae21f277f 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -288,8 +288,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                     else:
                         logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
 
-                # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
-                # successfully. We also need to unset anything from the environment which shouldn't be there 
+                # exported_vars() expands each value, so it must be called before
+                # empty_environment() below: an expansion that shells out needs the
+                # environment bitbake was started with. We also need to unset
+                # anything from the environment which shouldn't be there
                 exports = bb.data.exported_vars(the_data)
 
                 bb.utils.empty_environment()
diff --git a/lib/bb/data.py b/lib/bb/data.py
index b12972c03..7c01e6bf8 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -193,6 +193,12 @@ def exported_keys(d):
                                       not bb.utils.to_boolean(d.getVarFlag(key, 'unexport')))
 
 def exported_vars(d):
+    """Return the exported variables as a list of (key, value) pairs.
+
+    Every value is expanded before returning, so a caller that changes the
+    environment afterwards still gets what the expansion saw.
+    """
+    exported = []
     k = list(exported_keys(d))
     for key in k:
         try:
@@ -202,7 +208,9 @@ def exported_vars(d):
             continue
 
         if value is not None:
-            yield key, str(value)
+            exported.append((key, str(value)))
+
+    return exported
 
 def emit_func(func, o=sys.__stdout__, d = init()):
     """Emits all items in the data store in a format such that it can be sourced by a shell."""
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index fd690a9e2..a83c71e2c 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -723,3 +723,31 @@ class EmitVar(unittest.TestCase):
         self.assertEqual(self.get_output(out), ['bad_chars="a\\"b \\',
                                                 'c\\`d \\',
                                                 'e\\$f"'])
+
+class ExportedVars(unittest.TestCase):
+    def test_expanded_before_returning(self):
+        # Called while the variable is set, read once it is gone: the value
+        # has to be the one from the call, not from the read.
+        d = bb.data.init()
+        d.setVar("TESTVAR", "${@os.environ.get('BB_TEST_EXPORT', 'gone')}")
+        d.setVarFlag("TESTVAR", "export", "1")
+
+        with bb.utils.environment(BB_TEST_EXPORT="present"):
+            exported = bb.data.exported_vars(d)
+
+        self.assertEqual(dict(exported), {"TESTVAR": "present"})
+        self.assertIsInstance(exported, list)
+
+    def test_unexpandable_value_warns_and_is_skipped(self):
+        # The warning belongs to the call, not to a later iteration.
+        d = bb.data.init()
+        d.setVar("TESTVAR", "value")
+        d.setVarFlag("TESTVAR", "export", "1")
+        d.setVar("TESTBROKEN", "${@int('not a number')}")
+        d.setVarFlag("TESTBROKEN", "export", "1")
+
+        with LogRecord() as logs:
+            exported = bb.data.exported_vars(d)
+
+        self.assertEqual(dict(exported), {"TESTVAR": "value"})
+        self.assertTrue(logContains("Unable to export ${TESTBROKEN}", logs))
-- 
2.47.3


