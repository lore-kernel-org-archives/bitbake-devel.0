Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.2180.1591989338005116337
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2020 12:15:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qFeKS5bp;
 spf=pass (domain: konsulko.com, ip: 209.85.221.44, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f44.google.com with SMTP id e1so10894293wrt.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2020 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Czc2MuqKCGfZkSHGJyw3rk9HO/wMvd+cFFn5Ky0iw10=;
        b=qFeKS5bpaqP7qUgzgt2zsoUbdl5TewnvTa22a/MpkiiOS+Z1g0MGGGQOz7OFJDTtgt
         6kW+HZOAESe7XrKdfVbw1T6w39NG0+Ard04HB7MkgJHG6wASwCVzLZf5/MSzssQi+wIE
         U6L8oj6W/DZi0CaaA4BOd+sy/XgRzWvww1BgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Czc2MuqKCGfZkSHGJyw3rk9HO/wMvd+cFFn5Ky0iw10=;
        b=R1cQj+Bi9xWlHwWc3byPideTfWmXTKiSFBkAi8YC2AkaqURvgIdek4zIqv8016vvyP
         8MLW4c0X5jjDeZi6X9ISz7p0cdzUmz5Oax9c8EcpwLvbwAZD/BCLxks2hG8nDRlgFMo0
         fnxCz3zwTwlcHp70oUEbiffbTlv6Jpb3mZQsxy023TtVPZ/8kjNrx9tvsbHgReMtQmHf
         YCqIKLg+MkARW5GpBj/QykYNeRoK9jH21ZxADMv4052X3n5YRwHatoo3bBg8CuSJn89w
         YW1xRYnNjF5xxcGdh3qzpVYjAdv48r7UO2fh5g2KJlZeoVpoFHYMImPLP+ESuVayB9mD
         DrzA==
X-Gm-Message-State: AOAM530QcMb2K3BX3du7oqcj8VbFWXhfOurRM5J1iBXv+v5390CdyMOV
	F7vAkH6L8TfEIbLGvUEFSON6JJEw+30E2g==
X-Google-Smtp-Source: ABdhPJxIFpVa1XpVTyNRWHFX5lClSQy0eVvWcWkU5CtmQoMlWWoK8tpwuQoaSfe4Hmrs5C8N1qxmIg==
X-Received: by 2002:a5d:5551:: with SMTP id g17mr15740589wrw.45.1591989336062;
        Fri, 12 Jun 2020 12:15:36 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from ar2.home.b5net.uk ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id j11sm10781334wru.69.2020.06.12.12.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:15:35 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 1/2] fetch2/gitsm: Mark srcrev as fetched once all submodules are processed
Date: Fri, 12 Jun 2020 20:15:21 +0100
Message-Id: <20200612191522.12352-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prevents multiple bitbake.srcrev entries being created when a
repository has more than one submodule. It also ensures that the
bitbake.srcrev entry is not added unless all submodules are correctly
fetched.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 56bd5f04..175dee05 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -163,9 +163,6 @@ class GitSM(Git):
             try:
                 newfetch = Fetch([url], d, cache=False)
                 newfetch.download()
-                # Drop a nugget to add each of the srcrevs we've fetched (used by need_update)
-                runfetchcmd("%s config --add bitbake.srcrev %s" % \
-                            (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=workdir)
             except Exception as e:
                 logger.error('gitsm: submodule download failed: %s %s' % (type(e).__name__, str(e)))
                 raise
@@ -181,6 +178,9 @@ class GitSM(Git):
             shutil.rmtree(tmpdir)
         else:
             self.process_submodules(ud, ud.clonedir, download_submodule, d)
+            # Drop a nugget for the srcrev we've fetched (used by need_update)
+            runfetchcmd("%s config --add bitbake.srcrev %s" % \
+                        (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=ud.clonedir)
 
     def unpack(self, ud, destdir, d):
         def unpack_submodules(ud, url, module, modpath, workdir, d):
-- 
2.26.2

