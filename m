Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D6EC4167B
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 22:49:15 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.84669.1701730148073197640
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Dec 2023 14:49:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=eOb1jwON;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 68D749C31BC
	for <bitbake-devel@lists.openembedded.org>; Mon,  4 Dec 2023 17:49:07 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id EF_kBjhlnRj2; Mon,  4 Dec 2023 17:49:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 27CF09C3D77;
	Mon,  4 Dec 2023 17:49:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 27CF09C3D77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701730147; bh=cZ/HAjIUty8oe60jm8VAiaBm1mpt2UtM83cgX+hS/aM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=eOb1jwONp3fULvY96My0Svkuv5rg08OQSep0Le4olF3ZoLTNSGfNp0s4IHsIb7TPT
	 wyfihyL70NMZsCCz20M69hUjCcDTYYk3ErE6BSAvF8QWIW+a9Jm30froMoyXMa3t3L
	 WB1dEnm66u3lOH+6mIWvGP95wEduNd0dfRE80J11WPwl9zIe8l9dLhwjlg2a0MuVM8
	 cXCDn2U8Pj00mccs4HoCzS7HX6K8j3ZL4G0aEabrDXA4Q6tiSMEd1DwAEv4Y+Oe4gK
	 oxxuG6gpTMJNH7yIhTNdtOue7t+yH/P6pbWEc5b3vIOfPbH89VTiLk+y9zaMoIl/Du
	 /YMVFbvURgeeg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id y0u7D4TB_Wzd; Mon,  4 Dec 2023 17:49:07 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 84B7B9C31BC;
	Mon,  4 Dec 2023 17:49:06 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/3] toaster/test: from test_no_builds_message.py wait for the empty state div to appear
Date: Mon,  4 Dec 2023 23:48:32 +0100
Message-Id: <20231204224832.399005-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204224832.399005-1-alassane.yattara@savoirfairelinux.com>
References: <20231204224832.399005-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Dec 2023 22:49:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15607

From tests/browser/test_sample.py wait for the empty state div to appear

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_sample.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/tests/browser/test_sample.py b/lib/toaster/tests=
/browser/test_sample.py
index 73973778..f04f1d9a 100644
--- a/lib/toaster/tests/browser/test_sample.py
+++ b/lib/toaster/tests/browser/test_sample.py
@@ -32,6 +32,7 @@ class TestSample(SeleniumTestCase):
         """ Test that a message is shown when there are no builds """
         url =3D reverse('all-builds')
         self.get(url)
+        self.wait_until_visible('#empty-state-allbuildstable')  # wait f=
or the empty state div to appear
         div_msg =3D self.find('#empty-state-allbuildstable .alert-info')
=20
         msg =3D 'Sorry - no data found'
--=20
2.34.1


