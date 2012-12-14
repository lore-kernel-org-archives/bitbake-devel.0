Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TjVw4-0007U5-OV for bitbake-devel@lists.openembedded.org;
	Fri, 14 Dec 2012 15:08:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBEDrfpZ011914;
	Fri, 14 Dec 2012 13:53:41 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11710-02; Fri, 14 Dec 2012 13:53:37 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBEDrWxZ011908
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 14 Dec 2012 13:53:34 GMT
Message-ID: <1355493212.32519.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 14 Dec 2012 13:53:32 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Philip Balister <philip@balister.org>
Subject: BBHandler/ConfHandler: Improve multiline comment handling
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
X-List-Received-Date: Fri, 14 Dec 2012 14:08:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Faced with an expression like:

 # Some comment \
 FOO = "bar"

what should bitbake do? Technically, the \ character means its multiline and
currently the code treats this as a continuation of the comment. This can
surprise some people and is not intuitive.

This patch makes bitbake simply error and asks the user to be clearer
about what they mean.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 2ee8ebd..58049bd 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -200,7 +200,10 @@ def feeder(lineno, s, fn, root, statements):
 
     if s and s[0] == '#':
         if len(__residue__) != 0 and __residue__[0][0] != "#":
-            bb.error("There is a comment on line %s of file %s (%s) which is in the middle of a multiline expression.\nBitbake used to ignore these but no longer does so, please fix your metadata as errors are likely as a result of this change." % (lineno, fn, s))
+            bb.fatal("There is a comment on line %s of file %s (%s) which is in the middle of a multiline expression.\nBitbake used to ignore these but no longer does so, please fix your metadata as errors are likely as a result of this change." % (lineno, fn, s))
+
+    if len(__residue__) != 0 and __residue__[0][0] == "#" and s[0] != "#":
+        bb.fatal("There is a confusing multiline, partially commented expression on line %s of file %s (%s).\nPlease clarify whether this is all a comment or should be parsed." % (lineno, fn, s))
 
     if s and s[-1] == '\\':
         __residue__.append(s[:-1])
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index dbc6776..9b09c9f 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -98,15 +98,22 @@ def handle(fn, data, include):
     while True:
         lineno = lineno + 1
         s = f.readline()
-        if not s: break
+        if not s:
+            break
         w = s.strip()
-        if not w: continue          # skip empty lines
+        # skip empty lines
+        if not w:
+            continue
         s = s.rstrip()
-        if s[0] == '#': continue    # skip comments
         while s[-1] == '\\':
             s2 = f.readline().strip()
             lineno = lineno + 1
+            if s2 and s[0] == "#" and s2[0] != "#":
+                bb.fatal("There is a confusing multiline, partially commented expression on line %s of file %s (%s).\nPlease clarify whether this is all a comment or should be parsed." % (lineno, fn, s))
             s = s[:-1] + s2
+        # skip comments
+        if s[0] == '#':
+            continue
         feeder(lineno, s, fn, statements)
 
     # DONE WITH PARSING... time to evaluate




