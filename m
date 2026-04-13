Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AA4EBFD30
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 09:59:38 +0000 (UTC)
Received: from mail187-14.suw11.mandrillapp.com (mail187-14.suw11.mandrillapp.com [198.2.187.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.268919.1776074373398703883
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Apr 2026 02:59:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=@mandrillapp.com header.s=mte1 header.b=sMPHTwBK;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=yann.dirson@vates.tech header.s=mte1 header.b=wvidtTLO;
 spf=pass (domain: bounce.vates.tech, ip: 198.2.187.14, mailfrom: bounce-md_30504962.69dcbe84.v1-db4c095609a740e7b2c7182ba3bb2136@bounce.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1776074372; x=1776344372;
	bh=UwPEUWVCAf3wFNiyyNveriV7FhqJXMVNLXYmrR4wg4k=;
	h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=sMPHTwBKQJU7ry+QYs0BZ+bJ9XdojbhIWLE0XYIg9IwiZNOOTNDZ71zjwwY1iIAU5
	 ag0+L3WQYFzaz1cb3tfLtAVEUV4+ht3FqUKAmUddDJT06HbO2Dz7e+GMdl/y2HSk72
	 B2FJyRUq2Pk61nxYjlapRLpt55RTOJzLXe9LR+u1866/YBQpVmSxhX2EjcneIbnnae
	 TORuIAL28sy47M2WGMIBmvESZCTMzkMIvovHHkeAfrkbYhApvlBJI9zJov5LM/F814
	 xNwre0q1DDDUcguFA2c8UfG+KYNxzCp9ep+VasRBLpDbP9oeiyUm7K8BOfbxbiprSD
	 +7YrmqIp+GQNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1776074372; x=1776334872; i=yann.dirson@vates.tech;
	bh=UwPEUWVCAf3wFNiyyNveriV7FhqJXMVNLXYmrR4wg4k=;
	h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=wvidtTLOwCWTX/EOL6wkI2i39NuS9+mKOE1FlM04ZD/uNr2syUG0S/PEyscPNYwaR
	 kkvM8WJbpISCMTvQ0un54m/lspxenxiFliPds5hQ6jyDcroDbHDzNVi/zhLnU6T5cE
	 CLSl8MGqKnoCN/99Bqd/bWQW43ptkXA2M2eyPWLtmvLwzYni4Ixn/oBcoo9C31NnQT
	 cHfBt1kFLYUhnrpTg3t5Lmm+DjvKDzXEDQ47Sk2k5DQcUKdU8jAKo009ZpO1NFhoyi
	 N4nqT6TNxNU3R8HgRSzO+EXdmNOE/ZAIrcbQDewY0zNXlzMyc5D7qIcxrnnxtqAed4
	 JsLdpWbSk3BqA==
Received: from pmta09.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail187-14.suw11.mandrillapp.com (Mailchimp) with ESMTP id 4fvNDN4SvMz8XS2dY
	for <bitbake-devel@lists.openembedded.org>; Mon, 13 Apr 2026 09:59:32 +0000 (GMT)
From: "Yann Dirson" <yann.dirson@vates.tech>
Subject: =?utf-8?Q?[PATCH=203/3]=20goh1=5Ffile:=20deal=20with=20false=20positives=20from=20is=5Fzipfile?=
Received: from [37.26.189.201] by mandrillapp.com id db4c095609a740e7b2c7182ba3bb2136; Mon, 13 Apr 2026 09:59:32 +0000
X-Mailer: git-send-email 2.47.3
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1776074372058
To: bitbake-devel@lists.openembedded.org
Cc: "Yann Dirson" <yann.dirson@vates.tech>
Message-Id: <20260413095918.20804-3-yann.dirson@vates.tech>
In-Reply-To: <20260413095918.20804-1-yann.dirson@vates.tech>
References: <20260413095918.20804-1-yann.dirson@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.db4c095609a740e7b2c7182ba3bb2136?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260413:md
Date: Mon, 13 Apr 2026 09:59:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Apr 2026 09:59:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19362

This function is known https://github.com/python/cpython/issues/72680 for
false-positives.  With python 3.13.5 there is one with
https://vault.almalinux.org/10.0/CRB/x86_64_v2/os/Packages/jdom2-2.0.6.1-8.el10.noarch.rpm

The double "is_zipfile = False" is redundant but likely more clear.

Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
---
 lib/bb/utils.py | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 366836bfc..aeeb3f2ee 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -694,14 +694,19 @@ def goh1_file(filename):
     import zipfile
 
     lines = []
+    is_zipfile = False
     if zipfile.is_zipfile(filename):
-        with zipfile.ZipFile(filename) as archive:
-            for fn in sorted(archive.namelist()):
-                method = hashlib.sha256()
-                method.update(archive.read(fn))
-                hash = method.hexdigest()
-                lines.append("%s  %s\n" % (hash, fn))
-    else:
+        try:
+            with zipfile.ZipFile(filename) as archive:
+                for fn in sorted(archive.namelist()):
+                    method = hashlib.sha256()
+                    method.update(archive.read(fn))
+                    hash = method.hexdigest()
+                    lines.append("%s  %s\n" % (hash, fn))
+            is_zipfile = True
+        except zipfile.BadZipFile:
+            is_zipfile = False
+    if not is_zipfile:
         hash = _hasher(hashlib.sha256(), filename)
         lines.append("%s  go.mod\n" % hash)
     method = hashlib.sha256()
-- 
2.47.3



--
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


