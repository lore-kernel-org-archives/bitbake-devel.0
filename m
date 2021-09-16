Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.1979.1631802353704426193
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 07:25:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EUHOL/S2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id u18so8062792wrg.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQ6Y9VmdI2ut6X/WRNTGGDerRsnCTeu2AisIOBErx9s=;
        b=EUHOL/S2U55kVbqHgkgChDOpIBL2VSGXQqlD5MQm4B0MEth8Ic0BYRyRlXBUYLwtiK
         JlafNr7uGALv2kYSXzlb7iIhT/yorVDLR5XomkHLdW6l48xwtSkw/pzEfr8yOZF4wWB/
         QBvs0Lp+vb86PDbNmjhLN0CO+iFeQAx/Kit+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQ6Y9VmdI2ut6X/WRNTGGDerRsnCTeu2AisIOBErx9s=;
        b=KD3nwMQlukuqeverNZ5gFZFtpqaJ09Jjf57yNBLNY1rCmQqnLvdRiT1gAC3szBYjzH
         L1bSI+NBaopsYueRvcAYEwLqOI/osQvVS/zupK+5lnNgp2jJgznKrUOlFLHy2mcbEDKN
         WgaPuHPXupvsCBwhxSOmfdpefGYlzSYTjA3w/pxH5loiBHaiKgZQUvtE0XDdIvDwrFvA
         rMsvOL3DvveDIvW5XNhsIxnSqiwJjuFZTsw/R8j7R4qKWeTVacxSTmMzFZKT2UI6EIHI
         abSGOfpQjICHgitNaWwW+tUmklOek5AEWNQ3oIG+6hGAORNi0PDfL2DKo4n6gPJzJODn
         kZug==
X-Gm-Message-State: AOAM53344grQXVEod4/o5K9l919Ol890L5z18mfUPj/Ai1ARedSafYew
	HPXD0XXm3m5obU6dUyfYsiZjRHn1lGD+9n/m
X-Google-Smtp-Source: ABdhPJzgAO/CtMjraiJLHnG5j6Qh5/WzqWnWySSiZPGPebO80OhxMjCyZhvX5UarzBJtdutmmbfacw==
X-Received: by 2002:a5d:618c:: with SMTP id j12mr6470346wru.208.1631802351906;
        Thu, 16 Sep 2021 07:25:51 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:f11f:8fd1:42b2:e87c])
        by smtp.gmail.com with ESMTPSA id 20sm8150922wme.46.2021.09.16.07.25.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 07:25:51 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/git: Avoid races over mirror tarball creation
Date: Thu, 16 Sep 2021 15:25:49 +0100
Message-Id: <20210916142549.1464585-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a potential race over the mirror tarballs where a partial git repo
could be extracted causing fetcher failures if the tarball is being rewritten
whilst another build accesses it.

Create the mirror tarball atomically to avoid this.

[YOCTO #14441]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 488f4c7414..3643a491d7 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -68,6 +68,7 @@ import subprocess
 import tempfile
 import bb
 import bb.progress
+from contextlib import contextmanager
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
@@ -418,6 +419,20 @@ class Git(FetchMethod):
                 bb.utils.remove(tmpdir, recurse=True)
 
     def build_mirror_data(self, ud, d):
+
+        # Create as a temp file and move atomically into position to avoid races
+        @contextmanager
+        def create_atomic(filename, d):
+            fd, tfile = tempfile.mkstemp(dir=os.path.dirname(filename))
+            try:
+                yield tfile
+                umask = os.umask(0o666)
+                os.umask(umask)
+                os.chmod(tfile, (0o666 & ~umask))
+                runfetchcmd("mv %s %s" % (tfile, filename), d)
+            finally:
+                os.close(fd)
+
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
                 if os.path.islink(ud.fullshallow):
@@ -428,7 +443,8 @@ class Git(FetchMethod):
                     self.clone_shallow_local(ud, shallowclone, d)
 
                     logger.info("Creating tarball of git repository")
-                    runfetchcmd("tar -czf %s ." % ud.fullshallow, d, workdir=shallowclone)
+                    with create_atomic(ud.fullshallow, d) as tfile:
+                        runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
                     runfetchcmd("touch %s.done" % ud.fullshallow, d)
                 finally:
                     bb.utils.remove(tempdir, recurse=True)
@@ -437,7 +453,8 @@ class Git(FetchMethod):
                 os.unlink(ud.fullmirror)
 
             logger.info("Creating tarball of git repository")
-            runfetchcmd("tar -czf %s ." % ud.fullmirror, d, workdir=ud.clonedir)
+            with create_atomic(ud.fullmirror, d) as tfile:
+                runfetchcmd("tar -czf %s ." % tfile, d, workdir=ud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
     def clone_shallow_local(self, ud, dest, d):
-- 
2.32.0

