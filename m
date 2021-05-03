Received: from mga09.intel.com (mga09.intel.com [])
 by mx.groups.io with SMTP id smtpd.web08.34519.1620052568707992183
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 May 2021 07:36:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: eZoWLEmX7d98bWWbh5jLQezN1OnRlnD21ekgv/Al8CZRtp03bEhsatQP86Ia6KngOZ0QVn+eAZ
 a7hLzuQ8mYIw==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197849362"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="197849362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:36:09 -0700
IronPort-SDR: fyooikKOOU4eFVOLy/9hQpp79Mqe9G6v1DbxMN16dCJUrCiZphOURZwHmL44QTxQ20VDNv+K2f
 +Dx/YepaBU2w==
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="405696791"
Received: from semohdyu-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.249.72.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:36:08 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 3/3] fetch/gitsm: Fix crash when using git LFS and submodules
Date: Mon,  3 May 2021 22:35:54 +0800
Message-Id: <b2ebbac82a8c319d934261449133d399fc17d8c1.1620052467.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620052467.git.anuj.mittal@intel.com>
References: <cover.1620052467.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niels Avonds <niels@codebits.be>

Gitsm fetcher crashes when cloning a repository that contains LFS files.
This happens because the unpack method is called during download, but the
submodules have not been downloaded yet at this point.

This issue was introduced in this
commit: 977b7268bf4fd425cb86d4a57500350c9b829162

[YOCTO #14283]

Signed-off-by: Niels Avonds <niels@codebits.be>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 26caedc4d2e9b5a0f1d57f9291754a7f6c5e437e)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b59a7cdc8..21ef85a2a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -389,7 +389,7 @@ class Git(FetchMethod):
             tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
             try:
                 # Do the checkout. This implicitly involves a Git LFS fetch.
-                self.unpack(ud, tmpdir, d)
+                Git.unpack(self, ud, tmpdir, d)
 
                 # Scoop up a copy of any stuff that Git LFS downloaded. Merge them into
                 # the bare clonedir.
-- 
2.30.2

