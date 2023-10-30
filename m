Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F05C4167D
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:51:14 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.159372.1698695473575983290
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:51:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=vF2sXKOg;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EE8C09C2A91
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 15:51:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jEfsg3zxn6kS; Mon, 30 Oct 2023 15:51:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 90D7E9C332D;
	Mon, 30 Oct 2023 15:51:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 90D7E9C332D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698695472; bh=p2J+od2B1eMImjzJ6UqaVnL/r0kbwNU9wZ1YSW48g4U=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=vF2sXKOgKDgD+ADs+HTnDQ01QFwg6ZtvyrxbNFJWT1WxH7mux6Y+VG0LJZIAdYFJh
	 24IoRBA4N0Ba1b8AgTINLIxL2IWftQ9zYMmO5Cjrj/O+5U4+oGkPmtBWPZGH2y2W7c
	 pSioAP/OBgnFUeGpEA83+rqt/5yU/zFtWq7MW8AwMKpHpvtMmp3Xbp61KIUuOZIiE9
	 AjQz5Y4v/MKPTS65O5fsJkCFVbIwsbpNgvoG5A4QlhVONnYwmwhykyb9JH2Pa+OxND
	 o9/glPoarksfWWXe+aU9tvtgB+I23DK/LkAqe93Zo+ZDnzcZoDPg5EDlhjVGX4VyXx
	 z51XU1F3KS8/A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id L3SSH1OXrv2z; Mon, 30 Oct 2023 15:51:12 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B00FE9C2848;
	Mon, 30 Oct 2023 15:51:11 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 5/8] Toaster: Bug-fix django.db.utils.IntegrityError: Problem installing fixture
Date: Mon, 30 Oct 2023 20:50:34 +0100
Message-Id: <20231030195037.232912-5-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:51:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15329

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


