Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.66751.1595886901319855562
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jul 2020 14:55:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gNlPQDiE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id 88so16306949wrh.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jul 2020 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T5ot0VQpF8ze+POZ4NhVzuzYh9f8x1xenckVzzpZVJg=;
        b=gNlPQDiEYfFTPQQMr0JOwdgE0VZe8kkDxS+qeJrE7QxLu5iVobtTQvH/cbEv/0vRrj
         be4g3ePdXihslgPY6apLBd7DW52VEJz1TKOfAV/+Du7TqTdC9bckDiYUy8QVPiNZ9ePs
         /kACbmoAT2iwgOtdQVSHlgh0u6wQbFGr0W9e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5ot0VQpF8ze+POZ4NhVzuzYh9f8x1xenckVzzpZVJg=;
        b=UyuEQzvlnTzZL/xfanNr6FYS6yRRy3jTEVv+Ob0m0NdZ3vDlh7m/gR9IgDlU9ZSqJw
         cBufEwyVS8AFZgtyljUGT+Au9fc3o9M7yS1RRK6K8hvpfZOZr5IBvvEVfAOfv6ZKTiNK
         WhB1Wyiwzk1Qhot7EW/SmG4fOyxjdqMUGrHDVJ0hJC+IoD1AUlvZGtWyZesiYIYz/mR9
         q67GMwQYv46nDPZW+KTaf2Mi58vbm/fVqGmz8c3+3P9CXzKMtQr3ZDNlOYxcsqLWkX+D
         E29PfCPVVbOPr9Zetpz058zV/pMm4atDe2CoOP3svZa08bpb10oiPvvZ2PYR3RRJWI3M
         Xaqw==
X-Gm-Message-State: AOAM533Ubf1Sd15FA0xTB2+vrlfSIDAEJAo3wtRgM0QBZEMy7IpMJQ/V
	uhJSyLwgoTaBScYkuu+gPtoYuSuvNkRSIQ==
X-Google-Smtp-Source: ABdhPJzqxDklaBO6UX3yMr5pOdqs79kE/2wdIGJiNjVYM+V1kkRa+BpxkqayhLcKw29ksPR/GvGGzg==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr21956906wrv.202.1595886899508;
        Mon, 27 Jul 2020 14:54:59 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (4.0.f.e.b.e.7.9.7.7.5.0.0.c.1.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c1c0:577:97eb:ef04])
        by smtp.gmail.com with ESMTPSA id t25sm1078422wmj.18.2020.07.27.14.54.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:54:56 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] server/process: Account for xmlrpc connections
Date: Mon, 27 Jul 2020 22:54:51 +0100
Message-Id: <20200727215451.319333-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727215451.319333-1-richard.purdie@linuxfoundation.org>
References: <20200727215451.319333-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UI control can happen via the xmlrpc connection. Account for this when timing
out UI connections. This was causing issues for toaster on systems where it
couldn't parse the metadata within the timeout.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 5a87f0820d..b66fbe0acd 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -202,7 +202,7 @@ class ProcessServer(multiprocessing.Process):
             # If we don't see a UI connection within maxuiwait, its unlikely we're going to see
             # one. We have had issue with processes hanging indefinitely so timing out UI-less
             # servers is useful.
-            if not self.hadanyui and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
+            if not self.hadanyui and not self.xmlrpc and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
                 print("No UI connection within max timeout, exiting to avoid infinite loop.")
                 self.quit = True
 
-- 
2.25.1

