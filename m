Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SFqIT-0007nt-Hk
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 19:16:33 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 05 Apr 2012 10:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85747409"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.33])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Apr 2012 10:07:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Apr 2012 18:07:18 +0100
Message-Id: <1333645638-9195-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH] lib/bb/fetch2: don't skip checksums when local mirror enabled
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 05 Apr 2012 17:16:33 -0000

If you have PREMIRRORS set up to point to a local directory, the local
download function does nothing and always succeeds and the mirror code
was writing a .done stamp regardless, thus the checksum verification was
being skipped even if the file wasn't actually copied from the mirror.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e5c4b34..414cc2b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -476,9 +476,10 @@ def try_mirrors(d, origud, mirrors, check = False):
 
             if not os.path.exists(ud.donestamp) or ud.method.need_update(newuri, ud, ld):
                 ud.method.download(newuri, ud, ld)
-                open(ud.donestamp, 'w').close()
-                if hasattr(ud.method,"build_mirror_data"):
-                    ud.method.build_mirror_data(newuri, ud, ld)
+                if os.path.exists(ud.localpath):
+                    open(ud.donestamp, 'w').close()
+                    if hasattr(ud.method,"build_mirror_data"):
+                        ud.method.build_mirror_data(newuri, ud, ld)
 
             if not ud.localpath or not os.path.exists(ud.localpath):
                 continue
-- 
1.7.5.4



