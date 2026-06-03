Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8483CD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 10:48:48 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17310.1780483725669238615
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 03:48:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T3joGMrX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4905529b933so99941725e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780483724; x=1781088524; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6veTflboWUU3OOTCvoZcLwVbjp6nXJH524RdKgSjIs=;
        b=T3joGMrXeCSnXHPuPsxMzJYrt2zBLzO3n8k1tfl21UrlB2kwG/wbs/Wq4Fjnx6r81r
         CTK4bo9qkVI/tSoo7m14Zi+O0JoqiZDc4DZgrGcnlUq1HCQ4owwOvLcu0KdPVtFxO35S
         logoTmNoPPtc1IA0/KA0gnhAZLApfOqgH2S+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483724; x=1781088524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L6veTflboWUU3OOTCvoZcLwVbjp6nXJH524RdKgSjIs=;
        b=hbXK8NNlQ57Nsp4sUMv8onzCJr6xOuXVBlUPi5J7FX3iBhXy0vICuvIoVrLyLNQFLX
         U6zbq7fos/YHHS3JRbZbOQYfAXPpNiJz+8Bzq1los9vUpWSrDmwdwsS8hwGE9tKpXtLf
         dojOaVeWgu5Lw0+XpFIlNNHBH02n2os5BqqYxH5YeOpbrzOfeOga94Ubu0GXMluyQV3q
         VniaseQ9/0uWKCf4ajZoBIw9humR6QdSoedU6UnY/oi6QuptPlCyF5izBIDPOfxdjtzp
         SbYeGxmb4+9Gdce6N8mgF2RzalzufhnNWJOxJNQUtsf12+GWCR8Q8a0RUrTrdCUwCmz2
         lMTw==
X-Gm-Message-State: AOJu0Yz0Y1PBygzq+r7tG7UeWtXLbkTCOpq+dCozYcOTSSrx1IwEhX6a
	Wk9AEKOFgG3IH/tdbPpBRYPVcfJwJy9Iv2HIrAhxKAZqR0oPa3EpkfrkyHDwRVf0p0nuOR2JF4U
	VNDU/
X-Gm-Gg: Acq92OFongPYfeFhxvLsMA1RVMtk9Es5MJt1c5M3duRPucaVTqDHYJHRvi1KI0RKFT6
	BTUT+hibcpl5kmrtg9t+2T+0i9Pc9ilqHSGC3bR2eSUqIdGhkVbmkEnUepvZQ9e4dG39NnAlu8A
	TWHle98OF/8xZYbqKBevrulclqBhkZmepmktqHMLJaEOn00sXjNMdPy0B3G+kBgaH57uqeFseuG
	yevdJe0DjadPxGMzYQo2N5GRBXJ9H1URKONnzyCOWoUhqtbf7dSXh9riPeTSVAaaHxOzt1bqo1x
	Z1BT1b4bt67AnfYjI92hYvtg+ynJARfI3lFzSUMNX7o2yvTYufpOilH2LaEQJVROuLWdjsI1aWK
	23XLm3H6q1bQmZm3MhkM8/W1Ffely2GPLw0vNsrphh6yuGv5ssNtkNJvcT4uJEVMiVDBd66cAgV
	mk4epL3aHvk2roHFzOAMgK7zOOalh2tFK+Jsd2+Ou/WjrFnz8HQf89dAZO12/XiA==
X-Received: by 2002:a05:600c:810c:b0:490:b11f:2560 with SMTP id 5b1f17b1804b1-490b5e6ef66mr49370355e9.9.1780483724052;
        Wed, 03 Jun 2026 03:48:44 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm8090759f8f.30.2026.06.03.03.48.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:48:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/8] fetch/wget: Convert to use lists of command arguments
Date: Wed,  3 Jun 2026 11:48:35 +0100
Message-ID: <20260603104840.815399-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
References: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 10:48:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19596

To follow best practises and avoid shell=True subprocess usage, convert
the fetcher commands to use lists instead of strings. This improves variable
quoting and models modern coding standards.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6e186e1ca1f..475f042dd84 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -83,13 +83,13 @@ class Wget(FetchMethod):
         if not ud.localfile:
             ud.localfile = ud.host + ud.path.replace("/", ".")
 
-        self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget --tries=2 --timeout=100"
+        self.basecmd = shlex.split(d.getVar("FETCHCMD_wget") or "") or ['wget', '--tries=2', '--timeout=100']
 
         if ud.type == 'ftp' or ud.type == 'ftps':
-            self.basecmd += " --passive-ftp"
+            self.basecmd.append("--passive-ftp")
 
         if not self.check_certs(d):
-            self.basecmd += " --no-check-certificate"
+            self.basecmd.append("--no-check-certificate")
 
     def _runwget(self, ud, d, command, quiet, workdir=None):
 
@@ -97,20 +97,21 @@ class Wget(FetchMethod):
 
         logger.debug2("Fetching %s using command '%s'" % (ud.url, command))
         bb.fetch2.check_network_access(d, command, ud.url)
-        runfetchcmd(command + ' --progress=dot --verbose', d, quiet, log=progresshandler, workdir=workdir)
+
+        runfetchcmd(command + ['--progress=dot', '--verbose'], d, quiet, log=progresshandler, workdir=workdir)
 
     def download(self, ud, d):
         """Fetch urls"""
 
-        fetchcmd = self.basecmd
+        fetchcmd = self.basecmd.copy()
 
         dldir = os.path.realpath(d.getVar("DL_DIR"))
         localpath = os.path.join(dldir, ud.localfile) + ".tmp"
         bb.utils.mkdirhier(os.path.dirname(localpath))
-        fetchcmd += " --output-document=%s" % shlex.quote(localpath)
+        fetchcmd.append("--output-document=%s" % localpath)
 
         if ud.user and ud.pswd:
-            fetchcmd += " --auth-no-challenge"
+            fetchcmd.append("--auth-no-challenge")
             if ud.parm.get("redirectauth", "1") == "1":
                 # An undocumented feature of wget is that if the
                 # username/password are specified on the URI, wget will only
@@ -120,10 +121,13 @@ class Wget(FetchMethod):
                 # AWS will reject any request that has authentication both in
                 # the query parameters (from the redirect) and in the
                 # Authorization header.
-                fetchcmd += " --user=%s --password=%s" % (ud.user, ud.pswd)
+                fetchcmd.append("--user=" + ud.user)
+                fetchcmd.append("--password=" + ud.pswd)
 
         uri = ud.url.split(";")[0]
-        fetchcmd += " --continue --directory-prefix=%s '%s'" % (dldir, uri)
+        fetchcmd.append("--continue")
+        fetchcmd.append("--directory-prefix=" + dldir)
+        fetchcmd.append(uri)
         self._runwget(ud, d, fetchcmd, False)
 
         # Sanity check since wget can pretend it succeed when it didn't
@@ -482,8 +486,7 @@ class Wget(FetchMethod):
         """
         f = tempfile.NamedTemporaryFile()
         with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
-            fetchcmd = self.basecmd
-            fetchcmd += " --output-document=%s '%s'" % (f.name, uri)
+            fetchcmd = self.basecmd + ["--output-document=%s" % f.name, uri]
             try:
                 self._runwget(ud, d, fetchcmd, True, workdir=workdir)
                 fetchresult = f.read()

