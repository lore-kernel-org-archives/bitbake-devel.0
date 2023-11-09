Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C9C001B2
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 15:56:36 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.125366.1699545388401935171
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 07:56:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=NSHh7IOm;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4FA969C34B2
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 10:56:27 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id hIjRw5a_BoUN; Thu,  9 Nov 2023 10:56:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E5B959C2CF2;
	Thu,  9 Nov 2023 10:56:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E5B959C2CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699545386; bh=p2J+od2B1eMImjzJ6UqaVnL/r0kbwNU9wZ1YSW48g4U=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=NSHh7IOmEvjSuCrLHRqODTPBD+ED6M4LY1RxvizCxOf73i3Cau0McZftPO60vhOF4
	 OVp/IKvncJWx0wgcqNVzecmV4Hp1pzRgIlSmDifbmxv07TKFK4JoTNR3cVHpZPz0u9
	 o1cMoXPA6nZlxaCF7LlvsMUdOi2oaHlQqEcVR3h/w/HrVc3H2BAPNH2JQgojeqIWej
	 3x7KRNoPJG432K4OqNjlURhHwhIDLtR8YfTjZ16sj93Djt1yZHQgObkzty+1ereb46
	 /tLM+92fmoUG1bRRJ7vzFKeoQeadUTPUcBhFVv1ndcFS7Mdy5z/Znr1vFTFeGHAcGs
	 xyhUpXuwWDKaA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id m4xBrg9WCmqc; Thu,  9 Nov 2023 10:56:26 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1E4C29C27A3;
	Thu,  9 Nov 2023 10:56:25 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 5/8] Toaster: Bug-fix django.db.utils.IntegrityError: Problem installing fixture
Date: Thu,  9 Nov 2023 16:56:15 +0100
Message-Id: <20231109155618.133124-5-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109155618.133124-1-alassane.yattara@savoirfairelinux.com>
References: <20231109155618.133124-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 15:56:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15467

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


