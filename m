Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 383E5732CF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Feb 2015 18:13:36 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 10 Feb 2015 10:13:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,551,1418112000"; d="scan'208";a="664422220"
Received: from mjbowe-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.18.120])
	by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2015 10:13:35 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Feb 2015 18:13:23 +0000
Message-Id: <fb1a25f7597004ca3e261c99146337c5872537ca.1423591698.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1423591698.git.paul.eggleton@linux.intel.com>
References: <cover.1423591698.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1423591698.git.paul.eggleton@linux.intel.com>
References: <cover.1423591698.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] utils: ensure explode_dep_versions2 raises an exception on invalid/missing operator
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 10 Feb 2015 18:13:43 -0000

We really want an error rather than the version to just be silently
skipped when the operator is missing (e.g. "somepackage (1.0)" was
specified instead of "somepackage (>= 1.0)".)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 90090b2..7ba1234 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -53,6 +53,9 @@ def set_context(ctx):
 # Context used in better_exec, eval
 _context = clean_context()
 
+class VersionStringException(Exception):
+    """Exception raised when an invalid version specification is found"""
+
 def explode_version(s):
     r = []
     alpha_regexp = re.compile('^([a-zA-Z]+)(.*)$')
@@ -188,6 +191,7 @@ def explode_dep_versions2(s):
                 i = i[1:]
             else:
                 # This is an unsupported case!
+                raise VersionStringException('Invalid version specification in "(%s" - invalid or missing operator' % i)
                 lastcmp = (i or "")
                 i = ""
             i.strip()
-- 
1.9.3


