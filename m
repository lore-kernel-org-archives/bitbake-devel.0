Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA0CC46CD2
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 16:27:41 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.20966.1704817656693133108
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 08:27:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=MhC6EazK;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0AACD9C2AA0
	for <bitbake-devel@lists.openembedded.org>; Tue,  9 Jan 2024 11:27:36 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ej3obuw_Rkr0; Tue,  9 Jan 2024 11:27:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 847489C0AAC;
	Tue,  9 Jan 2024 11:27:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 847489C0AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704817655; bh=UkLfyjM4OdlRSPJ5BcZXvkIWvhyghgi/K4h0N5TTjBk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=MhC6EazKzjuPYYzNu0vkZdon/BHurzZjznaXfkfQyK8mdqa7SzgiBhVMTL0S/yXin
	 0cxRs3jvv5Uok70RCZEORhbZ9XomQnPFkBMBsHJnc/0TT4M9Bi3QZiXZBoe7DNtb+r
	 nyVQgQLmRgLnK1XexH4BzHK8pn4MV2OPLR0J+z0fILSw1cgsF76nGueWubGyavGZiN
	 t/pbR2YYSDMh3397pwRsbaGRnwgjh9XTfzgb+lwcitMT8EohfAl6UE1CZxXd42DoaT
	 bU7pp0HMv4hcNlIpIr497TjcdiHSwNjcmj/DwsUevKLpa05as/BCzWWQbqnRLc9xkm
	 jCGesHz2+j9Jg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id pC2U75RSORrv; Tue,  9 Jan 2024 11:27:35 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A9FC49C08FE;
	Tue,  9 Jan 2024 11:27:34 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 2/4] toaster/test: bug-fix "#hint-error-project-name" should be visible
Date: Tue,  9 Jan 2024 17:27:27 +0100
Message-Id: <20240109162729.531311-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109162729.531311-1-alassane.yattara@savoirfairelinux.com>
References: <20240109162729.531311-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 16:27:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15765

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


