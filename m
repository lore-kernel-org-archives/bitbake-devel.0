Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4052CD6E56
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 10:48:58 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17313.1780483730483795100
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 03:48:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WDDWSW5o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-460166910e6so1661292f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780483729; x=1781088529; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/NoUBj09rXP6qscXGRUm68Bx4twS8Pqds3hkylzAqU=;
        b=WDDWSW5orKqkWyEGC2/6GHBTqa0Ik1oxICP3ifQKYlMFwd8KvMJcCgUf50AfJgLmrj
         Td5mo/9TujCxPBMWF0xcqYbDwOJ87uQylCbRzDpCKkTnr24XnldWog/F3Is2B7YGHQ13
         nivyYnf/0KI9uLTajYrqFuMqEJ+iZhuxz8RD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483729; x=1781088529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m/NoUBj09rXP6qscXGRUm68Bx4twS8Pqds3hkylzAqU=;
        b=JiX10OxigSqdtLdVUmP0LrRWknfmhQFfG8cupphIpNV1f+MMlgbMx7Q7IUZbAufqzW
         3sv5aa8A10CnRyNM79Z0u9X8QDzbYRyB8JLcsN/2pnK7Xc8Ic/XCFR3TwEu4xiI//KZ5
         upCvIg304HFUWKsL3NvtoDjTJrKERMceUxIMRY+2d6Rim1IPffKRBXjyBZJ2FLeYWrrR
         qiSSbRLZVYK2tg907ysR4fJeIPrXXUPNIzYUPE+JrHWPxTjtvjxtWkSo3ctqe7aosJR1
         idxSyRlL9pD58ZjmZ2RzM4rCua2cVPpjSbQPWpC+HRX5Z2yzHNE7vi2nbgGx9rAkUBHz
         9KHA==
X-Gm-Message-State: AOJu0Yx/YWtfeidm+8CIb0Z6/LzvY6AiTD48fawCl0vBtgBECeUw20YK
	P6LKnSToCd76xwI67Z87nd+zrhUnhTyegz3EckY/bfo5SIi6UHuocTWQQf4UBGv44fgClI7IUR7
	p9BdU
X-Gm-Gg: Acq92OFnYas2QWpZ2ZTE6Bta1vQqsDQGffyK8ivo/EjXO4bHsx/tnw+V0CAMCqprD0r
	r9SlLSxyF/BL8mzb5ILakTFzverZMq7OX05oHiQuhjVJkXU8IV9cMWRUmHMlibjwtv6sNkmSTpa
	c1kSlCzbuzFzLkAFGiqMs2KZkWLKOJh7XWUhJXrqp5nFGMCc9quOZ9xL4oFNpINAGnYz4qVZxYj
	2y0epFNQZtGgYK676AxJH205UdqPcOFISJv6FqSgYhpU5Xzfi1lU/5wlPeHktukCbzu8R1P8Yvi
	C7QK27qJYCG03AHC0M6vBm2+HUUJkN01twlLgc+WzYThnM8EcrXkRe+y2Xax6onQbTGd9YZ6KBX
	cZoVjmOLQAQu8cc5/V2v343CFbQq/em7AWLj9zvbdli2nC6znjdjk1I0z4w4exki1Wiqj5u60sX
	ie25dpHjfOeVw0yRSprJC8I4VrWEfBV/xUOdiH/Rs5mHfuc1o72113whfhwZ6oIw==
X-Received: by 2002:adf:f64f:0:b0:446:96b1:f5f with SMTP id ffacd0b85a97d-46021783c0fmr2735813f8f.8.1780483728861;
        Wed, 03 Jun 2026 03:48:48 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm8090759f8f.30.2026.06.03.03.48.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:48:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/8] fetch/{npm,npmsw}: Convert to use lists of command arguments
Date: Wed,  3 Jun 2026 11:48:38 +0100
Message-ID: <20260603104840.815399-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
References: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 10:48:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19599

