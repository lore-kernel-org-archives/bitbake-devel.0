Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SUNzN-0001ia-QH for bitbake-devel@lists.openembedded.org;
	Tue, 15 May 2012 22:04:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4FJsv9J010609
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2012 20:54:57 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09693-06 for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2012 20:54:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4FJsmgU010603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 May 2012 20:54:49 +0100
Message-ID: <1337111687.2711.53.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 May 2012 20:54:47 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/fetch: Spell out which fetcher backends support and recommend checksums
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
X-List-Received-Date: Tue, 15 May 2012 20:04:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There were some hardcoded behaviours in the system for which backends
support checksums verses which backends recommend them verses which
don't recommend them.
    
This moves the functionality into specific fetchers and then makes the
general code generic. This cleans up the codebase and fixes some corner
cases such as trying to checksum directories returned by the git fetcher.
   
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index f629c01..9864595 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -271,10 +271,13 @@ def verify_checksum(u, ud, d):
     matched
     """
 
+    if not ud.method.supports_checksum(ud):
+        return
+
     md5data = bb.utils.md5_file(ud.localpath)
     sha256data = bb.utils.sha256_file(ud.localpath)
 
-    if ud.type in ["http", "https", "ftp", "ftps"]:
+    if ud.method.recommends_checksum(ud):
         # If strict checking enabled and neither sum defined, raise error
         strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
         if (strict and ud.md5_expected == None and ud.sha256_expected == None):
@@ -578,10 +581,14 @@ class FetchData(object):
             self.sha256_name = "sha256sum"
         if self.md5_name in self.parm:
             self.md5_expected = self.parm[self.md5_name]
+        elif self.type not in ["http", "https", "ftp", "ftps"]:
+            self.md5_expected = None
         else:
             self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name)
         if self.sha256_name in self.parm:
             self.sha256_expected = self.parm[self.sha256_name]
+        elif self.type not in ["http", "https", "ftp", "ftps"]:
+            self.sha256_expected = None
         else:
             self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name)
 
@@ -660,6 +667,19 @@ class FetchMethod(object):
         """
         return os.path.join(data.getVar("DL_DIR", d, True), urldata.localfile)
 
+    def supports_checksum(self, urldata):
+        """
+        Is localpath something that can be represented by a checksum?
+        """
+        return True
+
+    def recommends_checksum(self, urldata):
+        """
+        Is the backend on where checksumming is recommended (should warnings 
+        by displayed if there is no checksum)?
+        """
+        return False
+
     def _strip_leading_slashes(self, relpath):
         """
         Remove leading slash as os.path.join can't cope
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 962cc0a..ecc5e0d 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -82,6 +82,9 @@ class Git(FetchMethod):
         """
         return ud.type in ['git']
 
+    def supports_checksum(self, urldata):
+        return False
+
     def urldata_init(self, ud, d):
         """
         init git specific variable within url data
diff --git a/bitbake/lib/bb/fetch2/ssh.py b/bitbake/lib/bb/fetch2/ssh.py
index 91ac15f..8d6434a 100644
--- a/bitbake/lib/bb/fetch2/ssh.py
+++ b/bitbake/lib/bb/fetch2/ssh.py
@@ -69,6 +69,9 @@ class SSH(FetchMethod):
     def supports(self, url, urldata, d):
         return __pattern__.match(url) != None
 
+    def supports_checksum(self, urldata):
+        return False
+
     def localpath(self, url, urldata, d):
         m = __pattern__.match(urldata.url)
         path = m.group('path')
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 98900ac..e223b21 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -45,6 +45,9 @@ class Wget(FetchMethod):
         """
         return ud.type in ['http', 'https', 'ftp']
 
+    def recommends_checksum(self, urldata):
+        return True
+
     def urldata_init(self, ud, d):
 
         ud.basename = os.path.basename(ud.path)



