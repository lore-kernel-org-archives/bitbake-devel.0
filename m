Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web08.4967.1603749987936464902
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Oct 2020 15:06:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Uk1h5O8A;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id n6so14620005wrm.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Oct 2020 15:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8mWAbKth21RiAkR69KfIUwu/SqypdZZkqLza0HvIaE=;
        b=Uk1h5O8ADTfhzJS9yjf9ilGhyl0Ou/JyuVeoEQ1z3qqERsCphyEGLNULpP+qyMPilV
         N4tGAeZQrb2tiK6UqBGlFdHV2U0xLuZ47jHwHpejvJZd3e7P+nauggSL0SOEY1UwLNbX
         WpK1iDZBaMhyYsXjsIobijFRFyPE7hlQw5+uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x8mWAbKth21RiAkR69KfIUwu/SqypdZZkqLza0HvIaE=;
        b=E7q0N7zZqPS9gOIHnpwjJZLJJkK0kL1PSrV2RqABAjehBfOu9n1gL3zIdlODxEG8qe
         I+tTrQ3TMT3kKdGj7BLl/xxFbf09w2uXexj1h1mGgIXO1gINvUp4iqtIhktEjoP7h5lg
         VK1tVfgLXn8d/DJLZC9I46l37Vsm+I8bnkCd165ZoCfVhqhL7BYACLBPcAIodTPnCJQe
         jUQQTjkT9kPNcAHKazTKBkDYsMaakxz8gRBfmHYi98xGM4/kXzgl4cdB8yOlDfB2WNxH
         xEBXzSvr7Cl9FyvjR21AHu5Q99h+IlR/nfdmNl4UxDr1bjDLrloDNZjnRHduCYWJMMjL
         7Jkw==
X-Gm-Message-State: AOAM533xBM+gbNjTPT/ymU5+z2S175nG1itM+K+oNMrB3rWQsVaKhvNq
	qYW/l3UZBkufnY5uYDSq09jJRCNAC2OXaQ==
X-Google-Smtp-Source: ABdhPJyXzzFwvtGK2z7/qeiFK0ZUddrDAazsUIYI2eC78PKSenuFi4mHVFfHPGcpJ7h0ZihrMb1PIg==
X-Received: by 2002:adf:82e5:: with SMTP id 92mr19343685wrc.192.1603749986290;
        Mon, 26 Oct 2020 15:06:26 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.0.2.3.2.a.1.a.7.6.b.c.7.6.8.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:1867:cb67:a1a2:320d])
        by smtp.gmail.com with ESMTPSA id y10sm24754505wrq.73.2020.10.26.15.06.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 15:06:25 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Update upstream master->main branchname transition
Date: Mon, 26 Oct 2020 22:06:25 +0000
Message-Id: <20201026220625.112834-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 5a4db9ca4c..da17d7f281 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -923,7 +923,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
         # We want to avoid regressions!
-        url = "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2"
+        url = "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
-- 
2.25.1

