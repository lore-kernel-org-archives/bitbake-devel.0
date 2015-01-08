Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5497A706D9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 09:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t089eeor020716
	for <bitbake-devel@lists.openembedded.org>; Thu, 8 Jan 2015 09:40:40 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WYa8-ONTILg2 for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 09:40:40 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t089eQg1020704
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 8 Jan 2015 09:40:38 GMT
Message-ID: <1420710063.25779.82.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 08 Jan 2015 09:41:03 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Shut down the parser in error state
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
X-List-Received-Date: Thu, 08 Jan 2015 09:41:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the cooker is in an error state, we shouldn't continue to try parsing.
This fixes an issue where an invalid PR server is detected when bitbake
is started and ensures bitbake exits cleanly rather than hanging.

[YOCTO #6934]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0d9b85e..23e7abd 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1355,7 +1355,7 @@ class BBCooker:
         if self.state == state.running:
             return
 
-        if self.state in (state.shutdown, state.forceshutdown):
+        if self.state in (state.shutdown, state.forceshutdown, state.error):
             if hasattr(self.parser, 'shutdown'):
                 self.parser.shutdown(clean=False, force = True)
             raise bb.BBHandledException()



