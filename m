Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web12.7838.1594823253809834485
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jul 2020 07:27:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Au38cy2r;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.66, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f66.google.com with SMTP id gc9so3145243pjb.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Jul 2020 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=rNKfWGNJSCNzCg6u1m7/W5+Hw1UCLZ8ZXClRpcwUu5s=;
        b=Au38cy2ruu/jZ62W6gvSGyDl5QEvhpsRSgzmoP37ljJ4pa5UwyLeT7vtEXc0667NdB
         m0Mlmt7K4k3kTB8IJaSm/wWSivWBl+X34Rw+5qZpAbUe/W2+/juTvI5T9xTE60GY+b1b
         yfYneO/VylIYRBoHtBMPdAt4m7s7pXZ/Ipwr59geWJNzGUU2UIcW6gWkFDbG1FF8tRXS
         eN7d+hum479dN5Y8bNJbtJfCn+D2kwmXasXca7EFNWE5qxMddHUStXdQ2csF6sTp05UL
         S6W5T8IkBMczwtv9rwasx6epKn8hUyBXekTuXsXBlTqKUOzG4lGSINthMT9yZumzt4+z
         20qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=rNKfWGNJSCNzCg6u1m7/W5+Hw1UCLZ8ZXClRpcwUu5s=;
        b=cocl0MwNG9Ljarz2xtI1e7ShaWrRKDtMW7qAVe+wnlTfi3+OCIAJ5phC2wNyThcN+s
         XvCGviuTHJvXEEAFAqTdOnm/WZbg1K3eP5M5BCF54sOY7o41+vX17j82sHg8CZyVhrHo
         XOa5MZS7erCc0U4KGIZQ1TlcPjfpuDEdLT0MUQd62kR1038Qd5aPL26RLwWjCRBX5+XP
         VhhpJ5JDg84D7s0QDZWbVKcpxq85QDSzCq/aMCJMfS0GnhBQ8RldQAX3WSzIowH6RzeY
         yZtY+LOYtikIRq7Nkx8XGHdy4VFQV4qyUPGlMWJLDrgbwxypkAwTRfNZGEyfvZdKYCn8
         DSOA==
X-Gm-Message-State: AOAM531ApsJrQAnK8VFOUNYqcFgY/9sf+bkjSwo7KUJa0riDjSGVRNmo
	qyW1OzP0ECYy24I2s3bS8O1rtEuyGScJIA==
X-Google-Smtp-Source: ABdhPJyQcRkffrLVoLCx7JxYmuJiEg2Gt2WjKFR+8VbwGk4wGPvT9z4EwhZwzCzWx9Wj6o8sh3axtg==
X-Received: by 2002:a17:90b:f05:: with SMTP id br5mr10718120pjb.42.1594823252895;
        Wed, 15 Jul 2020 07:27:32 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id i125sm2423915pgd.21.2020.07.15.07.27.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:32 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 5/8] fetch2: Change git fetcher not to destroy old references
Date: Wed, 15 Jul 2020 04:26:47 -1000
Message-Id: <6e527ea72b0816bf5f454473faf6523c365daa18.1594822992.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594822992.git.steve@sakoman.com>
References: <cover.1594822992.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

It looks like we're about to see a lot of changes in branch names in repos. If
we have the prune option here, those old names are lost, the changes propagate
to our source mirrors and our old releases break.

We have the force option so any replaced references should be replaced, its only
orphaned branches which will now be preserved.

I believe this behaviour will cause us fewer problems given the changes that
look likely to happen.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 820ab886e79eea516560c0c008e4cf059c6e11a3)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5b3793a7..2ce9395f 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -355,7 +355,7 @@ class Git(FetchMethod):
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
 
             runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d, workdir=ud.clonedir)
-            fetch_cmd = "LANG=C %s fetch -f --prune --progress %s refs/*:refs/*" % (ud.basecmd, repourl)
+            fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, repourl)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
-- 
2.17.1

