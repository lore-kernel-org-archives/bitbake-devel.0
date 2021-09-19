Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.9032.1632047552297006787
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 19 Sep 2021 03:32:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UJ18zmpg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so13376112wmq.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 19 Sep 2021 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXQxrySfQHrVBR82WvPlMcjJ3MHO49jvq7iBFxrhLAw=;
        b=UJ18zmpgdN5IwIzHPJ4P+3Q7UQtchnSUBQNjqwQlGZKLTsumZTsyM/rj/8MrkB58AD
         wt7B2Ok0Z+QYnhED3axC8Hgs6HftJFzbSZaDGU3zkV+CdSuzaZL5JLv7dEWFb/nf7Eln
         N2g+nWEF7Tg0t3TGZHd8OUl3+tp2OqvGZyJbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXQxrySfQHrVBR82WvPlMcjJ3MHO49jvq7iBFxrhLAw=;
        b=Sg0ONWPdYLrfbarrDHjpNSwRnD+j4FmKbLJOe693KND026Mv2b4wgPZImjzy75LV5z
         f0baPLYp/Os4NTu56mX3glca+w4a84RZJOqaSdQCSut2spy5Rgjsc/JF8glni1BOxmYg
         eCUvciA7tiLlTVG8ONBf3CEtmIorkdvoaxfhGq3eulfDCEAtW4oaz57mXFEpi55A4XJe
         Te1GXrbfYKpDQzPxlOhlN7JBDQ/HE9bUUZuslvky0LiSO/czd3FBZ/5JpeST8qQsMptf
         sXGcGfvyen7ehgpFTF4K5CoDrsfIq1AAm4UKoNsi65yvdfruGuuBSJOsv5vEGiG+I4ol
         /Axg==
X-Gm-Message-State: AOAM533YjJpt6LFgyhf2loxoF4wxS9gJ5gpEX9C9OX6npku6F3BqKIv9
	nV/l0eM1bQC93VAQy2OZ7atyL7de9AM+cegJ
X-Google-Smtp-Source: ABdhPJwTCbWRhqcES41eDkbT5u3q/9lprVMixW2SNLgAqXj/WzqXZ9GtxNB7JHtusMfd+iR+ilNRrw==
X-Received: by 2002:a05:600c:4fd4:: with SMTP id o20mr22693162wmq.164.1632047550390;
        Sun, 19 Sep 2021 03:32:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:f583:326e:a3bb:7da1])
        by smtp.gmail.com with ESMTPSA id r5sm12017758wrm.79.2021.09.19.03.32.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 03:32:29 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch2/git: Use os.rename instead of mv
Date: Sun, 19 Sep 2021 11:32:27 +0100
Message-Id: <20210919103228.1541093-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

os.rename will overwrite the destination file if present so we can use this
instead of the process call overhead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 3643a491d7..e8ddf2c761 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -422,14 +422,14 @@ class Git(FetchMethod):
 
         # Create as a temp file and move atomically into position to avoid races
         @contextmanager
-        def create_atomic(filename, d):
+        def create_atomic(filename):
             fd, tfile = tempfile.mkstemp(dir=os.path.dirname(filename))
             try:
                 yield tfile
                 umask = os.umask(0o666)
                 os.umask(umask)
                 os.chmod(tfile, (0o666 & ~umask))
-                runfetchcmd("mv %s %s" % (tfile, filename), d)
+                os.rename(tfile, filename)
             finally:
                 os.close(fd)
 
@@ -443,7 +443,7 @@ class Git(FetchMethod):
                     self.clone_shallow_local(ud, shallowclone, d)
 
                     logger.info("Creating tarball of git repository")
-                    with create_atomic(ud.fullshallow, d) as tfile:
+                    with create_atomic(ud.fullshallow) as tfile:
                         runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
                     runfetchcmd("touch %s.done" % ud.fullshallow, d)
                 finally:
@@ -453,7 +453,7 @@ class Git(FetchMethod):
                 os.unlink(ud.fullmirror)
 
             logger.info("Creating tarball of git repository")
-            with create_atomic(ud.fullmirror, d) as tfile:
+            with create_atomic(ud.fullmirror) as tfile:
                 runfetchcmd("tar -czf %s ." % tfile, d, workdir=ud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
-- 
2.32.0

