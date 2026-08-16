Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43786C5DF7B
	for <webhook@archiver.kernel.org>; Sun, 16 Aug 2026 22:15:21 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18820.1786918513981367473
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Aug 2026 15:15:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=lKTJ2PXr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-202608162215111c66f403060002071e-0ishme@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202608162215111c66f403060002071e
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 17 Aug 2026 00:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6J85fSpDKPsXWHDTZZ7Xe8eirjAj37YNt4RskIzRLjY=;
 b=lKTJ2PXrk74HnyJfrZXS26A5lIfn7LCcjPss1j77BolLiRy7sLqidbQVMz62UoJN4wOrGK
 BFJko/v3iw/K8V83fJi5eD2YhJONWgTAYYc2W2GCb9l8MYPn+oIj5SffV7k8J16i6W2eLv0e
 CDRLRQ2VlM5d0CDQK8zva/PLDVHMAKpkJwbVHsfG0hGE6iCyXLRT2FAw2CFsVB/CBf+7cG9T
 6cWitr7Bk5OGH25PTJe1N8yNlFrnh9B9yarIoBhrqJoGr3NEF8oJnotqQAfRMfiFSKfLlCTP
 SIpsad3cvF/DhDKb+zWy1//4qjq1kRwugJGwpVEi6mb4p3N0sRFiP/CA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 3/8] tests/cooker: add a bitbake -b bbappend test
Date: Mon, 17 Aug 2026 00:14:42 +0200
Message-ID: <20260816221507.155861-4-adrian.freihofer@siemens.com>
In-Reply-To: <20260816221507.155861-1-adrian.freihofer@siemens.com>
References: <20260816221507.155861-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Aug 2026 22:15:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19959

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add BuildFileTest.test_buildfile_applies_bbappends() to cover the
buildfile ("bitbake -b") mode, which had no test coverage at all.

The test writes a recipe plus a matching .bbappend into a temporary
directory, points EXTRA_BBFILES at both, and runs a task that records
the value of a variable the bbappend overrides. It then asserts the
bbappend's value was the one in effect.

It uses the parse-tests BBPATH rather than runqueue-tests because its
bitbake.conf already globs *.bbappend and the recipe needs no task
scaffolding beyond its own.

Without the preceding fix the recorded value is the recipe's default,
i.e. -b built the recipe with the bbappend silently dropped.

Built on _BitbakeSubprocessTestCase so the "bitbake -b" subprocess's
server is properly waited on before the TemporaryDirectory cleanup
runs.

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/cooker.py | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index c49375ed8..c32694cc5 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -119,3 +119,49 @@ class CookerTest(unittest.TestCase):
         expected = []
 
         self.assertEqual(log_handler.logdata, expected)
+
+
+class BuildFileTest(_BitbakeSubprocessTestCase):
+    """Tests for the buildfile ("bitbake -b") mode."""
+
+    # parse-tests BBPATH: minimal bitbake.conf whose BBFILES honours
+    # EXTRA_BBFILES and already includes *.bbappend
+    _parsetests = os.path.realpath(os.path.join(os.path.dirname(__file__), "parse-tests"))
+
+    recipe = """\
+MARKER ??= "no-bbappend"
+python do_marker() {
+    with open(d.expand("${TOPDIR}/marker.log"), "w") as f:
+        f.write(d.getVar("MARKER"))
+}
+addtask marker
+"""
+
+    bbappend = 'MARKER = "bbappend-applied"\n'
+
+    def test_buildfile_applies_bbappends(self):
+        """bitbake -b must build the recipe with its bbappends applied.
+
+        buildFileInternal() looks the appends up in self.collections[mc], which
+        on the -b path is only ever populated by matchFiles().
+        """
+        with tempfile.TemporaryDirectory(prefix="buildfilerecipes") as recipes, \
+             self._build_dir(prefix="buildfiletest") as builddir:
+            recipe = os.path.join(recipes, "appendtest.bb")
+            with open(recipe, "w") as f:
+                f.write(self.recipe)
+            with open(os.path.join(recipes, "appendtest.bbappend"), "w") as f:
+                f.write(self.bbappend)
+
+            env = os.environ.copy()
+            env["BBPATH"] = self._parsetests
+            env["BB_ENV_PASSTHROUGH_ADDITIONS"] = "TOPDIR EXTRA_BBFILES"
+            env["TOPDIR"] = builddir
+            env["EXTRA_BBFILES"] = "%s/*.bb %s/*.bbappend" % (recipes, recipes)
+
+            cmd = ["bitbake", "-b", recipe, "-c", "marker"]
+            self._run_subprocess(cmd, env, builddir)
+
+            with open(os.path.join(builddir, "marker.log")) as f:
+                self.assertEqual(f.read(), "bbappend-applied",
+                                 "bitbake -b did not apply the recipe's bbappend")
-- 
2.55.0


