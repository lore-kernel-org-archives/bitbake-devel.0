Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web12.21422.1613331374161630474
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Feb 2021 11:36:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=X9tnxZGk;
 spf=pass (domain: gmail.com, ip: 209.85.210.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f52.google.com with SMTP id e4so4274805ote.5
        for <bitbake-devel@lists.openembedded.org>; Sun, 14 Feb 2021 11:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIAqRNyZFIENOLaDn0TQAPdDAIsjKS3Fp1pcUe0neVU=;
        b=X9tnxZGkJhsksPNAB4L8V2DVLAiX3MLCeftmvcNXoYDRUqpwo3Kfu2e9qSAimGdBBO
         UVdiXCAr7vgPczFLtuvI724QcEMt2qM+dxO5E2+8zkgEu58yHmbecWwCyxw9oGw5Dv52
         ykvLGd5V2lgnj0SycMX3yH2IBzyWC/4XuutZDxsTnyBqp4Aj9AIXBriyO5QAqhumgs3r
         7IlPgq8hxGIwbo/udUfU3nXlA21ZGkQ64KIcai/gsdu5O4/mHtKOuJsQQqPnZEbAHAa7
         RjZ240lyh4omQizgW28h0zT4V3t00PSx7rnvq2L4QEvxR72AlMExYeVOl27n7x9R6it4
         9+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIAqRNyZFIENOLaDn0TQAPdDAIsjKS3Fp1pcUe0neVU=;
        b=Y6MAyHZwMNuCGBIxKPt2/YcXtg4mn+CLvITm1iDWTdQ5ezvz2kSiOBBi8yFPvrrJJ2
         hXpz6ttlX5+wFqoPQUgCmUXwtBoceJoJASBr1XU0oWRD6yMWUJtpsD7KAiqSnNSlMzMv
         L1hAQ3ES2JjQ3MKDV93CcWBkzfc3QdCQoJo8HOfjKiZMByQhbiyp65rWw0VQw/0HBY/g
         B+XygNGg95+vJI+R89U1lP/zxoW2+PJbi8NSrMrf6F1wrcgLC5qDqzclDRgE922/3TpP
         l9axYMvLuafRQnkW2qL0kg6qh2kF7t2yaC05jx4KTI8JsypV1vypJzCuEbgC1rIyBMAE
         66dg==
X-Gm-Message-State: AOAM530MIfMc2IYToeIHL5Nj+hG/y0+2DHN5qjhVqy+4LaNjaaeSx2WD
	elrCVr2CApBNpyZrfVKdPbyA1nhB/q4=
X-Google-Smtp-Source: ABdhPJxdEWmh2bX/7aoRWxJmiFqXLHSXgOR1cViTSFxccZ1jDoWKtcPusff/rnpDRJprxZLXm+1U8g==
X-Received: by 2002:a05:6830:3152:: with SMTP id c18mr9215937ots.191.1613331373365;
        Sun, 14 Feb 2021 11:36:13 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id r1sm521553oic.23.2021.02.14.11.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 11:36:12 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: ticotimo@gmail.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] contrib: Add Dockerfile for building hash server
Date: Sun, 14 Feb 2021 13:36:07 -0600
Message-Id: <20210214193607.22974-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a Dockerfile for build the reference hash equivalence server in a
container

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 contrib/hashserv/Dockerfile | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 contrib/hashserv/Dockerfile

diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
new file mode 100644
index 00000000..d6fc728f
--- /dev/null
+++ b/contrib/hashserv/Dockerfile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2021 Joshua Watt <JPEWhacker@gmail.com>
+# 
+# Dockerfile to build a bitbake hash equivalence server container
+#
+# From the root of the bitbake repository, run:
+#
+#   docker build -f contrib/hashserv/Dockerfile .
+#
+
+FROM alpine:3.13.1
+
+RUN apk add --no-cache python3
+
+COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
+COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
+
+ENTRYPOINT ["/opt/bbhashserv/bin/bitbake-hashserv"]
-- 
2.30.0

