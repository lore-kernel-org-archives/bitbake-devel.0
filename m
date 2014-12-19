Return-Path: <andy.voltz@timesys.com>
X-Greylist: delayed 309 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 19 Dec 2014 16:36:45 UTC
Received: from exchange07.timesys.com (exchange07.timesys.com
	[209.114.137.116])
	by mail.openembedded.org (Postfix) with ESMTP id 337B57291F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Dec 2014 16:36:45 +0000 (UTC)
Received: from smarf.timesys.com (192.168.3.76) by exchange07.timesys.com
	(192.168.1.221) with Microsoft SMTP Server id 8.1.436.0;
	Fri, 19 Dec 2014 11:31:38 -0500
From: Andy Voltz <andy.voltz@timesys.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 19 Dec 2014 11:31:37 -0500
Message-ID: <1419006697-2588-2-git-send-email-andy.voltz@timesys.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1419006697-2588-1-git-send-email-andy.voltz@timesys.com>
References: <1419006697-2588-1-git-send-email-andy.voltz@timesys.com>
MIME-Version: 1.0
Subject: [PATCH] update ncurses ui to accept configParams
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
X-List-Received-Date: Fri, 19 Dec 2014 16:36:46 -0000
Content-Type: text/plain

Signed-off-by: Andy Voltz <andy.voltz@timesys.com>
---
 lib/bb/ui/ncurses.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index b6c20ec..9589a77 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -361,13 +361,13 @@ class NCursesUI:
                 shutdown = shutdown + 1
                 pass
 
-def main(server, eventHandler):
+def main(server, eventHandler, params):
     if not os.isatty(sys.stdout.fileno()):
         print("FATAL: Unable to run 'ncurses' UI without a TTY.")
         return
     ui = NCursesUI()
     try:
-        curses.wrapper(ui.main, server, eventHandler)
+        curses.wrapper(ui.main, server, eventHandler, params)
     except:
         import traceback
         traceback.print_exc()
-- 
2.1.3


