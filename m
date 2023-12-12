Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0CFC4332F
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 20:05:36 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.6335.1702411529753598970
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Dec 2023 12:05:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=SvbbyxM3;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 82FD49C2795;
	Tue, 12 Dec 2023 15:05:28 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id SrQR8uS8WKXi; Tue, 12 Dec 2023 15:05:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EF8569C36BA;
	Tue, 12 Dec 2023 15:05:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EF8569C36BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702411528; bh=TwXaLmMbZtOih2J/l9U9aDmbbJ4K1aYLn4ZeGOFXozE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=SvbbyxM3b9e0rdG3w1Rc6rGae347yNW47Zqa4+2MR6PN923nCC01ds6x4Bu3t4ed/
	 VtdnyJnmXGKOVbBBD7mi8XusT45oBnDC2wrYPNOMYOpsn+ksI2U/KkvACekvLVzdJJ
	 YgCixXiPiGLFcRbQ3zCR1r32aRpKhuoMyBP+E+tdvLKjruQ4wMVrmOENfDP4XLQJhy
	 JWJ0xAkaAX4AM4eSp/c1tYdegO9JWoQZ3GOM7UUZUBZRXg4DmziD7AqSaqVXIwQMlR
	 StGnySJRvKGm8wdGX1WSQi8+B6nOrEiAZZXoQfCXt9R1Ew5UVNG1/eRLoqZR0T16+f
	 /3gIcpdc6qU9g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hTIB0Cv-hFJW; Tue, 12 Dec 2023 15:05:27 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CA3079C2795;
	Tue, 12 Dec 2023 15:05:27 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH] toaster: remove test and update setup to avoid rebuilding image
Date: Tue, 12 Dec 2023 15:05:15 -0500
Message-Id: <20231212200515.219392-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 20:05:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15656

Update build test to fix setUp, by including the built, the system was re=
building the image on every test, causing the database to lock
Delete test for unique order, this test was the only test using the self.=
built element and breaking the system.

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 lib/toaster/tests/builds/test_core_image_min.py | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/toaster/tests/builds/test_core_image_min.py b/lib/toaste=
r/tests/builds/test_core_image_min.py
index dc1ad9da..c5bfdbfb 100644
--- a/lib/toaster/tests/builds/test_core_image_min.py
+++ b/lib/toaster/tests/builds/test_core_image_min.py
@@ -27,7 +27,6 @@ class BuildCoreImageMinimal(BuildTest):
     """Build core-image-minimal and test the results"""
=20
     def setUp(self):
-        self.built =3D self.build("core-image-minimal")
         self.completed_build =3D self.target_already_built("core-image-m=
inimal")
=20
     # Check if build name is unique - tc_id=3D795
@@ -47,17 +46,6 @@ class BuildCoreImageMinimal(BuildTest):
                          total_builds,
                          msg=3D'Build cooker log path is not unique')
=20
-    # Check if task order is unique for one build - tc=3D824
-    def test_Task_Unique_Order(self):
-        total_task_order =3D Task.objects.filter(
-            build=3Dself.built).values('order').count()
-        distinct_task_order =3D Task.objects.filter(
-            build=3Dself.completed_build).values('order').distinct().cou=
nt()
-
-        self.assertNotEqual(total_task_order,
-                         distinct_task_order,
-                         msg=3D'Errors task order is not unique')
-
     # Check task order sequence for one build - tc=3D825
     def test_Task_Order_Sequence(self):
         cnt_err =3D []
--=20
2.34.1


