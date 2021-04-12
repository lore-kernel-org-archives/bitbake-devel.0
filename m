Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.31092.1618227726806811508
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:42:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Iw9e4a8/;
 spf=pass (domain: konsulko.com, ip: 209.85.221.54, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f54.google.com with SMTP id a6so12591660wrw.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u68nok4DvsdaBQxWiDiZKXMYun0l5wGq9Zk7Qhj3Wlg=;
        b=Iw9e4a8/NxG/m8Uc3mGWbBLWkDXCWbN7qmE1r4ximnjtjFh4hwGMOcJGU9A4uNh8Um
         PmA1AypWX5ylamHyS5YevTgUt5Ncl7WeTuLJwC6twvWhgpXQ8zm0YS4wvuwJXxC9RHuE
         XtF/hJ0Jx0AFe31axlKGSYaty3Z3pcY3twn+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u68nok4DvsdaBQxWiDiZKXMYun0l5wGq9Zk7Qhj3Wlg=;
        b=bxUFT9FKj5ExcGuvs+1kO8KK+WNALfrkfvEr3N45ETOkMaETY3bseMF+X/LyRa00+L
         +p1uxnp2J6NgOgoxiFIKIX8D7VYuKh77ZzAKGGeRXYrJoiCYkdTNK/Pb0QpUtFBqd7ax
         mWwYoxDozScmwKNgwIrbiXJGGR4YhTbopANFshgDvcB2TvCtUFUL9Jy2PXDJjdeDqRmP
         Biypef2xSemNJMIhitOV10LpkSwWg/BldzMQormxu7hlurX0ZTbDiCT3ytif64YQoHg+
         grnO7SvwXX/PAOJjVOn49mEoE0W2gCJ2zAkFPd5RlUKm0l1oVkxKOqFTHU57cEoxPuMs
         wcrw==
X-Gm-Message-State: AOAM531IQveQVr2HooAfzPjTqGO2IsnNzbwWYWl5GVznxDMURHI48/lv
	44H62YdYiozlIjx4TbkBfHKdrtI3vsVUZA==
X-Google-Smtp-Source: ABdhPJx8OMCoVYcYcZ8yC+JNyL9+qU7wrmyu6txxP8R46OJr1t6gpY3ecCYM5aCdi0C3tH+ueZyS+w==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr30809480wrv.220.1618227725228;
        Mon, 12 Apr 2021 04:42:05 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:42:04 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 11/11] prserv: Add connect function
Date: Mon, 12 Apr 2021 12:41:49 +0100
Message-Id: <20210412114149.4750-12-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function abstracts the setup of a PR service client connection so
that openembedded-core doesn't need to be updated any time the details
are changed.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 70bb2b2fc..055b18bd2 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -371,3 +371,14 @@ def ping(host, port):
     conn=PRClient()
     conn.connect_tcp(host, port)
     return conn.ping()
+
+def connect(host, port):
+    global singleton
+
+    if host.strip().lower() == 'localhost' and not port:
+        host = 'localhost'
+        port = singleton.port
+
+    conn = PRClient()
+    conn.connect_tcp(host, port)
+    return conn
-- 
2.26.2

