Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.13662.1612652938326996112
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:08:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=hj7Pr2HV;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: akuster808@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id cl8so5686554pjb.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=joe1kNENLFLiKrk4JUrG8+UYWKuqLAeuSf3I0p/ao+I=;
        b=hj7Pr2HV+KpAZnQFjRhID4tphKOVBC+woemkZzZAvRtG/X0naFSpEuVTN82+zx0qa/
         fEo+jElSdv5L4YWxi4LJ1whLrOQUy6Uq/0BCknuHVQkF1PeM/0VAUenWk49aIxyBUT1y
         cN/Bz7TiN5Lgsr8mQHAKpSrfdC3EJnQhA7Uqs2RucwvV0o6qMb2o6uaYk4cDYQ2qowcB
         /ehibSWAYnDA2B4mdxGpEfalnuX3a7zg6Vlp3nzoTFRjAz8992G9A1G36ukqsWqgQ/m7
         qMCYvAb/i+Z8pI0+dF7rOmZQEyJtMwUPreiAKcfRlF2glHQ+Cz27n9CEvT7wI/B1ilv5
         ZCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=joe1kNENLFLiKrk4JUrG8+UYWKuqLAeuSf3I0p/ao+I=;
        b=NAvk8Gb+nIJliSp+3H4kY4t0YLvcHGdyFxpA2nLDMCONktcOCyOk9gkpquxiuRc1Xz
         XL3p555D/+OciDjqjYYn1MKbzHHYEyYgKSxbLQ3Z7PoTh+otu2DnTXxa3yf3fIlA2oYn
         k3vcY0SafFo55acAn91Ch24+SIYlKMMWQiuy1lntVwTBELlO1kYAu0PgYKWuTzuI/Wfu
         +nwnn4KLQSqnR3LYTf6RKnh4C1dQgtgrazQWiM4jmLBworzlU9r5VCAVo6FBfR+fHuz9
         Q2ItMqRv3wFbZYGT+RmxkGLQQQ7te3rFqmqdlUmSgkGcnpeSp5oYAwRouE6W+vR10i92
         A9dw==
X-Gm-Message-State: AOAM530NgXQ39e6f2Fwjx4OoRnjv8q2Jaj2SWwj+s2mo6F+gE9+8Hj6L
	sqQ5nbwOkDpJiCdiIpHIDhqAOBlDsJUZMA==
X-Google-Smtp-Source: ABdhPJztyI8Q6Oo5OY9H7OizsuA3f468nRn13IdPzkI7Nx/HMvDyX1sD2IhL+83oRz+VFP7LbaddQA==
X-Received: by 2002:a17:902:be0d:b029:e1:4ab:8fd2 with SMTP id r13-20020a170902be0db02900e104ab8fd2mr10286639pls.6.1612652937792;
        Sat, 06 Feb 2021 15:08:57 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.08.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:08:57 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 06/10] flatbuffers: whitelist CVE-2020-35864
Date: Sat,  6 Feb 2021 15:08:43 -0800
Message-Id: <b5b2f97772780bea9fe10d358dab0807ffc6b1ad.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
References: <cover.1612652802.git.akuster808@gmail.com>

From: Mikko Rapeli <mikko.rapeli@bmw.de>

CVE-2020-35864 is for the rust crate for flatbuffers, not
flatbuffers itself.

https://security-tracker.debian.org/tracker/CVE-2020-35864

"NOT-FOR-US: flatbuffers rust crate"

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-devtools/flatbuffers/flatbuffers_1.12.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-oe/recipes-devtools/flatbuffers/flatbuffers_1.12.0.bb b/meta-oe/recipes-devtools/flatbuffers/flatbuffers_1.12.0.bb
index 1abfc8819d..65f7beec40 100644
--- a/meta-oe/recipes-devtools/flatbuffers/flatbuffers_1.12.0.bb
+++ b/meta-oe/recipes-devtools/flatbuffers/flatbuffers_1.12.0.bb
@@ -14,6 +14,8 @@ SRCREV = "6df40a2471737b27271bdd9b900ab5f3aec746c7"
 
 SRC_URI = "git://github.com/google/flatbuffers.git"
 
+CVE_CHECK_WHITELIST += "CVE-2020-35864"
+
 CXXFLAGS += "-fPIC"
 BUILD_CXXFLAGS += "-fPIC"
 
-- 
2.17.1

