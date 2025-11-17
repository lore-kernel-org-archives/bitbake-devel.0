Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C8CEBF96
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 12:52:33 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8394.1763383945942905625
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 04:52:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=BnhX0ipJ;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 33C9E1A1B6D
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:52:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 03197606B9;
	Mon, 17 Nov 2025 12:52:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4942110371D32;
	Mon, 17 Nov 2025 13:52:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763383943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BdFe5rpe8C7wa3/06oK9kc118beYF/7jQ8BMjgIeBmM=;
	b=BnhX0ipJPuGxmw+MpOqVaIGlJr2mCMIj+A2gusXNOgJ2SdofhSfbDdU7Z5gr/jy4cZ4PLi
	BLcTofvcQyJW6kOFFC9CQK+ULEPS6StSJk6X328i6418gUq37XIkpsgjneaJ0TdcLE7l+5
	0gR0UeO1wRykFO/B40GW2IhTPBhkH2KD7wuaS7uTz14PDmBbcsjTyWPzDdEY5pNj7DALRL
	hRbbHevo0RLKYzGw3LAk+rN8ICTJJhfOSH/7qQ9+jsVim18k6mR6WBL8Cu57vT4+W+TWa6
	PlqmzCDYtcwIMpSLFjtSyLEeLlvxplDFcJAeHTN/YX7mcmSMlGZbu67cxDWgxw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 17 Nov 2025 13:52:18 +0100
Subject: [PATCH v3 2/2] bitbake-selftest: setup: add test for
 --update-bb-conf=no
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-bitbake-setup-conf-updates-v3-2-46cdf826e79c@bootlin.com>
References: <20251117-bitbake-setup-conf-updates-v3-0-46cdf826e79c@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-conf-updates-v3-0-46cdf826e79c@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3012;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=wwBBGidTe3HW5YXhvn9nByxYVRO1Ib/cHVBDMF+P2lU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGxqEjE0XxBQFvim6V88qZ1qKAuXRREPSGwGZ7
 7TbRIOcCxGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRsahAAKCRDRgEFAKaOo
 NpynEACKt1otAyrGUYX8fOuk4jacf1z2htfchsKWwRu9CSjPM0eujYFCsqWjSXrjFRB0Nc6HVU9
 DC3JqhRlINiwxqpeC2hOtJGoLUoESMXvg+Mu7ydQnD0Cw1KsmdOrFc/rn4H974wyooW+/icc6eq
 3yH/+axbdmPCNbBXJG7eopLTd1QaUEkcbd+teMaHvFFNxUiCmUm4RswHwGvkE/wGpVdXzkt/wfZ
 7tirL1Iales/dZZ3gEkR1lm6V4UU945ud8xrEthP7UuuKwrysNfUcT4hBn+oGT2VKNM010KPgee
 tmOoevLQZ4KMd3RGMLOhs4aPCNIeYJHbnm2yaXu/+gkcyqcxa9upTkI6lV0VQfzh9BjAMf1JayI
 S2/nNeqlqbI3swNPkKi/5CPioIV1ronNv7URiA4gHENqgTTHvNQLDq4lH+NZO8CzgW1ENLANOfy
 9BWvu40344bMgXtrkGNVo5YbFX/lbunLWnlFEmvxqW3inxZtAhoWFeA2g2k7/b4/yaFhoUTaZNQ
 waoD0yP/OiNzjBsOp77vjeJXvTazmQG5qR9Nz8a5AI6gfbafE0HdUGf3+zBU4s8uq4KLCcLng/0
 navK0zB1rJAL6J+cDo+AbNZeV7tbFxH3DgJkShf1s4R1NX1TeKqG5F/vdXy69P6cDq7b/7r0Z1W
 vvmyF6NJ6gTKX8A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:52:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18429

We want to check that with --update-bb-conf set to 'no' our BitBake
configuration remains unchanged. For this create a list of checksums of
the files in conf/ and compare before/after bitbake-setup update
--update-bb-conf=no.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/tests/setup.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 18b560b93d..0b93292d3e 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -6,6 +6,8 @@
 
 from bb.tests.fetch import FetcherTest
 import json
+import hashlib
+import glob
 
 class BitbakeSetupTest(FetcherTest):
     def setUp(self):
@@ -361,3 +363,36 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
             self.check_setupdir_files(setuppath, test_file_content)
+
+        # do the same as the previous test, but now without updating the bitbake configuration (--update-bb-conf=no)
+        # and check that files have not been modified
+        def _conf_chksum(confdir: str) -> list:
+            sums = []
+            for f in glob.glob(f'{confdir}/*'):
+                if os.path.isfile(f) and not os.path.islink(f):
+                    with open(f, 'rb') as fd:
+                        sha = hashlib.sha256()
+                        sha.update(fd.read())
+                        sums.append(os.path.basename(f) + '_' + sha.hexdigest())
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


