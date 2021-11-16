Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EEAC433F5
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 03:32:53 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web12.5172.1637033566840862534
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 19:32:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="257369178"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="257369178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:53 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="506232252"
Received: from jli90-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.214.145.204])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:51 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 6/8] tests/fetch: Update pcre.org address after github
 changes
Date: Tue, 16 Nov 2021 11:32:35 +0800
Message-Id: 
 <3ce3efde167e8cd109659b81275a6935875877eb.1637033341.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637033341.git.anuj.mittal@intel.com>
References: <cover.1637033341.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 03:32:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13054

From: Richard Purdie <richard.purdie@linuxfoundation.org>

vcs.pcre.org was a redirect to github which we use for subversion testing.
With the protocol changes at github and the removal of the redirect, use a
direct address for github.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 6230ca71eb7eb2a6db162e28a01727d00af5299b)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0fb279e8..86eccf7d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1117,7 +1117,7 @@ class SVNTest(FetcherTest):
 
         bb.process.run("svn co %s svnfetch_co" % self.repo_url, cwd=self.tempdir)
         # Github will emulate SVN.  Use this to check if we're downloding...
-        bb.process.run("svn propset svn:externals 'bitbake svn://vcs.pcre.org/pcre2/code' .",
+        bb.process.run("svn propset svn:externals 'bitbake https://github.com/PhilipHazel/pcre2.git' .",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
         bb.process.run("svn commit --non-interactive -m 'Add external'",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
-- 
2.33.1


