Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7317CEBF96
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 08:21:21 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4952.1763367676640165690
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 00:21:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=b6IM3GWx;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 552171A1B5E;
	Mon, 17 Nov 2025 08:21:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24505606B9;
	Mon, 17 Nov 2025 08:21:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AFD110371CF2;
	Mon, 17 Nov 2025 09:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763367674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FbNfCTbjkfYeXa1kv9jGhbZoGyCEAk3uUnlIbQ0hZL4=;
	b=b6IM3GWxDSFJLzDWQCB013ZLkCxTPHm/D/4H6OSmWOBu5PAfC5UQxlFzNuaGy9vP4DuG5u
	T04vbupuAlBqNvcDmaVE3RQTr9WGoWNpPDoupEeXd6HdTqpKZmyAjOuJa1tHoF4V2STcV9
	XtocaJNg+OhTLNEUz2A7N+O+2Yb2oRE4/peq+ksncvmQQhrLsy0EZDdOIb4k065/yt5hpL
	USY6fyPighxvqlGNNnnqosUtTQ8Dr2pWQ2ZxfgF49tv2AWjg8RIooaq96SSTgEvNoGrnZo
	yiP228Azy2KL1uPZOhY0Gaw8Psi/2xvSS5cQl94NUYxvhqWO+oXPkZ75pweSAg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 17 Nov 2025 09:21:09 +0100
Subject: [PATCH v2 2/2] bitbake-selftest: setup: add test for
 --update-bb-conf=no
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-bitbake-setup-conf-updates-v2-2-209637e01fbe@bootlin.com>
References: <20251117-bitbake-setup-conf-updates-v2-0-209637e01fbe@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-conf-updates-v2-0-209637e01fbe@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2958;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=RLdkp5vRp2BsRO6Fjj0aqY6e5YsOx70No1i5wcdGRo8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGtr4D4h8IbnkPEiId9nxRNtTLpeif6/CF7I1q
 f4rB8MJcTyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRra+AAKCRDRgEFAKaOo
 Nn5FD/9vvpE3Wn/Cbg40sFoMvmpG2Cu7sp3nU/owhow4MeGCD4tf0o2tInYz7Eg8tEQKXmBfjbM
 dJ3A3FaVeCYdQ7acNRBhtu+8PoBSHeSFH2PJg8ZM/bpL2n7B3MJwoxH7vBrdc9ZAEfYld+mMT0C
 zxtaAA+XIk3deYB7s9ybf/ZY9gBfzZNbePlxvhgoHJZ0494r7CoziZepaoDk6W+FEqIe/YATqLl
 c9n9gmz7C9JYoAVEC4N9B6VssEzHuXZUX1c+eDlc++TUnCjF9jFJvdfpJqUoJ/WRMUoeqvCRbrb
 MYdQmY/1zNyqVz/Clr/Hn6vbCAxgROjegUDijfyUHt6XCv3Z9PUtK0mFZlrAjNVAgR5h5Gqc/4r
 pgpTegF8OnzxfRQQnB5QkDE8wPhvTQzADfN+hF0LNGeihypxxqDNmupDtXRZkKwvB+pDlLoiO8M
 HVwQwzR5Z8y0PahL17u7viFOOIsxvecWcIpddtMDi++yMEfOdzhxcDPAXz18htg1zStsJbn6Veu
 bGqbQqnMW12Q3VR6gJE6xIi+kkZb5U6G7Lm7xnu8yFiMtKcrpCsQRMcfRPOrtS0p8N5Wourfboq
 8pgU5SlmKUZpnZ8v0GzebarVdI4lcGY2FB/KLkXcQxjJ1IobPexvQPnoXKOcxG1EeXLbxe7tXMs
 2yjWspvgel9jgrA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:21:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18420

We want to check that with --update-bb-conf set to 'no' our BitBake
configuration remains unchanged. For this create a list of checksums of
the files in conf/ and compare before/after bitbake-setup update
--update-bb-conf=no.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/tests/setup.py | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 18b560b93d..1aab5f384a 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -6,6 +6,8 @@
 
 from bb.tests.fetch import FetcherTest
 import json
+import hashlib
+import glob
 
 class BitbakeSetupTest(FetcherTest):
     def setUp(self):
@@ -361,3 +363,35 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
             self.check_setupdir_files(setuppath, test_file_content)
+
+        # do the same as the previous test, but now without updating the bitbake configuration (--update-bb-conf=no)
+        # and check that files have not been modified
+        def _conf_chksum(confdir: str) -> list:
+            sums = []
+            for f in glob.glob(f'{confdir}/*'):
+                if not os.path.islink(f):
+                    with open(f, 'rb') as fd:
+                        sum = os.path.basename(f) + '_' + hashlib.file_digest(fd, "sha256").hexdigest()
+                        sums.append(sum)
+            return sums
+
+        prev_test_file_content = test_file_content
+        test_file_content = 'modified-in-branch-no-bb-conf-update\n'
+        branch = "another-branch-no-bb-conf-update"
+        self.git('checkout -b {}'.format(branch), cwd=self.testrepopath)
+        self.add_file_to_testrepo('test-file', test_file_content)
+        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
+        for c in ('gadget', 'gizmo',
+                  'gizmo-env-passthrough',
+                  'gizmo-no-fragment',
+                  'gadget-notemplate', 'gizmo-notemplate'):
+            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+            # write something in local.conf and bblayers.conf
+            for f in ["local.conf", "bblayers.conf"]:
+                with open(f"{setuppath}/build/conf/{f}", "w") as fd:
+                    fd.write("deadbeef")
+            sums_before = _conf_chksum(f"{setuppath}/build/conf")
+            out = self.runbbsetup("update --update-bb-conf='no'")
+            sums_after = _conf_chksum(f"{setuppath}/build/conf")
+            self.assertEqual(sums_before, sums_after)

-- 
2.51.0


