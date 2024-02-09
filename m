Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5146FC4828F
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 16:04:57 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.15864.1707494694648275638
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 08:04:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=KsErsa2a;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: thomas.perrot@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2E0724000B;
	Fri,  9 Feb 2024 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707494692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v+bZGvv1DFaP9AwgP0Q6HewF1qyw+i3ygnsRWuyKkag=;
	b=KsErsa2audhahPyvKM5IJ6WPSgt8kO7iVy3E8Ak+3lmesCUNgnds9pLDZKiCSLKTsm8+k5
	rPRzSKfC3Vh9VDiAPr3KV8sHyjfJo1kPf4PMPIC0JMeAJoyAtzt4zcWPrYrUEBs9NPDRrq
	J/c6v8H+KOiWPdSOjyHbuk3k5+K+/cV/jZkGYhU30s9qphnX2RXe4HLmv8MPxLQP4WOxxU
	Z/n9HSX0TeI+7H09S9fsFL+l/wQWsDYDgfFUTrFjhw2xhHV+zsSguji5ma92sKfW5AaFFx
	GTpP1x5Z5MuY1DxA70kpMNt7MZAHEZEBiTnEW/NkSZEQnCcasQcGlkW9bF3jEQ==
From: thomas.perrot@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [bitbake-devel][PATCH v2] wget.py: always use the custom user agent
Date: Fri,  9 Feb 2024 17:04:50 +0100
Message-ID: <20240209160450.2871718-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.perrot@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 16:04:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15856

From: Thomas Perrot <thomas.perrot@bootlin.com>

Add the "--user-agent" paramater in the wget base command to
perform all wget commands with this parameter, because a few
HTTP servers block requests with the default wget user agent.

For example, "hg.openjdk.org" never send a response to requests
have been sent with wget:
wget https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
Resolving hg.openjdk.org (hg.openjdk.org)... 23.54.129.73
Connecting to hg.openjdk.org (hg.openjdk.org)|23.54.129.73|:443... connected.
HTTP request sent, awaiting response...

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 lib/bb/fetch2/wget.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index dc025800e659..bb38dd435827 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -87,7 +87,8 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile = d.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."))
 
-        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp"
+        self.basecmd = d.getVar("FETCHCMD_wget") \
+            or "/usr/bin/env wget -t 2 -T 30 --passive-ftp --user-agent='%s'" % (self.user_agent)
 
         if not self.check_certs(d):
             self.basecmd += " --no-check-certificate"
@@ -454,7 +455,7 @@ class Wget(FetchMethod):
         f = tempfile.NamedTemporaryFile()
         with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
             fetchcmd = self.basecmd
-            fetchcmd += " -O " + f.name + " --user-agent='" + self.user_agent + "' '" + uri + "'"
+            fetchcmd += " -O " + f.name + " '" + uri + "'"
             try:
                 self._runwget(ud, d, fetchcmd, True, workdir=workdir)
                 fetchresult = f.read()
@@ -492,7 +493,7 @@ class Wget(FetchMethod):
                     valid = 1
                 elif self._vercmp(version, newver) < 0:
                     version = newver
-                
+
         pupver = re.sub('_', '.', version[1])
 
         bb.debug(3, "*** %s -> UpstreamVersion = %s (CurrentVersion = %s)" %
-- 
2.43.0


