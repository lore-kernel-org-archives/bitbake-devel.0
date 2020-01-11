Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id AB57C7FFB5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Jan 2020 02:56:50 +0000 (UTC)
IronPort-SDR: U7EXS3wlKzRe0nmeUbo2nW3gZ481mR0OUA2lhv2VSDcCnJWTEuL7vU9Ji9sMfl409lTHrNib2h
	Wd+yWJCYZHdcrzeyDYBxlabupz2BcR95A6Hb/eUcqOK3/Um319BS27DvXSqzUSQbFk8/CgVubo
	P8DnoFxRPbiES8hxCz1022AYDfa2J4hPNEPmxcBIDWJ7qD/3OGwOn9Odpqbz8Jc85FRABjGHBo
	Dtl+Infwe6ctlwBbUFXwaXJUjgQwH0tmafVigjgGtj3IYnNTvoTyObCTw/nWVVCxW81jZ2r9ad
	k+U=
X-IronPort-AV: E=Sophos;i="5.69,419,1571695200"; 
   d="scan'208";a="4323809"
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 11 Jan 2020 03:56:48 +0100
Message-ID: <20200111025648.15713-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Subject: [master][zeus][PATCH] knotty: Hide the footer if a process progress bar is shown
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
X-List-Received-Date: Sat, 11 Jan 2020 02:56:52 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

With the introduction of the hash equivalence server, the progress bar
for "Checking sstate mirror object availability" is shown repeatedly
while the tasks are being executed. If the footer is not hidden then,
it will be moved up one line every time, creating a messy interface.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index bd9911cf6f..ddcb214867 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -477,7 +477,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if event is None:
                 if main.shutdown > 1:
                     break
-                termfilter.updateFooter()
+                if not parseprogress:
+                    termfilter.updateFooter()
                 event = eventHandler.waitEvent(0.25)
                 if event is None:
                     continue
@@ -539,6 +540,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     continue
                 if event.total == 0:
                     continue
+                termfilter.clearFooter()
                 parseprogress = new_progress("Parsing recipes", event.total).start()
                 continue
             if isinstance(event, bb.event.ParseProgress):
@@ -638,6 +640,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.event.ProcessStarted):
                 if params.options.quiet > 1:
                     continue
+                termfilter.clearFooter()
                 parseprogress = new_progress(event.processname, event.total)
                 parseprogress.start(False)
                 continue
-- 
2.21.1


