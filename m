Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F8C5AD49
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 21:26:45 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.50.1748640404359367896
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 May 2025 14:26:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=LrchiHu4;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.179, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350b1b9129so14482685ad.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1748640403; x=1749245203; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hz76oaIhqN0E0HjBJseH2MLMf+QqL8Uh8HACVe1Elo=;
        b=LrchiHu4QpvtNd26uVlG/1co2cHS0TA0NYDctYllco+lvDnPrxzmiW45mzZJZOrIlW
         qsjp2eaZ3yqpeHqtTdFUnKFrJ6a9bX1w47GNeDZTUsWQIR05yDoYNra+P14nHYFp3xua
         PhYVICFVOZbgR57+8Xjq7hTDZUsOxIHNvpU9Jv1FV92JGTFMhnOc0dkisLkDLg9sUhEc
         yUlovXAGr4QgSIg1GPfiUyyo3P6a3REv7lZspxls6RQ0Ox09Mt95AlnD71csH8ErzeXH
         rL9kW0+wJ1a8WN3pF8t8S1Ds2rsnDF//ng8sPMl97Ictl/tF99n2455cW9twGU027SVi
         xYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640403; x=1749245203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hz76oaIhqN0E0HjBJseH2MLMf+QqL8Uh8HACVe1Elo=;
        b=STt7cRRXRJK245zNC3QAXJw42LWeiE4XNK5tOd+r2HZZJIzCdTNnAhsdyK3FCdskQy
         1/F+diPnZlCDnCnJvEcKrETNkbSqjJbreO1cz+1yoUvyVsBnzdFidtYVaoY1mj5IN9pY
         AgP2KercV7U/zOxgb220W4JCMMnuK1lsFVYq3JEvPdwA+INRZFDGRFryONrMnd6FUP5U
         nGIXzPLN++T485Rj6KbBa02R48/AdronAzxXF+IJ3qRxhJSoP/VntZlzzQBiWgLBK1ae
         GEveipELv4j3kg1ot4yO5GzPjihIZnYcxXAurgccRXjQ6hP0gB3TdHFwsCoGXNVr+Ki4
         yExQ==
X-Gm-Message-State: AOJu0Yzz5peXiURT9hlWv/tHWiHbatEzY+GmoCcLAzYfAp+ixQWrp6Gr
	VcURpSaEeWfiXHQZlCFfVL2xo2hvYRP5FfxxtQ2docpwTjP5+jpH6LUUvmFtCFkB6j2Eg9VHMtY
	8tVgu
X-Gm-Gg: ASbGncsSTRar1HrXU+yIlMv2ANacsEDhKFF8MH5FGedlzJIF06jH1lrS9HS8U9kc9hW
	ehXetSCsEMgd6Xnt+kc3aGrc9dYxebWB+ntcPwgkItzImWMjc9vK7Gl92Vcmey5GlQhusvvzARY
	3rCFN3nje5LaljWO24GMO/a8PsyFxRBNq7ORAAOqAeS2NXOww3qeZALeSdxtUen2KZvxxxZ/lKg
	jgqqSFanmv524ZyQKIqG5vyJ1uwBtUQwq6oFVQAM0rJgIPdgrEF01+e/8gTeMoodUep+BHIhqOm
	nWOd/f2eWg7XYAwF8JPfbNwalPoAieR8CXxbWN3vro0=
X-Google-Smtp-Source: AGHT+IESVgcK/aBwjGDguQ8RdgMZPjVzmr8ZmfWgRX9E7cv+3lkSsLmDw/mB0UXi0ty45tg7GUa5AQ==
X-Received: by 2002:a17:903:3ba7:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-2353981e62fmr46461985ad.50.1748640403622;
        Fri, 30 May 2025 14:26:43 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:c9d8:e2d0:bfbc:3a26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf50c9sm32652095ad.162.2025.05.30.14.26.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:26:43 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH] toaster/tests/buildtest: Switch to new CDN
Date: Fri, 30 May 2025 14:26:36 -0700
Message-ID: <aef3536b6e4cdbff6d3a171e183811509370b9f9.1748640301.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748640301.git.steve@sakoman.com>
References: <cover.1748640301.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 21:26:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17662

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


