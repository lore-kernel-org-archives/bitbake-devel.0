Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49160C4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 17:26:37 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.33671.1699637187612106861
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 09:26:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=dujE8s0a;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 883C49C34CE
	for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 12:26:26 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MbpeGUHk-j2S; Fri, 10 Nov 2023 12:26:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1C1009C34CA;
	Fri, 10 Nov 2023 12:26:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1C1009C34CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699637186; bh=TI85V8khtbmprk33aOMUsjCreVjcrl+rqvz3viKPjZs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=dujE8s0ausQrFQzW68wZyanTAXcGc+MgqPseDB5BNT2OT2uy0mrZpf++5Rv8AVNcg
	 DmtLWcAxlCHPCTTUk2AnxoF+8+Ng0BgdoBX//ziPffhDW3hY9Rxz5FHNpxSFjzK7dN
	 /N+ZJ13hn7kOPvalfk/bARgeM5yNaz9n8gOCIbcFP48U6fN/SKuSP0+9wftRDp2vM3
	 cZEb5upghdSq9drhacY+OKvDW51iThF6z4HKKJ8ER6q45DeF91mtUodBatRFgC7nTw
	 d14og083iN/AIf0jAo6xYT+u6o8eGiMtKPE3yg1lwk53l7YfZ/wEqtnWAw5GLfv0iy
	 czcbeDdNOUp/w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Dh3L8kPnt2sw; Fri, 10 Nov 2023 12:26:26 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5634D9C328E;
	Fri, 10 Nov 2023 12:26:25 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/6] Toaster: Write UI TestCase -> Visualize all builds
Date: Fri, 10 Nov 2023 18:26:15 +0100
Message-Id: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 17:26:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15506

Test a message is shown when there are no build in all builds page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_sample.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/toaster/tests/browser/test_sample.py b/lib/toaster/tests=
/browser/test_sample.py
index b0067c21..73973778 100644
--- a/lib/toaster/tests/browser/test_sample.py
+++ b/lib/toaster/tests/browser/test_sample.py
@@ -27,3 +27,12 @@ class TestSample(SeleniumTestCase):
         self.get(url)
         brand_link =3D self.find('.toaster-navbar-brand a.brand')
         self.assertEqual(brand_link.text.strip(), 'Toaster')
+
+    def test_no_builds_message(self):
+        """ Test that a message is shown when there are no builds """
+        url =3D reverse('all-builds')
+        self.get(url)
+        div_msg =3D self.find('#empty-state-allbuildstable .alert-info')
+
+        msg =3D 'Sorry - no data found'
+        self.assertEqual(div_msg.text, msg)
--=20
2.34.1


