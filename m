Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C09A5722FA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Nov 2014 15:37:20 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 28 Nov 2014 07:34:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,477,1413270000"; d="scan'208";a="615532361"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.148])
	by orsmga001.jf.intel.com with ESMTP; 28 Nov 2014 07:37:20 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Nov 2014 09:37:17 -0600
Message-Id: <c93c67ae299dadff6103e722327e053697afeab7.1417134564.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 10/12] fetch/wget.py: latest_versionstring remove newuri set because is previous set
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
X-List-Received-Date: Fri, 28 Nov 2014 15:37:22 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index f5bdfc7..7841553 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -365,8 +365,6 @@ class Wget(FetchMethod):
         else:
             newuri = newpath
 
-        # generate the new uri with the appropriate latest directory
-        newuri = regex_uri or bb.fetch.encodeurl([ud.type, ud.host, newpath, ud.user, ud.pswd, {}])
         newversion = self._check_latest_version(newuri, package,
                         current_version, ud, d)
         while not newversion:
-- 
1.9.1


