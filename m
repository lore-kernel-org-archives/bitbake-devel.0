Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67101C41535
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:44:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.334.1699551862793254977
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 09:44:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=ItCCpgc1;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1F8149C34CD
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 12:44:22 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id UjCH5GZRPint; Thu,  9 Nov 2023 12:44:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ADF0E9C2D22;
	Thu,  9 Nov 2023 12:44:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com ADF0E9C2D22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699551861; bh=p2J+od2B1eMImjzJ6UqaVnL/r0kbwNU9wZ1YSW48g4U=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ItCCpgc1eomxaWhSiWcFtlluPOrFKB0tvpMvbinpR2lToNogHNVuP18TllgAXAfsC
	 6NCMBxNq1OU8BgTjuuco44NdE/wKRQIiioDJlNEEIOO0NT/yfNbViunqBQK/gNq1EA
	 F0RN9DbgthfoJNhbA/lM8UV6zaaR8se0figw77NfzGkTuEgMO5zvICX5PirgrZ5h7G
	 /3Odfs6sJv8kbZMnwL7rcryV7eJfm/zB/HUd54vsCEwp++EiBE+w9oKcfpVPXMU+03
	 ztlXPz9+ViHU4zpVmGkzUpcRCEi6N8MqRfx81GkvV8icqpukpUaranxV6E4wTPzCQc
	 SreOSQkL+n2ww==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id NkfRLFJLObnu; Thu,  9 Nov 2023 12:44:21 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D28959C2CD7;
	Thu,  9 Nov 2023 12:44:20 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v5 5/6] Toaster: Bug-fix django.db.utils.IntegrityError: Problem installing fixture
Date: Thu,  9 Nov 2023 18:44:11 +0100
Message-Id: <20231109174412.257199-5-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109174412.257199-1-alassane.yattara@savoirfairelinux.com>
References: <20231109174412.257199-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 17:44:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15482

toastergui-unittest-data.xml fixture contains a release objects with
name=3D"master" or an release with same name seem existing
- Change release name and fix bitbakeversion instead of bitbake_version

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml=
 b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
index 1d522f88..df106934 100644
--- a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
+++ b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
@@ -19,9 +19,9 @@
      <field type=3D"CharField" name=3D"description">poky_distro2 descrip=
tion</field>
   </object>
   <object pk=3D"1" model=3D"orm.release">
-     <field type=3D"CharField" name=3D"name">master</field>
+     <field type=3D"CharField" name=3D"name">foo_master</field>
      <field type=3D"CharField" name=3D"description">master project</fiel=
d>
-     <field to=3D"orm.bitbake_version" name=3D"bitbake_version">1</field=
>
+     <field to=3D"orm.bitbakeversion" name=3D"bitbake_version">1</field>
   </object>
   <object pk=3D"1" model=3D"orm.project">
     <field type=3D"CharField" name=3D"name">a test project</field>
--=20
2.34.1


