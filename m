Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 58B7C7841E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 16:38:42 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7VGcfWe028724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 31 Aug 2017 17:38:42 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnSUL-0003Fk-A7; Thu, 31 Aug 2017 17:38:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 17:38:37 +0100
Message-Id: <1504197520-12428-7-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 31 Aug 2017 17:38:42 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 07/10] ui/knotty: Send updateConfig early
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
X-List-Received-Date: Thu, 31 Aug 2017 16:38:46 -0000

If for example you run:

bitbake -r somefile.inc
rm somefile.inc
bitbake -e

bitbake will crash with an error about not being able to find somefile.inc. This
is because it tries to reparse the base config for the early getVariable requests
before it sees the updated missing -r option.

Send the updateConfig command earlier to avoid this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index f3900bd..6b0781d 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -344,6 +344,9 @@ _evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.Lo
 
 def main(server, eventHandler, params, tf = TerminalFilter):
 
+    if not params.observe_only:
+        params.updateToServer(server, os.environ.copy())
+
     includelogs, loglines, consolelogfile = _log_settings_from_server(server, params.observe_only)
 
     if sys.stdin.isatty() and sys.stdout.isatty():
@@ -398,7 +401,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     universe = False
     if not params.observe_only:
         params.updateFromServer(server)
-        params.updateToServer(server, os.environ.copy())
         cmdline = params.parseActions()
         if not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
-- 
2.7.4


