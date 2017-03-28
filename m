Return-Path: <pidge@toganlabs.com>
Received: from burlywood.maple.relay.mailchannels.net
	(burlywood.maple.relay.mailchannels.net [23.83.214.26])
	by mail.openembedded.org (Postfix) with ESMTP id 534AE77A8A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 13:54:30 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|pidge@toganlabs.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0FD77203AD2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 13:54:31 +0000 (UTC)
Received: from hp181.hostpapa.com (unknown [100.96.128.152])
	by relay.mailchannels.net (Postfix) with ESMTPA id AA1B820368F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 13:54:30 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|pidge@toganlabs.com
Received: from hp181.hostpapa.com (hp181.hostpapa.com [172.20.55.158])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.37); Tue, 28 Mar 2017 13:54:31 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostpapa|x-authuser|pidge@toganlabs.com
X-MailChannels-Auth-Id: hostpapa
X-Grain-Robust: 5addefe66aa4a162_1490709270971_993948391
X-MC-Loop-Signature: 1490709270971:500971595
X-MC-Ingress-Time: 1490709270971
Received: from ns325767.ip-37-187-157.eu ([37.187.157.197]:37956
	helo=ns325767.ovh.net) by hp181.hostpapa.com with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-SHA256:128) (Exim 4.87)
	(envelope-from <pidge@toganlabs.com>)
	id 1csrZt-001040-UR; Tue, 28 Mar 2017 15:54:30 +0200
From: Elizabeth 'pidge' Flanagan <pidge@toganlabs.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Mar 2017 16:04:54 +0200
Message-Id: <1490709894-31154-1-git-send-email-pidge@toganlabs.com>
X-Mailer: git-send-email 1.9.1
X-OutGoing-Spam-Status: No, score=5.0
X-AuthUser: pidge@toganlabs.com
Subject: [PATCHv2] s3.py: Add support for fetching source mirrors/minor cleanup
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
X-List-Received-Date: Tue, 28 Mar 2017 13:54:33 -0000

This commits main purpose is to add support for fetching source
mirrors. In the current incarnation:

SOURCE_MIRROR_URL ?= "s3://mybucket/downloads"

will fail for two reasons. First, download doesn't support it,
but second, without aws included in HOSTTOOLS you'll end up
with aws not being found by bitbake (for either source mirrors or
sstate mirrors).

Part of this is fixed with this commit. However, this will still
fail if HOSTTOOLS doesn't include 'aws' in bitbake.conf. I've another
commit or two to fix that as well.

I've also DRYed up some of the error handling, removed the hardcoded
aws and added some logging.

Signed-off-by: Elizabeth 'pidge' Flanagan <pidge@toganlabs.com>
---
 lib/bb/fetch2/s3.py | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 27993aa..791f3b2 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -34,6 +34,7 @@ import urllib.request, urllib.parse, urllib.error
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
 from bb.fetch2 import runfetchcmd
+from bb.fetch2 import logger
 
 class S3(FetchMethod):
     """Class to fetch urls via 'aws s3'"""
@@ -48,6 +49,8 @@ class S3(FetchMethod):
         return True
 
     def urldata_init(self, ud, d):
+        ud.basecmd = d.getVar("FETCHCMD_s3", True) or "/usr/bin/env aws s3"
+
         if 'downloadfilename' in ud.parm:
             ud.basename = ud.parm['downloadfilename']
         else:
@@ -60,8 +63,13 @@ class S3(FetchMethod):
         Fetch urls
         Assumes localpath was called first
         """
-
-        cmd = 'aws s3 cp s3://%s%s %s' % (ud.host, ud.path, ud.localpath)
+        if 'downloadfilename' in ud.parm:
+            dldir = d.getVar("DL_DIR", True)
+            bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
+            cmd = '%s cp s3://%s%s %s%s%s' % (ud.basecmd, ud.host, ud.path, dldir, os.sep, ud.localpath)
+        else:
+            cmd = '%s cp s3://%s%s %s' % (ud.basecmd, ud.host, ud.path, ud.localpath)
+        logger.debug(2, "Fetching %s using command '%s'" % (ud.url, cmd))
         bb.fetch2.check_network_access(d, cmd, ud.url)
         runfetchcmd(cmd, d)
 
@@ -70,11 +78,11 @@ class S3(FetchMethod):
         # tool with a little healthy suspicion).
 
         if not os.path.exists(ud.localpath):
-            raise FetchError("The aws cp command returned success for s3://%s%s but %s doesn't exist?!" % (ud.host, ud.path, ud.localpath))
+            raise FetchError("The command  %s returned success but %s doesn't exist?!" % (cmd, ud.localpath))
 
         if os.path.getsize(ud.localpath) == 0:
             os.remove(ud.localpath)
-            raise FetchError("The aws cp command for s3://%s%s resulted in a zero size file?! Deleting and failing since this isn't right." % (ud.host, ud.path))
+            raise FetchError("The command %s resulted in a zero size file?! Deleting and failing since this isn't right." % (cmd))
 
         return True
 
@@ -83,7 +91,9 @@ class S3(FetchMethod):
         Check the status of a URL
         """
 
-        cmd = 'aws s3 ls s3://%s%s' % (ud.host, ud.path)
+        cmd = '%s ls s3://%s%s' % (ud.basecmd, ud.host, ud.path)
+        logger.debug(2, "Checking %s using command '%s'" % (ud.url, cmd))
+
         bb.fetch2.check_network_access(d, cmd, ud.url)
         output = runfetchcmd(cmd, d)
 
@@ -91,6 +101,6 @@ class S3(FetchMethod):
         # is not found, so check output of the command to confirm success.
 
         if not output:
-            raise FetchError("The aws ls command for s3://%s%s gave empty output" % (ud.host, ud.path))
+            raise FetchError("The command %s gave empty output" % (cmd))
 
         return True
-- 
1.9.1


