Return-Path: <anibal.limon@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B0F94725F0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Jan 2015 23:34:22 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 19 Jan 2015 15:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,430,1418112000"; d="scan'208";a="672493699"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.161])
	by orsmga002.jf.intel.com with ESMTP; 19 Jan 2015 15:34:22 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Jan 2015 17:34:25 -0600
Message-Id: <1421710465-16610-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] bb/fetch2/wget.py: latest_versionstring escape packagename when built regex
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
X-List-Received-Date: Mon, 19 Jan 2015 23:34:31 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When built package regex for use in searching upstream version in sites,
the package name need to be escaped to avoid usage of special regex
char.

For example when search for gtk+, '+' need to be escaped.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index b081b76..9e4b443 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -328,7 +328,7 @@ class Wget(FetchMethod):
         if version:
             package_custom_regex_comp = re.compile(
                 "(?P<name>%s)(?P<ver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)$" %
-                (version[0], pver_regex, parch_regex, psuffix_regex))
+                (re.escape(version[0]), pver_regex, parch_regex, psuffix_regex))
 
         return package_custom_regex_comp
 
-- 
1.9.1


