Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7986CCD1A5
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 18:29:56 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.20570.1761071393416144821
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Oct 2025 11:29:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gRAypF/t;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so1226096366b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071392; x=1761676192; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXvmfESRxNtg9fgt/TY5148YzCRNeYFUs1NPw/I5ySY=;
        b=gRAypF/t2Uh0K0CV1nq+zSKtaZ7slM5+V0inSBkqRyYh/PLBXWkx9NH0J7+jc/T/zS
         8u4gIpw8GkxMzSN0Hs6/q+Mle/ziHMPlT5HLgOvkfJuXSGiw0hi6apkV8yHZO1wW7tCi
         dYpmioZVD0yEUHFVtarIld5G78Acz+ek3V0HwDaognrR2LWPdMu56tVggbZnY9lZlw0K
         B8pEX4k0ourCqCJ4k1MrVKywG30sO31ZcJZwvVtD/UDlZQg91Xn8zVln02IoZ5P31Ssv
         IVXqeX/yobVG/jSbTQeAciTYwbY+kn15n3YeXT6ho9+JeJW0hopu+T4zPsElUYDe0YNy
         Rtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071392; x=1761676192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXvmfESRxNtg9fgt/TY5148YzCRNeYFUs1NPw/I5ySY=;
        b=l4foWyoKpI05+j2xYnj4L4RGtJkIgBhSfcUhyxnjwJ/X1oWHOklAjvG/Betud24j+p
         ZnX0AfL1gILhoHOgBerVxzJfQdKiHl6RSlaTm3i6QgWrLAD/mI9Xbl++hDOAwGxTOz3m
         dils5/20kgVb/gJDpJisjZXSzWnnOOK0p1r/BYe19faMAw9k25qzjo99/C5oMVtBo7yQ
         WO0L0kcK9e0hrnzJSN/MYZWN8S+JN49q3aXRFWOoN7kaLAIhJ5ZK1G5xQIEP0tzZpvwi
         lDBc5KCDLIRV41dDvL99/tScL+WEgH+dI5yvfXwM887EU/sE0bIn9vu79lsIegzKZQyD
         EXNg==
X-Gm-Message-State: AOJu0Yztz+3lynNdkk7y3Ln0Xmyd0g7C1GQoWq9cTcCYLGhyxK4I2HUu
	UFEoMLWrzJyw6Gp+nCQIIzBNGZMyCaJef4lCwYl0gXhFJBVJSn5UN3MSsBnZQg==
X-Gm-Gg: ASbGncvNSHsCobVjw5vceZBBmflnELFLydrzqL+hGddzLNKdb/pFE8N3rjLX8O4cX+q
	/pKeyneXRnFR7UpYMaT71qpcqUuhl/ecXwQG2PCLtz2AP66HuH8tmWZbRPCNa+0Tq/PN88p4Ezu
	Aqd4/CnJV4Qqfn408Tm0PggZ7BNu1AI1NUzDdW68H8P6xCCMBL/WjxMpvDMI5ElFCs3rzRySxKP
	hHe9A6ToMkCmJSUMcwL6VMR1zcGzhVoJY/sr3oDH1sDiffQ2xZdVCIu/OWy0zmYhozvQTKKhjdj
	gsruiXjB0G1JIQ5YUfmMfYRJ7e2Mhawhah5mswEdThrZDwkzOj4WbfLDrtEKpjEOXi7KCXq9tx9
	0aMYBbHCbnShzRqXZrxbOpXvl+WdIQ8qZekLdXOIjfBCLvC3bqiSh8wJS/FyS3QyVSlYt71ICxe
	a0PPZ9PhvPZmejn5SEtzWe
X-Google-Smtp-Source: AGHT+IEOo6eCOSyNCprMcSNAQEh5FJcediWDtVvll1jTGDDv7eF1X+pUXFmPg+ZFSv1i9T2Apf/dKQ==
X-Received: by 2002:a17:907:3f04:b0:b3f:a960:e057 with SMTP id a640c23a62f3a-b64749411b1mr2269258666b.31.1761071391552;
        Tue, 21 Oct 2025 11:29:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:564c:7f09:5ade:5a5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm1151383166b.54.2025.10.21.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:29:51 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>
Subject: [PATCH 1/3] doc: bitbake-user-manual: describe UNPACKDIR in fetching
Date: Tue, 21 Oct 2025 20:28:32 +0200
Message-ID: <20251021182834.11403-2-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021182834.11403-1-adam.blank.g@gmail.com>
References: <20251021182834.11403-1-adam.blank.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 18:29:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18198

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst  | 8 +++++---
 .../bitbake-user-manual-ref-variables.rst                 | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f357765b7..d10d2f611 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -42,7 +42,7 @@ The instantiation of the fetch class is usually followed by::
    rootdir = l.getVar('UNPACKDIR')
    fetcher.unpack(rootdir)
 
-This code unpacks the downloaded files to the specified by ``UNPACKDIR``.
+This code unpacks the downloaded files to the specified :term:`UNPACKDIR`.
 
 .. note::
 
@@ -51,7 +51,7 @@ This code unpacks the downloaded files to the specified by ``UNPACKDIR``.
    examine the OpenEmbedded class file ``base.bbclass``
    .
 
-The :term:`SRC_URI` and ``UNPACKDIR`` variables are not hardcoded into the
+The :term:`SRC_URI` and :term:`UNPACKDIR` variables are not hardcoded into the
 fetcher, since those fetcher methods can be (and are) called with
 different variable names. In OpenEmbedded for example, the shared state
 (sstate) code uses the fetch module to fetch the sstate files.
@@ -606,7 +606,9 @@ password, and fetches a Revision based on a Label::
 
 .. note::
 
-   You should always set S to "${UNPACKDIR}/p4" in your recipe.
+   Your recipe should always set S as shown in the following example::
+
+     S = "${UNPACKDIR}/p4"
 
 By default, the fetcher strips the depot location from the local file paths. In
 the above example, the content of ``example-depot/main/source/`` will be placed
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 810f88689..e50b71380 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1697,3 +1697,7 @@ overview of their function and contents.
    :term:`TOPDIR`
       Points to the build directory. BitBake automatically sets this
       variable.
+
+   :term:`UNPACKDIR`
+      The directory into which recipe's downloads are unpacked during its
+      build process.

