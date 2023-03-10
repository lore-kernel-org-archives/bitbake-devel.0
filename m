Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536EAC6FD1E
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 20:46:11 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.30843.1678481168569897903
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 12:46:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=aBPNs9p9;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id t15so6192796wrz.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 12:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678481167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+wr0y+3hDTDN/eAqmRT5JAzd57gK4wzuxLBf3VOBxc=;
        b=aBPNs9p90QIvHWNySLUjR2qmPCKTJLvC4mPxct/AImjdqVVvfyhk/wkChsTrRbaSxJ
         Gedtk28xZ5THEfkpGzIUQCBvmo2JmoLS2zR3gwCtv1OeVwDxtj9YqpyxpanwvtyqSwcX
         k3U9AKuCLcVn1Fws2iUAyphsnXz3QTIuGfOpDQ7RJZHe+QDI09OgjF3P3ZhwOstJBoTR
         P4CO1en0dls8lBBH/2EXJkiP1S5r2q5dRR8xVQ4utLFEu+PZBRDW/felhfpAQsvJIYKw
         rJvO7Mg/mGu/t7OYpDUUFIDwYgO2YXzAXuHpe4A0PMG9R1PJ8Z6p6aAU0nh15eIr4qY3
         F8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+wr0y+3hDTDN/eAqmRT5JAzd57gK4wzuxLBf3VOBxc=;
        b=jKeROc7XBKz4XI/d+0tAvfLikt1fb7oXPBfdhAohM0L6N6EOQjXWiKX4tORc/XiVY1
         L9rO5gSS8FFQh3WnEklIgjaPOp5bnuG3rimrHiAjwIFYVMUyTEpzV/WuJNqZbU7FIN8D
         JIlIm0dhPL4e1SpBAzEMwAypwmUO9skxBgcSoAjwXdHI2IWhG8WPvbXwWqokhHeW/e2B
         DdU+VoOqWenR70Kp5QliLOnpzLDFDbijuAXI0tEcAKy6OypxbnUzjKzLlyRB9gIf4VQ8
         WZjs9ZCs5xjPkmT+IE5ViX/AMyJOhs+XyAIIgHBqAW/HOrRHbcAtdVJ/DEQfAkcYi+VE
         XUxQ==
X-Gm-Message-State: AO0yUKUMvkzA7UZYUxBJk2UdKwBKb5SxXUVRl6x7zaTQAqaJe7doDcc8
	lxSvNwyDlRJmqaXjRzVO6+RzM0CouZA=
X-Google-Smtp-Source: AK7set+X/Xq2X/HyJ6xRXCV4P01Xp3wPJnXsYa4I+hYmFVaxTSstaxZbp8Nesng8pYQ0phpvJttAlw==
X-Received: by 2002:adf:eec2:0:b0:2c7:4ec:8d79 with SMTP id a2-20020adfeec2000000b002c704ec8d79mr19541366wrp.21.1678481166898;
        Fri, 10 Mar 2023 12:46:06 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d5707000000b002c54f4d0f71sm676929wrv.38.2023.03.10.12.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:46:06 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH 1/4] utils: Allow to_boolean to support int values
Date: Fri, 10 Mar 2023 21:45:58 +0100
Message-Id: <20230310204601.730833-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 20:46:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14544

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Some variables may be set as:

X = 1

as well the more usual

X = "1"

so add support to to_boolean to handle this case.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index bca4830f2..cdb3c6864 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -990,6 +990,9 @@ def to_boolean(string, default=None):
     if not string:
         return default
 
+    if isinstance(string, int):
+        return string != 0
+
     normalized = string.lower()
     if normalized in ("y", "yes", "1", "true"):
         return True
-- 
2.39.2


