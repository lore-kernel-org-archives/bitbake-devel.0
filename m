Return-Path: <anibal.limon@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id DFDF271AC8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 15:47:28 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga105.fm.intel.com with ESMTP; 14 Oct 2016 08:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,493,1473145200"; d="scan'208";a="179867441"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.32])
	by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2016 08:47:29 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Oct 2016 10:48:39 -0500
Message-Id: <1476460119-13126-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Cc: brian.avery@intel.com, benjamin.esquivel@intel.com
Subject: [PATCHv2] bb.event: fix infinite loop on print_ui_queue
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
X-List-Received-Date: Fri, 14 Oct 2016 15:47:31 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If bitbake ends before _uiready and bb.event.LogHandler was add
to the bitbake logger it causes an infinite loop when logging
something.

The scenario is print_ui_queue is called at exit and executes
the log handlers [2] one of them is bb.event.LogHandler this handler
appends the same entry to ui_queue causing the inifine loop [3].

In order to fix a new copy of the ui_queue list is created when iterate
ui_queue.

[YOCTO #10399]

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=10399#c0
[2] http://git.openembedded.org/bitbake/tree/lib/bb/event.py?id=41d9cd41d40b04746c82b4a940dca47df02514fc#n156
[3]
http://git.openembedded.org/bitbake/tree/lib/bb/event.py?id=41d9cd41d40b04746c82b4a940dca47df02514fc#n164

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/event.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index c5a5f94..6f1cb10 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -139,7 +139,7 @@ def print_ui_queue():
 
         # First check to see if we have any proper messages
         msgprint = False
-        for event in ui_queue:
+        for event in ui_queue[:]:
             if isinstance(event, logging.LogRecord):
                 if event.levelno > logging.DEBUG:
                     if event.levelno >= logging.WARNING:
@@ -153,7 +153,7 @@ def print_ui_queue():
 
         # Nope, so just print all of the messages we have (including debug messages)
         logger.addHandler(stdout)
-        for event in ui_queue:
+        for event in ui_queue[:]:
             if isinstance(event, logging.LogRecord):
                 logger.handle(event)
 
-- 
2.1.4