To follow best practises and avoid shell=True subprocess usage, convert
the fetcher commands to use lists instead of strings. This improves variable
quoting and models modern coding standards.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/npm.py   | 24 +++++++++++-------------
 lib/bb/fetch2/npmsw.py |  2 +-
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index ed9ed167946..3c0cd9ff098 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -75,12 +75,9 @@ def npm_integrity(integrity):
 def npm_unpack(tarball, destdir, d):
     """Unpack a npm tarball"""
     bb.utils.mkdirhier(destdir)
-    cmd = "tar --extract --gzip --file=%s" % shlex.quote(tarball)
-    cmd += " --no-same-owner"
-    cmd += " --delay-directory-restore"
-    cmd += " --strip-components=1"
+    cmd = ['tar', '--extract', '--gzip', '--file=%s' % tarball, '--no-same-owner', '--delay-directory-restore', '--strip-components=1']
     runfetchcmd(cmd, d, workdir=destdir)
-    runfetchcmd("chmod -R +X '%s'" % (destdir), d, quiet=True, workdir=destdir)
+    runfetchcmd(['chmod', '-R', '+X', destdir], d, quiet=True, workdir=destdir)
 
 class NpmEnvironment(object):
     """
@@ -129,19 +126,20 @@ class NpmEnvironment(object):
                 workdir = tmpdir
 
             def _run(cmd):
-                cmd = "NPM_CONFIG_USERCONFIG=%s " % (self.user_config.name) + cmd
-                cmd = "NPM_CONFIG_GLOBALCONFIG=%s " % (self.global_config_name) + cmd
-                return runfetchcmd(cmd, d, workdir=workdir)
+                extraenv = {}
+                extraenv['NPM_CONFIG_USERCONFIG'] = self.user_config.name
+                extraenv['NPM_CONFIG_GLOBALCONFIG'] = self.global_config_name
+                return runfetchcmd(cmd, d, workdir=workdir, extraenv=extraenv)
 
             if configs:
                 bb.warn("Use of configs argument of NpmEnvironment.run() function"
                     " is deprecated. Please use args argument instead.")
                 for key, value in configs:
-                    cmd += " --%s=%s" % (key, shlex.quote(value))
+                    cmd.append('--%s=%s' % (key, value))
 
             if args:
                 for key, value in args:
-                    cmd += " --%s=%s" % (key, shlex.quote(value))
+                    cmd.append('--%s=%s' % (key, value))
 
             return _run(cmd)
 
@@ -190,7 +188,7 @@ class Npm(FetchMethod):
             ud.localfile = npm_localfile(ud.package, ud.version)
 
         # Get the base 'npm' command
-        ud.basecmd = d.getVar("FETCHCMD_npm") or "npm"
+        ud.basecmd = shlex.split(d.getVar("FETCHCMD_npm") or "") or ["npm"]
 
         # This fetcher resolves a URI from a npm package name and version and
         # then forwards it to a proxy fetcher. A resolve file containing the
@@ -206,8 +204,8 @@ class Npm(FetchMethod):
             args = []
             args.append(("json", "true"))
             args.append(("registry", ud.registry))
-            pkgver = shlex.quote(ud.package + "@" + ud.version)
-            cmd = ud.basecmd + " view %s" % pkgver
+            pkgver = ud.package + "@" + ud.version
+            cmd = ud.basecmd + ['view', pkgver]
             env = NpmEnvironment(d)
             check_network_access(d, cmd, ud.registry)
             view_string = env.run(cmd, args=args)
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 85f4482ad7d..5255e8b465e 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -276,7 +276,7 @@ class NpmShrinkWrap(FetchMethod):
                     npm_unpack(depsrcdir, depdestdir, d)
                 else:
                     bb.utils.mkdirhier(depdestdir)
-                    cmd = 'cp -fpPRH "%s/." .' % (depsrcdir)
+                    cmd = ['cp', '-fpPRH', '%s/.' % depsrcdir, "."]
                     runfetchcmd(cmd, d, workdir=depdestdir)
 
     def clean(self, ud, d):

