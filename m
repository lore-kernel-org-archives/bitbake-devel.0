Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 092D56F58F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:57:28 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2A0vN0N028013 for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:57:23 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id geWzCxtq3wqh for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:57:23 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2A0vHY7028009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:57:21 GMT
Message-ID: <1394413031.7883.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 17:57:11 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Remove latency when exiting
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
X-List-Received-Date: Mon, 10 Mar 2014 00:57:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There is no point in waiting 0.25s for when we should be processing
the shutdown. This simply reordering removes latency from the
bitbake command.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 14bdb37..55cf507 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -310,11 +310,11 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         try:
             event = eventHandler.waitEvent(0)
             if event is None:
+                if main.shutdown > 1:
+                    break
                 termfilter.updateFooter()
                 event = eventHandler.waitEvent(0.25)
             if event is None:
-                if main.shutdown > 1:
-                    break
                 continue
             helper.eventHandler(event)
             if isinstance(event, bb.runqueue.runQueueExitWait):



