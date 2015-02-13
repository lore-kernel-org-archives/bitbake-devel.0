Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 190F273471
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Feb 2015 21:58:20 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 13 Feb 2015 13:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,573,1418112000"; d="scan'208";a="677724302"
Received: from unknown (HELO alimon-ThinkPad-W540.zpn.intel.com)
	([10.219.4.49])
	by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2015 13:58:16 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Feb 2015 15:58:12 -0600
Message-Id: <1423864694-24940-6-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
References: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 5/7] fetch2: wget _modelate_version improvments
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
X-List-Received-Date: Fri, 13 Feb 2015 21:58:21 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix sustition for rc, beta and alpha releses from -N to N weight.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 809e9fc..570bd47 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -143,9 +143,9 @@ class Wget(FetchMethod):
 
         version = re.sub('\-', '.', version)
         version = re.sub('_', '.', version)
-        version = re.sub('(rc)+', '.-1.', version)
-        version = re.sub('(alpha)+', '.-3.', version)
-        version = re.sub('(beta)+', '.-2.', version)
+        version = re.sub('(rc)+', '.1000.', version)
+        version = re.sub('(beta)+', '.100.', version)
+        version = re.sub('(alpha)+', '.10.', version)
         if version[0] == 'v':
             version = version[1:len(version)]
         return version
-- 
1.9.1


