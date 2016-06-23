Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C73D4731AC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 10:59:47 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 23 Jun 2016 03:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,516,1459839600"; d="scan'208";a="723878747"
Received: from clim19-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.149.148])
	by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2016 03:59:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jun 2016 22:59:03 +1200
Message-Id: <640803dc036c9188965dc262f9f0540627c92b3d.1466679280.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 01/10] knotty: provide a symlink to the latest console log
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
X-List-Received-Date: Thu, 23 Jun 2016 10:59:47 -0000

If you're looking to find the latest console log repeatedly it can be a bit
tedious - let's just create a symlink just as we do with other logs to
make it easy to find.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 9605c8e..ddd36d5 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -287,6 +287,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         bb.msg.addDefaultlogFilter(consolelog)
         consolelog.setFormatter(conlogformat)
         logger.addHandler(consolelog)
+        loglink = os.path.join(os.path.dirname(consolelogfile), 'console-latest.log')
+        bb.utils.remove(loglink)
+        try:
+           os.symlink(os.path.basename(consolelogfile), loglink)
+        except OSError:
+           pass
 
     llevel, debug_domains = bb.msg.constructLogOptions()
     server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
-- 
2.5.5


