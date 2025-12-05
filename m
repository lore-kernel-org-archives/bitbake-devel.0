Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730B8D3B7CA
	for <webhook@archiver.kernel.org>; Sat,  6 Dec 2025 09:09:30 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.94.1764978073879186862
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Dec 2025 15:41:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GGRSq1dA;
 spf=pass (domain: gmail.com, ip: 209.85.214.175, mailfrom: swami310@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297dc3e299bso23982505ad.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Dec 2025 15:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764978073; x=1765582873; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=up7GrmVv03FDKlz+Yy6e92KJRxCWnu0iT52hFYe0oZY=;
        b=GGRSq1dA9n/Rd+oVRRft69vJOVjGCEI3FNBu7F/lA/AXrrVkDzDV7DZPgT+DxjIp98
         FbfjD1P8OoGBjN/CPdDD46CjyHw8DWEadV0yitpdNfD9zyx/nU4wB+tc7pU4U+Cz+umL
         BCUX9VZ9ZLfT0i7qqaL61OPFK911RhGvBPhNywd8/TsWI9Vmz1qpM5XFMPl0iNg6N09Q
         pPZ2JuOMOnzO5Yefzgj35HMF+sARa6Z1FNxw1+RYO+N2kiVjYT8XVDwVc5jOwu1Tv3gO
         HP4SSzMfKB0FJ2PDetG4CF1htgCUbfOid5yr05frPUXwu2+K5qGHGLRppuWZpRh+FDSO
         AMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764978073; x=1765582873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up7GrmVv03FDKlz+Yy6e92KJRxCWnu0iT52hFYe0oZY=;
        b=tspZXxMiyaa67dXuWxIKJs7ui4YftFvp1XbhgjOoiPAmdcj8u7wsF9cy0l8mq32hmF
         z48AuI5+3cI1j7QQ73mUOq+Yeis3KoP/uZN5xloyKbXS4xUT/YCnYatxs8gYbMuyJ9dn
         tfdWiq/CTOinHNl0xSzZ2ZIvq0lD10Aljut4QB9FoKg6A60XD8uZbR5DOTEe1zUqohBS
         oY+YiKH+4dlzu2nXS9kn8VFWCGXnVq/3EvZDY8bHdEEUBaj8tH1J704az7XdDJOPMh6e
         IAhUDfG52ay9vlz8RBIi6clgJVyQR/2wjx4u1hhCYwXdZyouVV9x9e7bgAPIoxp8f/+1
         fmXQ==
X-Gm-Message-State: AOJu0Yws46FvioSecGYdADvM93/4oQRuzIkHDBa9Qjp2XfdsMohxZJ6x
	/+tOAe3aL060791/PBhHauRV/Wf8DznYDcNz3UFdpWJB/XvylRb1PSh+2Dp+jA0a
X-Gm-Gg: ASbGncu58mCXm7HHYrOfP5VeqZKeZCfi5LTuCmXfIbP/dt0R3g2Ci77YEVRvv3F9nld
	wZMS5bX5lBEYYzsfgC83pteEZiON3+PTZrMD7PldGnsq7m6vvjYAROl0Tp+xnCSScLKAymt9grP
	nViODjmeAyV76f5c8OaBsquf05PZK75AyXpiTR8v1HRikdxO8G3qlId8tB/vmyLdm+yv8rQxj9y
	UPq3ZCxtEWy+AWp9+6lURmuOPP73oT5SVONT0oZJnw5xncLVtXo68y649bEjmxBkApL7FFXt2JY
	wK7pCoNfuJPsy8ZrMnHqoJjgAUfQz9D5oBT6abDD3wg5Ljcv9c1Q2TIr+g/WGYd2Gl1l7a8Zvi0
	BLYHRuIw4LCRFak3QTw5Jw/bDLtBJgLFTumHX9vDlfz2l4EHu1R0hCXvbIodGjr8eGfbF2rxq4g
	tSCa0DU4SdLgzCv1Kkw2rDQKJbZ5pzK1j0f2su
X-Google-Smtp-Source: AGHT+IHvu/CojEQ3Lpq8HZXPjj3YuTcCrWWGketIU/axRkMSbUazH/P6FH16zysqRtUTzVtDFkcwfw==
X-Received: by 2002:a17:903:986:b0:268:cc5:5e4e with SMTP id d9443c01a7336-29df579e8f2mr5342345ad.1.1764978072779;
        Fri, 05 Dec 2025 15:41:12 -0800 (PST)
Received: from lenovo-ThinkPad-T480.. ([2405:201:e00e:f108:daa4:9a3f:4443:ba80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6ae0sm58759225ad.93.2025.12.05.15.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 15:41:12 -0800 (PST)
From: "Swami" <swami310@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com,
	Swami <swami310@gmail.com>
Subject: [PATCH v7] bitbake-user-manual: Document BB_CMDLINE
Date: Sat,  6 Dec 2025 05:10:33 +0530
Message-ID: <20251205234033.6363-1-swami310@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Dec 2025 09:09:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18549

Add documentation for the internal read-only variable :term:`BB_CMDLINE`.

Fixes [YOCTO #15746]

Signed-off-by: Swaminathan K <swami310@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a..32860ec0c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -116,6 +116,10 @@ overview of their function and contents.
       Specifies if SSL certificates should be checked when fetching. The default
       value is ``1`` and certificates are not checked if the value is set to ``0``.
 
+   :term:`BB_CMDLINE`
+      :term:`BB_CMDLINE` is an internal variable and is read-only. It captures
+      the exact command line used for the current invocation of BitBake.
+
    :term:`BB_HASH_CODEPARSER_VALS`
       Specifies values for variables to use when populating the codeparser cache.
       This can be used selectively to set dummy values for variables to avoid

