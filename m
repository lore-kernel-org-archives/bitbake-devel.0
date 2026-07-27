Return-Path: <amery@apptly.co>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD1AC531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 17:29:06 +0000 (UTC)
Received: from v523.v5ed9ac7d.euw1.send.eu.mailgun.net (v523.v5ed9ac7d.euw1.send.eu.mailgun.net [141.193.32.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36784.1785173338709964665
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jul 2026 10:28:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@e.apptly.co header.s=mta header.b=QeZaNnE7;
 spf=pass (domain: e.apptly.co, ip: 141.193.32.23, mailfrom: bounce+ec7242.b6604b-bitbake-devel=lists.openembedded.org@e.apptly.co)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=e.apptly.co; q=dns/txt; s=mta; t=1785173336; x=1785180536;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=AwTLqwsPFz6fO9sDYlCx1hERwmpluBJ2KIxUsWuFEZc=;
 b=QeZaNnE7tNwMtXwgOs+RAk5V7YaV+2hXhjLJkUBOH0V+bF6MrLEtuupJz6MXC2ULdhX0GzKdeBb8P8cB+LJYaQSMQmJX+6kjG9IXnslob6BhbjGz7RpjqqpRNigQeigvrcP8JWU7tqX0sdsVhbbaDIU7hxFQ0IvX6EMxZfSYs9A=
X-Mailgun-Sid: WyI5YTJmMyIsImJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyIsImI2NjA0YiJd
Received: from localhost (unknown [51.179.224.164]) by
 fe660923a79b87cf0cad4ce5af71efb1327ed2fd002ac585f8bb2d664fb51f5a with SMTP id
 6a679558599bd22e9500bfb0 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 27 Jul 2026 17:28:56 GMT
X-Mailgun-Sending-Ip: 141.193.32.23
Sender: amery=apptly.co@e.apptly.co
From: Alejandro Mery <amery@apptly.co>
To: bitbake-devel@lists.openembedded.org
Cc: Alejandro Mery <amery@apptly.co>
Subject: [PATCH v2] bitbake-worker: Evaluate exported_vars() before emptying the environment
Date: Mon, 27 Jul 2026 17:28:56 +0000
Message-ID: <20260727172856.2304118-1-amery@apptly.co>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jul 2026 17:29:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19865

exported_vars() returns a lazy generator. It was bound before
empty_environment() cleared the process environment and only iterated
afterwards, so any datastore expansion deferred until iteration ran
against the wiped environment rather than the one bitbake started with.

The corruption is not uniform. The loop writes each variable into
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

Materialise the generator into a list before emptying the environment so
every expansion happens while that environment is still intact. Add
tests for the expansion timing this relies on: values materialised
before empty_environment() survive it, a generator consumed after it
does not.

- v2: comment the ordering at the call site, and add the tests.
- v1: the list() wrap alone.

Signed-off-by: Alejandro Mery <amery@apptly.co>
---
 bin/bitbake-worker   |  5 ++++-
 lib/bb/tests/data.py | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 4ad716975..b8dc9c862 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -296,7 +296,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
 
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
-                exports = bb.data.exported_vars(the_data)
+                # Iterating it expands each value, so materialise the generator before
+                # empty_environment() below: an expansion deferred past that point runs
+                # against the wiped environment, not the one bitbake started with.
+                exports = list(bb.data.exported_vars(the_data))
 
                 bb.utils.empty_environment()
                 for e, v in exports:
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index fd690a9e2..06c88ffc6 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -723,3 +723,45 @@ class EmitVar(unittest.TestCase):
         self.assertEqual(self.get_output(out), ['bad_chars="a\\"b \\',
                                                 'c\\`d \\',
                                                 'e\\$f"'])
+
+class ExportedVars(unittest.TestCase):
+    """bb.data.exported_vars() expands each value as it is iterated.
+
+    bitbake-worker's fork_off_task() therefore materialises the generator
+    with list() before it calls bb.utils.empty_environment(): an exported
+    variable whose value expands from the environment (e.g. a gitver-style
+    PV that runs git and needs the real PATH) has to be expanded while that
+    environment still exists. bitbake-worker runs on import (only its
+    version check sits behind a __main__ guard), so these tests reproduce
+    its sequence against bb.data and pin the behaviour the worker relies
+    on, not the worker itself.
+    """
+
+    def setUp(self):
+        self.saved_environment = dict(os.environ)
+        os.environ["BB_TEST_EXPORTED_VARS"] = "intact"
+
+        self.d = bb.data.init()
+        self.d.setVar("TESTEXPORT",
+                      "${@os.environ.get('BB_TEST_EXPORTED_VARS', 'wiped')}")
+        self.d.setVarFlag("TESTEXPORT", "export", "1")
+
+    def tearDown(self):
+        # empty_environment() wipes the environment of this process, not a
+        # copy of it, so put it back whatever the test did.
+        os.environ.clear()
+        os.environ.update(self.saved_environment)
+
+    def test_materialised_before_empty_environment(self):
+        # What bitbake-worker does: list() expands every value while the
+        # environment is still intact, so the wipe cannot reach them.
+        exports = list(bb.data.exported_vars(self.d))
+        bb.utils.empty_environment()
+        self.assertEqual(dict(exports)["TESTEXPORT"], "intact")
+
+    def test_lazy_generator_expands_after_empty_environment(self):
+        # Why the list() is required: a generator bound before the wipe but
+        # consumed after it expands against the wiped environment instead.
+        exports = bb.data.exported_vars(self.d)
+        bb.utils.empty_environment()
+        self.assertEqual(dict(exports)["TESTEXPORT"], "wiped")
-- 
2.47.3


