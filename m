Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web12.9771.1612362159753030012
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Feb 2021 06:22:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=1xFIN+uF;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id u11so14463445plg.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Feb 2021 06:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U6KPSr2UdFLODw0QbaJwzKCCYkG82wEhXKAxIJQimrk=;
        b=1xFIN+uF6igiZ6LxqHiBRMwRkc8zRKLg4Y76U6gKIS43Wv3DppSzNA/ur+FQImcchJ
         3I8IVLykT/10goxD4QJb4jPyXYB0JLwufDLT/L5qRbPOQiXeUYNqWn9CfBxM6cLkqh+o
         PWEmKvwohrz17XGX69XsBXXQYoKEovISsUUsN1obdQ90X8mXirH07oMMRfWEqFAuqIri
         KoypHWlUkZEgcla3KIgZpRMVsS23+h9YVsv8piG8Y2SRXPPliJjDzZ+r2jjz53gkCFB2
         8BRKItpSHdIR8avETUBt8rpGQCDpu0NDoooUQYRn5Bmnt8aX5ZIiEMfBQ8NpFX3ra5jH
         9jNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6KPSr2UdFLODw0QbaJwzKCCYkG82wEhXKAxIJQimrk=;
        b=pdbz6EvXtqmK24ZV1/P3AxcpjLTaP+gajbJbMxY+ZyjHTAovBQNIaoKRHRj1q4TT27
         5IbicMxz/UVs+5mYPBe8WPF5muf3vQ/SthRf4JqQT5UY996GSz8kykiYwpKK7foWUYHw
         jVPg2bzZXc3DYKQFE7cI74Oudv1jLZDejzk+vd5tpxud/IrDOpV8T78UDlftIQxcC/Ud
         E1e6nXsb8QDUbFXPwPaurIY5vx7rljoBUHFHW0GnDq1oGNM2pztAAsOx3eWMBqyQwr/r
         AbcajY8PSV0HVCc5epa/kemxRZtE2dVF080OFo0GbEiK8t6IkAM7D5Pm7zipRpPSKeYa
         sVGg==
X-Gm-Message-State: AOAM531QvTRtyMim7hyAwZqtEGlqzPDwxV6BzSAi8SZ2KY5o39ge7Dmy
	PZMmmllbwuLLcKn/LRcCL+ZrFeby+Dp1eTnGD4o=
X-Google-Smtp-Source: ABdhPJxX2Bn9TJwRoZEHADsrh8TOROQfqhEbndjsJQ1WLaOiwJYeNV9tmCBVXKx2J8L3UUdhjpZciQ==
X-Received: by 2002:a17:902:e54e:b029:de:8c70:2ec4 with SMTP id n14-20020a170902e54eb02900de8c702ec4mr3473120plf.56.1612362158754;
        Wed, 03 Feb 2021 06:22:38 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from hexa.router0800d9.com ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id t129sm2882713pfc.16.2021.02.03.06.22.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:22:38 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/4] git.py: skip smudging if lfs=0 is set
Date: Wed,  3 Feb 2021 04:22:06 -1000
Message-Id: <db404eeb4d91b0285ab1e948ffc1316bfaad39d0.1612361853.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612361853.git.steve@sakoman.com>
References: <cover.1612361853.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mauro Queirós <maurofrqueiros@gmail.com>

Git-LFS objects were being fetched even when lfs=0 was not set.
This patch disables LFS smudging when lfs=0. That way, only the LFS pointers
are downloaded during checkout.

Signed-off-by: Mauro Queiros <maurofrqueiros@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 646d86df7de774255246a3d7051c308e43eb257d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index dcecff5d..59afc32d 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -475,6 +475,9 @@ class Git(FetchMethod):
 
         need_lfs = ud.parm.get("lfs", "1") == "1"
 
+        if not need_lfs:
+            ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
+
         source_found = False
         source_error = []
 
-- 
2.25.1

