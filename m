Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4030C4167B
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:51:24 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.159179.1698695477313085994
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:51:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=s6W4a4Ry;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A2BA99C284C
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 15:51:16 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id k4kk50wXsqKJ; Mon, 30 Oct 2023 15:51:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EF85E9C332F;
	Mon, 30 Oct 2023 15:51:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EF85E9C332F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698695476; bh=rBWAoJ0FniWSG44KVipEyg2HlVrTAi29swGjkkmqBuQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=s6W4a4Ryoad2qBbK7lEvbp4yOfr5tzA1BwUdNNmh2djBDRnZmnMPm//rIaWmMFX5S
	 JqffDxaQWdE6on3S3DTwPPFQ7BC9ZWxtyWGzcETWRo16ExWuaoFexu7SOl98s/vYQu
	 oBu8rr/I0nrR9cx7mGkcDhgrgVrLnOR7A8mo3u3Ae/9Kz9RLEOzSEOGiOV9zl118qH
	 8uuGEr/tkiTsovalzGXSKRT6yIQ1Pqxb4op0xIyc9eEmCXH6zGMwkBKAp53QuSPLm7
	 tW9r/DxGlDyOHcfwFOJNw43Q6XgsdBPDWYoYCNIH0+V+s6ZM1nDBiRitwU7GsZrluW
	 aPIIx9vh9hlng==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Mu9Mojzj7b2Z; Mon, 30 Oct 2023 15:51:15 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4A7C59C2A91;
	Mon, 30 Oct 2023 15:51:15 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 8/8] Toaster: Added pytest.init file
Date: Mon, 30 Oct 2023 20:50:37 +0100
Message-Id: <20231030195037.232912-8-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:51:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15332

Added pytest init file to configure pytest and generate test reports.

Objective
- We propose to integrate the plugin Pytest to generate test reports for =
Toaster application.
- To keep configurations to a minimal, we propose to integrate Pytest wit=
h Tox(tox.ini).
- Tox will automate the execution of the Pytest test cases. =20

Pros
- Generate test reports
- Create a historical record of test results over time
- Track Toasters stability and quality=20
- Documentation and Transparency
- Debugging, troubleshooting  : identify regressions (input, output,)=20

Cons
- Limited predefined report options. Although Pytest provides different r=
eport
formats, its default reports are rather straightforward, We might have to=
 put extra effort into crafting them ourselves.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/pytest.ini | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 lib/toaster/pytest.ini

diff --git a/lib/toaster/pytest.ini b/lib/toaster/pytest.ini
new file mode 100644
index 00000000..f07076b7
--- /dev/null
+++ b/lib/toaster/pytest.ini
@@ -0,0 +1,19 @@
+# -- FILE: pytest.ini (or tox.ini)
+[pytest]
+DJANGO_SETTINGS_MODULE =3D toastermain.settings_test
+
+python_files =3D db/test_*.py commands/test_*.py views/test_*.py browser=
/test_*.py functional/test_*.py
+
+# --create-db - force re creation of the test database
+# https://pytest-django.readthedocs.io/en/latest/database.html#create-db=
-force-re-creation-of-the-test-database
+
+# --html=3Dreport.html --self-contained-html
+# https://docs.pytest.org/en/latest/usage.html#creating-html-reports
+# https://pytest-html.readthedocs.io/en/latest/user_guide.html#creating-=
a-self-contained-report
+addopts =3D --create-db --html=3D"Toaster Tests Report.html" --self-cont=
ained-html=20
+
+# Define environment variables using pytest-env
+# A pytest plugin that enables you to set environment variables in the p=
ytest.ini file.
+# https://pypi.org/project/pytest-env/
+env =3D
+    TOASTER_BUILDSERVER=3D1
--=20
2.34.1


