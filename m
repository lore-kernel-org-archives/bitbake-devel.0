Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72658E7AD71
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:12 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web10.110654.1696344787522546448
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j85z2dET;
 spf=pass (domain: gmail.com, ip: 209.85.160.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so672466fac.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344786; x=1696949586; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFwb4QmsIr48JsVIP/uJ3wtNpRoCIU21ziKjfyK/fPs=;
        b=j85z2dET6gDWLnY4yG8KkBNOVIvCS1Ze5lq+b2r/mUTUkUnrVsAfzRyBTKimEXbFL3
         iWOw8lu0/zkymXevAdZIjJC8qfzn96MlD0xp7QC7XcM9Hjb1daop2py33JKv0pszJPbW
         UK12ukCh3zBF9m25x8TbkCdG0MW4mgdSSEC8uxjbOvayCWcmgczQ3+DLAd5om46r8tIy
         STbhrb6WVAUptNaKZ7+jyXxdaSpITS9Q8/hkXUF5d3eyBf4sgkDFiTeM3hXWhapH+KTh
         MkhUjXsRnuNMg2Ei3sLz41G/gmzDH2RW7pzqeC881faxus7r3ysSQ5o2JdFTr/WACAxr
         vGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344786; x=1696949586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFwb4QmsIr48JsVIP/uJ3wtNpRoCIU21ziKjfyK/fPs=;
        b=PN17mVsniwlVEMGbJIzpoOXlxZbQtN0p/w2sF7XWGXyZD8gcnyTqUI4Xjr6DlSpYNT
         tj4T4/2cLlOnj7kqsoeOcGR1T87v9D0tSoeia78iss/XiHeiMGIpiLC4OxSuZtJhVhSP
         O74aESOtjnPwKvywXOWLnziIfy3yN4T2q9txBV95V35Y+cMA2wLw5rS1uel4COrzZy9k
         zmcJCnqO9UzLZgsUgUdD9DyA8jaKV/MXZEwkV/IQ+Kwtn/DDnzPMTOdwGu/yLVCsULjU
         codA3xUFiYjyh+GEA2/f/M3ZNdPeSwO/PVhrSF1Nbshl9QUdAMVsCVuXMLX51dPR+78c
         EHTA==
X-Gm-Message-State: AOJu0YyHpiSa6kkT+tEm+NEuWfcSJ6sduPbGj7saJzKhlgD5dMxg9rIN
	n5eNn+loyImjwgm/vVMa1IdfOpVGtzQ=
X-Google-Smtp-Source: AGHT+IGAth2lTFvqbkmyl60Y4io8ifbHEy2Rp+xidbCOCTYZkCqCCqp1JMAFanvrHaUx2l52luixWA==
X-Received: by 2002:a05:6870:f6a1:b0:1dc:ddd0:6edc with SMTP id el33-20020a056870f6a100b001dcddd06edcmr16647899oab.1.1696344786288;
        Tue, 03 Oct 2023 07:53:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:53:05 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 11/12] contrib: Update hashserv Dockerfile
Date: Tue,  3 Oct 2023 08:52:48 -0600
Message-Id: <20231003145249.1166276-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145249.1166276-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
 <20231003145249.1166276-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:53:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15172

Updates the hash equivalence docker file to the latest Alpine version,
and also to install the required python modules into a virtual
environment

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/contrib/hashserv/Dockerfile       | 33 ++++++++++++++++-------
 bitbake/contrib/hashserv/requirements.txt |  5 ++++
 2 files changed, 29 insertions(+), 9 deletions(-)
 create mode 100644 bitbake/contrib/hashserv/requirements.txt

diff --git a/bitbake/contrib/hashserv/Dockerfile b/bitbake/contrib/hashserv/Dockerfile
index 74b4a3be1d1..7a9525db8d5 100644
--- a/bitbake/contrib/hashserv/Dockerfile
+++ b/bitbake/contrib/hashserv/Dockerfile
@@ -9,15 +9,30 @@
 #   docker build -f contrib/hashserv/Dockerfile .
 #
 
-FROM alpine:3.13.1
+FROM alpine:3.18.4
 
-RUN apk add --no-cache python3
+RUN apk add --no-cache \
+    python3 \
+    py3-virtualenv \
+    py3-pip
 
-COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
-COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
-COPY lib/bb /opt/bbhashserv/lib/bb/
-COPY lib/codegen.py /opt/bbhashserv/lib/codegen.py
-COPY lib/ply /opt/bbhashserv/lib/ply/
-COPY lib/bs4 /opt/bbhashserv/lib/bs4/
+# Setup virtual environment
+RUN mkdir /opt/hashserver
+WORKDIR /opt/hashserver
 
-ENTRYPOINT ["/opt/bbhashserv/bin/bitbake-hashserv"]
+ENV VIRTUAL_ENV=/opt/hashserver/venv
+RUN python3 -m venv $VIRTUAL_ENV
+ENV PATH="$VIRTUAL_ENV/bin:$PATH"
+RUN pip install -U pip
+
+COPY contrib/hashserv/requirements.txt .
+RUN pip install -r requirements.txt && rm requirements.txt
+
+COPY bin/bitbake-hashserv ./bin/
+COPY lib/hashserv ./lib/hashserv/
+COPY lib/bb ./lib/bb/
+COPY lib/codegen.py ./lib/
+COPY lib/ply ./lib/ply/
+COPY lib/bs4 ./lib/bs4/
+
+ENTRYPOINT ["./bin/bitbake-hashserv"]
diff --git a/bitbake/contrib/hashserv/requirements.txt b/bitbake/contrib/hashserv/requirements.txt
new file mode 100644
index 00000000000..567a27d4323
--- /dev/null
+++ b/bitbake/contrib/hashserv/requirements.txt
@@ -0,0 +1,5 @@
+websockets==11.0.3
+sqlalchemy==2.0.21
+sqlalchemy[asyncio]==2.0.21
+aiosqlite==0.19.0
+asyncpg==0.28.0
-- 
2.34.1


