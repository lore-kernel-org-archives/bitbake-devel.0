Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89169CDB484
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:25 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web10.25783.1697149038767331614
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=P9MF0gYl;
 spf=pass (domain: gmail.com, ip: 209.85.160.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso818722fac.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149037; x=1697753837; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCToLQA/pUbriTOgT+s1dGSF7zBcftNtb7l30OKEmGg=;
        b=P9MF0gYlYBfbN99R1YEJUeX1yC6EoJBhLdQT2Rx17XoeaZ8gv6ixrayqKBtPlC/YsV
         S5U0hp9dJwv+GGCRkadG5Q7KiYJEqIYldTA/b3+JMdExjxGaOhOgqVuwFF+dVeyoihE0
         ZjqvNqgVAW3HBU/ySfPx7ScLcJUsqM5UBcB7zj0Ptui063WhePK1kaSchktzBwLXLKm5
         ZpYrAFLz/BWK2gtNtaIEdF0G0nOzddH8hFNr4UpGgCFQY+qZg6WU1kCpniBO9IaOcFQK
         MvWZRauKtXB5vevbO/Li/Pr4+0lc8nT3wLa5KdEJ3EEo/XL+UeMdI4QIqq4ziF+8hqVv
         AcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149037; x=1697753837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCToLQA/pUbriTOgT+s1dGSF7zBcftNtb7l30OKEmGg=;
        b=aLltjIN1UarpIdBQFkOmeMMUoK4DSKVRIJ6JW/Th4QjTwURcy/neQM/+0T6ohNXVn3
         DQB6XaOzo72OUzdJLF34zncSwMM+W/9KslnJgZKmt+tm8XVbdL2jA5NTWIC9D6uLoLkL
         TJm10hcwiHhvKqyniCwbD6nHcdri146vblkkoRBmq8VOJEKqopsL1eX+2ofEhE21NVcE
         CN8tn6MVwk3YccC8tqs/NCOFHt963doY+1kscQttuP6IlOdzVqbI+wtooo2fhiCy5y4D
         VwP6YfHx9fwgFmUL2WyD1LwhkhiH/8JauSHJUYSh21QekUuOqf1s8xx5HM+wh/ursrEC
         SJJw==
X-Gm-Message-State: AOJu0YypOPweuUy+Q4Xfv2i6wt/9kf5wv/+vDLkcY/ujZeN4n+We8ppU
	O1uNjyyXvRpaRcJI2j6Hh7JHphtEsOU=
X-Google-Smtp-Source: AGHT+IHs8rCTAAfN+BvksNO+j3cORyTY6BoEBTA81D3+66H3rHG5ogZZ/nBOmph5c1XbgSAYiMbJZg==
X-Received: by 2002:a05:6870:d93:b0:1e9:74c1:52e7 with SMTP id mj19-20020a0568700d9300b001e974c152e7mr8503146oab.36.1697149037248;
        Thu, 12 Oct 2023 15:17:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:16 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 10/18] contrib: hashserv: Add docker-compose
Date: Thu, 12 Oct 2023 16:16:47 -0600
Message-Id: <20231012221655.632637-11-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15228

Adds a docker-compose.yaml file and docker-compose script wrapper to run
it with the correct arguments. This can be used to easily standup a hash
equivalence server with a postgresql database for demonstration
purposes.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 contrib/hashserv/docker-compose      | 11 +++++++++
 contrib/hashserv/docker-compose.yaml | 36 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 contrib/hashserv/docker-compose
 create mode 100644 contrib/hashserv/docker-compose.yaml

diff --git a/contrib/hashserv/docker-compose b/contrib/hashserv/docker-compose
new file mode 100755
index 00000000..74cbf480
--- /dev/null
+++ b/contrib/hashserv/docker-compose
@@ -0,0 +1,11 @@
+#! /bin/sh
+# Copyright (C) 2023 Garmin Ltd.
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Wrapper script to correctly run docker-compose with the correct argument for
+# the hash equivalence server
+
+cd "$(dirname "$0")/../../"
+
+exec docker-compose -f contrib/hashserv/docker-compose.yaml --project-directory . "$@"
diff --git a/contrib/hashserv/docker-compose.yaml b/contrib/hashserv/docker-compose.yaml
new file mode 100644
index 00000000..c1ab73c1
--- /dev/null
+++ b/contrib/hashserv/docker-compose.yaml
@@ -0,0 +1,36 @@
+# Copyright (C) 2023 Garmin Ltd.
+#
+# SPDX-License-Identifier: GPL-2.0-only
+
+---
+version: "3.7"
+services:
+  postgresql:
+    image: postgres:16.0
+    restart: always
+    environment:
+      - POSTGRES_DB=hashserver
+      - POSTGRES_USER=postgres
+      - POSTGRES_PASSWORD=postgres
+    volumes:
+      - postgres-data:/var/lib/postgresql/data
+
+  hashserver:
+    build:
+      context: .
+      dockerfile: ./contrib/hashserv/Dockerfile
+    image: bitbake-hashserver:latest
+    restart: always
+    ports:
+      - "9000:9000"
+    environment:
+      - HASHSERVER_LOG_LEVEL=INFO
+      - "HASHSERVER_BIND=ws://0.0.0.0:9000"
+      - "HASHSERVER_DB=postgresql+asyncpg://postgresql:5432/hashserver"
+      - HASHSERVER_DB_USERNAME=postgres
+      - HASHSERVER_DB_PASSWORD=postgres
+    depends_on:
+      - postgresql
+
+volumes:
+  postgres-data:
-- 
2.34.1


