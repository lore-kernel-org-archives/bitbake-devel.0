Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web09.9800.1612362165324887586
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Feb 2021 06:22:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=U2oaHdFG;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.48, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f48.google.com with SMTP id nm1so4459153pjb.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Feb 2021 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=COeyGI6czC8zczjsXJWL+/SqbNmMXGc3A5Nv9ZzRVBs=;
        b=U2oaHdFGzCCjCQEiJEFJHQ7GSOkoEWsl1o6zOVK0n8xTRyd3mu8MybHKiWBt2+ikj7
         LZBfLsHXbuQRUUbXtkQlwYNYRuTvVDIQLNl6auMU703bH4Mru1O1loA2YIb2G7QcqxfB
         06Y99IMOw7NRM5pPMGWe7tcJAb5Dvh2Zxq2HnMNgYmk+0T59dg82vyH93ivLC6YZPIWq
         oRkzZhxNHI2ExczWivkhVcTlXaj6LG4z2mEl3afNt+uiQc0khOVSRTEKEa0hq30wYaSD
         mgq15tIfUXD9MS/dzdHcKJtIjAhfsyS+XerUGKW9wYxdwSoqrIjmFMMR27/joaZRP7t1
         LmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COeyGI6czC8zczjsXJWL+/SqbNmMXGc3A5Nv9ZzRVBs=;
        b=J/+Lbr4K/sebOBLMAA5AT4FMeEe5pENoKH1Pjs1nOu04FN46EYgniEOItSw0T1LKBS
         eOmGU6/5LOuHCQ9IrK7iPjL7ftgAicQ/iHvrKNnmBFRVD7KpPGn+85m/mbkNhvNdKMdc
         9QoZsVIezT88b0LolGLh3YCqt6PHDesMO2BC6mo940gCprQQzTKdQVo8iX+L3SY11O3+
         EbEsuKZ6rV9Be4YuyMu0Mnv191K+QUzm67RZtGvkFn3vjh/cFUs6Drgphyp3hbsZzG/9
         DyyhfQsM6GhoECtWkJeIC7/uoOYCiTFx4EKrV0Ye778gxc+z/KNoX9Io/ojxvB5fHatQ
         otlg==
X-Gm-Message-State: AOAM531j3Thhp+LPuB8JhoPEDBtkMOM5GUtJFRRpI+hwyS+Nk6HKB5AB
	XulAmJLwDtatjR9dNwnfOfcZNi2dN2eOM8AmC8I=
X-Google-Smtp-Source: ABdhPJyLPLKHgcGgD3LkeO3oOCo1JI6jNObRbrAfYQESY0P0OvcdjO1VdpADqu0y2MP0wQd+TgQXOA==
X-Received: by 2002:a17:902:7c88:b029:e1:c7d:c26f with SMTP id y8-20020a1709027c88b02900e10c7dc26fmr3300581pll.36.1612362164362;
        Wed, 03 Feb 2021 06:22:44 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from hexa.router0800d9.com ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id t129sm2882713pfc.16.2021.02.03.06.22.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:22:43 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/4] git.py: LFS bitbake note should not be printed if need_lfs is not set.
Date: Wed,  3 Feb 2021 04:22:07 -1000
Message-Id: <4a4dd06aa061e827c161430e963c812d50bb3585.1612361853.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612361853.git.steve@sakoman.com>
References: <cover.1612361853.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mauro Queirós <maurofrqueiros@gmail.com>

The message "Repository %s has LFS content but it is not being fetched" was
being printed, even when Git-LFS was available and "lfs=1" was set. In those
situations, we want to fetch LFS content, so that message would not make sense.

Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 45028dfda5a29a34ab408cb3f11d72ae17963340)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 59afc32d..bdbfe5c0 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -509,7 +509,7 @@ class Git(FetchMethod):
         if self._contains_lfs(ud, d, destdir):
             if need_lfs and not self._find_git_lfs(d):
                 raise bb.fetch2.FetchError("Repository %s has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)" % (repourl))
-            else:
+            elif not need_lfs:
                 bb.note("Repository %s has LFS content but it is not being fetched" % (repourl))
 
         if not ud.nocheckout:
-- 
2.25.1

