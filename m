Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CC8C25B77
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 10:49:09 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.7239.1715251740898238078
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 May 2024 03:49:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D7DtAi0b;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-349545c3eb8so392077f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 May 2024 03:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715251739; x=1715856539; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWxShWrpti5fOKp9dI/itIIK4BbTIsv6rtXgYBSzwyo=;
        b=D7DtAi0b0WZ6AJGH3QADnIAqUsILS9nbTxkUNYaWwGDrig1dpxBXwrxf9HBMZMfQV0
         vq5K1GGUV9HlQnBkFiwJr3OgNraxpEb6JbaiYgxmzAJ4l4TPfysRrOhElc4BCt8cCOMz
         sWjGr558qJpwrYzDvS9dVHaiKaVNMTcHykCCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251739; x=1715856539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWxShWrpti5fOKp9dI/itIIK4BbTIsv6rtXgYBSzwyo=;
        b=IxDR2m8vlx8dNwdavto+DglW9v8Zw5TWr2Gdn+9sZ60pEYsBkIGk/Ia7XP2IwHZ5FX
         9bnBl3WdQMwnwWKNRY0cQfoEIvxVYS6CA4dtTqQLEZcHIiYzspTHGM83ICqh4TGM7UOh
         LQAVRUyC+88XCbmzxNp1a6vXy4z96PRhXmhtXV/aK8EEx/205U88ye1Ns8Zt5G5Mx1vo
         icMJbxjq+y+9ulXJTklhXO2xIQZsXYIVHjfo3g0d+T8bdMs1jXg340+7Jf8AVD5bl1qY
         DFgT7C2PvUcDkKkwgAtx7Y02nO91qjQQlpFMacR/4tjOZg8s0msz9YRbaecmsAE+HBMZ
         ijgQ==
X-Gm-Message-State: AOJu0YzJqHHTheJMFExTt9H4CKCiBUXhOJ6KD+suPp8o5bcvLO0pJ19u
	TbT9WMRkqV8gy3aP6x02cSY0HDn4nkOSwRX4AQiGCr1YcFZzqPUg9YvE1KJ0pyY/Ktghi0rP3jk
	gk0w=
X-Google-Smtp-Source: AGHT+IFUPQsUtEmMHX307Op5Ix9FWsrrCD12JkTg4QZTsGUULs09mkDrIr4S1qU+4r3j7iFkRGqq/w==
X-Received: by 2002:a5d:54d1:0:b0:34d:bab1:26eb with SMTP id ffacd0b85a97d-34fcb3acd12mr3498640f8f.68.1715251738973;
        Thu, 09 May 2024 03:48:58 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a95b:1bc1:5128:ffbc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a777dsm1365743f8f.50.2024.05.09.03.48.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:48:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] asyncrpc/client: Fix websockets minimum version for python 3.10
Date: Thu,  9 May 2024 11:48:57 +0100
Message-Id: <20240509104857.3913445-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 May 2024 10:49:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16195

python 3.10 support is only available in websockets 10.0 and later:

https://github.com/python-websockets/websockets/commit/08d8011132ba038b3f6c4d591189b57af4c9f147

Update the version for this case. This avoids failures on Ubuntu 22.04.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/asyncrpc/client.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 65f3f8964d..b49de99313 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -25,7 +25,9 @@ ADDR_TYPE_TCP = 1
 ADDR_TYPE_WS = 2
 
 WEBSOCKETS_MIN_VERSION = (9, 1)
-
+# Need websockets 10 with python 3.10+
+if sys.version_info >= (3, 10, 0):
+    WEBSOCKETS_MIN_VERSION = (10, 0)
 
 def parse_address(addr):
     if addr.startswith(UNIX_PREFIX):
-- 
2.40.1


