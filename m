Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.2640.1615498709714097166
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Mar 2021 13:38:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WlFgK6wW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so3667379wmq.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Mar 2021 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=totqKPdHotGGmp+P6Kdf+owSIS3ZQXjDa+zH/eC4zmA=;
        b=WlFgK6wWn3rvzOTQdxUlfNI0RA5kXYV/chJdBBLzqhQ1LP2J61OucXnFi3RAPIFtdc
         IiVyUf1mfsDCXTyk5duM9E8UBOo8uENAWbKgRCc7ZOziS558THAGuK1bbeMehDZuULMt
         Qb/vHfB4xf001uYtC0NSonexX6gR6J0+XevVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=totqKPdHotGGmp+P6Kdf+owSIS3ZQXjDa+zH/eC4zmA=;
        b=J+0oGAD98/6VewXfvB1U0SjZomYZx/Ilpvxn8mQJBzYA2lZUBkxktogG9wr7aUOyh4
         nax/b/tw3Z6rE8thRD/deu2kuxDwTXWcN3D7ML77JhvjJuAvW00ZXeFhrQ68xZy0hFtT
         DxMLlJyNv57Kndq5p7SlCcDyLfQ1JmPeC/E28RmEzfw8TSsf/rF4x4LDoTa1NWR+5kTA
         hcUCaTq5TdQUCvjfXB0WCbaIBb0RMB479lM9RoFGwpLdzZMX0t3hXAHmlV5s7WHvpHH6
         5E0NeADTkz4dZyamtSpyWFycnTxc3BqtvcRns/Fisp/BtIrJZZOBKsgm5A6KuArWdys0
         ASKA==
X-Gm-Message-State: AOAM531JoXHVGbCiBrs3PVP32+lPVdbY1TvrfdViMYDR1B9kgAmGagQD
	PggHEibhDLaSSmuf5So6+sFnL1KCkwHCMA==
X-Google-Smtp-Source: ABdhPJw8r+NyUzv+q/qLvhE00b1ZYpXb0d+WeGm1Hf451yMgMXoT9Tn2VxYcXYNAa5n63v7cRmvKpg==
X-Received: by 2002:a05:600c:26d2:: with SMTP id 18mr10016588wmv.41.1615498708102;
        Thu, 11 Mar 2021 13:38:28 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:7cc6:73c3:839f:86be])
        by smtp.gmail.com with ESMTPSA id l4sm5546125wrt.60.2021.03.11.13.38.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 13:38:27 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] event: Fix another 'if d' test to test for None explictly
Date: Thu, 11 Mar 2021 21:38:27 +0000
Message-Id: <20210311213827.2564100-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should have been fixed in the previous patch, well spotted Chris!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 22171a9ca5..31e7c2a4d2 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -118,7 +118,7 @@ def fire_class_handlers(event, d):
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
                     continue
-            if d and not name in (d.getVar("__BBHANDLERS_MC") or set()):
+            if d is not None and not name in (d.getVar("__BBHANDLERS_MC") or set()):
                 continue
             execute_handler(name, handler, event, d)
 
-- 
2.27.0

