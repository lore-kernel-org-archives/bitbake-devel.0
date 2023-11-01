Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C0C001DB
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 22:13:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.1274.1698876813511961230
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 15:13:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=aCyv8oI9;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0159F9C33C6
	for <bitbake-devel@lists.openembedded.org>; Wed,  1 Nov 2023 18:13:31 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id c33lHfV-vNyL; Wed,  1 Nov 2023 18:13:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4E4119C33B7;
	Wed,  1 Nov 2023 18:13:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4E4119C33B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698876806; bh=NAiXiXudW5HAzWGSTgdi8vjw3qlRBRFU2L/jrIL19RI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=aCyv8oI9H1k0poV8JJ+UPAlpM4nOVXlFuShLRKuhJGOm/hy+LUmgjdAcuCC0W++fS
	 VJoFvvzC1qiGIoyjF3/noyFdhSXonHoGojrixG2kHZIysvskwaS0tfwogcUJwzeuxq
	 vrc4VVY1XJ6njjsOsUKjGBYj60qcQJvYMP9GcG9aGhEprDyAhwCxjaXd8fxEOBBF9B
	 GFu5pfQkPStU4CEY4MsVUQRgylD9GqhTWGo+NB6mSugzyuBXEmFbLeqWbWj5CV8bma
	 DLZF/2bPKJvIFZkSxSXwMmr1x5dKuExRyKXsRsTNMPZrRRQk9zvUJyYXeLEoeKyX17
	 qjimeFAsOB3ow==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id C-idA4XSQmbS; Wed,  1 Nov 2023 18:13:26 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BB47F9C314F;
	Wed,  1 Nov 2023 18:13:24 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/8] Toaster: Bug-fix webdriver No parameter named options
Date: Wed,  1 Nov 2023 23:13:08 +0100
Message-Id: <20231101221314.236173-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
References: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 22:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15407

Change options to chrome_options

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toa=
ster/tests/browser/selenium_helpers_base.py
index e0ac4376..055dbebc 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -39,7 +39,7 @@ def create_selenium_driver(cls,browser=3D'chrome'):
         options.add_argument('--disable-dev-shm-usage')
         options.add_argument('--no-sandbox')
         options.add_argument('--remote-debugging-port=3D9222')
-        return webdriver.Chrome(options=3Doptions)
+        return webdriver.Chrome(chrome_options=3Doptions)
     elif browser =3D=3D 'firefox':
         return webdriver.Firefox()
     elif browser =3D=3D 'marionette':
--=20
2.34.1


