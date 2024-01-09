Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F7C47073
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 13:54:00 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.17036.1704808438425819408
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 05:53:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=IvjCMbjP;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 64D439C37C9
	for <bitbake-devel@lists.openembedded.org>; Tue,  9 Jan 2024 08:53:57 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id rod29MkLru0N; Tue,  9 Jan 2024 08:53:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 085779C160A;
	Tue,  9 Jan 2024 08:53:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 085779C160A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704808437; bh=UkLfyjM4OdlRSPJ5BcZXvkIWvhyghgi/K4h0N5TTjBk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=IvjCMbjPRuzyD8uyBniEDglMP4nYzgrW7F25/egMQ+I69z+oFPt8EX66mmKQmxiWK
	 ff8Ix7ZjmlLE43qL09Z3i6pKep3n/z2Qsa9I/gibJmZ6UYrsbF0ajniKfCLWC9wXYr
	 ZgqHBlwqYYkfRXbQJiBeiC868nPnRraJhC3IHc7//B6YhPFryOYrp+sFgxuq+gIpCo
	 JRHqiOP4yqTr8n24Y4I4woPJUPu5MtsI2TaVndtyonxb4zxpWVpMg1lYGas3Fm2hH2
	 tH1f10tfJqvh8vx2gRgO+6iSDFLu54qOHMSx+2rWvskDjf1pTb4iVoXCy0Un9Kc7qW
	 wM7r7uODuLEaQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id x0DktH2ytm40; Tue,  9 Jan 2024 08:53:56 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 6EC4A9C0B24;
	Tue,  9 Jan 2024 08:53:56 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 2/3] toaster/test: bug-fix "#hint-error-project-name" should be visible
Date: Tue,  9 Jan 2024 14:53:51 +0100
Message-Id: <20240109135352.416686-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109135352.416686-1-alassane.yattara@savoirfairelinux.com>
References: <20240109135352.416686-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 13:54:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15759

Failed: https://autobuilder.yoctoproject.org/typhoon/#/builders/161/build=
s/142

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_new_project_page.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toa=
ster/tests/browser/test_new_project_page.py
index 70b55f3c..458bb653 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -79,6 +79,7 @@ class TestNewProjectPage(SeleniumTestCase):
=20
         url =3D reverse('newproject')
         self.get(url)
+        self.wait_until_visible('#new-project-name', poll=3D3)
=20
         self.enter_text('#new-project-name', project_name)
=20
@@ -90,7 +91,8 @@ class TestNewProjectPage(SeleniumTestCase):
=20
         self.click("#create-project-button")
=20
-        element =3D self.wait_until_visible('#hint-error-project-name', =
poll=3D3)
+        self.wait_until_present('#hint-error-project-name', poll=3D3)
+        element =3D self.find('#hint-error-project-name')
=20
         self.assertTrue(("Project names must be unique" in element.text)=
,
                         "Did not find unique project name error message"=
)
--=20
2.34.1


