Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A42C433EF
	for <webhook@archiver.kernel.org>; Fri, 31 Dec 2021 00:22:04 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mx.groups.io with SMTP id smtpd.web11.5667.1640910121693805729
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Dec 2021 16:22:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=B9vWeQGB;
 spf=pass (domain: intel.com, ip: 134.134.136.100,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640910123; x=1672446123;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=308V58jMGsDLIKKuaQqKpJV4o8XPsN5t6Ys1IUK34Rg=;
  b=B9vWeQGBvGS0mg35TqBEzeLPDtk85R0Eq+z5U8PmLxX+aIUiBmHQGoct
   pK79I8EjqdP3ri6yuU3jipm9wzUtYUMcRRZD5J1idqVfbaGrJ5Lvz72Rw
   nKn99kvrBuG2Eczd5/wvNBpU/d9+ZIz8tIhJdFBKPe30h55BUWPkh/7jd
   B/Km3AOsj4zY0nolLeCmgmZttDMxMIqAxFW+IM+R/yZ1Vc12fAqlKjlT0
   hoh8fjqqnN39ZfCA/8KR1ekCD1+8m+8ubwByLu8B6pm6LrqeMqOaD82YW
   bZdwRp3t0sZP0T/Zt8Fldlg3AGqfgIRdtcNlPvGspM1FUxwfJzADzjwBW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="305110476"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="305110476"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:22:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="468943770"
Received: from jiayingk-mobl2.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.231.141])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:22:02 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 2/4] fetch: npm: Quote destdir in run chmod command
Date: Fri, 31 Dec 2021 08:21:53 +0800
Message-Id: 
 <e5b8983bec98b33dab2706575b9e7763c102f720.1640910042.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640910042.git.anuj.mittal@intel.com>
References: <cover.1640910042.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Dec 2021 00:22:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13206

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Quote destdir in run chmod command to support special characters in
package name and to avoid syntax error for packages like
'@(._.)/execute'.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a701dfce3f0e74b4d7c687eeda83fe9c8e7240b1)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e497c38d..d9daec20 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -72,7 +72,7 @@ def npm_unpack(tarball, destdir, d):
     cmd += " --delay-directory-restore"
     cmd += " --strip-components=1"
     runfetchcmd(cmd, d, workdir=destdir)
-    runfetchcmd("chmod -R +X %s" % (destdir), d, quiet=True, workdir=destdir)
+    runfetchcmd("chmod -R +X '%s'" % (destdir), d, quiet=True, workdir=destdir)
 
 class NpmEnvironment(object):
     """
-- 
2.33.1


