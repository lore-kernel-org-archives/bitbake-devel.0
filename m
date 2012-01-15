Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RmN5w-00084v-UO
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 11:13:49 +0100
Received: by opal (Postfix, from userid 111)
	id BC50E10339; Sun, 15 Jan 2012 10:15:10 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120115101510.BC50E10339@opal>
Date: Sun, 15 Jan 2012 10:15:10 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/fetch2: improve error formatting for fetcher errors
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
X-List-Received-Date: Sun, 15 Jan 2012 10:13:49 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 86811bd85e2e453ee92a05fe60160d9b49ac69e8
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=86811bd85e2e453ee92a05fe60160d9b49ac69e8

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Fri Jan 13 17:01:46 2012 +0000

bitbake/fetch2: improve error formatting for fetcher errors

* The "name" argument to FuncFailed is rarely used as a name in actual
  usage within bitbake, so don't treat it as one in the output.
* Don't print URL for FetchError if it was not specified (i.e. don't
  output "Fetcher failure for URL 'None'")
* Don't include URL in "unable to fetch from any source" message since
  we supply it to FetchError and it will be printed anyway.
* Don't include URL in "checksum failed" message for the same reason

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/build.py           |    2 +-
 lib/bb/fetch2/__init__.py |   11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index a9ce14f..39f075d 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -53,7 +53,7 @@ class FuncFailed(Exception):
         self.logfile = logfile
         self.name = name
         if name:
-            self.msg = "Function '%s' failed" % name
+            self.msg = 'Function failed: %s' % name
         else:
             self.msg = "Function failed"
 
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3af56e5..21abb13 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -55,7 +55,10 @@ class MalformedUrl(BBFetchException):
 class FetchError(BBFetchException):
     """General fetcher exception when something happens incorrectly"""
     def __init__(self, message, url = None):
-         msg = "Fetcher failure for URL: '%s'. %s" % (url, message)
+         if url:
+            msg = "Fetcher failure for URL: '%s'. %s" % (url, message)
+         else:
+            msg = "Fetcher failure: %s" % message
          self.url = url
          BBFetchException.__init__(self, msg)
          self.args = (message, url)
@@ -302,10 +305,10 @@ def verify_checksum(u, ud, d):
     # it does not match.
     msg = ""
     if md5mismatch and ud.md5_expected:
-        msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected (from URL: '%s')" % (ud.localpath, 'md5', md5data, ud.md5_expected, u)
+        msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected" % (ud.localpath, 'md5', md5data, ud.md5_expected)
 
     if sha256mismatch and ud.sha256_expected:
-        msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected (from URL: '%s')" % (ud.localpath, 'sha256', sha256data, ud.sha256_expected, u)
+        msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected" % (ud.localpath, 'sha256', sha256data, ud.sha256_expected)
 
     if len(msg):
         raise FetchError('Checksum mismatch!%s' % msg, u)
@@ -983,7 +986,7 @@ class Fetch(object):
                         localpath = try_mirrors (self.d, ud, mirrors)
 
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
-                    raise FetchError("Unable to fetch URL %s from any source." % u, u)
+                    raise FetchError("Unable to fetch URL from any source.", u)
 
                 update_stamp(u, ud, self.d)
 



