Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C63C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 13:31:41 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.14494.1741872693115452273
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Mar 2025 06:31:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gCzIQcR/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso6463565e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Mar 2025 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741872691; x=1742477491; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/zlz6C58soMUL2ckeIZ6xmNy1j/awzK7Hi97Z5fC/YY=;
        b=gCzIQcR/jnuJLbxicfo0nCmsfhB8LAl4l3gz0CaYH8X5p82AkxrsH0/3w7eC31Iklv
         gqACA7DaNzDykl1CtJUOaUHRRHkGReA/liganD2TKtRWBo5wA6yi1O6zVl6SFjdc5trZ
         p9NWMHPyezB8KUPU9xcAwV4eoX3gtK8wMpLVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872691; x=1742477491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zlz6C58soMUL2ckeIZ6xmNy1j/awzK7Hi97Z5fC/YY=;
        b=Gyu+ioqOD76VLuI+AaI1bT0t76gfwXveHD1ApPZvNdmKG6uWfklY31/US7DBGvRUmK
         uBRjDGTvufUtzwG7uF5UsjSEJD3O/WXSpt298l3NV44fIU6tRPvw2/zsg4d0rrrP4qtO
         yLxpXSaUlHUEEFYMPL446w6aOPFXOQsKoUNJS8DzlXrX9VtuLvcqNPtrbIW35vq7MRMj
         MB/miEWF4y4VhH4D3DhqZfd/I19m/rC+FZd1mhbU4UxRGBwGvr0HhSnCIzobpjPNn5Yy
         VyK52B10Be81SmnAws9M/zQQIC7jRzro7B8ypBkRRel8Sbp9nDE0UIA1Y31mOeX0gvNi
         D6Dw==
X-Gm-Message-State: AOJu0YzMnZsKuZoICXRHbD3RTvhB/r5WObA3CfzZr6TJ9hNWwyMwVwUr
	DmrGGe5csfnbsxfE7ZJPfimdmoTv+uZXsxJNwA2xoDyxyr8l7sCxHydYWitT85sVP4lXQbDgadN
	T
X-Gm-Gg: ASbGncsp9S7pf8p4tuLifTNB6xXNMCyiu0uAvZKE7myAwzrQfOFzEa/9FtyM0oJKPKD
	rxRc3txwdy1eJ0tRWcyTMHHkN+SCja9s+T9Ixx5wZttud8kvUWOAZph1QD6x7qIo7H91160mzY4
	ru+Kfeeh/zTgFNkPChbhku4KJrd8+bDp2pWl7DBrHnoAw+p5a9o6IDFM1NOvxDrlX3D0Cv6Xwf0
	ILVJi6oebeLQ7J1mOnjVof7KMZv98nH24Xz/rgFR80F/EnNEJjSf4f9GDf7fRziwCw+gUh5pUl6
	DtWFTvBCvz+d6kdt1327WXPbMp+SUS7chdbkrLCCGyzbNgPEHp0YjyT26mZ1c/j/R4cISh84iQ=
	=
X-Google-Smtp-Source: AGHT+IGH5WOYZgfipbfYfcoEeevyc7Vgt+r+DxabLlur/0rLyWHhRm544E9vn9GqhIBri28acxJ0/w==
X-Received: by 2002:a05:600c:1546:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-43d0a900bb5mr50227205e9.6.1741872690788;
        Thu, 13 Mar 2025 06:31:30 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:cc37:5f80:1a41:4bc8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74d339sm53339175e9.14.2025.03.13.06.31.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:31:29 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Ensure module dependency changes invalidate the base config cache
Date: Thu, 13 Mar 2025 13:31:28 +0000
Message-ID: <20250313133128.3345603-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Mar 2025 13:31:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17440

Changing module files was changing the tash hashes but it was not invalidating
the parse cache, leading to tashhash mismatch errors during builds.

Add information from modulecode_deps to the configuration hash used for
cache invalidation to avoid this and trigger reparses when function library
code changes.

[YOCTO #15795]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 360068fd0a..8e7dd98384 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -1120,5 +1120,10 @@ class DataSmart(MutableMapping):
                     value = d.getVar(i, False) or ""
                     data.update({i:value})
 
+        moddeps = bb.codeparser.modulecode_deps
+        for dep in sorted(moddeps):
+            # Ignore visitor code, sort sets
+            data.update({'moddep[%s]' % dep : [sorted(moddeps[dep][0]), sorted(moddeps[dep][1]), sorted(moddeps[dep][2]), sorted(moddeps[dep][3]), moddeps[dep][4]]})
+
         data_str = str([(k, data[k]) for k in sorted(data.keys())])
         return hashlib.sha256(data_str.encode("utf-8")).hexdigest()

