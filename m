Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by mx.groups.io with SMTP id smtpd.web12.5258.1590636284712945291
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 May 2020 20:24:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.1.11, mailfrom: kai.kang@windriver.com)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 04S3OfwQ028770
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Wed, 27 May 2020 20:24:41 -0700 (PDT)
Received: from pek-lpg-core3.wrs.com (128.224.153.232) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Wed, 27 May 2020 20:24:34 -0700
From: "kai" <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <martin.jansa@gmail.com>
Subject: [PATCH] bitbake-user-manual-metadata.xml: fix a minor error
Date: Thu, 28 May 2020 11:24:31 +0800
Message-ID: <20200528032431.26150-1-kai.kang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain

From: Kai Kang <kai.kang@windriver.com>

In the '_remove' example in bitbake-user-manual-metadata.xml, there is
no 'jkl' in the original value of FOO2. So remove it from result.

Signed-off-by: Kai Kang <kai.kang@windriver.com>
---
 .../doc/bitbake-user-manual/bitbake-user-manual-metadata.xml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 10b588352b..2c5d01f26b 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -432,7 +432,7 @@
                 The variable <filename>FOO</filename> becomes
                 "&nbsp;&nbsp;789&nbsp;123456&nbsp;&nbsp;&nbsp;&nbsp;"
                 and <filename>FOO2</filename> becomes
-                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jkl&nbsp;&nbsp;abcdef&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".
+                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;abcdef&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".
             </para>
 
             <para>
-- 
2.17.1

