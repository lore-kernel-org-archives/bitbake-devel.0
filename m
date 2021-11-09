Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517EEC433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 14:50:42 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web12.13084.1636469435357316700
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 06:50:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="293287550"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="293287550"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="588760042"
Received: from chinboon-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.234.207])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:39 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 4/7] tests/fetch: Update pcre.org address after github
 changes
Date: Tue,  9 Nov 2021 22:50:25 +0800
Message-Id: 
 <5279652a6cb2164e7f0571055cdece8b76ad7569.1636469164.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1636469164.git.anuj.mittal@intel.com>
References: <cover.1636469164.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 14:50:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12977

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
index 25abf67ac..7edbf50b5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1136,7 +1136,7 @@ class SVNTest(FetcherTest):
 
         bb.process.run("svn co %s svnfetch_co" % self.repo_url, cwd=self.tempdir)
         # Github will emulate SVN.  Use this to check if we're downloding...
-        bb.process.run("svn propset svn:externals 'bitbake svn://vcs.pcre.org/pcre2/code' .",
+        bb.process.run("svn propset svn:externals 'bitbake https://github.com/PhilipHazel/pcre2.git' .",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
         bb.process.run("svn commit --non-interactive -m 'Add external'",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
-- 
2.31.1


