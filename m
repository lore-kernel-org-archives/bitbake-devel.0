Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E6DC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Oct 2021 14:50:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.1637.1633445411980533402
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Oct 2021 07:50:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39AC9D6E;
	Tue,  5 Oct 2021 07:50:05 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDE5C3F70D;
	Tue,  5 Oct 2021 07:50:04 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: mark.hatle@kernel.crashing.org
Subject: [PATCH 2/4] tests/fetch: prefix the FetcherTest temporary directory
Date: Tue,  5 Oct 2021 15:49:59 +0100
Message-Id: <20211005145001.2717748-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005145001.2717748-1-ross.burton@arm.com>
References: <20211005145001.2717748-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Oct 2021 14:50:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12726

Set a prefix so the temporary directories are identifable.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index af292a2163..6978cbfaa0 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -376,7 +376,7 @@ class FetcherTest(unittest.TestCase):
     def setUp(self):
         self.origdir =3D os.getcwd()
         self.d =3D bb.data.init()
-        self.tempdir =3D tempfile.mkdtemp()
+        self.tempdir =3D tempfile.mkdtemp(prefix=3D"bitbake-fetch-")
         self.dldir =3D os.path.join(self.tempdir, "download")
         os.mkdir(self.dldir)
         self.d.setVar("DL_DIR", self.dldir)
--=20
2.25.1


