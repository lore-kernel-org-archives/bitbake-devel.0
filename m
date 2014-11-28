Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D24DE72318
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Nov 2014 15:37:21 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 28 Nov 2014 07:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,477,1413270000"; d="scan'208";a="615532369"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.148])
	by orsmga001.jf.intel.com with ESMTP; 28 Nov 2014 07:37:21 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Nov 2014 09:37:19 -0600
Message-Id: <d4fffe492923c1102334251cf872ce7d30346a90.1417134564.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93c67ae299dadff6103e722327e053697afeab7.1417134564.git.anibal.limon@linux.intel.com>
References: <c93c67ae299dadff6103e722327e053697afeab7.1417134564.git.anibal.limon@linux.intel.com>
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 12/12] fetch2/wget.py: latest_versionstring clean improvments minor
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

Update documentation strings in _check_latest_dir and _check_latest_version
methods with  the correct return types.

_check_latest_version method remove unused testversion variable.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 7841553..d82e78c 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -192,7 +192,7 @@ class Wget(FetchMethod):
     def _check_latest_dir(self, url, versionstring, ud, d):
         """
         Return the name of the directory with the greatest package version
-        If error or no version, return ""
+        If error or no version, return None
         """
         bb.debug(3, "DirURL: %s, %s" % (url, versionstring))
         soup = BeautifulSoup(self._fetch_index(url, ud, d))
@@ -230,7 +230,7 @@ class Wget(FetchMethod):
     def _check_latest_version(self, url, package, current_version, ud, d):
         """
         Return the latest version of a package inside a given directory path
-        If error or no version, return ""
+        If error or no version, return None
         """
         valid = 0
         version = ('', '', '')
@@ -243,7 +243,6 @@ class Wget(FetchMethod):
 
         pn_regex = d.getVar('REGEX', True)
         if pn_regex:
-            testversion = version
             pn_regex = re.compile(pn_regex)
             bb.debug(3, "pn_regex = '%s'" % (pn_regex.pattern))
             
-- 
1.9.1


