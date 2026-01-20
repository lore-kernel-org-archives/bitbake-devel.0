Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3956BD2ED0F
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 05:55:22 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.787.1768888518911403617
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Jan 2026 21:55:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=KPCx0K3e;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1329275-2026012005551468b0659829000207af-v6xbbr@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2026012005551468b0659829000207af
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 20 Jan 2026 06:55:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=00Q5NPDDLsmOxeuLjnkCsY3EeXvx7TWX0EN325x+aGY=;
 b=KPCx0K3eHxKIqYlDd1NGbrigBmfjuoka/KFyVxSrwn2qTUEqI762lD8AnYOrSBJQ3/v8xf
 Vo8+nfd85z5MGou8cvCU/8P2wxvylagI22l1OIJNCsR8JwZO21mA4GbHZujoc1g9uDPbMIX5
 3YK4dvLkFvFbcgcrFDvH8U8v7Ywq5pAHQJKtZONzRYwXyRYbNBrPlnB2IEON9YnDSUz5pQ0c
 SA/b0hqyyRGbX1//XPHVte7WdJ/QxqCZmZN0FnPyEOwVIg6dkTR+whbxcZq21xO/JWphqg/n
 GK/NUo/8MCp1W0LScGuOF+spPmT6mnIRAn7S3JC/xA6q8H3QNip4daKw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 2/2] oe-selftest: runqemu: use zst rootfs for test
Date: Tue, 20 Jan 2026 06:54:06 +0100
Message-ID: <20260120055500.1749670-3-adrian.freihofer@siemens.com>
In-Reply-To: <20260120055500.1749670-1-adrian.freihofer@siemens.com>
References: <20260120055500.1749670-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 05:55:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18808

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Use .tar.zst as rootfs IMAGE_FSTYPES in the runqemu selftest to make the
test quicker and more relevant to current usage.

Simplify changing the IMAGE_FSTYPES for the test.

Improve the test speed by using get_bb_vars to get multiple bb vars at
once.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 meta/lib/oeqa/selftest/cases/runqemu.py | 28 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/meta/lib/oeqa/selftest/cases/runqemu.py b/meta/lib/oeqa/selftest/cases/runqemu.py
index 7ed89e80de..bfa76812ae 100644
--- a/meta/lib/oeqa/selftest/cases/runqemu.py
+++ b/meta/lib/oeqa/selftest/cases/runqemu.py
@@ -11,7 +11,7 @@ import oe.types
 from oeqa.core.decorator import OETestTag
 from oeqa.core.decorator.data import skipIfNotArch, skipIfNotMachine
 from oeqa.selftest.case import OESelftestTestCase
-from oeqa.utils.commands import bitbake, runqemu, get_bb_var
+from oeqa.utils.commands import bitbake, runqemu, get_bb_var, get_bb_vars
 
 
 @OETestTag("runqemu")
@@ -189,17 +189,25 @@ class QemuTest(OESelftestTestCase):
     def setUpClass(cls):
         super(QemuTest, cls).setUpClass()
         cls.recipe = 'core-image-minimal'
-        cls.machine = get_bb_var('MACHINE')
-        cls.deploy_dir_image = get_bb_var('DEPLOY_DIR_IMAGE')
-        cls.image_link_name = get_bb_var('IMAGE_LINK_NAME', cls.recipe)
-        cls.cmd_common = "runqemu nographic snapshot"
-        cls.qemuboot_conf = "%s.qemuboot.conf" % (cls.image_link_name)
-        cls.qemuboot_conf = os.path.join(cls.deploy_dir_image, cls.qemuboot_conf)
+        cls.image_fstypes = "tar.zst"
 
         cls.write_config(cls,
 """
-IMAGE_FSTYPES += "tar.bz2"
-""")
+IMAGE_FSTYPES += "%s"
+""" % cls.image_fstypes)
+
+        bb_vars = get_bb_vars([
+            'DEPLOY_DIR_IMAGE',
+            'IMAGE_LINK_NAME',
+            'MACHINE',
+            ],
+            cls.recipe)
+        cls.deploy_dir_image = bb_vars['DEPLOY_DIR_IMAGE']
+        cls.image_link_name = bb_vars['IMAGE_LINK_NAME']
+        cls.machine = bb_vars['MACHINE']
+        cls.cmd_common = "runqemu nographic snapshot"
+        cls.qemuboot_conf = "%s.qemuboot.conf" % (cls.image_link_name)
+        cls.qemuboot_conf = os.path.join(cls.deploy_dir_image, cls.qemuboot_conf)
 
         bitbake(cls.recipe)
 
@@ -231,7 +239,7 @@ IMAGE_FSTYPES += "tar.bz2"
             self.assertTrue(qemu_shutdown_succeeded, 'Failed: %s does not shutdown within timeout(%s)' % (self.machine, shutdown_timeout))
 
     def test_qemu_can_boot_nfs_and_shutdown(self):
-        rootfs_tar = "%s.tar.bz2" % (self.image_link_name)
+        rootfs_tar = "%s.%s" % (self.image_link_name, self.image_fstypes)
         rootfs_tar = os.path.join(self.deploy_dir_image, rootfs_tar)
         self.assertExists(rootfs_tar)
         cmd = "%s %s" % (self.cmd_common, rootfs_tar)
-- 
2.52.0


