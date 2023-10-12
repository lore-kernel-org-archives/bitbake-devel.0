Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C695C46CA1
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:25 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web10.25781.1697149037024861932
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WIJLD/nV;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1dd8304b980so858560fac.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149035; x=1697753835; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuHSXV9DEdKgc6+iKsVGiG90dOWMFf1GWYwpfRpoxJI=;
        b=WIJLD/nVdNqdJm3FP8C0NLte4kcndq+VhhM5loCraDCNsJqb9oNbnZYlwAliFmUIlO
         oCosRR6VwyMHCFd28mCKDk6CAfRs4rdKXR7XHm5DJFIE4DWTihuiZwCvO4XxBaYAFM+j
         7HW55TL/DhwuPV5FIse8EkJ8/NrMQfC9RIvuBbOzHBaZDW+UnS8bFgDP0WOPTqTp3pmD
         qg8RqPAqNQ8a3EGsRcrFK360my7roZoMtpasjTmNPS5u8ePX4qT5QW3Kz3D9faEQP3Wf
         VlVyULXAoFq9zFumhH/JyMUJpWfba2lLjcKoSb7dHZFsw+G3tohjT+kmCWxTsxlZY9XN
         TztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149035; x=1697753835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuHSXV9DEdKgc6+iKsVGiG90dOWMFf1GWYwpfRpoxJI=;
        b=MbVTkX+JIVRHm4g8+gjukT2Z7UyhiIrch2oxVWCMG/vpsb6K5vkGFT8fBiG85MToMZ
         CGFL1606sbMVsTd+u9I3OFQYDP+o+1V64/0a65suP9UFCrIpqtYCNSdZxwuCEURSz26L
         HPVSqPQYyhVi/5zQub5Fhc+GJoUsZl8q4LHvwdsPBgglu26mG0KqwhFTu+WVyXJtF27H
         PXM9LbyXcyXbYh82h9YXWS5jmjQ0GWlQSNaKJGfAIKMhz3fsEE5Ve/RaiiltlbszkIHq
         62XZFQ31x/U+TAZOtO/E03H/u+Z4qHWaqp4aVjrK63hrxXj8tiWL1SDURsGqRSQo3RJT
         Ndog==
X-Gm-Message-State: AOJu0YzWAFJJKkcrQpZ4cubhEnQpmfYd6mYxKOECOUHhdwojzP7IyJQg
	8o4HwQisLTzVOVavh5Tuf2qwF5iXrM8=
X-Google-Smtp-Source: AGHT+IE/29MOSCzM+rXWln3KFrLFZIoLBL9tLANgvxkb5G7FNxkq+woJUuo0Wc/iDW0guW0DI1t1Qg==
X-Received: by 2002:a05:6870:e99a:b0:1d6:439d:d03e with SMTP id r26-20020a056870e99a00b001d6439dd03emr29834512oao.18.1697149035560;
        Thu, 12 Oct 2023 15:17:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:14 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 09/18] contrib: Update hashserv Dockerfile
Date: Thu, 12 Oct 2023 16:16:46 -0600
Message-Id: <20231012221655.632637-10-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15227

Updates the hash equivalence docker file to the latest Alpine version,
and also to install the required python modules into a virtual
environment

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 contrib/hashserv/Dockerfile       | 33 ++++++++++++++++++++++---------
 contrib/hashserv/requirements.txt |  5 +++++
 2 files changed, 29 insertions(+), 9 deletions(-)
 create mode 100644 contrib/hashserv/requirements.txt

diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
index 74b4a3be..7a9525db 100644
--- a/contrib/hashserv/Dockerfile
+++ b/contrib/hashserv/Dockerfile
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
diff --git a/contrib/hashserv/requirements.txt b/contrib/hashserv/requirements.txt
new file mode 100644
index 00000000..567a27d4
--- /dev/null
+++ b/contrib/hashserv/requirements.txt
@@ -0,0 +1,5 @@
+websockets==11.0.3
+sqlalchemy==2.0.21
+sqlalchemy[asyncio]==2.0.21
+aiosqlite==0.19.0
+asyncpg==0.28.0
-- 
2.34.1


