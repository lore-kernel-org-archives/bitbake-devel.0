Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T3qFD-0007Oe-Hh
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 17:19:51 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by fmsmga102.fm.intel.com with ESMTP; 21 Aug 2012 08:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,802,1336374000"; d="scan'208";a="136534556"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.105])
	by AZSMGA002.ch.intel.com with ESMTP; 21 Aug 2012 08:07:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Aug 2012 16:07:37 +0100
Message-Id: <1345561657-5784-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: hob: create console log directory before writing
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
X-List-Received-Date: Tue, 21 Aug 2012 15:19:51 -0000

The default value of BB_CONSOLELOG in OE-Core now points to a directory
that might not exist prior to the first build, so ensure it is created
first.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index cb2338e..611024a 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1312,6 +1312,7 @@ class Builder(gtk.Window):
 
     def do_log(self, consolelogfile = None):
         if consolelogfile:
+            bb.utils.mkdirhier(os.path.dirname(consolelogfile))
             if self.consolelog:
                 self.logger.removeHandler(self.consolelog)
                 self.consolelog = None
-- 
1.7.9.5



