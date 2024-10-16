Return-Path: <riemensjesse@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C41CD1AD38
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 09:36:26 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web11.19255.1729071379912641938
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Oct 2024 02:36:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=U2Ju431C;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: riemensjesse@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so5502198a12.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Oct 2024 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729071378; x=1729676178; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYdCj/HVImj87yxAuv7X0FBLu4Ims2s/CR2LU7U9jxE=;
        b=U2Ju431CPPSyfEhq2mxaELkG1O10cl63KQh1JsnK4C3l2Sk2UYOOS4qMof1ZcqP1gd
         J/vlhPBAmROi/4pWDVuIGi6q74huGaRUEUAaINb0CyZOl/Rg0Itt+LgOzsnmNXzYwYoN
         6ooXcpUtZd53IYhle4Z2e0RPtA9WpvbCv+uP6WLT3EkXsqFRh/Xr5TLeQByNY721Yylt
         2DXpKDzpWmwqBf6pPNWdlEXMYnW1Af9FhR3bZxdV4GaKaCpOqfkTZdwdzVnwqUMISgr9
         HUUHCXULMaao1T4LirsGR3CYiSD4nUPDO4qHwrsN8ljD3wqN3omIRtGcjMsZ5GXl5J5n
         7e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071378; x=1729676178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYdCj/HVImj87yxAuv7X0FBLu4Ims2s/CR2LU7U9jxE=;
        b=oEt8RN2HyeVHu4tZ0i4iC0Jik8Uab4x8T28+FeK5C22ukHKom0OpaPr7iEG8qy6wZj
         CdbAUZXOg0mtfDc/qeeLMwiJyRGiJrLsWuqvfxLQcd8/NU7DQJtaSy2V5yeyVxd0KYhA
         RM9xJiPQbFFkW5dKELx+HhFKskFLnr+bTBJ4A5Lgi5Z+zvoVjy/2nYABWLAla110IrGO
         KZzyTTRtbd6YEH071mPl3SR4dpo0Z74gp2JF/kGJvBa6ZOM/Zp4plBIDZCHc0i5iS4FA
         Y8Jbzn1qlPdm9tdCv9DaEK0mJztOMZaEjMbUHpy1y/L2x9e7WfIwCG+czjMXT9ec1dte
         4Syg==
X-Gm-Message-State: AOJu0YxUrDfiTm0zTMAP8CsUEYacSqjQnj20peVOUu0vIcstBed5OgVs
	/n3r9S4KKohkHBHgGAGPAI0udzH2NWCFwT28DEjBMdb1PLshSw41+cYS7r9T
X-Google-Smtp-Source: AGHT+IF4NMMhFL3lF5h8tT0zTQN2R+lJlaKLVN4J4/D+BCyDYIOKsWP6of+zLZFRU6C2gmY6Yy9w1w==
X-Received: by 2002:a17:907:d5a0:b0:a99:f3ab:c58d with SMTP id a640c23a62f3a-a9a34d6975bmr290718166b.16.1729071377584;
        Wed, 16 Oct 2024 02:36:17 -0700 (PDT)
Received: from jesse-hp.localdomain (216-130-172-081.dynamic.caiway.nl. [81.172.130.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2974c2d0sm161649366b.85.2024.10.16.02.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:36:17 -0700 (PDT)
From: Jesse Riemens <riemensjesse@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Jesse Riemens <riemensjesse@gmail.com>
Subject: [PATCH] contrib/hashserv/Dockerfile: Add libgcc to image for runtime dependency
Date: Wed, 16 Oct 2024 11:36:14 +0200
Message-ID: <20241016093614.91540-1-riemensjesse@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Oct 2024 09:36:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16688

Libgcc is required as a runtime dependency. Without it, we get the
following error:

OSError: Error loading shared library libgcc_s.so.1: No such file or
directory

Signed-off-by: Jesse Riemens <riemensjesse@gmail.com>
---
 contrib/hashserv/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
index 74b4a3be1..aec1f86fc 100644
--- a/contrib/hashserv/Dockerfile
+++ b/contrib/hashserv/Dockerfile
@@ -11,7 +11,7 @@
 
 FROM alpine:3.13.1
 
-RUN apk add --no-cache python3
+RUN apk add --no-cache python3 libgcc
 
 COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
 COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
-- 
2.43.0


