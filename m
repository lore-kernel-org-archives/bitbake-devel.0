Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web12.4912.1588673982421723116
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2020 03:19:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Hotp+Z8C;
 spf=pass (domain: gmail.com, ip: 209.85.128.67, mailfrom: uvv.mail@gmail.com)
Received: by mail-wm1-f67.google.com with SMTP id k12so1658107wmj.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2020 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6voPpv6paKOeofYmRFqDsoxDqFp4DwVBdezcvoR3Dqk=;
        b=Hotp+Z8CI521OkTlcTpdh/K0KnelMPyvhLHWPZyLhFJZPqZATKkcOM1kYGpJe4KinY
         XwayzGYo101KvaW88lOnT2345NTSn4HJk3mQYYP2Q2tGBy0WcrWY7AX0jwExoySQVD5D
         pHUYd8By6T8C/l8CsSqrSRt1csFeoXALV0oAKYOTF+8MQlnSQI6gBO420ERwseu8l3dB
         l9h79LS3GbnOS/HL74I23xdusEtg23bKUxwt8NDoa10fk1VL2K7mwM3tHmHIXa647O/J
         9Wn4xem+rjPx+OeEQKY4JhbNeBPb/rpZnkRiJo94XLJVW5Xmme9BjgHQfSh9Pe4h14UJ
         RKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6voPpv6paKOeofYmRFqDsoxDqFp4DwVBdezcvoR3Dqk=;
        b=AylmBY5lGp/B8L3V5NI5pLbDlayWvSQGLYUQSVThLTpTBrIQuBtgPTp8gCFddr2q3v
         T3xI2KH9USApqnVJ0QfqQDU2SBWl6xG66MblcYDHyE/N5A0rro2ZZ3dicpfjRcbmkpZp
         98mAkfwaF2csnNBFFCbwMjqKG95GEO5LeoAPfMGgSvsKBFvub3i9HQjvzALOsXW9JWpj
         YQ1PBOHeYshWYDm1qR5gAIBW8fZZdcBE9yHYXDG+CxpfUWnYlXS1ZPyZgE7e5HWiNa6S
         xM3+Hdu1sT/lP3P3PqdpS6MkXrP6wmHlrJR/XKMZpx5hU0lAfThl6SM+MT2hKHVE77JY
         O63w==
X-Gm-Message-State: AGi0PuZtV/GQBGcqKJxBkHcGMlqC92gwS6mV87ZS5OoMw3fddPsRJjn0
	nrzkyAtzq1YDamCCG52H7NB3NaYMjSE=
X-Google-Smtp-Source: APiQypIaUQrE+13fFyTDAiaSCCftFJIk+mR2OLMD5iv/A9Gx7LFO/qSLuoY35JDwdz+jG9ADG3trSw==
X-Received: by 2002:a1c:6344:: with SMTP id x65mr2724177wmb.56.1588673980261;
        Tue, 05 May 2020 03:19:40 -0700 (PDT)
Return-Path: <uvv.mail@gmail.com>
Received: from localhost.localdomain (dslb-002-205-007-252.002.205.pools.vodafone-ip.de. [2.205.7.252])
        by smtp.gmail.com with ESMTPSA id g25sm2992615wmh.24.2020.05.05.03.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:19:39 -0700 (PDT)
From: "Vyacheslav Yurkov" <uvv.mail@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
Subject: [PATCH] bitbake: fetch2: Fix CVS fetcher clean method
Date: Tue,  5 May 2020 12:18:09 +0200
Message-Id: <20200505101809.702174-1-uvv.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>

Clean method assumes that download directory should be determined from
CVSDIR variable, but this is handled differently in download method.
Now we set download directory for the whole class in urldata_init

Signed-off-by: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
---
 bitbake/lib/bb/fetch2/cvs.py | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/cvs.py b/bitbake/lib/bb/fetch2/cvs.py
index 29123a483c..22abdef792 100644
--- a/bitbake/lib/bb/fetch2/cvs.py
+++ b/bitbake/lib/bb/fetch2/cvs.py
@@ -51,6 +51,10 @@ class Cvs(FetchMethod):
 
         ud.localfile = d.expand('%s_%s_%s_%s%s%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.tag, ud.date, norecurse, fullpath))
 
+        pkg = d.getVar('PN')
+        cvsdir = d.getVar("CVSDIR") or (d.getVar("DL_DIR") + "/cvs")
+        ud.pkgdir = os.path.join(cvsdir, pkg)
+
     def need_update(self, ud, d):
         if (ud.date == "now"):
             return True
@@ -106,10 +110,7 @@ class Cvs(FetchMethod):
 
         # create module directory
         logger.debug(2, "Fetch: checking for module directory")
-        pkg = d.getVar('PN')
-        cvsdir = d.getVar("CVSDIR") or (d.getVar("DL_DIR") + "/cvs")
-        pkgdir = os.path.join(cvsdir, pkg)
-        moddir = os.path.join(pkgdir, localdir)
+        moddir = os.path.join(ud.pkgdir, localdir)
         workdir = None
         if os.access(os.path.join(moddir, 'CVS'), os.R_OK):
             logger.info("Update " + ud.url)
@@ -120,8 +121,8 @@ class Cvs(FetchMethod):
         else:
             logger.info("Fetch " + ud.url)
             # check out sources there
-            bb.utils.mkdirhier(pkgdir)
-            workdir = pkgdir
+            bb.utils.mkdirhier(ud.pkgdir)
+            workdir = ud.pkgdir
             logger.debug(1, "Running %s", cvscmd)
             bb.fetch2.check_network_access(d, cvscmd, ud.url)
             cmd = cvscmd
@@ -140,7 +141,7 @@ class Cvs(FetchMethod):
         # tar them up to a defined filename
         workdir = None
         if 'fullpath' in ud.parm:
-            workdir = pkgdir
+            workdir = ud.pkgdir
             cmd = "tar %s -czf %s %s" % (tar_flags, ud.localpath, localdir)
         else:
             workdir = os.path.dirname(os.path.realpath(moddir))
@@ -151,9 +152,6 @@ class Cvs(FetchMethod):
     def clean(self, ud, d):
         """ Clean CVS Files and tarballs """
 
-        pkg = d.getVar('PN')
-        pkgdir = os.path.join(d.getVar("CVSDIR"), pkg)
-
-        bb.utils.remove(pkgdir, True)
+        bb.utils.remove(ud.pkgdir, True)
         bb.utils.remove(ud.localpath)
 
-- 
2.25.1

