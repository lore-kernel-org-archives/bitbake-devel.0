Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7DC04FF8
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 09:38:01 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.14344.1713865074205604003
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Apr 2024 02:37:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Anvgtauu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 362522000C;
	Tue, 23 Apr 2024 09:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713865072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ1A1j1vyUJrZWXpv6ueyWGVm6alviP6v6D57fOXcGo=;
	b=AnvgtauuFG9a9NPk5jeBxLe1RoRv6mC8I/TAgCxyLVF6pOQpXoYmtrRHFJINyGZcvqWRnc
	XDKykEN13YBLpuZqW9gpL7hX+Y1maZMoQMQsJBdDMXKdRWTJ3dWnyTSzVBqujNEiqL1T5M
	zVTQe2v1kNfioPYYim+tmpfeQ2Wd9da7U8l/sPjkkYoy3ylC9L1/DfjwErhwJECx9m+PnC
	7EIlaHIcmofC3yjtkN6F9G6/344rx9GV7OhWdXkUz2TjN3WCSLZEqZgt70eoH0wdqiTsmW
	RnFjoHmCVuK1uBOG0VbHt1NhrL4pBEhKcmBaXLnKT7A0N20eHy3mo9hug37bzQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 5/5] prserv: add bitbake selftests
Date: Tue, 23 Apr 2024 11:37:39 +0200
Message-Id: <20240423093739.364140-6-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423093739.364140-1-michael.opdenacker@bootlin.com>
References: <20240423093739.364140-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 09:38:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16128

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Run them with "bitbake-selftest prserv.tests"

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 bin/bitbake-selftest |   2 +
 lib/prserv/tests.py  | 381 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 383 insertions(+)
 create mode 100644 bitbake/lib/prserv/tests.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index f25f23b1ae..ce901232fe 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -15,6 +15,7 @@ import unittest
 try:
     import bb
     import hashserv
+    import prserv
     import layerindexlib
 except RuntimeError as exc:
     sys.exit(str(exc))
@@ -33,6 +34,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.utils",
          "bb.tests.compression",
          "hashserv.tests",
+         "prserv.tests",
          "layerindexlib.tests.layerindexobj",
          "layerindexlib.tests.restapi",
          "layerindexlib.tests.cooker"]
