Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7EDC4167B
	for <webhook@archiver.kernel.org>; Tue,  5 Dec 2023 16:40:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.104662.1701794428826286293
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Dec 2023 08:40:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=ue4gA8G8;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 391049C3787
	for <bitbake-devel@lists.openembedded.org>; Tue,  5 Dec 2023 11:40:28 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id zDfpU17eROCr; Tue,  5 Dec 2023 11:40:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EF24D9C3644;
	Tue,  5 Dec 2023 11:40:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EF24D9C3644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701794427; bh=cZ/HAjIUty8oe60jm8VAiaBm1mpt2UtM83cgX+hS/aM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ue4gA8G8xkEqu7MOn/EfyAxW71SSi9ZeS5DU8ACZ9KVYbkxiD/UF/zXLrEMr5ESMM
	 OsQqZ0qBRod9LiuUyS1vKr6a5+DPsJkF13vFobIrK3Pm1d78UgDkuBtklERLu/JNX8
	 tk44tPPeaQolkrbC5qWUgowD+5/CXvK4CxCvD1PqwX7qvfSAqRb48GS6dLvup21Bd/
	 NDI675RmMRobL6UGkKKJz+ARqt7BRgqnFjKoU8BN+XKCObXnqgA6PIJAGTG9PGNLfB
	 O0sVTtEhilXcEB+tbSTwJunMYnNA/Hr0IqsqW3bCNgBzJ+ArJSKu1YgBueh6pGop9S
	 Dd3OSSeA5FD8Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 1f5YWOJ-eJd0; Tue,  5 Dec 2023 11:40:27 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 60B1E9C339D;
	Tue,  5 Dec 2023 11:40:27 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 3/4] toaster/test: from test_no_builds_message.py wait for the empty state div to appear
Date: Tue,  5 Dec 2023 17:40:21 +0100
Message-Id: <20231205164022.151951-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205164022.151951-1-alassane.yattara@savoirfairelinux.com>
References: <20231205164022.151951-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Dec 2023 16:40:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15615

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


