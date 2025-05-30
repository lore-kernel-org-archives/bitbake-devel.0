Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B6EC5B543
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 17:44:10 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.1351.1748627046319005516
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 May 2025 10:44:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Ns8S2R2N;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.171, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2350b1b9129so13342285ad.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1748627045; x=1749231845; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hz76oaIhqN0E0HjBJseH2MLMf+QqL8Uh8HACVe1Elo=;
        b=Ns8S2R2NrsL8RR0dK8wIjHKc4s8DKLuusAnPQJaVwNcULL3nXm9gL/Ut9JJgljLTWr
         NnMECQX2UOsDuRc4bzWxt9DvtO1XwD8U87/bLUyaT7d9HlMBySVC/4yRDFfoSIlv10pG
         hnbjBHGCDqydG+cQ2XA5GK0XyynGu9JykwQqqyXNeKtFXrJ8cNY8N+Ej677Gtyo7RkQY
         X3rwiPB7WuKUnhgdsBMi5EXRzh03D8TlivmOus4iR/2VctoKEp/iBD/YGIM1LHmaX5f8
         oBQoSB0Mhe9YB4QgbYanv1nJVxD9773FotuEG6o+AVHequ1CLs9DMG6+14w3j04jvhDh
         bz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748627045; x=1749231845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hz76oaIhqN0E0HjBJseH2MLMf+QqL8Uh8HACVe1Elo=;
        b=ihG6W9MYopSUNZv9lsvWuG6MEg0+yPYAgP5ua4ORJI1LkJ7EaTw7QNjxd7NwHgV3qs
         Gh71j0WjMa9AjaT9FxUrAF1vdrUTOkrEOxILpG21MGU7lLHdfE8RDG4wsCCzXNQbgEJ6
         rAPS6Sq3R6nwl0/IfhppJhe6C8GJLfFOb3fBUKx0cV9BSF7zXyn5s6yvA16vskA558wY
         vo87+V7Sy5oGizYWHC4ed9CKmceKG6KjS6L6A/FC0dZcArjhYNIZszCOPS7PXgPirdLz
         2RwSjP9zneMomGCL7Yd5hPlaO9IGrmL27wPye95nBJdjMdmtNyE5QpRqI65nKGHtYfA+
         ez2A==
X-Gm-Message-State: AOJu0YxQJJtNadhgODmdODyOduo/SmYWFR39rOlqTw9c02bhc0HTjdxy
	0tLNAbeO7O3j1VPwZXK/9Y7QBinxIM+qiF355ZTSBnBAmA5EX0WtFoRc0UTRROOz4vL2oizjQ3Z
	iHlEo
X-Gm-Gg: ASbGnctRZ8+i8EB3aZKL7YjZCpW8C0DRbonoaYpSFUcktq6cN+6/siHyBG1i2iI394D
	ZhGVaCxjim2fhJcNH3yKMdkHHS9bg16I20yT8ZLGzzmcDSU8zH0W/LZNNnggv1egWP05xIDs/Vb
	iVmxxIsrn8gyZiWIxzET3kUugM/KqCJvT+ztuCotaq4o3yJCjxisq2rNpdKpg6wU7HJvKmnb6h5
	NG6ZxjXvsDyeeVIAPZ8s9RWeryeNvvw1B5eemJb1s4OdXS1JSR2vcgBur7KWtWSBlC6/9+QL4K6
	JF+aopz9C7ploTYzYiHkDM5+5L5t4ztdBDi4M4RxLFY=
X-Google-Smtp-Source: AGHT+IHdLXi0/5MYdcKr1TOrbNGCmhmXZPpMe58vMjyl+L6tJBA+rrjOSJ0qcpePVDDZIHoYmqQ6FA==
X-Received: by 2002:a17:903:1746:b0:234:d7b2:2ac6 with SMTP id d9443c01a7336-235395c1ab7mr52259415ad.22.1748627045570;
        Fri, 30 May 2025 10:44:05 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:c9d8:e2d0:bfbc:3a26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bca137sm31128245ad.10.2025.05.30.10.44.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:44:05 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][walnascar][2.12][PATCH] toaster/tests/buildtest: Switch to new CDN
Date: Fri, 30 May 2025 10:44:01 -0700
Message-ID: <74c28e14a9b5e2ff908a03f93c189efa6f56b0ca.1748626979.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748626979.git.steve@sakoman.com>
References: <cover.1748626979.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 17:44:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17661

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The project is switching the way handle our CDN provision of sstate objects,
update the URL accordingly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3372524cb961d95993b27fe4a8d794cdb7255e09)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/toaster/tests/builds/buildtest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/builds/buildtest.py
index cacfccd4d..e54d56133 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -128,7 +128,7 @@ class BuildTest(unittest.TestCase):
         if os.environ.get("TOASTER_TEST_USE_SSTATE_MIRROR"):
             ProjectVariable.objects.get_or_create(
                 name="SSTATE_MIRRORS",
-                value="file://.* http://cdn.jsdelivr.net/yocto/sstate/all/PATH;downloadfilename=PATH",
+                value="file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH",
                 project=project)
 
         ProjectTarget.objects.create(project=project,
-- 
2.43.0


