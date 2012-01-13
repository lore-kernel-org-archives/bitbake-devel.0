Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RlkeD-0006X6-EN
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 18:10:38 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jan 2012 09:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="98177346"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.110])
	by orsmga002.jf.intel.com with ESMTP; 13 Jan 2012 09:01:59 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 17:01:50 +0000
Message-Id: <cb29a5510ffabad6148e706979e87218d8c9c4b2.1326473488.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 6/8] bitbake/fetch2: reduce output for fetch failures
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
X-List-Received-Date: Fri, 13 Jan 2012 17:10:38 -0000

Make the warning for the initial fetch failure a single line - we don't
need the full command and output here yet, but write it into the log in
full as a debug message. However, if fetching from mirrors fails as well
then print out the full details for the first error that occurred as an
ERROR rather than a WARNING.

Since this is logged as an ERROR, combined with an earlier patch it
suppresses the full log which does make the output much more readable
for any fetch error.

Fixes [YOCTO #1832].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 771f72e..fe4f4b1 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -965,6 +965,7 @@ class Fetch(object):
                 if premirroronly:
                     self.d.setVar("BB_NO_NETWORK", "1")
 
+                firsterr = None
                 if not localpath and m.need_update(u, ud, self.d):
                     try:
                         logger.debug(1, "Trying Upstream")
@@ -980,7 +981,9 @@ class Fetch(object):
                         raise
 
                     except BBFetchException as e:
-                        logger.warn(str(e))
+                        logger.warn('Failed to fetch URL %s' % u)
+                        logger.debug(1, str(e))
+                        firsterr = e
                         # Remove any incomplete fetch
                         if os.path.isfile(ud.localpath):
                             bb.utils.remove(ud.localpath)
@@ -989,6 +992,8 @@ class Fetch(object):
                         localpath = try_mirrors (self.d, ud, mirrors)
 
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
+                    if firsterr:
+                        logger.error(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
                 update_stamp(u, ud, self.d)
-- 
1.7.5.4



