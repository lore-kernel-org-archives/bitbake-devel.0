Received: from mga14.intel.com (mga14.intel.com [])
 by mx.groups.io with SMTP id smtpd.web11.2273.1619407679873857581
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Apr 2021 20:28:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: 4DVWgB+lPM/CLY8A0uli16uVvK7qUat0CAKHcie7wOKCaZy0YCrkyGlF2sKpHIm9k59XuauYRq
 BOnMe2g8Farw==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="195828065"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="195828065"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:28:05 -0700
IronPort-SDR: iD9PGV9SjNy25i2CTTCIOC86l4pDth9bqK5zy4QqUc06ABzvugUjvfQwzvwllgW13TnelvXcjn
 m6em2a60MKnw==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="464923245"
Received: from wsan-mobl1.ccr.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.45.138])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:28:04 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 5/5] fetch/gitsm: Fix crash when using git LFS and submodules
Date: Mon, 26 Apr 2021 11:27:52 +0800
Message-Id: <d03dc4b3ec98addf391bf204af99b8e43bdc2a6f.1619407547.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619407547.git.anuj.mittal@intel.com>
References: <cover.1619407547.git.anuj.mittal@intel.com>
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
index e3ba80a3f..cf7424ebf 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -394,7 +394,7 @@ class Git(FetchMethod):
             tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
             try:
                 # Do the checkout. This implicitly involves a Git LFS fetch.
-                self.unpack(ud, tmpdir, d)
+                Git.unpack(self, ud, tmpdir, d)
 
                 # Scoop up a copy of any stuff that Git LFS downloaded. Merge them into
                 # the bare clonedir.
-- 
2.30.2

