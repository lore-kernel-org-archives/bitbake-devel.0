Return-Path: <daniel@qtec.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E48C433EF
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 10:45:59 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web12.28781.1647859556542580853
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 03:45:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qtec.com header.s=google header.b=eI8B9F57;
 spf=pass (domain: qtec.com, ip: 209.85.218.50, mailfrom: daniel@qtec.com)
Received: by mail-ej1-f50.google.com with SMTP id r22so8880955ejs.11
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Mar 2022 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=omlQARRJ9vsLj2xnDTUrLOI3VJyBMsPx7mIV/SWFu4A=;
        b=eI8B9F57Mm6FlxyMoS93nm+mxnBQr1DCqUHpUGhnXjS3XU02ajfXfoqRZS2jINnCO1
         DlT+WUKfnEwJGSub+Rfge2xL/EMc4A4CRlMNhAus13Dcl2SeCWlZUCaLV9TqV0TqXNds
         S9j8LS5gP+JI3pVGlKDNGOb7Q48NYfb4Q/lP1zxAueHq9EKiSbWF4BP8tXskU3hFKNVF
         Nnjc+YH4qQIvQHBPeAfvmFyZVMNfzerLTOdsW7pTJtiLgxURgpXKgIiLRujNnobDtFK4
         B3CnJd77OXg8YBxGS9fc/RbULJ2DV15CWd7BvxdhJN6OGcbRNWvc4hIuYx8Xt+9m1fUC
         itpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=omlQARRJ9vsLj2xnDTUrLOI3VJyBMsPx7mIV/SWFu4A=;
        b=bSbsg3mEwoGO95SMH5maTtmW4EDN5GpuON5Zut1vgHwK719KPYx682QhrqQPQexFX8
         6LNkpgidG9bVHXHE6sywKE3YJYBXQB59UYoll2GaYCdm7K4a+sy2LZR9FPOP+mKcorWe
         FvxCrOzIVWBNlBlviJrvdWuFKgvsfbm9jgNi4aJpd+NaQw17k5LJRJFOf20tYEDXjEBJ
         KvB1EWmcryFsptcShVJAfSU30CqvVob2iY8ntMTjz19VuA3sh/f0J64gJ/yNQ7ZO5aJY
         gYLpzsUPqBYmioRWQRaySwaHXTzhrmdVbhdB8jCtBLRGSsC8ioLwzlxcbRsxcaS5dSpy
         HVqg==
X-Gm-Message-State: AOAM531QJvNBS8wY8FRXzwJWcqtVpUWDi8mwnnr4dBAFVJYfqHw07Yfj
	4zQc65wXOvpXo09ZsM58PDytCgvjigSyEMtB+t1RTa860mC5XvWuZZ/ZOt8MsRetXNESGTxJPiG
	zdK46cBW0YX2AncJ8Ts+9+v+k5ED/TYn3wS6ZfiwSAR4HrikF9scYKHbn0n2eWKuM2RIwrK1dPV
	JD8SWQ6vg=
X-Google-Smtp-Source: 
 ABdhPJzrCxjwrIIQosQ57gN+Be1+ZF+Cntvrd9Pc/7ch6MJ4G4qIFOcI/H6xttJtnP2g7HoLDeZ51Q==
X-Received: by 2002:a17:906:9b93:b0:6da:6388:dc57 with SMTP id
 dd19-20020a1709069b9300b006da6388dc57mr19834044ejc.338.1647859554380;
        Mon, 21 Mar 2022 03:45:54 -0700 (PDT)
Received: from datops.qtec.com (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net.
 [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id
 u10-20020a50d94a000000b004131aa2525esm7786806edj.49.2022.03.21.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 03:45:53 -0700 (PDT)
From: Daniel Gomez <daniel@qtec.com>
To: bitbake-devel@lists.openembedded.org
Cc: dagmcr@gmail.com,
	Daniel Gomez <daniel@qtec.com>
Subject: [PATCH] contrib: Add Dockerfile for building PR service
Date: Mon, 21 Mar 2022 11:45:44 +0100
Message-Id: <20220321104544.261271-1-daniel@qtec.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Mar 2022 10:45:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13489

Adds a Dockerfile for building the PR service in a container.

Based on the hash equivalence server container [hashserv].

Use the following environment variables to configure the PR service
container:
- DBFILE: database filename. Default:
  /var/lib/bbprserv/prserv.sqlite3.
- LOGFILE: log filename. Default: /var/lib/bbprserv/prserv.log.
- LOGLEVEL: logging level. Default: DEBUG.
- HOST: ip address to bind. Default: 0.0.0.0.
- PORT: port number. Default: 8585.
- DBMODE: database mode. Default: Empty (RW).
Note: DBMODE in RO: "--read-only".

[hashserv]: contrib/hashserv/Dockerfile

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---
 contrib/prserv/Dockerfile | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 contrib/prserv/Dockerfile

diff --git a/contrib/prserv/Dockerfile b/contrib/prserv/Dockerfile
new file mode 100644
index 00000000..9585fe3f
--- /dev/null
+++ b/contrib/prserv/Dockerfile
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2022 Daniel Gomez <daniel@qtec.com>
+#
+# Dockerfile to build a bitbake PR service container
+#
+# From the root of the bitbake repository, run:
+#
+#   docker build -f contrib/prserv/Dockerfile . -t prserv
+#
+# Running examples:
+#
+# 1. PR Service in RW mode, port 18585:
+#
+# docker run --detach --tty \
+# --env PORT=18585 \
+# --publish 18585:18585 \
+# --volume $PWD:/var/lib/bbprserv \
+# prserv
+#
+# 2. PR Service in RO mode, default port (8585) and custom LOGFILE:
+#
+# docker run --detach --tty \
+# --env DBMODE="--read-only" \
+# --env LOGFILE=/var/lib/bbprserv/prservro.log \
+# --publish 8585:8585 \
+# --volume $PWD:/var/lib/bbprserv \
+# prserv
+#
+
+FROM alpine:3.14.4
+
+RUN apk add --no-cache python3
+
+COPY bin/bitbake-prserv /opt/bbprserv/bin/
+COPY lib/prserv /opt/bbprserv/lib/prserv/
+COPY lib/bb /opt/bbprserv/lib/bb/
+COPY lib/codegen.py /opt/bbprserv/lib/codegen.py
+COPY lib/ply /opt/bbprserv/lib/ply/
+COPY lib/bs4 /opt/bbprserv/lib/bs4/
+
+ENV PATH=$PATH:/opt/bbprserv/bin
+
+RUN mkdir -p /var/lib/bbprserv
+
+ENV DBFILE=/var/lib/bbprserv/prserv.sqlite3 \
+    LOGFILE=/var/lib/bbprserv/prserv.log \
+    LOGLEVEL=debug \
+    HOST=0.0.0.0 \
+    PORT=8585 \
+    DBMODE=""
+
+ENTRYPOINT [ "/bin/sh", "-c", \
+"bitbake-prserv \
+--file=$DBFILE \
+--log=$LOGFILE \
+--loglevel=$LOGLEVEL \
+--start \
+--host=$HOST \
+--port=$PORT \
+$DBMODE \
+&& tail -f $LOGFILE"]
--
2.35.1


