Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BCC433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 14:16:10 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web12.32718.1635171369772633063
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 07:16:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209759055"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="209759055"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:08 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="634754771"
Received: from syong7-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.249.78.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:06 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 4/9] npmsw: Avoid race condition with multiple npm
 fetchers
Date: Mon, 25 Oct 2021 22:15:51 +0800
Message-Id: 
 <ad822ada5c9abbf580de3efc4f6ee244ec017cee.1635171215.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635171215.git.anuj.mittal@intel.com>
References: <cover.1635171215.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 14:16:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12821

From: Caner Altinbasak <cal@brightsign.biz>

If multiple npmsw fetchers are trying to download the same npm file, one of them
can try to download the file while other is calling verify. npmsw methods gets
called without holding the lock, which causes race conditions in fetching and
verification etc. Lock the lockfile before calling proxy fetcher methods.

Signed-off-by: Caner Altinbasak <cal@brightsign.biz>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit fa39e6689d0f0fff772e1c81682698f4b1587b8a)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/npmsw.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 0c3511d8a..fdecbc6db 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -29,6 +29,8 @@ from bb.fetch2.npm import npm_integrity
 from bb.fetch2.npm import npm_localfile
 from bb.fetch2.npm import npm_unpack
 from bb.utils import is_semver
+from bb.utils import lockfile
+from bb.utils import unlockfile
 
 def foreach_dependencies(shrinkwrap, callback=None, dev=False):
     """
@@ -187,7 +189,9 @@ class NpmShrinkWrap(FetchMethod):
             proxy_ud = ud.proxy.ud[proxy_url]
             proxy_d = ud.proxy.d
             proxy_ud.setup_localpath(proxy_d)
+            lf = lockfile(proxy_ud.lockfile)
             returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
+            unlockfile(lf)
         return returns
 
     def verify_donestamp(self, ud, d):
-- 
2.31.1


