Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TA0ah-0001en-Di
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 17:35:31 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 07 Sep 2012 08:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,387,1344236400"; d="scan'208";a="142631249"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.175])
	by AZSMGA002.ch.intel.com with ESMTP; 07 Sep 2012 08:23:00 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Sep 2012 16:22:53 +0100
Message-Id: <b732cf22e79d9ac005ef828a3d0fc4d7aa20032a.1347031196.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1347031196.git.paul.eggleton@linux.intel.com>
References: <cover.1347031196.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1347031196.git.paul.eggleton@linux.intel.com>
References: <cover.1347031196.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] fetch2: fix malformed URL causing a useless traceback
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
X-List-Received-Date: Fri, 07 Sep 2012 15:35:31 -0000

The implementation of NoMethodError and MalformedUrl was broken - if you
just set self.args in an exception class to a string it treats it as a
list and then fails later on with a TypeError due to the number of
arguments not matching up.

This nasty exception during exception handling was breaking the normal
exception flow (fixed separately), which meant that if you had a
malformed URL or invalid protocol in SRC_URI you would get the
following:

ERROR: Command execution failed: Traceback (most recent call last):
  File "/home/user/poky/poky/bitbake/lib/bb/command.py", line 84, in runAsyncCommand
    self.cooker.updateCache()
  File "/home/user/poky/poky/bitbake/lib/bb/cooker.py", line 1207, in updateCache
    if not self.parser.parse_next():
  File "/home/user/poky/poky/bitbake/lib/bb/cooker.py", line 1694, in parse_next
    logger.error('Unable to parse %s', value.recipe,
AttributeError: 'exceptions.TypeError' object has no attribute 'recipe'

A specific fix for [YOCTO #2977].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index fae1add..37f7d75 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -54,7 +54,7 @@ class MalformedUrl(BBFetchException):
          msg = "The URL: '%s' is invalid and cannot be interpreted" % url
          self.url = url
          BBFetchException.__init__(self, msg)
-         self.args = url
+         self.args = (url,)
 
 class FetchError(BBFetchException):
     """General fetcher exception when something happens incorrectly"""
@@ -87,7 +87,7 @@ class NoMethodError(BBFetchException):
          msg = "Could not find a fetcher which supports the URL: '%s'" % url
          self.url = url
          BBFetchException.__init__(self, msg)
-         self.args = url
+         self.args = (url,)
 
 class MissingParameterError(BBFetchException):
     """Exception raised when a fetch method is missing a critical parameter in the url"""
-- 
1.7.9.5



