Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TiDXN-0005gH-RR for bitbake-devel@lists.openembedded.org;
	Tue, 11 Dec 2012 01:17:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBB02vw0006759
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Dec 2012 00:02:57 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04616-10 for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Dec 2012 00:02:51 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBB02oaQ006748
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Dec 2012 00:02:51 GMT
Message-ID: <1355184170.6771.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Dec 2012 00:02:50 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] BBhandler/data: Fix __inherit_cache duplication
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
X-List-Received-Date: Tue, 11 Dec 2012 00:17:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The inherits cache contains duplicate entries, some with the full patch, some
just starting classes/xxx. This is a waste of parse time and potentially
error prone. This patch fixes various pieces of code so the absolute paths are
always preferred and work correctly. The inherits_class function did not work
with full paths so the patch fixes this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 9a32353..dc5a425 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -357,6 +357,8 @@ def generate_dependencies(d):
 
 def inherits_class(klass, d):
     val = getVar('__inherit_cache', d) or []
-    if os.path.join('classes', '%s.bbclass' % klass) in val:
-        return True
+    needle = os.path.join('classes', '%s.bbclass' % klass)
+    for v in val:
+        if v.endswith(needle):
+            return True
     return False
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 92c55f5..e6039e1 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -74,6 +74,13 @@ def inherit(files, fn, lineno, d):
         if not os.path.isabs(file) and not file.endswith(".bbclass"):
             file = os.path.join('classes', '%s.bbclass' % file)
 
+        if not os.path.isabs(file):
+            dname = os.path.dirname(fn)
+            bbpath = "%s:%s" % (dname, d.getVar("BBPATH", True))
+            abs_fn = bb.utils.which(bbpath, file)
+            if abs_fn:
+                file = abs_fn
+
         if not file in __inherit_cache:
             logger.log(logging.DEBUG -1, "BB %s:%d: inheriting %s", fn, lineno, file)
             __inherit_cache.append( file )




