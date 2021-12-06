Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48155C433EF
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 16:41:27 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web08.54241.1638808886695437327
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Dec 2021 08:41:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OTN2RCvT;
 spf=pass (domain: gmail.com, ip: 209.85.128.45,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id
 d72-20020a1c1d4b000000b00331140f3dc8so279995wmd.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Dec 2021 08:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fOYbGTmwl1u5DZ/JB4UR4Oo3Jf2BEmQAIaWN9O/tRxU=;
        b=OTN2RCvTycj4sWtSE301uOu3vNCDIZuL9sjz47bf/kzbEAamepI1oUUtwArIIuLTyB
         MzyZ3HuUFsH4AEyiWh1gCdJvmVIwwKEvpUihKubUgtO1AazFJaq+Wqr1jV4Xsw6hKi1s
         Lm+PvbMZUjlAIpELUwTDhu+oY4pM0S4q2Qmx7N9RwblH3EWxjmeP3o181yoMujGEx+dZ
         Z7NB4JCTBkkVKkBiDVz2CuzxvCCTpgRRVQeok36MLOmW+75r95FL7nzyS187jKs8mcZR
         nCKlE9yYs23FmRUsumw56TKb2WAQ9qoHyjBSYCKcRD8ScrMn5pxamAtJmeot1l99gZLf
         beLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fOYbGTmwl1u5DZ/JB4UR4Oo3Jf2BEmQAIaWN9O/tRxU=;
        b=XrgrSXNuQAo60ZJLnnnTkgJeL378HrXKpNscmwXB5lnzFMebh3aU4esi/US/Sjx3aU
         I9TnRavXxd9YkV9+FpnsR0I5i5i/p9VfNt3NkPO+ISlW6jQrif8eRq0rB4hPcrSHnUmJ
         xa86j+7JlANV69HhdsGDLBOfFsxiNXcxmWJc0tJNvW2ZwHFUb6DL8lUAgW2/VvnsflV+
         2GuOlACVfhA//xtLGcyxxKOfbXhFDQrOxL+SMqSNidWNYpMxdZO0yS4m4Z0sjHurQUUR
         xeVtUg1lXAj5laJCg4Qf8lYEpJnjkWNNfjVm2N3BVXvBPIfy2BiDobbMlaXBUT6lbpRA
         Yt3A==
X-Gm-Message-State: AOAM530+l5vYew+Sui4fs4JuHBe8pfQwtWdbBFhA3Tj1hP6s44OeyJNA
	UkQNL3Pa9Mpg0KpjsgoYOakN5wv5LOwcCQ==
X-Google-Smtp-Source: 
 ABdhPJy0rCfhMHggm82jLYCCiyLXo+mirbR+nYouh3BkyRqYjvmBL3Al2TIxuLtr1FIvQlUvg03SxQ==
X-Received: by 2002:a1c:4c13:: with SMTP id
 z19mr40340899wmf.143.1638808885192;
        Mon, 06 Dec 2021 08:41:25 -0800 (PST)
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz.
 [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id
 y12sm11630615wrn.73.2021.12.06.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:41:24 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] fetch2/wget: do not hardcode tarball compressors in version
 check
Date: Mon,  6 Dec 2021 17:41:19 +0100
Message-Id: <20211206164119.4076119-1-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Dec 2021 16:41:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13133

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index fd9b304961..3021ef359e 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -583,7 +583,7 @@ class Wget(FetchMethod):
 
         # src.rpm extension was added only for rpm package. Can be removed if the rpm
         # packaged will always be considered as having to be manually upgraded
-        psuffix_regex = r"(tar\.gz|tgz|tar\.bz2|zip|xz|tar\.lz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
+        psuffix_regex = r"(tar\.\w+|tgz|zip|xz|rpm|bz2|orig\.tar\.\w+|src\.tar\.\w+|src\.tgz|svnr\d+\.tar\.\w+|stable\.tar\.\w+|src\.rpm)"
 
         # match name, version and archive type of a package
         package_regex_comp = re.compile(r"(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s$)"
-- 
2.20.1


