Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Rl3Vh-0005TC-4q
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 20:06:57 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 11 Jan 2012 10:30:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="94832999"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.95])
	by azsmga001.ch.intel.com with ESMTP; 11 Jan 2012 10:30:55 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jan 2012 18:30:48 +0000
Message-Id: <2f0137e4558e924e61a308a9c9b310d37bc6f83b.1326306561.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326306561.git.paul.eggleton@linux.intel.com>
References: <cover.1326306561.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326306561.git.paul.eggleton@linux.intel.com>
References: <cover.1326306561.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] bitbake/knotty: don't count errors as warnings
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
X-List-Received-Date: Wed, 11 Jan 2012 19:06:57 -0000

The count of warnings being shown at the end also included the number
of errors.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/knotty.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 0340619..cd6e0e7 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -127,7 +127,7 @@ def main(server, eventHandler):
                 if event.levelno >= format.ERROR:
                     errors = errors + 1
                     return_value = 1
-                if event.levelno >= format.WARNING:
+                elif event.levelno >= format.WARNING:
                     warnings = warnings + 1
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to 
-- 
1.7.5.4



