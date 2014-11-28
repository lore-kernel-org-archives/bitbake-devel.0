Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 08503723C5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Nov 2014 01:12:21 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 27 Nov 2014 17:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,691,1406617200"; d="scan'208";a="491044051"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.148])
	by orsmga003.jf.intel.com with ESMTP; 27 Nov 2014 17:09:15 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 19:12:01 -0600
Message-Id: <f3b0a27949c58323f9da18454aeeade321866fcd.1417134564.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 03/12] fetch2/wget.py: latest_versionstring create _init_regex method for have one place when regex'es are defined
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
X-List-Received-Date: Fri, 28 Nov 2014 01:12:22 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index db5f27b..687d494 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -273,12 +273,9 @@ class Wget(FetchMethod):
         if valid and version:
             return re.sub('_', '.', version[1])
 
-    def latest_versionstring(self, ud, d):
+    def _init_regexes(self):
         """
-        Manipulate the URL and try to obtain the latest package version
-
-        sanity check to ensure same name and type. Match as many patterns as possible
-        such as:
+        Match as many patterns as possible such as:
                 gnome-common-2.20.0.tar.gz (most common format)
                 gtk+-2.90.1.tar.gz
                 xf86-input-synaptics-12.6.9.tar.gz
@@ -310,10 +307,18 @@ class Wget(FetchMethod):
         # match name, version and archive type of a package
         self.name_version_type_regex = re.compile("(?P<name>%s?)\.?v?(?P<ver>%s)(\-source)?[\.\-](?P<type>%s$)" % (self.pn_regex, version_regex, suffixlist))
 
+    def latest_versionstring(self, ud, d):
+        """
+        Manipulate the URL and try to obtain the latest package version
+
+        sanity check to ensure same name and type.
+        """
         regex_uri = d.getVar("REGEX_URI", True)
         newpath = ud.path
         pupver = ""
 
+        self._init_regexes()
+
         # search for version matches on folders inside the path, like:
         # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
         m = re.search("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/", ud.path)
-- 
1.9.1


