Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Shido-0002f8-N4 for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 16:45:49 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LEZ3Nl023386
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jun 2012 15:35:03 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22548-09 for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jun 2012 15:34:58 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LEYt0x023374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jun 2012 15:34:56 +0100
Message-ID: <1340289297.1640.122.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Jun 2012 15:34:57 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2: Add new mirror syntax to simplify mirror specifications
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
X-List-Received-Date: Thu, 21 Jun 2012 14:45:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When writing mirror specifications, the current regexp syntax can be awkward
and hard to get it to do what you want. For example, extracting the 'basename'
of a repository:

PREMIRRORS = "git://.*/([^/]+/)*([^/]*) git://somewhere.org/somedir/\\2;protocol=file"

can now become:

PREMIRRORS = "git://.*/.* git://somewhere.org/somedir/BASENAME;protocol=file"

which is much clearer. A MIRRORNAME substitution is also added which contains
an encoded form of both host and path. One of the problems with the existing
regexp syntax is you couldn't access HOST information from PATH and vice-versa
which is an issue this patch also addresses.

Tests for the new syntax are also added.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 1b99a0f..e6f55f8 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -182,7 +182,7 @@ def encodeurl(decoded):
 
     return url
 
-def uri_replace(ud, uri_find, uri_replace, d):
+def uri_replace(ud, uri_find, uri_replace, replacements, d):
     if not ud.url or not uri_find or not uri_replace:
         logger.error("uri_replace: passed an undefined value, not replacing")
         return None
@@ -213,6 +213,8 @@ def uri_replace(ud, uri_find, uri_replace, d):
             if not uri_replace_decoded[loc]:
                 result_decoded[loc] = ""    
             else:
+                for k in replacements:
+                    uri_replace_decoded[loc] = uri_replace_decoded[loc].replace(k, replacements[k])
                 #bb.note("%s %s %s" % (i, uri_replace_decoded[loc], uri_decoded[loc]))
                 result_decoded[loc] = re.sub(i, uri_replace_decoded[loc], uri_decoded[loc])
             if loc == 2:
@@ -485,13 +487,20 @@ def build_mirroruris(origud, mirrors, ld):
     uris = []
     uds = []
 
+    replacements = {}
+    replacements["TYPE"] = origud.type
+    replacements["HOST"] = origud.host
+    replacements["PATH"] = origud.path
+    replacements["BASENAME"] = origud.path.split("/")[-1]
+    replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.')
+
     def adduri(uri, ud, uris, uds):
         for line in mirrors:
             try:
                 (find, replace) = line
             except ValueError:
                 continue
-            newuri = uri_replace(ud, find, replace, ld)
+            newuri = uri_replace(ud, find, replace, replacements, ld)
             if not newuri or newuri in uris or newuri == origud.url:
                 continue
             uris.append(newuri)
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 9961343..1477fab 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -48,7 +48,14 @@ class FetcherTest(unittest.TestCase):
         ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2", "http://www.apache.org/dist", "http://archive.apache.org/dist")
             : "http://archive.apache.org/dist/subversion/subversion-1.7.1.tar.bz2",
         ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2", "http://.*/.*", "file:///somepath/downloads/")
-            : "file:///somepath/downloads/subversion-1.7.1.tar.bz2"
+            : "file:///somepath/downloads/subversion-1.7.1.tar.bz2",
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http") 
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http") 
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http") 
+            : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
         #("file://sstate-xyz.tgz", "file://.*/.*", "file:///somewhere/1234/sstate-cache") : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
@@ -143,8 +150,9 @@ class FetcherTest(unittest.TestCase):
         for k, v in self.replaceuris.items():
             ud = bb.fetch.FetchData(k[0], self.d)
             ud.setup_localpath(self.d)
-            newuris = bb.fetch2.uri_replace(ud, k[1], k[2], self.d)
-            self.assertEqual(newuris, v)
+            mirrors = bb.fetch2.mirror_from_string("%s %s" % (k[1], k[2]))
+            newuris, uds = bb.fetch2.build_mirroruris(ud, mirrors, self.d)
+            self.assertEqual(newuris, [v])
 
     def test_urilist1(self):
         fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)




