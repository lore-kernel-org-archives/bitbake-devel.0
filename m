Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB6E7AD70
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:12 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.110216.1696344788775610898
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:53:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fCMgSzrg;
 spf=pass (domain: gmail.com, ip: 209.85.160.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e10507a4d6so687807fac.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344787; x=1696949587; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKQcDC2aqTwuAyVrpsIUcbCPaQoypuxcDL8hUPW5OvQ=;
        b=fCMgSzrg/jDZYaNOnDnVf2Rh/W96IG4qsTVErAd5S9Fi2x3FltUSlpSNXMzimOi8gh
         FlvYnGRlavSxKlJWzZO5OaeJQZmocARxQK6lCpIWZ8CIIQw+11XLQRzV5dTjtRyHRTZk
         eOsqeveoeJNHCM+h0ce3CJ/MfgriRdFxWbdQcM5GlxNxmP5f6aVkfkL3iq+7QgyKEM58
         5IQePst1TAWWSNVJHN4ZOD2XvYCPG2jA4e5V67zeLU8ThHuvQktBGHbkPDHZ7fVmlcao
         0j7xjePsEkn04q3+D3DUPxtyDcIcgmG8+ZN23lULXGNBHJQfrHJejJBbAuY5jqPLTNDr
         kdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344787; x=1696949587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKQcDC2aqTwuAyVrpsIUcbCPaQoypuxcDL8hUPW5OvQ=;
        b=CvemF5kxq7f08kxpWlt/xNxNVrQb46bkDx629+RcAFKNurPcb/951f0REku8WGbXC8
         Y8nnU/EkG56nvapKTUkdfW8WtPjqaoXNZd2v6hDK69F/ner9OyeqeYmECdv2hmTZlZiv
         hCnGxrMaEi/14RnPxTJHsdXTMJUMcmGVaLm6au2nxdmeWLFLTTF7SDQf/rc1Ur6wb8OX
         Yu5U/hazTX4kMD05bfKAHwWDJ2LYxRCBoGRTkRRLFV46dGF7eiiKHNQXG8WE8zOEVEOg
         fbqIoroVd703ra4Wd0dnswdAYfwKDbDLxbnyoeBMEIDLPHkVydgyj6ms9niwqo2hinfX
         hr+Q==
X-Gm-Message-State: AOJu0YwvTHFYVDFecPHa6t1nmaBChAqzGt00DzyA6uYGqDeWN78hjQYI
	UBEoYOBemwaMc6V6JkVR9GM0XJJDXYs=
X-Google-Smtp-Source: AGHT+IEyQrA1wW7d5FIXMzTPvaVP5mrewiHg2EiZGozRONil67ImcSGVw2Wp33R99LpsNWOFoDAUgQ==
X-Received: by 2002:a05:6870:c588:b0:1d5:a17e:f62 with SMTP id ba8-20020a056870c58800b001d5a17e0f62mr17826036oab.24.1696344787486;
        Tue, 03 Oct 2023 07:53:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:53:06 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 12/12] contrib: hashserv: Add docker-compose
Date: Tue,  3 Oct 2023 08:52:49 -0600
Message-Id: <20231003145249.1166276-13-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15173

Adds a docker-compose.yaml file and docker-compose script wrapper to run
it with the correct arguments. This can be used to easily standup a hash
equivalence server with a postgresql database for demonstration
purposes.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/contrib/hashserv/docker-compose      | 11 ++++++
 bitbake/contrib/hashserv/docker-compose.yaml | 36 ++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 bitbake/contrib/hashserv/docker-compose
 create mode 100644 bitbake/contrib/hashserv/docker-compose.yaml

diff --git a/bitbake/contrib/hashserv/docker-compose b/bitbake/contrib/hashserv/docker-compose
new file mode 100755
index 00000000000..74cbf4807d0
--- /dev/null
+++ b/bitbake/contrib/hashserv/docker-compose
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
diff --git a/bitbake/contrib/hashserv/docker-compose.yaml b/bitbake/contrib/hashserv/docker-compose.yaml
new file mode 100644
index 00000000000..c1ab73c12e8
--- /dev/null
+++ b/bitbake/contrib/hashserv/docker-compose.yaml
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


