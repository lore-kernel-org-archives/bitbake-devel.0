Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 54053731A3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Dec 2015 18:39:15 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 31 Dec 2015 10:39:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,504,1444719600"; d="scan'208";a="872546475"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 31 Dec 2015 10:39:17 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id E1ED06A4087;
	Thu, 31 Dec 2015 11:27:14 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Dec 2015 18:42:15 +0200
Message-Id: <1451580136-29714-4-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1451580136-29714-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1451580136-29714-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 3/4] uievent: get rid of EventHandler attribute
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
X-List-Received-Date: Thu, 31 Dec 2015 18:39:17 -0000

This attribute was introduced by mistake. EventHandle is used in the
code for the same purpose.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>

diff --git a/bitbake/lib/bb/ui/uievent.py b/bitbake/lib/bb/ui/uievent.py
index 80686a6..a900555 100644
--- a/bitbake/lib/bb/ui/uievent.py
+++ b/bitbake/lib/bb/ui/uievent.py
@@ -44,14 +44,14 @@ class BBUIEventQueue:
         server.register_function( self.send_event, "event.sendpickle" )
         server.socket.settimeout(1)
 
-        self.EventHandler = None
+        self.EventHandle = None
         count_tries = 0
 
         # the event handler registration may fail here due to cooker being in invalid state
         # this is a transient situation, and we should retry a couple of times before
         # giving up
 
-        while self.EventHandler == None and count_tries < 5:
+        while self.EventHandle == None and count_tries < 5:
             self.EventHandle, error = self.BBServer.registerEventHandler(self.host, self.port)
 
             if (self.EventHandle != None):
-- 
2.1.4


