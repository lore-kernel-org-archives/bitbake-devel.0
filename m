Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id C7C4B65C78
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 23:32:16 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 08 Jul 2015 16:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,435,1432623600"; d="scan'208";a="521077053"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.155])
	by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2015 16:32:16 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 18:34:20 -0500
Message-Id: <1436398461-26014-7-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1436398461-26014-1-git-send-email-anibal.limon@linux.intel.com>
References: <1436398461-26014-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <limon.anibal@gmail.com>
Subject: [PATCHv4 6/7] tests/fetch.py: FetchCheckStatusTest add cases for ftp and https.
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
X-List-Received-Date: Wed, 08 Jul 2015 23:32:18 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aníbal Limón <limon.anibal@gmail.com>

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/tests/fetch.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1132af5..13555bd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -719,8 +719,14 @@ class FetchCheckStatusTest(FetcherTest):
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.3.tar.gz",
+                      "https://yoctoproject.org/",
+                      "https://yoctoproject.org/documentation",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
-                      "http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz"]
+                      "http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
+                      "ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
+                      "ftp://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
+                      "ftp://ftp.gnu.org/gnu/gmp/gmp-4.0.tar.gz",
+                      ]
 
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
         print("Unset BB_SKIP_NETTESTS to run network tests")
-- 
1.9.1