diff --git a/lib/prserv/tests.py b/lib/prserv/tests.py
new file mode 100644
index 0000000000..d133c239f8
--- /dev/null
+++ b/lib/prserv/tests.py
@@ -0,0 +1,381 @@
+#! /usr/bin/env python3
+#
+# Copyright (C) 2024 BitBake Contributors
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+from . import create_server, create_client, increase_revision, revision_greater_or_equal
+import prserv.db as db
+from bb.asyncrpc import InvokeError
+import logging
+import os
+import sys
+import tempfile
+import unittest
+import socket
+import subprocess
+from pathlib import Path
+
+THIS_DIR = Path(__file__).parent
+BIN_DIR = THIS_DIR.parent.parent / "bin"
+
+version = "dummy-1.0-r0"
+pkgarch = "core2-64"
+other_arch = "aarch64"
+
+checksumX = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4f0"
+checksum0 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a0"
+checksum1 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a1"
+checksum2 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a2"
+checksum3 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a3"
+checksum4 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a4"
+checksum5 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a5"
+checksum6 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a6"
+checksum7 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a7"
+checksum8 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a8"
+checksum9 = "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801ba4ab4a9"
+
+def server_prefunc(server, name):
+    logging.basicConfig(level=logging.DEBUG, filename='prserv-%s.log' % name, filemode='w',
+                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
+    server.logger.debug("Running server %s" % name)
+    sys.stdout = open('prserv-stdout-%s.log' % name, 'w')
+    sys.stderr = sys.stdout
+
+class PRTestSetup(object):
+
+    def start_server(self, name, dbfile, upstream=None, read_only=False, prefunc=server_prefunc):
+
+        def cleanup_server(server):
+            if server.process.exitcode is not None:
+                return
+            server.process.terminate()
+            server.process.join()
+
+        server = create_server(socket.gethostbyname("localhost") + ":0",
+                               dbfile,
+                               upstream=upstream,
+                               read_only=read_only)
+
+        server.serve_as_process(prefunc=prefunc, args=(name,))
+        self.addCleanup(cleanup_server, server)
+
+        return server
+
+    def start_client(self, server_address):
+        def cleanup_client(client):
+            client.close()
+
+        client = create_client(server_address)
+        self.addCleanup(cleanup_client, client)
+
+        return client
+
+class FunctionTests(unittest.TestCase):
+
+    def test_0a_increase_revision(self):
+        self.assertEqual(increase_revision("1"), "2")
+        self.assertEqual(increase_revision("1.0"), "1.1")
+        self.assertEqual(increase_revision("1.1.1"), "1.1.2")
+        self.assertEqual(increase_revision("1.1.1.3"), "1.1.1.4")
+        self.assertRaises(ValueError, increase_revision, "1.a")
+        self.assertRaises(ValueError, increase_revision, "1.")
+        self.assertRaises(ValueError, increase_revision, "")
+
+    def test_0b_revision_greater_or_equal(self):
+        self.assertTrue(revision_greater_or_equal("2", "2"))
+        self.assertTrue(revision_greater_or_equal("2", "1"))
+        self.assertTrue(revision_greater_or_equal("10", "2"))
+        self.assertTrue(revision_greater_or_equal("1.10", "1.2"))
+        self.assertFalse(revision_greater_or_equal("1.2", "1.10"))
+        self.assertTrue(revision_greater_or_equal("1.10", "1"))
+        self.assertTrue(revision_greater_or_equal("1.10.1", "1.10"))
+        self.assertFalse(revision_greater_or_equal("1.10.1", "1.10.2"))
+        self.assertTrue(revision_greater_or_equal("1.10.1", "1.10.1"))
+        self.assertTrue(revision_greater_or_equal("1.10.1", "1"))
+
+    # DB tests
+
+    def test_0b_db(self):
+        dbfile = "testtable.sqlite3"
+        if os.path.exists(dbfile):
+            os.remove(dbfile)
+
+        self.db = db.PRData(dbfile)
+        self.table = self.db["PRMAIN"]
+
+        self.table.store_value(version, pkgarch, checksum0, "0")
+        self.table.store_value(version, pkgarch, checksum1, "1")
+        # "No history" mode supports multiple PRs for the same checksum
+        self.table.store_value(version, pkgarch, checksum0, "2")
+        self.table.store_value(version, pkgarch, checksum2, "1.0")
+
+        self.assertTrue(self.table.test_package(version, pkgarch))
+        self.assertFalse(self.table.test_package(version, other_arch))
+
+        self.assertTrue(self.table.test_value(version, pkgarch, "0"))
+        self.assertTrue(self.table.test_value(version, pkgarch, "1"))
+        self.assertTrue(self.table.test_value(version, pkgarch, "2"))
+
+        self.assertEqual(self.table.find_package_max_value(version, pkgarch), "2")
+
+        self.assertEqual(self.table.find_min_value(version, pkgarch, checksum0), "0")
+        self.assertEqual(self.table.find_max_value(version, pkgarch, checksum0), "2")
+
+        # Test history modes
+        self.assertEqual(self.table.find_value(version, pkgarch, checksum0, True), "0")
+        self.assertEqual(self.table.find_value(version, pkgarch, checksum0, False), "2")
+
+        self.assertEqual(self.table.find_new_subvalue(version, pkgarch, "3"), "3.0")
+        self.assertEqual(self.table.find_new_subvalue(version, pkgarch, "1"), "1.1")
+
+class PRBasicTests(PRTestSetup, unittest.TestCase):
+
+    def setUp(self):
+        dbfile = "prtest-basic.sqlite3"
+        if os.path.exists(dbfile):
+            os.remove(dbfile)
+
+        self.server1 = self.start_server("basic", dbfile)
+        self.client1 = self.start_client(self.server1.address)
+
+    def test_1a_basic(self):
+
+        # Checks on non existing configuration
+
+        result = self.client1.test_pr(version, pkgarch, checksum0)
+        self.assertIsNone(result, "test_pr should return 'None' for a non existing PR")
+
+        result = self.client1.test_package(version, pkgarch)
+        self.assertFalse(result, "test_package should return 'False' for a non existing PR")
+
+        result = self.client1.max_package_pr(version, pkgarch)
+        self.assertIsNone(result, "max_package_pr should return 'None' for a non existing PR")
+
+        # Add a first configuration
+
+        result = self.client1.getPR(version, pkgarch, checksum0)
+        self.assertEqual(result, "0", "getPR: initial PR of a package should be '0'")
+
+        result = self.client1.test_pr(version, pkgarch, checksum0)
+        self.assertEqual(result, "0", "test_pr should return '0' here, matching the result of getPR")
+
+        result = self.client1.test_package(version, pkgarch)
+        self.assertTrue(result, "test_package should return 'True' for an existing PR")
+
+        result = self.client1.max_package_pr(version, pkgarch)
+        self.assertEqual(result, "0", "max_package_pr should return '0' in the current test series")
+
+        # Check that the same request gets the same value
+
+        result = self.client1.getPR(version, pkgarch, checksum0)
+        self.assertEqual(result, "0", "getPR: asking for the same PR a second time in a row should return the same value.")
+
+        # Add new configurations
+
+        result = self.client1.getPR(version, pkgarch, checksum1)
+        self.assertEqual(result, "1", "getPR: second PR of a package should be '1'")
+
+        result = self.client1.test_pr(version, pkgarch, checksum1)
+        self.assertEqual(result, "1", "test_pr should return '1' here, matching the result of getPR")
+
+        result = self.client1.max_package_pr(version, pkgarch)
+        self.assertEqual(result, "1", "max_package_pr should return '1' in the current test series")
+
+        result = self.client1.getPR(version, pkgarch, checksum2)
+        self.assertEqual(result, "2", "getPR: second PR of a package should be '2'")
+
+        result = self.client1.test_pr(version, pkgarch, checksum2)
+        self.assertEqual(result, "2", "test_pr should return '2' here, matching the result of getPR")
+
+        result = self.client1.max_package_pr(version, pkgarch)
+        self.assertEqual(result, "2", "max_package_pr should return '2' in the current test series")
+
+        result = self.client1.getPR(version, pkgarch, checksum3)
+        self.assertEqual(result, "3", "getPR: second PR of a package should be '3'")
+
+        result = self.client1.test_pr(version, pkgarch, checksum3)
+        self.assertEqual(result, "3", "test_pr should return '3' here, matching the result of getPR")
+
+        result = self.client1.max_package_pr(version, pkgarch)
+        self.assertEqual(result, "3", "max_package_pr should return '3' in the current test series")
+
+        # Ask again for the first configuration
+
+        result = self.client1.getPR(version, pkgarch, checksum0)
+        self.assertEqual(result, "4", "getPR: should return '4' in this configuration")
+
+        # Ask again with explicit "no history" mode
+
+        result = self.client1.getPR(version, pkgarch, checksum0, False)
+        self.assertEqual(result, "4", "getPR: should return '4' in this configuration")
+
+        # Ask again with explicit "history" mode. This should return the first recorded PR for checksum0
+
+        result = self.client1.getPR(version, pkgarch, checksum0, True)
+        self.assertEqual(result, "0", "getPR: should return '0' in this configuration")
+
+        # Check again that another pkgarg resets the counters
+
+        result = self.client1.test_pr(version, other_arch, checksum0)
+        self.assertIsNone(result, "test_pr should return 'None' for a non existing PR")
+
+        result = self.client1.test_package(version, other_arch)
+        self.assertFalse(result, "test_package should return 'False' for a non existing PR")
+
+        result = self.client1.max_package_pr(version, other_arch)
+        self.assertIsNone(result, "max_package_pr should return 'None' for a non existing PR")
+
+        # Now add the configuration
+
+        result = self.client1.getPR(version, other_arch, checksum0)
+        self.assertEqual(result, "0", "getPR: initial PR of a package should be '0'")
+
+        result = self.client1.test_pr(version, other_arch, checksum0)
+        self.assertEqual(result, "0", "test_pr should return '0' here, matching the result of getPR")
+
+        result = self.client1.test_package(version, other_arch)
+        self.assertTrue(result, "test_package should return 'True' for an existing PR")
+
+        result = self.client1.max_package_pr(version, other_arch)
+        self.assertEqual(result, "0", "max_package_pr should return '0' in the current test series")
+
+    def test_1b_is_readonly(self):
+        result = self.client1.is_readonly()
+        self.assertFalse(result, "Server should not be described as 'read-only'")
+
+class PRReadOnlyTests(PRTestSetup, unittest.TestCase):
+
+    def setUp(self):
+        # Here we're using the database test table, as for reasons not understood yet,
+        # the other tables we created from the PR server in prior tests, have empty contents!
+        dbfile = "testtable.sqlite3"
+        self.server1 = self.start_server("basic-readonly", dbfile, read_only=True)
+        self.client1 = self.start_client(self.server1.address)
+
+    def test_2a_read_only_server(self):
+
+        result = self.client1.is_readonly()
+        self.assertTrue(result, "Database should be described as 'read-only'")
+
+        # Checks on non existing configuration
+        self.assertIsNone(self.client1.test_pr(version, pkgarch, checksumX))
+        self.assertFalse(self.client1.test_package("unknown", pkgarch))
+
+        # Look up an existing configuration
+        result = self.client1.getPR(version, pkgarch, checksum0)
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum0), "2") # "no history" mode
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum0, True), "0") # "history" mode
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum2), "3")
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum2, True), "1.0")
+        self.assertEqual(self.client1.max_package_pr(version, pkgarch), "2")
+
+        # Try to insert a new value. The value should be correct given the read-only dababase, but won't be saved
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum3), "3")
+        # Same of another value
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum3), "3")
+
+class PRUpstreamTests(PRTestSetup, unittest.TestCase):
+
+    def setUp(self):
+
+        dbfile2 = "prtest-upstream2.sqlite3"
+        if os.path.exists(dbfile2):
+            os.remove(dbfile2)
+
+        self.server2 = self.start_server("upstream2", dbfile2)
+        self.client2 = self.start_client(self.server2.address)
+
+        dbfile1 = "prtest-upstream1.sqlite3"
+        if os.path.exists(dbfile1):
+            os.remove(dbfile1)
+
+        self.server1 = self.start_server("upstream1", dbfile1, upstream=self.server2.address)
+        self.client1 = self.start_client(self.server1.address)
+
+        dbfile0 = "prtest-local.sqlite3"
+        if os.path.exists(dbfile0):
+            os.remove(dbfile0)
+
+        self.server0 = self.start_server("local", dbfile0, upstream=self.server1.address)
+        self.client0 = self.start_client(self.server0.address)
+
+    def test_3a_upstream(self):
+
+        # For identical checksums, all servers should return the same PR
+
+        result = self.client2.getPR(version, pkgarch, checksum0)
+        self.assertEqual(result, "0", "getPR: initial PR of a package should be '0'")
+
+        result = self.client1.getPR(version, pkgarch, checksum0)
+        self.assertEqual(result, "0", "getPR: initial PR of a package should be '0' (same as upstream)")
+
+        result = self.client0.getPR(version, pkgarch, checksum0)
+        self.assertEqual(result, "0", "getPR: initial PR of a package should be '0' (same as upstream)")
+
+        # Now introduce new checksums on server1 for, same version
+
+        result = self.client1.getPR(version, pkgarch, checksum1)
+        self.assertEqual(result, "0.0", "getPR: first PR of a package which has a different checksum upstream should be '0.0'")
+
+        result = self.client1.getPR(version, pkgarch, checksum2)
+        self.assertEqual(result, "0.1", "getPR: second PR of a package that has a different checksum upstream should be '0.1'")
+
+        # Now introduce checksums on server0 for, same version
+
+        result = self.client1.getPR(version, pkgarch, checksum1)
+        self.assertEqual(result, "0.2", "getPR: can't decrease for known PR")
+
+        result = self.client1.getPR(version, pkgarch, checksum2)
+        self.assertEqual(result, "0.3")
+
+        result = self.client1.max_package_pr(version, pkgarch)
+        self.assertEqual(result, "0.3")
+
+        result = self.client0.getPR(version, pkgarch, checksum3)
+        self.assertEqual(result, "0.3.0", "getPR: first PR of a package that doesn't exist upstream should be '0.3.0'")
+
+        result = self.client0.getPR(version, pkgarch, checksum4)
+        self.assertEqual(result, "0.3.1", "getPR: second PR of a package that doesn't exist upstream should be '0.3.1'")
+
+        result = self.client0.getPR(version, pkgarch, checksum3)
+        self.assertEqual(result, "0.3.2")
+
+        # More upstream updates
+        # Here, we assume no communication between server2 and server0. server2 only impacts server0
+        # after impacting server1
+
+        self.assertEqual(self.client2.getPR(version, pkgarch, checksum5), "1")
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum6), "1.0")
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum7), "1.1")
+        self.assertEqual(self.client0.getPR(version, pkgarch, checksum8), "1.1.0")
+        self.assertEqual(self.client0.getPR(version, pkgarch, checksum9), "1.1.1")
+
+        # "history" mode tests
+
+        self.assertEqual(self.client2.getPR(version, pkgarch, checksum0, True), "0")
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum2, True), "0.1")
+        self.assertEqual(self.client0.getPR(version, pkgarch, checksum3, True), "0.3.0")
+
+        # More "no history" mode tests
+
+        self.assertEqual(self.client2.getPR(version, pkgarch, checksum0), "2")
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum0), "2") # Same as upstream
+        self.assertEqual(self.client0.getPR(version, pkgarch, checksum0), "2") # Same as upstream
+        self.assertEqual(self.client1.getPR(version, pkgarch, checksum7), "3") # This could be surprising, but since the previous revision was "2", increasing it yields "3".
+                                                                               # We don't know how many upstream servers we have
+
+class ScriptTests(unittest.TestCase):
+
+    def test_4a_start_bitbake_prserv(self):
+        try:
+            subprocess.check_call([BIN_DIR / "bitbake-prserv", "--start", "-f", "testtable.sqlite3"])
+        except subprocess.CalledProcessError as e:
+            self.fail("Failed to start bitbake-prserv: %s" % e.returncode)
+
+    def test_4b_stop_bitbake_prserv(self):
+        try:
+            subprocess.check_call([BIN_DIR / "bitbake-prserv", "--stop"])
+        except subprocess.CalledProcessError as e:
+            self.fail("Failed to stop bitbake-prserv: %s" % e.returncode)
-- 
2.34.1


