Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A71C433EF
	for <webhook@archiver.kernel.org>; Fri, 22 Oct 2021 13:59:58 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web12.8732.1634911197269178803
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Oct 2021 06:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=NQseAxHm;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.54,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f54.google.com with SMTP id np13so3015997pjb.4
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Oct 2021 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6uR7e75TaKweeSLVhRRrg/XLop3jkm/X0yH622SuNG0=;
        b=NQseAxHm38Jlx34m5kTSuYFP51/CsgpkYifDCN4SlJTnf6FpXyFdtASN0L2AEuG/fQ
         RJ7niphIdxoabZN/mJ5Jky/bdiF/T+RYaJF/jAqJE+bQa8EwItgm82Sw0hAfrZIRZQyK
         SdYaGbs7OS0ABni6VVsRhrI3lEl82hBl2bBQJD9bd3ndx7pAutbEun9kBBWsEyOjrEqK
         Zsz+Dpjau9Uv3AsuSR1vpS3ZzE/xOakAk3j+/9Cbs+QmQSUe7ZHhElSwfX7A5qdF58Qa
         J5NA3uFhhOQ45hHNzMqFDry6CyTRhJxvnge2f5SDAQnVxXvmdEiTcjkNdW3RRm9ORITw
         hz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uR7e75TaKweeSLVhRRrg/XLop3jkm/X0yH622SuNG0=;
        b=nShox+LEvsaq/IdoZfTwjY14m+1Bl/EoRwnCn1G9PbP3bz1m/ll1tPfS3fNOnzmiZd
         WelaB5f/T7+J46bhVr1gjKZb8g8i3/xizp7ZKWPCAyJAVZZ/hZA8cksn81IhEMKGoofv
         6uyxh/S4jKHJtQ9utiYGRtmEu4NFoW2Yw1ugR97OGcaePUI1SpgYD9XXXs8Ewg+9Y294
         4RDa6UPo4TD2HVYXHb8FbSIEarq4HeSvwsd9rweFE+7IU5V0OP0pNinriVMI5iE2N5S4
         v3JaA88ApZ4HKPY6Ei0lkXswugRcgxti/I/Bv1j6NcOzLqVCHrBxjW25E6vfiD/xBmic
         oWJQ==
X-Gm-Message-State: AOAM532eXvD5K1WN0xAB1Jsezj7KS/nPgSgUfhNb6UJ0Q+wbImtlfb+g
	87855NIYUIMKRj6v6NdcENmicYxM8uNV9KwMaVg=
X-Google-Smtp-Source: 
 ABdhPJw+1bqCjk/bUNS7C+ZwTiL8yCHL1FSiC9SgVfD9vJzgL2Vp6yg1G2JFkBwZHQdZ7EqTLKd4lg==
X-Received: by 2002:a17:902:b213:b0:13e:cd44:b4b5 with SMTP id
 t19-20020a170902b21300b0013ecd44b4b5mr11462305plr.18.1634911196257;
        Fri, 22 Oct 2021 06:59:56 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 d20sm10032806pfl.82.2021.10.22.06.59.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:59:55 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] fetch2/git: Use os.rename instead
 of mv
Date: Fri, 22 Oct 2021 03:59:15 -1000
Message-Id: 
 <b15afe7aaa70db935cd20a21c6a0b111cb268f14.1634910994.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634910994.git.steve@sakoman.com>
References: <cover.1634910994.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 22 Oct 2021 13:59:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12816

From: Richard Purdie <richard.purdie@linuxfoundation.org>

os.rename will overwrite the destination file if present so we can use this
instead of the process call overhead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b3cccaa6a896c41d8c9be5eebc327f726542d16b)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 81335c11..000aee19 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -412,14 +412,14 @@ class Git(FetchMethod):
 
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
 
@@ -433,7 +433,7 @@ class Git(FetchMethod):
                     self.clone_shallow_local(ud, shallowclone, d)
 
                     logger.info("Creating tarball of git repository")
-                    with create_atomic(ud.fullshallow, d) as tfile:
+                    with create_atomic(ud.fullshallow) as tfile:
                         runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
                     runfetchcmd("touch %s.done" % ud.fullshallow, d)
                 finally:
@@ -443,7 +443,7 @@ class Git(FetchMethod):
                 os.unlink(ud.fullmirror)
 
             logger.info("Creating tarball of git repository")
-            with create_atomic(ud.fullmirror, d) as tfile:
+            with create_atomic(ud.fullmirror) as tfile:
                 runfetchcmd("tar -czf %s ." % tfile, d, workdir=ud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
-- 
2.25.1


