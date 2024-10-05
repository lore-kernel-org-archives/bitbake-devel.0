Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569FFCFA741
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 13:45:08 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.11809.1728135902633257515
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Oct 2024 06:45:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=ZaYmliFL;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.49, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e082bf1c7fso2187131a91.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1728135902; x=1728740702; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzO3nwQqGxFP2DyvlxKQkMXVJaej6DjFda5/+UO1kKY=;
        b=ZaYmliFLctlnEwHw/AF32/XW7MbH08jHqGmj4bN/C91KrqayvnINVRxxf0dqm3IqgN
         YrkgPA3keU+9etxAm2nD2z0I3PNNRPBmJgzQZyZ1F/NADPgI0edBFmUj6aq93RErVJtM
         I98E7YetHo8vxrmom74MrIHsezEa0728my+QQA62ejSLXOVrqftFI8KjQK4RX/Oqkzrf
         aAlekUwmRyV4h+qAzZpZTX/vSS7NqtNUSa9EkuUorYgR5zlpJ4pgdlp/U8UEtPQZqv0K
         UTkb7eLUW/skKJByQ9ZNA4vy37XIc8J7gb9LNUsWwq2Xq8mRPrB8ANOyulcJmUy2F5sJ
         GCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135902; x=1728740702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzO3nwQqGxFP2DyvlxKQkMXVJaej6DjFda5/+UO1kKY=;
        b=S9g4RIfTJSEoom1XYjp+I6eQyIH2gxmQNz3R28d0dsrZ3L1mr8h+9NHY9pBRdgPiVs
         7FyRyDhSosveRldsBZeBIWN8HrWTZN0Dvy7pI41SsYUqDayu1C0p6BvpK+/hGq6/nNrN
         xIDuqQCbNRwHRfpU3mzVdO350RrETEoyNfrP7atgAOaUwh4Sd3h5B4+w99c0y4fmsLH6
         Qisu85JwSOeiZcQlKMqIsfo9A1O2QeunIJkNyoFg3thrwy+PAX80GUZC1fSX0mhjd6Xj
         TK/iH4YhAdFfM808EFutiJtfmKgl55lqr2eYnu5KHBbcnzoJATStBtaXVFTWIMe1KPNj
         0znQ==
X-Gm-Message-State: AOJu0Yy9sNaOz8y6Rr/H45Qn+V2palAcrDFPsKBm5GrcMpjbHA5K4s9Y
	3cK1vulkSydOZ53AzDpcVULCkZ+s3ZhZAS1kd8OqMF/M6hYqn2ImRYCpqqAQ+JPsNrp+Yv2pon1
	eYpY=
X-Google-Smtp-Source: AGHT+IGpT7zBmzDHCmE1m/Npdjw+YWfDrfCez+L6vJtFc03ho0NhcfnA/MNz4eg0xDq5+yXIQ0S0kA==
X-Received: by 2002:a17:90a:e2d5:b0:2e0:778f:d774 with SMTP id 98e67ed59e1d1-2e1e6213064mr7592468a91.2.1728135901851;
        Sat, 05 Oct 2024 06:45:01 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f919csm1831617a91.44.2024.10.05.06.45.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 06:45:01 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 2/4] tests/fetch: Tweak to work on Fedora40
Date: Sat,  5 Oct 2024 06:44:49 -0700
Message-Id: <3147ebb0edcca8f7f850aabd86ef010ab593496f.1728135724.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728135724.git.steve@sakoman.com>
References: <cover.1728135724.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 13:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16642

From: Richard Purdie <richard.purdie@linuxfoundation.org>

On Fedora40, "localhost" sometimes resolves to ::1 and sometimes to 127.0.0.1
and python only binds to one of the addresses, leading to test failures.

Use 127.0.0.1 explicitly to avoid problems of the name resolution, we're trying
to test things other than the host networking.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9adc6da42618f41bf0d6b558d62b2f3c13bedd61)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a7d9d5e88..efe5479a6 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1417,7 +1417,7 @@ class FetchLatestVersionTest(FetcherTest):
 
     def test_wget_latest_versionstring(self):
         testdata = os.path.dirname(os.path.abspath(__file__)) + "/fetch-testdata"
-        server = HTTPService(testdata)
+        server = HTTPService(testdata, host="127.0.0.1")
         server.start()
         port = server.port
         try:
@@ -1425,10 +1425,10 @@ class FetchLatestVersionTest(FetcherTest):
                 self.d.setVar("PN", k[0])
                 checkuri = ""
                 if k[2]:
-                    checkuri = "http://localhost:%s/" % port + k[2]
+                    checkuri = "http://127.0.0.1:%s/" % port + k[2]
                 self.d.setVar("UPSTREAM_CHECK_URI", checkuri)
                 self.d.setVar("UPSTREAM_CHECK_REGEX", k[3])
-                url = "http://localhost:%s/" % port + k[1]
+                url = "http://127.0.0.1:%s/" % port + k[1]
                 ud = bb.fetch2.FetchData(url, self.d)
                 pupver = ud.method.latest_versionstring(ud, self.d)
                 verstring = pupver[0]
-- 
2.34.1


