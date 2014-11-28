Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C17577230F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Nov 2014 15:37:21 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 28 Nov 2014 07:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,477,1413270000"; d="scan'208";a="615532364"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.148])
	by orsmga001.jf.intel.com with ESMTP; 28 Nov 2014 07:37:21 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Nov 2014 09:37:18 -0600
Message-Id: <daf206381d14c61ecc24cebcd2b1c2a0597f7193.1417134564.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93c67ae299dadff6103e722327e053697afeab7.1417134564.git.anibal.limon@linux.intel.com>
References: <c93c67ae299dadff6103e722327e053697afeab7.1417134564.git.anibal.limon@linux.intel.com>
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 11/12] tests/fetch.py: Update wget latest_versionstring cups case
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
X-List-Received-Date: Fri, 28 Nov 2014 15:37:21 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update test case for cups is needed because match only 2.0.0
versions see VERSION=2\.0\.0 in the previous string.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bitbake/lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 9d45743..3f80c4a 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -619,7 +619,7 @@ class FetchMethodTest(FetcherTest):
         ("xserver-xorg", "http://xorg.freedesktop.org/releases/individual/xserver/xorg-server-1.15.1.tar.bz2", "", "")
             : "1.15.1",
         # packages with valid REGEX_URI and REGEX
-        ("cups", "http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2", "http://www.cups.org/software.php", "/software\.php\?VERSION=2\.0\.0&FILE=2\.0\.0/(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
+        ("cups", "http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2", "http://www.cups.org/software.php", "(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
             : "2.0.0",
         ("db", "http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz", "http://www.oracle.com/technetwork/products/berkeleydb/downloads/index-082944.html", "http://download.oracle.com/otn/berkeley-db/(?P<name>db-)(?P<pver>((\d+[\.\-_]*)+))\.tar\.gz")
             : "6.1.19",
-- 
1.9.1


