Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0L8o-0002la-PV for bitbake-devel@lists.openembedded.org;
	Wed, 22 Feb 2012 23:58:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MMoAkh002669
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Feb 2012 22:50:10 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01958-03 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Feb 2012 22:50:05 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MMo2xA002655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Feb 2012 22:50:03 GMT
Message-ID: <1329951002.32110.31.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Feb 2012 22:50:02 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] siggen.py: Pass the datacache to signature generator classes
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
X-List-Received-Date: Wed, 22 Feb 2012 22:58:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The dataCache exposes much useful information to the singature generation code
for example its possible to figure out whether kernel dependencies are
important or not based on the RRECOMMENDS values.

We therefore pass this information to the handler and trust it to handle
any API changes in the dataCache structure.

For backwards compatibility, OE-Core is already updated to handle
the extra argument when it appears.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 3a9e132..975ae41 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -135,7 +135,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         for task in taskdeps:
             d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + "." + task])
 
-    def rundep_check(self, fn, recipename, task, dep, depname):
+    def rundep_check(self, fn, recipename, task, dep, depname, dataCache):
         # Return True if we should keep the dependency, False to drop it
         # We only manipulate the dependencies for packages not in the whitelist
         if self.twl and not self.twl.search(recipename):
@@ -151,7 +151,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         recipename = dataCache.pkg_fn[fn]
         for dep in sorted(deps, key=clean_basepath):
             depname = dataCache.pkg_fn[self.pkgnameextract.search(dep).group('fn')]
-            if not self.rundep_check(fn, recipename, task, dep, depname):
+            if not self.rundep_check(fn, recipename, task, dep, depname, dataCache):
                 continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?", dep)




