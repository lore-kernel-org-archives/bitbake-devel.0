Return-Path: <preeti.sachan@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F46CC6FD18
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 16:02:46 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web10.350.1680105760255887767
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Mar 2023 09:02:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel header.b=V2A8lCYF;
 spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: preeti.sachan@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680105760; x=1711641760;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KcHpwCJdB37TWTVwZbCAUJXJPCFsHYwSINHoSMCu3rs=;
  b=V2A8lCYFzeEG7hkus8ZGi7nLkePqlYB/nZGxNjOuwAPcBJ0yc2ZHSoDs
   R/mb/NHXn7AhybDeUp5xOo/X0qbqyCI64qJuv4dIb4SnO2kqsyGsIi9mp
   V2EYATQaU7VdibkdmRYK+c8FkiGP6N+Yp+GKF659cJFM78mjWhldHhocU
   G93SBH5GpIFCuce4iKudblnHvwYRWpATD6zirnlUsGX7whEUsTiU7/T9R
   R+pr4d5wA7+IESF8fOmOCAcuK0bZaTxW4kV2nNvfIEJDyWSqb5wK4nsmw
   YB8l3wR5blce4zPBELMoujJf9/OJR7MiDYXk1XctVaIvR//4g8++pMJLW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368693662"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="368693662"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 09:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="684335435"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="684335435"
Received: from preeti-ilbpg12.png.intel.com ([10.88.229.42])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2023 09:02:28 -0700
From: preeti.sachan@intel.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH] fetch/git: Fix local clone url to make it work with repo
Date: Wed, 29 Mar 2023 12:00:44 -0400
Message-Id: <20230329160044.3302416-1-preeti.sachan@intel.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Mar 2023 16:02:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14627

From: Robert Yang <liezhi.yang@windriver.com>

The "git clone /path/to/git/objects_symlink" couldn't work after the following
change:

https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f14c38d56

But repo command manages the git repo as symlinks, so check whether the objects
is an symlink to fix the problem:

* Nothing is changed if git/objects is not a symlink
* Use "git clone file://" when git/objects is a symlink

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4e286ca9..4d6e57ad 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -359,9 +359,13 @@ class Git(FetchMethod):
 
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
-            # We do this since git will use a "-l" option automatically for local urls where possible
+            # We do this since git will use a "-l" option automatically for local urls where possible,
+            # but it doesn't work when git/objects is a symlink, only works when it is a directory.
             if repourl.startswith("file://"):
-                repourl = repourl[7:]
+                repourl_path = repourl[7:]
+                objects = os.path.join(repourl_path, 'objects')
+                if os.path.isdir(objects) and not os.path.islink(objects):
+                    repourl = repourl_path
             clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
-- 
2.40.0


