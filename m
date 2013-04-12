Received: from mail-ea0-f181.google.com ([209.85.215.181])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UQev0-00023p-DC
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Apr 2013 16:25:35 +0200
Received: by mail-ea0-f181.google.com with SMTP id z10so1222422ead.26
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Apr 2013 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references; bh=FiGycoiJCMnAE34y89BAVkFAB++/U9TIYY2ti+bBMDM=;
	b=HSDB4rTPfWphpvt5XUgJcGt6yDTgFPL6JXI6cnZXM5w8H+9XX8k86wgO++1i2VUwlJ
	m/MWKEV3CiUfx3jUf5Pafpa74suw+yszIBMHm7m69lBXBQVC38whh6ADZACpFUqVCzWd
	GU11BlOW8uRY4IfAsn8Ffl54j1CusjqmK15Gf41F8QrGiRTh6QR+0btFQ1hxXWwzDQTp
	tROyCrlBzQ+9tBRs2JOMt+IN55gAPFA/v6CjOoaYT7YqjUiOpBK9aWadDnUq3Iy7txl/
	KXsUc/ImrQ+Ba8HXvX0v4MpBg1OIOKQo2dzUZoytQVAj6BCi2EJbyB4qFtfiRie8CQYG
	8Tog==
X-Received: by 10.14.107.69 with SMTP id n45mr28639526eeg.23.1365775689885;
	Fri, 12 Apr 2013 07:08:09 -0700 (PDT)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id ca4sm11234119eeb.15.2013.04.12.07.08.08
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 12 Apr 2013 07:08:09 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Apr 2013 16:08:10 +0200
Message-Id: <1365775690-30487-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <20130411133031.GF2477@jama>
References: <20130411133031.GF2477@jama>
Subject: [PATCH] fetch2: rename file with bad checksum instead of removing it completely
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
X-List-Received-Date: Fri, 12 Apr 2013 14:25:47 -0000

* this can be useful when someone wan't to compare old file with
  bad checksum and new one

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/__init__.py | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1bf67dd..dd1cc93 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -74,6 +74,9 @@ class FetchError(BBFetchException):
 
 class ChecksumError(FetchError):
     """Exception when mismatched checksum encountered"""
+    def __init__(self, message, url = None, checksum = None):
+        self.checksum = checksum
+        FetchError.__init__(self, message, url)
 
 class NoChecksumError(FetchError):
     """Exception when no checksum is specified, but BB_STRICT_CHECKSUM is set"""
@@ -561,7 +564,7 @@ def verify_checksum(u, ud, d):
         msg = msg + '\nIf this change is expected (e.g. you have upgraded to a new version without updating the checksums) then you can use these lines within the recipe:\nSRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"\nOtherwise you should retry the download and/or check with upstream to determine if the file has become corrupted or otherwise unexpectedly modified.\n' % (ud.md5_name, md5data, ud.sha256_name, sha256data)
 
     if len(msg):
-        raise ChecksumError('Checksum mismatch!%s' % msg, u)
+        raise ChecksumError('Checksum mismatch!%s' % msg, u, md5data)
 
 
 def update_stamp(u, ud, d):
@@ -804,6 +807,7 @@ def try_mirror_url(newuri, origud, ud, ld, check = False):
         if isinstance(e, ChecksumError):
             logger.warn("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (newuri, origud.url))
             logger.warn(str(e))
+            self.rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
             raise
         else:
@@ -1388,6 +1392,7 @@ class Fetch(object):
                         if isinstance(e, ChecksumError):
                             logger.warn("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
                             logger.debug(1, str(e))
+                            self.rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:
@@ -1495,6 +1500,18 @@ class Fetch(object):
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
 
+    def rename_bad_checksum(self, ud, suffix):
+        """
+        Renames files to have suffix from parameter
+        """
+
+        if ud.localpath is None:
+            return
+
+        new_localpath = "%s_bad-checksum_%s" % (ud.localpath, suffix)
+        bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
+        bb.utils.movefile(ud.localpath, new_localpath)
+
 from . import cvs
 from . import git
 from . import gitsm
-- 
1.8.1.5



