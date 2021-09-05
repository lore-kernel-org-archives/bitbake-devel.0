Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web11.15326.1630880882230826469
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Sep 2021 15:28:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YoB1lsWR;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: weaverjs@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id r21so4088701qtw.11
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Sep 2021 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hveI4eLNhozhpCJE1zCJyMtOEB1nXdy99H/zyOHf1Bs=;
        b=YoB1lsWRcgqqAWtJvzS1w1VpHQ98L6bDWebHtPTEF6l+AWbPaBOaVbD4Sw7s9naHID
         0tLSAkuRUtCe3gMYPzrttOlXRVlIkCyBOe36fwAOWDJBYDv/bYKxCD1uJo8rvCEC1bvt
         Y+yZUHvHw/ct3ZeaX2F84+Gib20een7V8Y7CIJvh8plqbZDdcAOMKNkmGiVafsZAfxSW
         8lU7D9qbhI6stuu7LTXV0kNea35H/elKm2WbULoRBt4iUZIUCiScKP1nax4DcRDjlWbz
         BKwT/XowUYt/UMzj5gascS0Yu6JkM0KUBcv2CQGt+pf0QLX+KWlM/tM08BH4dvXfP9aW
         yBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hveI4eLNhozhpCJE1zCJyMtOEB1nXdy99H/zyOHf1Bs=;
        b=jAFySLckYBrPDhN10WmDNtxcCkPwiMgwFy9amxcTfJDrCAT+xuWjt5oJNpANa3WPmu
         roDd0y8YZQb5TuAXOjBDjxDQyu6WhMLnQrDnZti8rsv+Iz/k40Zxcp9JFGGNMwPTKumY
         brW0RVYoGZ1Yw0U7he+k7pSXamBLV/ACCfigonTwD1d9U9D56uiyD+1PzyBMeUWMxnUx
         3+4NgX3tUPJwm8owcCdCrAbgLbuTT79VNZysH2ccbGSoq8QZnWPyRHdgqefMXwROy72o
         hDeqCZzbKG2OAw4C1+rUAuzzdnzXk60d5GkZ8S76goqzVWvPKUWHoDCpI7FtaFaNAzO7
         cA/A==
X-Gm-Message-State: AOAM531/cziTX7+7EDffv5C3DjGuPoB3OWJ/i0aDFdWByEXl908ggATV
	QAhf1hUwBq4UlbbXIxw8bTagSAXSWTtuL7JWGw==
X-Google-Smtp-Source: ABdhPJyMwMZx6PYQSGqwXnD/rhwpUoQJUY77CLoUQBL6G6Rzolo2S5HVPMzJ8zeUH4MM+sTj+A9htQ==
X-Received: by 2002:ac8:7d4e:: with SMTP id h14mr8471223qtb.404.1630880880943;
        Sun, 05 Sep 2021 15:28:00 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from p-impout007.msg.pkvw.co.charter.net (cpe-69-133-48-66.cinci.res.rr.com. [69.133.48.66])
        by smtp.gmail.com with ESMTPSA id w12sm4202790qtc.47.2021.09.05.15.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 15:28:00 -0700 (PDT)
From: "Scott Weaver" <weaverjs@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Scott Weaver <weaverjs@gmail.com>
Subject: [bitbake-devel][0/3] BZ#13039: updates to fetch2 and tests/fetch
Date: Sun,  5 Sep 2021 18:27:35 -0400
Message-Id: <20210905222738.1050768-1-weaverjs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this patch set, I address BZ#13039 and add fetcher tests specifically
for downloadfilename use cases along with an update to the npm fetcher tests.

https://bugzilla.yoctoproject.org/show_bug.cgi?id=13039

Scott Weaver (3):
  bitbake: fetch2: fix premirror URI when downloadfilename defined
  bitbake: tests/fetch: add downloadfilename tests
  bitbake: tests/fetch: add and fix npm tests

 bitbake/lib/bb/fetch2/__init__.py |  2 +-
 bitbake/lib/bb/tests/fetch.py     | 47 +++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.25.1

