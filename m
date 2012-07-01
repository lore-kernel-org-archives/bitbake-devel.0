Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>) id 1SlGzL-0002ls-1O
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Jul 2012 12:02:43 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id q619pes8003153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 1 Jul 2012 11:51:41 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1SlGoz-0001dJ-DR; Sun, 01 Jul 2012 11:52:01 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Jul 2012 11:52:00 +0200
Message-Id: <1341136320-6242-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 1.7.10.2
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.995
X-Spam-Score: -5.3
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,SPF_NEUTRAL,T_RP_MATCHES_RCVD,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] fetch2: try PREMIRRORS when calculating latest_revision
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
X-List-Received-Date: Sun, 01 Jul 2012 10:02:43 -0000

Since support for native git mirrors was added in recent bitbake, it
is possible to use local mirrors for calculating ${AUTOREV}.  This is
very useful for development: recipes SRCREV can be overridden locally
by 'SRCREV_pn-<recipe> = ${AUTOREV}' and a PREMIRROR which refers to a
local repository can be added for the SRC_URI .

Patch checks PREMIRRORS only but not normal MIRRORS because:

a) it can break things when upstream is temporarily unavailable while
   calling latest_revision() (--> MIRRORS will be consulted) but comes
   back when fetching source.

b) it makes the error reporting more complicated (only errors for
   upstream should be shown to user, not the MIRROR's ones).

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 lib/bb/fetch2/__init__.py |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e3e03e5..2da5e99 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -616,6 +616,29 @@ def try_mirrors(d, origud, mirrors, check = False):
             return ret
     return None
 
+def latest_revision(ud, d, name):
+    mirrors = mirror_from_string(d.getVar('PREMIRRORS', True))
+    ld = d.createCopy()
+    rev = None
+    uris, uds = build_mirroruris(ud, mirrors, ld)
+
+    for index, uri in enumerate(uris):
+        if not hasattr(uds[index].method, '_latest_revision'):
+            continue
+
+        try:
+            rev = uds[index].method.latest_revision(uri, uds[index], d, name)
+            break
+        except bb.fetch2.NetworkAccess:
+            pass
+        except bb.fetch2.BBFetchException as e:
+            pass
+
+    if rev == None:
+        rev = ud.method.latest_revision(ud.url, ud, d, name)
+
+    return rev
+
 def srcrev_internal_helper(ud, d, name):
     """
     Return:
@@ -643,7 +666,7 @@ def srcrev_internal_helper(ud, d, name):
     if rev == "INVALID":
         raise FetchError("Please set SRCREV to a valid value", ud.url)
     if rev == "AUTOINC":
-        rev = ud.method.latest_revision(ud.url, ud, d, name)
+        rev = latest_revision(ud, d, name)
 
     return rev
 
-- 
1.7.10.2



