Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QyRb2-0003sW-1G for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 18:55:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UGodmJ020212
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2011 17:50:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19937-03 for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2011 17:50:34 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UGoTMN020206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2011 17:50:30 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 30 Aug 2011 17:50:18 +0100
Message-ID: <1314723018.5939.368.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: bitbake/parse: Correctly handle multiline comments including whitespace
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
X-List-Received-Date: Tue, 30 Aug 2011 16:55:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If metadata contains:

"""

FOO = "bar"
"""

The variable FOO should get set to "bar" but doesn't due to the empty lines
be swallowed by the parser and FOO becomming part of the multiline comment.
This patch corrects that behaviour so FOO is set as expected.

[YOCTO #1377]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 402cd07..c59b468 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -194,21 +194,21 @@ def feeder(lineno, s, fn, root, statements):
                 return
 
 
-    # Skip empty lines
-    if s == '':
-        return          
-
-    if s[0] == '#':
+    if s and s[0] == '#':
         if len(__residue__) != 0 and __residue__[0][0] != "#":
             bb.error("There is a comment on line %s of file %s (%s) which is in the middle of a multiline expression.\nBitbake used to ignore these but no longer does so, please fix your metadata as errors are likely as a result of this change." % (lineno, fn, s))
 
-    if s[-1] == '\\':
+    if s and s[-1] == '\\':
         __residue__.append(s[:-1])
         return
 
     s = "".join(__residue__) + s
     __residue__ = []
 
+    # Skip empty lines
+    if s == '':
+        return   
+
     # Skip comments
     if s[0] == '#':
         return




