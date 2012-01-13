Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RlkeA-0006Wv-U9
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 18:10:35 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jan 2012 09:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="98177333"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.110])
	by orsmga002.jf.intel.com with ESMTP; 13 Jan 2012 09:01:56 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 17:01:46 +0000
Message-Id: <5731ad4e10692856d4235af1dc8d894150a39fa0.1326473488.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/8] bitbake/fetch2: improve error formatting for fetcher errors
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
X-List-Received-Date: Fri, 13 Jan 2012 17:10:35 -0000

* The "name" argument to FuncFailed is rarely used as a name in actual
  usage within bitbake, so don't treat it as one in the output.
* Don't print URL for FetchError if it was not specified (i.e. don't
  output "Fetcher failure for URL 'None'")
* Don't include URL in "unable to fetch from any source" message since
  we supply it to FetchError and it will be printed anyway.
* Don't include URL in "checksum failed" message for the same reason

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/build.py           |    2 +-
 bitbake/lib/bb/fetch2/__init__.py |   11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index aabc1b6..30e5497 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -53,7 +53,7 @@ class FuncFailed(Exception):
         self.logfile = logfile
         self.name = name
         if name:
-            self.msg = "Function '%s' failed" % name
+            self.msg = 'Function failed: %s' % name
         else:
             self.msg = "Function failed"
 
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 3af56e5..21abb13 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
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
 
-- 
1.7.5.4



