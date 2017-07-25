Return-Path: <ross.burton@intel.com>
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com
	[209.85.128.180])
	by mail.openembedded.org (Postfix) with ESMTP id 159EF7197B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 10:17:39 +0000 (UTC)
Received: by mail-wr0-f180.google.com with SMTP id y43so116893412wrd.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=ZOqRsPmu7Xmao6aN8YQ0BeVtKd4eExTemqS3ogiMmKM=;
	b=QpZFYW3T2RGGC3SN0fzGx73Mbdp8NRYoViLguy9XFi452qQAP3ERp083v2rhU17GsZ
	xuRrGZOXaxXZOEVaQ19WsHy51eEc0+d3eh7RhW1MPFC0GFhpopd4gHzNTViukiPsIoPb
	HNnvdlN9vafqgXLxXGMiQLmd4YspC2Xqy+JBtpBJcGhERZoSY/G5Y8lh+7su6SgDCkyw
	tmldBMUbUrdio/WW7QdiUv2QWdzUSRh+oceD92iOdUyypklJW6iuy+kI9/OIYrxbsfUH
	e1DT9eoCOKFExUlYsrxMlCpZy2eHNZ2H9FW4Lu6/p/tt4mO8djPhyDqs1Tsx6XlgWzbB
	Tc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=ZOqRsPmu7Xmao6aN8YQ0BeVtKd4eExTemqS3ogiMmKM=;
	b=IU+fbGollGa4ghpbLNFPb9TpwYrDsGnP+lt3MCwQ1jdkS5qn5h+V36esTJGd0lB2xD
	wF3gsWVYMILKtrIPXZGrCUfmGVcgexyjZDUeQ79Olfq3et9G1FAsL6qxvgqqm2auSZVq
	zX7S/8M06KQdnGAjXixghmhMxLW7lztfz1p9t1qXYR1OSqBTJrXX6VKFCSBvN8z0yVB0
	rATVJmRONoLUnxbHrUFEnrMoCYE+Ok1L5sU13L5+WTPljnXXSfcePmAffInP5sB8HZ02
	uqc85XVRL9Jfl/xh4eT7GMd7ljP1sSwABJRHlhX9M0BpKhnjSU08G2CRJGSwGXiiyi9N
	15FQ==
X-Gm-Message-State: AIVw113oJwh4erzZm6OTMVLc/3B7vznbmuXvxe+++B2cjLc8YC9DY9kq
	/+G1OB2sLX3q41y+Pj4=
X-Received: by 10.223.164.208 with SMTP id h16mr9160288wrb.100.1500977860378; 
	Tue, 25 Jul 2017 03:17:40 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	r128sm9562481wmb.27.2017.07.25.03.17.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 25 Jul 2017 03:17:39 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Jul 2017 11:17:36 +0100
Message-Id: <20170725101736.2247-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] fetch/wget: mitigate a wget race condition when listing FTP directories
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
X-List-Received-Date: Tue, 25 Jul 2017 10:17:40 -0000

When wget is fetching a listing for a directory over FTP it writes to a
temporary file called .listing in the current directory.  If there are many such
operations happening in parallel - for example during 'bitbake world -c
checkpkg' - then up to BB_NUMBER_THREADS instances of wget will be racing to
write to, read, and delete the same file.

This results in various failures such as the file disappearing before wget has
processed it or the file changing contents, which causes checkpkg to randomly
fail.

Mitigate the race condition by creating a temporary directory to run wget in
when doing directory listings.

[ YOCTO #11828 ]

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 208ee9bdd69..8ee9769d39b 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -90,13 +90,13 @@ class Wget(FetchMethod):
 
         self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate"
 
-    def _runwget(self, ud, d, command, quiet):
+    def _runwget(self, ud, d, command, quiet, workdir=None):
 
         progresshandler = WgetProgressHandler(d)
 
         logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
         bb.fetch2.check_network_access(d, command, ud.url)
-        runfetchcmd(command + ' --progress=dot -v', d, quiet, log=progresshandler)
+        runfetchcmd(command + ' --progress=dot -v', d, quiet, log=progresshandler, workdir=workdir)
 
     def download(self, ud, d):
         """Fetch urls"""
@@ -422,17 +422,16 @@ class Wget(FetchMethod):
         Run fetch checkstatus to get directory information
         """
         f = tempfile.NamedTemporaryFile()
+        with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
+            agent = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12"
+            fetchcmd = self.basecmd
+            fetchcmd += " -O " + f.name + " --user-agent='" + agent + "' '" + uri + "'"
+            try:
+                self._runwget(ud, d, fetchcmd, True, workdir=workdir)
+                fetchresult = f.read()
+            except bb.fetch2.BBFetchException:
+                fetchresult = ""
 
-        agent = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12"
-        fetchcmd = self.basecmd
-        fetchcmd += " -O " + f.name + " --user-agent='" + agent + "' '" + uri + "'"
-        try:
-            self._runwget(ud, d, fetchcmd, True)
-            fetchresult = f.read()
-        except bb.fetch2.BBFetchException:
-            fetchresult = ""
-
-        f.close()
         return fetchresult
 
     def _check_latest_version(self, url, package, package_regex, current_version, ud, d):
-- 
2.11.0


