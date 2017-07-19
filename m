Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 0545A78223
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:51 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410431"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:53 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:10 +0200
Message-Id: <24ad6b654f8eed7a5c9f271fb7247204eda4ac7b.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 11/12] fetch2: allow hiding checksum warning
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:52 -0000

If BB_STRICT_CHECKSUMS is set to "ignore" then don't display a warning
if no checksums are specified in the recipe. This is not intended to be
used from recipes - it is needed when we move to using more standard
code paths to fetch new files from scripts i.e. where we don't know what
the checksums are in advance.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5c02317..2e615b2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -584,6 +584,12 @@ def verify_checksum(ud, d, precomputed={}):
                               ud.sha256_name, sha256data))
             raise NoChecksumError('Missing SRC_URI checksum', ud.url)
 
+        if strict == "ignore":
+            return {
+                _MD5_KEY: md5data,
+                _SHA256_KEY: sha256data
+            }
+
         # Log missing sums so user can more easily add them
         logger.warning('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
                        'SRC_URI[%s] = "%s"',
-- 
2.9.4


