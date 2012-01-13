Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RlkeA-0006Wv-3X
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 18:10:34 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jan 2012 09:01:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="98177327"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.110])
	by orsmga002.jf.intel.com with ESMTP; 13 Jan 2012 09:01:55 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 17:01:45 +0000
Message-Id: <081cab9c738ab2c91b7f6e76c5f8ccb0638e4593.1326473488.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/8] bitbake/knotty: don't count errors as warnings in summary
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
X-List-Received-Date: Fri, 13 Jan 2012 17:10:34 -0000

The count of warnings being shown in the summary at the end was also
including the number of errors.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/knotty.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 0340619..5366386 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -127,7 +127,7 @@ def main(server, eventHandler):
                 if event.levelno >= format.ERROR:
                     errors = errors + 1
                     return_value = 1
-                if event.levelno >= format.WARNING:
+                elif event.levelno == format.WARNING:
                     warnings = warnings + 1
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to 
-- 
1.7.5.4



