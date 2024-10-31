Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0264DE6897C
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 12:00:27 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.10578.1730376025471612349
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Oct 2024 05:00:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kli32b6u;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43161c0068bso6941925e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Oct 2024 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730376024; x=1730980824; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XFgF5FY8AwCXtVHJz9r5Z2y/blKd9h+jQr6C02tXh/k=;
        b=kli32b6ueMEJlMBRgIM6aY1gF9HNizieY0t7mj6LbufumqQ7Yri131GzUu3XzBRsvo
         qMvg9Z/gLhFEorGtlODScDwCJ+gWArRsC5NqVnhaZx8X7eX68smWdHN4DvFDfo+Rvru0
         bj2X/VBH/StH6u0CQPziq/9AVmGbGMsHMJOh1bf6QUITvZZNY1+itLb5XcPh9pyhxR3I
         7e1ASLU1VlUiBr9FIrKZg/IlBYgIcXkTZcJIfCnPGShdt3PfH/mlHtAoaAu/poyYpOiZ
         h1SJC2I6tITriQ/UVaOpyqQBIDibjQrpEyE/xgV28yYFQZcfwsLxH3VcQ5DHN+KuFrki
         p53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730376024; x=1730980824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFgF5FY8AwCXtVHJz9r5Z2y/blKd9h+jQr6C02tXh/k=;
        b=Eb61OyiAWmGDDsWpLlmLZP9KvW691GN+9iRBjE0O19anvYjHD0RbPguRJ4QP/rsxth
         ExxdQzB4JHu5JWeTw0StlIC8o7zgbiyi9LRlbPsHUSeyptLYhAl7BeYhSpmR6dOoolH9
         mSUoUoFw4oP+pPaC6Bx0YI4n6ZnCyGVLMHS5N/SrRKewpOE2TMaxU9b26jKjKFC6tVwC
         kp2vtZeXMgzZoXFrYHBOilxBMDg2JsSMZCcj6QOpdm3+AxlXDT2DaZNe+wkhwIGlyE+E
         LrE8rqjmLCVLsY/zpoLGsn+mN9UKVjE7tMLKaaSy1sDtnFOeoVWETTe0wapC9UhwbfAm
         +ymA==
X-Gm-Message-State: AOJu0YxxOPPbFwaGtDH3d3fChAbUfUt9rrE32xTJP+6T2XnrBQ0S4WDL
	q8lbc4O00q5UJPtX3a42ipKdoCmcbs5YmBfrsnkfrRhE2tXSS8FGRubjjthl
X-Google-Smtp-Source: AGHT+IGwep/lgi3Rg6bbznZQp42Qbp+0EQ10ik7Wo0jEKI/FdaGLc1gj5XdJPDgH+qX7bw8A51UrUQ==
X-Received: by 2002:a05:600c:314b:b0:431:52cc:877e with SMTP id 5b1f17b1804b1-4319acbba2dmr140503715e9.20.1730376023498;
        Thu, 31 Oct 2024 05:00:23 -0700 (PDT)
Received: from fio.lan (bl15-243-112.dsl.telepac.pt. [188.80.243.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a781sm1933078f8f.96.2024.10.31.05.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:00:23 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake][PATCH 1/2] bitbake: hashserv: client: immediately test the server address
Date: Thu, 31 Oct 2024 12:00:14 +0000
Message-ID: <20241031120015.3651707-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Oct 2024 12:00:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16761

Test as soon as possible if it is possible to connect to the server
and use raw socket for this, which is much simpler and works for what you want.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 bitbake/lib/hashserv/__init__.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index ac891e0174..47b25fa6ab 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
@@ -82,6 +82,15 @@ def create_client(addr, username=None, password=None):
             c.connect_websocket(*a)
         else:
             c.connect_tcp(*a)
+
+        # test the connection now
+        import socket
+        try:
+            sock = socket.create_connection(a, timeout=5)
+            sock.close()
+        except socket.error as e:
+            raise ConnectionError
+
         return c
     except Exception as e:
         c.close()
-- 
2.47.0


