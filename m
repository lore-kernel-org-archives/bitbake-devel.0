Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.7477.1619705491549842139
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Apr 2021 07:11:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZjPyN53l;
 spf=pass (domain: konsulko.com, ip: 209.85.128.53, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f53.google.com with SMTP id n84so8765087wma.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Apr 2021 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xxjT7d94j+WCj0QLGcmhg1uRaBp4Bt8HiJLHWxNSn0=;
        b=ZjPyN53lESVUqoegQqacGnoprYyAXhIMtgq5dfFZbNu49Hh986P+eNwQbNBV8rxgvI
         KC/40n26IsSSVqZChYNiBXBIFPde3cC8f+yrBAWN7vkj0e5zCJ3oWscM0EPJLRX7Ib4X
         dzhOVpyvo/x+QD2FO/XlGw1EAtlIuqfQH/U9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xxjT7d94j+WCj0QLGcmhg1uRaBp4Bt8HiJLHWxNSn0=;
        b=CGlqNiUWEEFJgsKkXWuKpQAOmdNe2lC5mxHlokUOY7d7Jb8OCwaxFCaEl+Dv492jey
         tR5uWbgVhUp3u5Xg1NHucu1KnqtaBHJaTKy8ypDfjJM2g05w/aOMPaO3Bj6gsur8sW6Y
         bVbsC3nD2R49SxaF618BfKJUVf3VMM0+xDdUnvLsy+UE6/fK4Csr5XsUL9AzB6mEaJhn
         Wl2zWQ0DvC41g9apeWl7oqrbtttQTtYlIMKJ33CklZncRFHFwuvSeoo9btN4n4X7zYJB
         g2v/3sYMpHxSYeVaju85mg+eA0SDV0EMMw6TxTjPzFJ31NhDiYD1kHK0hMCUrI/TnOzZ
         yw9A==
X-Gm-Message-State: AOAM532qxnwm8DKce8KJjL8z4jOYMEo2+tf2DeZWQc0v1RLCx9EDGY8s
	tDHbS2jWw3jL6cEZnDEYO/oLXN9S0l8OEA==
X-Google-Smtp-Source: ABdhPJwPZYDXKhx22ulArfgY2RVq6Rep10b2fpXeRpv3U2WGt4bOKfhDevRafkJApTNzethZkx6HNg==
X-Received: by 2002:a1c:7fcd:: with SMTP id a196mr10817119wmd.180.1619705489999;
        Thu, 29 Apr 2021 07:11:29 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y16sm5282636wrp.78.2021.04.29.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 07:11:29 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 4/4] prserv: Add 15s timeout to auto shutdown
Date: Thu, 29 Apr 2021 15:11:13 +0100
Message-Id: <20210429141113.27974-5-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210429141113.27974-1-pbarker@konsulko.com>
References: <20210429141113.27974-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This timeout prevents bitbake from hanging if the prservice process
fails to terminate within a reasonable time period.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 5e322bf83..50d7cb694 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -362,7 +362,9 @@ def auto_shutdown():
     global singleton
     if singleton and singleton.process:
         singleton.process.terminate()
-        singleton.process.join()
+        singleton.process.join(15)
+        if singleton.process.exitcode is None:
+            logger.error("PRservice shutdown timed out")
         singleton = None
 
 def ping(host, port):
-- 
2.26.2

