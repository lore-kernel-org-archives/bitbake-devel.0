Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2AFFE6FCF7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 May 2014 17:18:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 May 2014 10:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,935,1392192000"; d="scan'208";a="548480128"
Received: from acdivito-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.240])
	by orsmga002.jf.intel.com with ESMTP; 29 May 2014 10:18:04 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 May 2014 18:17:15 +0100
Message-Id: <35531b2a4dd2b386adb9598e53b46ceaa1f5ac22.1401383609.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1401383609.git.paul.eggleton@linux.intel.com>
References: <cover.1401383609.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1401383609.git.paul.eggleton@linux.intel.com>
References: <cover.1401383609.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] fetch2: improve handling of two classes of URL parameter mistakes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 29 May 2014 17:18:39 -0000

Handle the following situations in a URL (e.g. in SRC_URI):

* Trailing semicolon in a URL - this is now ignored.
* Parameter specified with no value (no equals sign). This still
  produces an error, but at least it is MalformedUrl with a proper
  message rather than "ValueError: need more than 1 value to unpack".

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f571fc4..dcada12 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -56,8 +56,11 @@ class BBFetchException(Exception):
 
 class MalformedUrl(BBFetchException):
     """Exception raised when encountering an invalid url"""
-    def __init__(self, url):
-         msg = "The URL: '%s' is invalid and cannot be interpreted" % url
+    def __init__(self, url, message=''):
+         if message:
+             msg = message
+         else:
+             msg = "The URL: '%s' is invalid and cannot be interpreted" % url
          self.url = url
          BBFetchException.__init__(self, msg)
          self.args = (url,)
@@ -371,8 +374,11 @@ def decodeurl(url):
     p = {}
     if parm:
         for s in parm.split(';'):
-            s1, s2 = s.split('=')
-            p[s1] = s2
+            if s:
+                if not '=' in s:
+                    raise MalformedUrl(url, "The URL: '%s' is invalid: parameter %s does not specify a value (missing '=')" % (url, s))
+                s1, s2 = s.split('=')
+                p[s1] = s2
 
     return type, host, urllib.unquote(path), user, pswd, p
 
-- 
1.9.3


