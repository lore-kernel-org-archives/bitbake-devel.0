Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RmoBF-0002xR-Bl
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Jan 2012 16:09:05 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 16 Jan 2012 07:01:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="96995175"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.171])
	by orsmga001.jf.intel.com with ESMTP; 16 Jan 2012 07:01:13 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Jan 2012 15:01:08 +0000
Message-Id: <b806660e895fe6160d7e6cd527709879d4f6cd21.1326725777.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326725777.git.paul.eggleton@linux.intel.com>
References: <cover.1326725777.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326725777.git.paul.eggleton@linux.intel.com>
References: <cover.1326725777.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake/fetch2: allow resuming interrupted fetch
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
X-List-Received-Date: Mon, 16 Jan 2012 15:09:05 -0000

A lot of our checks in the fetcher code assume that if the downloaded
file exists, the download finished successfully; this meant that if
BitBake was interrupted in the middle of a fetch then it would not
resume the fetch the next time, but instead attempt to use the
half-fetched file and usually fail as a result.

Since we're already writing a ".done" stamp file when a fetch completes,
just check for its existence and assume the download didn't complete
successfully if it isn't present.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index fe4f4b1..07aac4c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -479,7 +479,7 @@ def try_mirrors(d, origud, mirrors, check = False):
                     return found
                 continue
 
-            if ud.method.need_update(newuri, ud, ld):
+            if not os.path.exists(ud.donestamp) or ud.method.need_update(newuri, ud, ld):
                 ud.method.download(newuri, ud, ld)
                 if hasattr(ud.method,"build_mirror_data"):
                     ud.method.build_mirror_data(newuri, ud, ld)
@@ -955,7 +955,7 @@ class Fetch(object):
             try:
                 self.d.setVar("BB_NO_NETWORK", network)
  
-                if not m.need_update(u, ud, self.d):
+                if os.path.exists(ud.donestamp) and not m.need_update(u, ud, self.d):
                     localpath = ud.localpath
                 elif m.try_premirror(u, ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
@@ -966,7 +966,7 @@ class Fetch(object):
                     self.d.setVar("BB_NO_NETWORK", "1")
 
                 firsterr = None
-                if not localpath and m.need_update(u, ud, self.d):
+                if not localpath and ((not os.path.exists(ud.donestamp)) or m.need_update(u, ud, self.d)):
                     try:
                         logger.debug(1, "Trying Upstream")
                         m.download(u, ud, self.d)
-- 
1.7.5.4



