Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SJucc-0007PL-DO
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 00:42:10 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 16 Apr 2012 15:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="89755536"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.96])
	by AZSMGA002.ch.intel.com with ESMTP; 16 Apr 2012 15:31:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 23:31:58 +0100
Message-Id: <1334615518-6809-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH] bitbake-layers: hide deprecation warnings
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
X-List-Received-Date: Mon, 16 Apr 2012 22:42:10 -0000

There are a number of DeprecationWarnings within BitBake code which
bitbake itself filters out; bitbake-layers was not doing this, resulting
in a stream of warnings printed out when used with Python < 2.7 (these
warnings default to disabled on version 2.7 and above.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index bbd56fe..6d35386 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -9,6 +9,7 @@
 
 import cmd
 import logging
+import warnings
 import os
 import sys
 import fnmatch
@@ -28,6 +29,7 @@ import bb.fetch2
 
 logger = logging.getLogger('BitBake')
 
+warnings.filterwarnings("ignore", category=DeprecationWarning)
 
 def main(args):
     # Set up logging
-- 
1.7.5.4



