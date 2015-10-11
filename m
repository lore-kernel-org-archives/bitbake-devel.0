Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AFDEE757AC
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 15:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9BF1rDQ024483 for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 16:01:53 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sHsSD18OowuA for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 16:01:52 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9BF1aA5024472
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 16:01:50 +0100
Message-ID: <1444555280.14364.22.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 11 Oct 2015 10:21:20 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.12.11-0ubuntu3 
Subject: [RFC PATCH] data_smart: Only support lowercase OVERRIDES
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
X-List-Received-Date: Sun, 11 Oct 2015 15:01:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Our current OVERRIDES handling means we end up caching and checking for
a lot of possible override combinations which turn out to very unlikely.
A typical example is the SRC_URI variable where we have to check if
"URI" is an override. Having spent many hours working in this code, I've
realised all the actual overrides we use are lower case and our standard
variables are mostly uppercase.

This means we could gain quite some speed advantage if we write this
into the code, that overrides only consist of lowercase characters. This
patch shows how simple this is and the resulting speed gains are
significant. This is a significant change but tests show we don't appear
to have any users of capitals in overrides in any OE-Core metadata.

Before "time bitbake -p":

real	2m4.224s
user	7m32.312s
sys	0m7.116s

After "time bitbake -p":

real	1m26.009s
user	5m10.484s
sys	0m4.640s

This check could also be made conditional however I'm not seeing a need
to do that at present.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/data_smart.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 0b8811b..1d5cc8c 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -543,7 +543,7 @@ class DataSmart(MutableMapping):
         # aka pay the cookie monster
         override = var[var.rfind('_')+1:]
         shortvar = var[:var.rfind('_')]
-        while override:
+        while override and override.islower():
             if shortvar not in self.overridedata:
                 self.overridedata[shortvar] = []
             if [var, override] not in self.overridedata[shortvar]:
@@ -617,7 +617,7 @@ class DataSmart(MutableMapping):
         if '_' in var:
             override = var[var.rfind('_')+1:]
             shortvar = var[:var.rfind('_')]
-            while override:
+            while override and override.islower():
                 try:
                     if shortvar in self.overridedata:
                         # Force CoW by recreating the list first



