Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2866DC41513
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 21:59:12 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.268963.1697579947218112129
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Oct 2023 14:59:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=HGtsNWBU;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E57129C3226
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 17:59:05 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jhvGo3nRUQg7; Tue, 17 Oct 2023 17:59:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 449289C2C9C;
	Tue, 17 Oct 2023 17:59:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 449289C2C9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697579945; bh=eKiSBrTuzEPt7GUbyMGUvWmEhbTDPkZY4Yh5GNnkhTU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=HGtsNWBUcV7uYHyA/Ev5A+3nKs/jiqzs7+6NazrrQMZjPe+rxzakCK3wG9VxE40fv
	 +yyvGX6Ksc5C4eEf+DEHNoVR5Cnc72nAqoWyDRWiEnJhKDrmv6Oty442N5eqQZ+uA0
	 Qbd1p0u6guZo6ISWypWqK/KG2Lrz6UszybXKWj2gZgWMZczrQ4YrIKj6wkM9bQfye+
	 RAgZZYagY02Qx8AUQCL9Gqw0h3wjH53Xp1b8D4cfpurb3RO7sSbmLN7uzX3qZ7AC4r
	 sUwnsozHKjTphBfEJXJIjNUudTx9y2eoBcEBttQ9lJKqThy93uf8NXHfssXulRO7+8
	 IT7MXoMBq7Djw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id oOYEQqo2rlTU; Tue, 17 Oct 2023 17:59:05 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 64D119C2AEF;
	Tue, 17 Oct 2023 17:59:04 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/2] Toaster: bug-fix on tests.views.test_views.py
Date: Tue, 17 Oct 2023 22:58:48 +0100
Message-Id: <20231017215848.514246-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017215848.514246-1-alassane.yattara@savoirfairelinux.com>
References: <20231017215848.514246-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 21:59:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15257

- Update toastergui/fixtures/toastergui-unittest-data.xml to added tow di=
stro
objects. Test fail because distro table was empty

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../toastergui/fixtures/toastergui-unittest-data.xml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml=
 b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
index 4517ed17..1d522f88 100644
--- a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
+++ b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
@@ -6,6 +6,18 @@
       <field type=3D"CharField" name=3D"dirpath">b</field>
       <field type=3D"CharField" name=3D"branch">a</field>
   </object>
+  <object pk=3D"1" model=3D"orm.distro">
+     <field type=3D"DateTimeField" name=3D"up_date"><None></None></field=
>
+     <field to=3D"orm.layer_version" name=3D"layer_version" rel=3D"ManyT=
oOneRel">1</field>
+     <field type=3D"CharField" name=3D"name">poky_distro1</field>
+     <field type=3D"CharField" name=3D"description">poky_distro1 descrip=
tion</field>
+  </object>
+  <object pk=3D"2" model=3D"orm.distro">
+     <field type=3D"DateTimeField" name=3D"up_date"><None></None></field=
>
+     <field to=3D"orm.layer_version" name=3D"layer_version" rel=3D"ManyT=
oOneRel">2</field>
+     <field type=3D"CharField" name=3D"name">poky_distro2</field>
+     <field type=3D"CharField" name=3D"description">poky_distro2 descrip=
tion</field>
+  </object>
   <object pk=3D"1" model=3D"orm.release">
      <field type=3D"CharField" name=3D"name">master</field>
      <field type=3D"CharField" name=3D"description">master project</fiel=
d>
--=20
2.34.1


