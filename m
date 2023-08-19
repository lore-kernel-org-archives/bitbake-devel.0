Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB312EE49A1
	for <webhook@archiver.kernel.org>; Sat, 19 Aug 2023 00:10:44 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by mx.groups.io with SMTP id smtpd.web10.411.1692403837398847872
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Aug 2023 17:10:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=ng0fm6kd;
 spf=pass (domain: ti.com, ip: 198.47.19.142, mailfrom: rs@ti.com)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37J0AaK7060962;
	Fri, 18 Aug 2023 19:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692403836;
	bh=kDnCwoTuipXnyTHwtlwCtrJHbHAGm8zLOPzDbkW3w6M=;
	h=From:To:CC:Subject:Date;
	b=ng0fm6kdoDlogfEARvrMqaPwlOCKZbt7JYmhymKhGMSQHfR47aslYNN1SgYDh1TZk
	 fCSgZqg5UlQBd2KsZZV+t/06/lbcnfCaztqJSg7g/kn0nyxusdE6U8+uDSxsJMubZn
	 JRnm1VkwHbLycT6nVUDeLu7iS2EvALb7/SVkaMEQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37J0AaE5114720
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Aug 2023 19:10:36 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 19:10:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 19:10:36 -0500
Received: from rs-desk.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37J0AZZC014393;
	Fri, 18 Aug 2023 19:10:35 -0500
From: <rs@ti.com>
To: <richard.purdie@linuxfoundation.org>
CC: <bitbake-devel@lists.openembedded.org>, Randolph Sapp <rs@ti.com>
Subject: [PATCH] gitsm: tolerate git-lfs in submodules
Date: Fri, 18 Aug 2023 19:10:11 -0500
Message-ID: <20230819001011.3226247-1-rs@ti.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Aug 2023 00:10:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14953

From: Randolph Sapp <rs@ti.com>

Explicitly pass down the lfs parameter from the source repo URI to
submodules. Add smudge skip to final checkout phase to make sure we
don't access the network here. Everything should have been fetched and
setup from the lfs logic in the git fetcher at this point.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 lib/bb/fetch2/gitsm.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 47225b97..a87361cc 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -123,6 +123,7 @@ class GitSM(Git):
             url += ";name=%s" % module
             url += ";subpath=%s" % module
             url += ";nobranch=1"
+            url += ";lfs=%s" % self._need_lfs(ud)
             # Note that adding "user=" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git://
             # URL a password is not supported, one have to use one of the
@@ -242,10 +243,12 @@ class GitSM(Git):
         ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
 
         if not ud.bareclone and ret:
-            # All submodules should already be downloaded and configured in the tree.  This simply sets
-            # up the configuration and checks out the files.  The main project config should remain
-            # unmodified, and no download from the internet should occur.
-            runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+            # All submodules should already be downloaded and configured in the tree.  This simply
+            # sets up the configuration and checks out the files.  The main project config should
+            # remain unmodified, and no download from the internet should occur. As such, lfs smudge
+            # should also be skipped as these files were already smudged in the fetch stage if lfs
+            # was enabled.
+            runfetchcmd("GIT_LFS_SKIP_SMUDGE=1 %s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
 
     def implicit_urldata(self, ud, d):
         import shutil, subprocess, tempfile
-- 
2.41.0


