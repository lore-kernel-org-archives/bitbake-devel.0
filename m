Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Rl3Vf-0005TC-GU
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 20:06:55 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 11 Jan 2012 10:30:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="94833008"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.95])
	by azsmga001.ch.intel.com with ESMTP; 11 Jan 2012 10:30:57 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jan 2012 18:30:50 +0000
Message-Id: <f091b69c50ec75e3da81fbd8677116c1377de380.1326306561.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326306561.git.paul.eggleton@linux.intel.com>
References: <cover.1326306561.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326306561.git.paul.eggleton@linux.intel.com>
References: <cover.1326306561.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] bitbake: make warning for initial fetch failure one line
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
X-List-Received-Date: Wed, 11 Jan 2012 19:06:55 -0000

Instead of printing the full fetch command and output for the initial
fetch failure, just print a one-liner containing the URL. If the user
needs more detail the full version is still output as a debug message
which will go into the log.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index b76358d..80cef3f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -977,7 +977,8 @@ class Fetch(object):
                         raise
 
                     except BBFetchException as e:
-                        logger.warn(str(e))
+                        logger.warn('Failed to fetch URL %s' % u)
+                        logger.debug(1, str(e))
                         # Remove any incomplete fetch
                         if os.path.isfile(ud.localpath):
                             bb.utils.remove(ud.localpath)
-- 
1.7.5.4



