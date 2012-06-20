Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqQ-0007wt-FN
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:18 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEHSIZ008014 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:34 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TYowpEBV9O1p for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:34 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEHSf1008015
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:29 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLfB-0002Sg-BW
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:12:58 +0100
Message-Id: <7c711081043606dd14bca0f76a52675cb4c8fe09.1340200208.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 07/14] fetch2: Improve mirror looping to consider more cases
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
X-List-Received-Date: Wed, 20 Jun 2012 14:27:37 -0000

Currently we only consider one pass through the mirror list. This doesn't
catch cases where for example you might want to setup a mirror of a mirror
and allow multiple redirection. There is no reason we can't support this
and the patch loops through the list recursively now.

As a safeguard, it will stop if any duplicate urls are found, hence
avoiding circular dependency looping.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py |   41 ++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index a2e0beb..5838436 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -464,6 +464,30 @@ def check_network_access(d, info = "", url = None):
     else:
         logger.debug(1, "Fetcher accessed the network with the command %s" % info)
 
+def build_mirroruris(origud, mirrors, ld):
+    uris = []
+    uds = []
+
+    def adduri(uri, ud, uris, uds):
+        for line in mirrors:
+            try:
+                (find, replace) = line
+            except ValueError:
+                continue
+            newuri = uri_replace(ud, find, replace, ld)
+            if not newuri or newuri in uris or uri == origud.url:
+                continue
+            uris.append(newuri)
+            ud = FetchData(newuri, ld)
+            ud.setup_localpath(ld)
+            uds.append(ud)
+
+            adduri(newuri, ud, uris, uds)
+
+    adduri(None, origud, uris, uds)
+
+    return uris, uds
+
 def try_mirror_url(newuri, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
@@ -529,18 +553,11 @@ def try_mirrors(d, origud, mirrors, check = False):
     mirrors is the list of mirrors we're going to try
     """
     ld = d.createCopy()
-    for line in mirrors:
-        try:
-            (find, replace) = line
-        except ValueError:
-            continue
-        newuri = uri_replace(origud, find, replace, ld)
-        if not newuri:
-            continue
-        ud = FetchData(newuri, ld)
-        ud.setup_localpath(ld)
-
-        ret = try_mirror_url(newuri, origud, ud, ld, check)
+
+    uris, uds = build_mirroruris(origud, mirrors, ld)
+
+    for index, uri in enumerate(uris):
+        ret = try_mirror_url(uri, origud, uds[index], ld, check)
         if ret != False:
             return ret
     return None
-- 
1.7.5.4



