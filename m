Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2547C4167B
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 14:28:21 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.13760.1699972092701103448
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Nov 2023 06:28:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=l6OJXLjl;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 53EF59C3552
	for <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 09:28:11 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id P9QOnCOALYim; Tue, 14 Nov 2023 09:28:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A960C9C3452;
	Tue, 14 Nov 2023 09:28:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A960C9C3452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699972090; bh=2kxm0JRfXtfgkO2UEcagNUKzcVFTWLExsjeiRQGlogs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=l6OJXLjlGYxGntcpHRgpHyOyQBhpcr8i92nA8Qk7QaWIQU1n5VArlwHNXwlSgz9Pt
	 vfz1EfCm49L8KHbO+fpLnStcc8QogvxAftFJ2Mc8l2zF8uuE1uCHjq7Q/LDAgDG6qC
	 TwVZg9IFkoBmtI3MPl0zUIMEj1KbdzmY+Jr2iZd01lTwEYqHdchkOIdpxzdT7UPzbc
	 c1jkhiXJQPYmUtNd5K3Qf75P5h/PeexagVGx1+ZbzyZB3HopD0yuv+RNldeQmtzgnt
	 KNG0yBRktPP80RfhTKBfLTgBFmkdnf+NQeD6BM1AID51lDqssoEmMm3fwvbUXVn7qo
	 r/TmyWUqCfGpA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fJoCyJU8medz; Tue, 14 Nov 2023 09:28:10 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1633E9C320B;
	Tue, 14 Nov 2023 09:28:09 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 1/6] Toaster: Write UI TestCase -> Test if 'no build' message is shown
Date: Tue, 14 Nov 2023 15:28:01 +0100
Message-Id: <20231114142806.53894-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 14:28:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15520

In all builds page, check if 'no build' message is shown when there are n=
o build.

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


