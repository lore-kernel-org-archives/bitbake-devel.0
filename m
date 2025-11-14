Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00DBCE8D56
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 16:44:45 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2774.1763138682611267166
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 08:44:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=m8F2RCwy;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 42C744E416B6;
	Fri, 14 Nov 2025 16:44:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1985E6060E;
	Fri, 14 Nov 2025 16:44:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AED710371CCB;
	Fri, 14 Nov 2025 17:44:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763138680; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AiKKvesHxlnm8k7b0ozjMONvDFDN69CnfFJwWK3Jrfc=;
	b=m8F2RCwy3iSm5F02mV+cJ6zpxIGvYhCq+FSSMcn6ub0nL1yLz4ze3k5+wE7axg9wQGK1Ha
	+7BLio8a+Per0QL0KQbOsDr+/JjTMwEyKALciVso4sxXkeIyQok+MKpammkTRnRekufGmg
	82DCAWv5p1IFuOeb8HsA3nrusZxgJAXbk/FMnazGzuHnpfiUzzzsWGvi/XcIH0KMaeA9kR
	iGkFVIzzEik93q8pZdHNLC/bIxK4d85mx0Uhh8Zwu5guuPH9Rx4sst9qkFv9hEzvUPfTyg
	3vPyFJmbpLmdPj7qDbjAac0zpWRq0EShzzdPLO3pebv+W/MI5ObJcdR79qGatQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Nov 2025 17:44:21 +0100
Subject: [PATCH 2/2] bitbake-selftest: setup: add test for
 --update-bb-conf=no
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-bitbake-setup-conf-updates-v1-2-990583d8251b@bootlin.com>
References: <20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=oSoVIGpWifQNULIQAkSZLwhMMElBl0JPJZ0o1bH4Baw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpF1x1a7HbvfJknW+0LWCXP8z6od+0bShGgGRWd
 0Q88HFHF+WJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRdcdQAKCRDRgEFAKaOo
 Nu5DEADDGi13j3zL6ISki4e4ZvTrpB2On/e0szsWJJ0hq02pUmZQWWxmOX8QNTlBVZ1HZZftdHc
 /W3MVR+ZMDg29ojKwDR+0nJ4n+2MM4HmQCgC9KH7XXUsjDmztbMlRplH5dcja1MFFqEPjz5RbvQ
 CBEzuJlgORtfXlQcBLgrj9nYupNfHEDTlJ9d6IgrqzQAFaiEYEQlfABMBtkM/W/jmSoL+7sYZ8I
 RDLkp7Q5VIZQc394/D5zC0GJZVNSPNmkM4sxiPjrJ/XICOO/ab2OA8qeOdalk8j/F4Atq4q8Oqm
 F7p9iWIxwzGYHq3bCYhd1YqhlIndHL/1nniWqFKRRCRazjISaOZTHEiVSu9cIgEUvyV4QLv0wtU
 4yZ6eCvFH3gVGdvhJRbqFKtkkzcIITKztlTNhL/AMvsQSCTvBkuqrfOvF66XZQ3QTJMb7frUJoX
 2vUb3TaCA4MdzulXlQJ/Am+hQWRFoRSQ7Fk/3Nsq8O2QpWyOq9oGwfKYfE4g2o6TBJgl2DJx+ea
 9KzNnDERqy4Ya1Ffx8mAI3GxBOd1cOGhDePskJhOWqGaLdpBnMopnxBiIi4JBbZPzn7LObhUW8A
 /rJBnBOVxKonwtL+pOB7OilOLb0HBmXy+w72YVMptHaCgs+w0DlgK3+ylYUeuYg4EaPA8pV4cJm
 BBwuagSDm3NSsCg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 16:44:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18404

We want to check that with --update-bb-conf set to 'no' our BitBake
configuration remains unchanged. For this create a list of checksums of
the files in conf/ and compare before/after bitbake-setup update
--update-bb-conf=no.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/tests/setup.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 58049c8c7a..b4258f0492 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -6,6 +6,8 @@
 
 from bb.tests.fetch import FetcherTest
 import json
+import hashlib
+import glob
 
 class BitbakeSetupTest(FetcherTest):
     def setUp(self):
@@ -360,3 +362,36 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
             self.check_setupdir_files(setuppath, test_file_content)
+
+        # do the same as the previous test, but now without updating the bitbake configuration (--update-bb-conf=no)
+        # and check that files have not been modified
+
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


