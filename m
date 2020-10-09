Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web12.550.1602262287997524271
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Oct 2020 09:51:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PJsMiTAN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id v12so10491123wmh.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Oct 2020 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QenYZ4AtzQb10FRtRp6k0fFGvJCCuc2GrQJS8PId9a4=;
        b=PJsMiTAN4SifCibBSMaNhQHgH5VuIC+8mHFUZ6ZN2tx4QJTr826Fb+GCUeAV0bGFoI
         aI7LPcQKAyAAMal0P7DXQ+6X9X32pp2izE0Iulot11J4sShcmmEvIlm9RznaVKh2OgjY
         g09XUthKBx0K/NdMYq+HIV1qK5YjviqAdSTyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QenYZ4AtzQb10FRtRp6k0fFGvJCCuc2GrQJS8PId9a4=;
        b=RkoY0kY6ywABAorSSSbGfHVHfPD6aYFQBpo0tF+72ggMtv8HwywBGN4HFkZC3NDo0g
         Dl0jM+dt1g9+j+HRotpDGb3SPLs1Ob78iE1bk6nl2F0kg9UrTWflRHgnUrNAIlIX788N
         OnX4gyf2gjGeR4nqsYj9SZLQTnKJESil4a/VDxw/dI/wj/gsmE7rGMSxcZAG3RxaTfMw
         rGjUbeSAlbiUkiK0+q8tWAj5OcR7TYYKFUxjHXYb+p+a6udrCUL0KktYfWJ3FPnurS+j
         Uaf2jCNKd+jqjPrbCShy8LbDe8ml4TeVm66tUCt9kDL1ACCk9emPyv++YRUnknBo/Qq4
         wD4Q==
X-Gm-Message-State: AOAM530g2uwdWGqL1bhyAiDk0TSUmfxfXGkAFypU/r8cGGYIHJkNFu/h
	PZChu9KATVjf7WJUwuKusy0yEX36lHfG9g==
X-Google-Smtp-Source: ABdhPJyXlX/3YFfmjV8i5dABQhWoWIrG/dC18+VzNl1LYpkiDwGGnhz/kVUBILEw0Zn3sJUAEHSHxQ==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr15024811wmb.22.1602262286102;
        Fri, 09 Oct 2020 09:51:26 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (0.6.6.4.7.a.b.4.4.1.e.0.e.3.c.2.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:2c3e:e14:4ba7:4660])
        by smtp.gmail.com with ESMTPSA id c16sm13591026wrx.31.2020.10.09.09.51.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:51:25 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] tinfoil: When sending commands we need to process events
Date: Fri,  9 Oct 2020 17:51:24 +0100
Message-Id: <20201009165124.3293429-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009165124.3293429-1-richard.purdie@linuxfoundation.org>
References: <20201009165124.3293429-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The server may be displaying useful information for the user through log
messages so we should display anything that has been sent. Its either this
or expecting every UI to implement this code around every command call
which isn't good API.

[YOCTO #14054]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tinfoil.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 2fb1bb7d27..763c329810 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -461,7 +461,16 @@ class Tinfoil:
         commandline = [command]
         if params:
             commandline.extend(params)
-        result = self.server_connection.connection.runCommand(commandline)
+        try:
+            result = self.server_connection.connection.runCommand(commandline)
+        finally:
+            while True:
+                event = self.wait_event()
+                if not event:
+                    break
+                if isinstance(event, logging.LogRecord):
+                    if event.taskpid == 0 or event.levelno > logging.INFO:
+                        self.logger.handle(event)
         if result[1]:
             raise TinfoilCommandFailed(result[1])
         return result[0]
-- 
2.25.1

