Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA9CED247
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 08:20:28 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7958.1763454015534189351
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Nov 2025 00:20:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Zmx7DeTg;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 37995C1267F
	for <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 08:19:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B4CE606FE;
	Tue, 18 Nov 2025 08:20:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB36B10371D1F;
	Tue, 18 Nov 2025 09:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763454013; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BdFe5rpe8C7wa3/06oK9kc118beYF/7jQ8BMjgIeBmM=;
	b=Zmx7DeTgI2o+ggAdE1EQkP5KL2nuUZNY2kFNGC6+OicwrQR03k+Gt0/y5EA7agKJATvlMO
	4SuAoi1J9aTJSUfZGVkjjPkyMI6Rfs4zt4AfWJVTp91LngcEnJEP/ABU/CD/LbbPW0IYI3
	Y1iIV1aHdkGAnZx5KgBc5qwqJRFZ9Sw2thWC0/IyiBZguZnmbFN0WCTeZmI/WMbg1WAYlv
	eSjOMxj6SNj7zobCfygrPGfWVpmHl1hX1N+f5moYkz9DXy8Ycz6JtVz/2ltvioYECT/e8C
	sUDOHYOXUmXfy63/2ne5F0YN/eJ0wlVL73D3P+TdJzXEdDwSY+Gxq2yAwqhD9Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 18 Nov 2025 09:19:57 +0100
Subject: [PATCH v4 2/2] bitbake-selftest: setup: add test for
 --update-bb-conf=no
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-bitbake-setup-conf-updates-v4-2-7336b663bca6@bootlin.com>
References: <20251118-bitbake-setup-conf-updates-v4-0-7336b663bca6@bootlin.com>
In-Reply-To: <20251118-bitbake-setup-conf-updates-v4-0-7336b663bca6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3012;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=wwBBGidTe3HW5YXhvn9nByxYVRO1Ib/cHVBDMF+P2lU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpHCw6eQskXyuP873wx5D9+PpJGf+z5aRZKSgp2
 mAqCV53N52JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRwsOgAKCRDRgEFAKaOo
 NmjRD/9nm3jTKIp1T4ihWu4NF39riu6gx4hn9sJCZcidVBTg1AFHrX4Au1quoD3SifmbQnkMoaG
 hELWRZE3ii1PQsmTaQIyuCQBZ+6ZfTpr/wjwRcuWqu8A0rLZXnG97LV8Dqc7XL0RPoM4F/Y67LD
 7wy3JTCaROwAm2DatM7B/ycj5K4t/BoAeY1UT8OnZMeyqYXn9l5LFxRFy1UeakiNQ6NSnQbojb4
 9Bpa7gNlYnyMDLEsFOMzyCv1CwGmvWBJaYHqk5ZtB5qVpmNMLU8ilKHGRMEmh6umzECd4vuRNnP
 AHGPFAoKm9B7NFamy8wWEYKoJ27n6cUMg/FKLRlO/UF43IgDyxcY0On8QJUBV0bM38c+ZUs539L
 5kDhLMl3YL3nyvSUnhpAdvMSKznXhytZ5gR2NWU6ZrVZSx72b1T8FtRuUex8rMeUWjl8M5N0Lal
 ndETAqCxymY06EWdztGzTeLEvBlm7V9WMTG6KVGUWB8FtcJh3lzxQmdPXHzMUCvicJZw1n0Duc3
 K00tFI7S9jnIBb9ri6yehYNOB1tln5EKRNVlFRZ/Gg742161uFTkSkIcK/+3l/ykQpHeHuH7EWZ
 MaJQnOrr1EOXVheLCy7wlmBXGw9D/jcx8sRqgnTknG2jIm02q2N34g+BTri6mhEmxOOYlh4iFHk
 ee6c4BLnJJJpO9Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 08:20:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18445

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


