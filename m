Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4296CEE4996
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 01:42:46 +0000 (UTC)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by mx.groups.io with SMTP id smtpd.web11.8262.1692668559376694045
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Aug 2023 18:42:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=UbHPM1zo;
 spf=pass (domain: ti.com, ip: 198.47.19.141, mailfrom: rs@ti.com)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37M1gbUw020536;
	Mon, 21 Aug 2023 20:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692668557;
	bh=Kpl1PxTTs6udVMmma4fl+d8iFMh5VsAzsj9c+Qx5CPA=;
	h=From:To:CC:Subject:Date;
	b=UbHPM1zoY09cLN9wn8uolFIW1AkPPoFgWfH9Wt0IyqB6PFUV2nMRl7cScra7IMD1e
	 IYaWjgC+ncxsBhrp9OawHfr9VJi1FO426VObg24nTs+IT1rB1/gCEmTIJXTNXQVOya
	 mwoKMSZRdvU47RE4Ojo5i+HdCbDreK8r5vSY2K1U=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37M1gbGh045953
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Aug 2023 20:42:37 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Aug 2023 20:42:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Aug 2023 20:42:37 -0500
Received: from rs-desk.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37M1gbQA090828;
	Mon, 21 Aug 2023 20:42:37 -0500
From: <rs@ti.com>
To: <richard.purdie@linuxfoundation.org>
CC: <bitbake-devel@lists.openembedded.org>, Randolph Sapp <rs@ti.com>
Subject: [PATCHv2] gitsm: tolerate git-lfs in submodules
Date: Mon, 21 Aug 2023 20:30:36 -0500
Message-ID: <20230822013035.3185034-2-rs@ti.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Aug 2023 01:42:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14957

From: Randolph Sapp <rs@ti.com>

Explicitly pass down the lfs parameter from the source repo URI to
submodules. Add smudge skip to final checkout phase to make sure we
don't access the network here. Everything should have been fetched and
setup from the lfs logic in the git fetcher at this point.

May address [YOCTO #14938]; needs more testing.

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


