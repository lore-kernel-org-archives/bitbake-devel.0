Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id D19F261137
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Feb 2020 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=axis.com; l=2091; q=dns/txt; s=axis-central1;
	t=1581737401; x=1613273401;
	h=from:to:subject:date:message-id:in-reply-to:references:
	mime-version:content-transfer-encoding;
	bh=H6zeW3ZFCewpaqlG/2YB99aA3icTg9xKG6evtCVvYug=;
	b=XV8euf1xFtcgjmjAup12OX5Z4uHK0kcAZ+TQzrhKODm73zsCbsKaIg49
	HYU5liToIGFK/OA7v48rHS9bpOYPXL/txLXdA0yAH1KgmGoq+ePbZHrmJ
	unVzBdK8nyp+PxhQ0FnZKF70lODuj2OQaMTm9TnxPUVJqbAz6DGBHA7o1
	Z9z8/WjP4I/J4z7sFTaJAKDngrEAZQoXA901pVzwscEe07vSve9J5vbB2
	3LKl1aMCTphTMlT8Sq5x1fqHt5cnWtk0zCjFTg740fCnrQF/sbZuXL3mt
	H0EB6zIFOVKbR+fHTWV7KCQIjt7sUGYfvigZyykYhkkTDW7uEJDULEhJt w==;
IronPort-SDR: pB+cR6bcIQl/lOXb8vfKPaJjEiH8LmXGCrdqB0efE95tetfFvqY3GQkd7szQV17ql28xTr6Puv
	OP9uATpBHL//RoEfl2g9lDca1/9ZFnwU7Be+38TXkoa4fLtbnVKj/aDdr9aqGYpkVudllzL+wV
	urbzQo3mhbKL7KdewmAa4ikqdqoeCmSqlhXD/Y8fyu9vOkFba5uZIn/hSopXszuyCEM/LmLUVA
	DtaqHfkX84HNN1cJfVVESwmh02QEC2Ma+WooJ4s2tSHSEjgdml5UTVXP0dD/A68FHRFzuQi3xY
	kjA=
X-IronPort-AV: E=Sophos;i="5.70,443,1574118000"; 
   d="scan'208";a="5300875"
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 15 Feb 2020 04:29:55 +0100
Message-ID: <20200215032955.3958-3-pkj@axis.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215032955.3958-1-pkj@axis.com>
References: <20200215032955.3958-1-pkj@axis.com>
MIME-Version: 1.0
Subject: [master][zeus][PATCH 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
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
X-List-Received-Date: Sat, 15 Feb 2020 03:30:00 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Mark any keys used to cache the srcrevs for a recipe as "dontcache" if
BB_DONT_CACHE is set for the recipe. Remove any such keys upon the
next bitbake run even if BB_SRCREV_POLICY is set to "cache". This will
make sure the srcrev is updated as expected if ${AUTOREV} is used.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 56462767e5..b83347ad90 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -499,6 +499,11 @@ def fetcher_init(d):
     srcrev_policy = d.getVar('BB_SRCREV_POLICY') or "clear"
     if srcrev_policy == "cache":
         logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
+        # We still need to remove keys that are marked with "dontcache".
+        for key in list(revs.keys()):
+            if key.startswith("dontcache-"):
+                logger.debug(1, "Removing SRCREV key: %s" % key)
+                revs.pop(key)
     elif srcrev_policy == "clear":
         logger.debug(1, "Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
         revs.clear()
@@ -729,9 +734,8 @@ def subprocess_setup():
     signal.signal(signal.SIGPIPE, signal.SIG_DFL)
 
 def get_autorev(d):
-    #  only not cache src rev in autorev case
-    if d.getVar('BB_SRCREV_POLICY') != "cache":
-        d.setVar('BB_DONT_CACHE', '1')
+    # Do not cache the srcrev in the autorev case
+    d.setVar('BB_DONT_CACHE', '1')
     return "AUTOINC"
 
 def get_srcrev(d, method_name='sortable_revision'):
@@ -1594,7 +1598,13 @@ class FetchMethod(object):
         return True, str(latest_rev)
 
     def generate_revision_key(self, ud, d, name):
-        return self._revision_key(ud, d, name)
+        key = self._revision_key(ud, d, name)
+        if d.getVar('BB_DONT_CACHE'):
+            # Mark the key so it can be removed on the next bitbake run even if
+            # BB_SRCREV_POLICY is "cache".
+            return "dontcache-%s" % key
+        else:
+            return key
 
     def latest_versionstring(self, ud, d):
         """
-- 
2.21.1


