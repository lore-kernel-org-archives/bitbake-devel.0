Return-Path: <daniel.ammann@bytesatwork.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC06AC76196
	for <webhook@archiver.kernel.org>; Fri, 17 Mar 2023 17:04:19 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.25219.1679072652924121348
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Mar 2023 10:04:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bytesatwork-ch.20210112.gappssmtp.com header.s=20210112 header.b=vQU9mLXU;
 spf=pass (domain: bytesatwork.ch, ip: 209.85.208.47, mailfrom: daniel.ammann@bytesatwork.ch)
Received: by mail-ed1-f47.google.com with SMTP id r11so23002029edd.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytesatwork-ch.20210112.gappssmtp.com; s=20210112; t=1679072650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcnFE664dMRvr5YXPac+BJi4lDEFH5XmSPuoQRVJEkE=;
        b=vQU9mLXUcIa018Z61n90kOQmxElEftECE0Q2D6CVfrs8UafYh/GeByMmyqUR4KfUnl
         qIzSX5KK6D5A8rjBKYzNCGO3qhy7kNheJztt/VAakVJo1AmSDhKgTQvvDhus9WS9sI5k
         XP/56WjCzF0gAQEthfQ76u0BpZzeyZKmkHcL2dotPZ5r3UXBcT6Nt0Nv5vpuSXJdf2xl
         xLISeV6wuTMKcSIi+cwpmVGj2Yl75sWbOGAgGxFOVL4xxNO6aGN2a9X8XcDa9XiErFzU
         rKMAUCILeJ/L+6Rg/Z0ay5vbqlMZuadIomu/pqJVUSa19FUfozpQm31agFcsJ7+YxYi+
         DpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679072650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcnFE664dMRvr5YXPac+BJi4lDEFH5XmSPuoQRVJEkE=;
        b=0JasacZ5cZg4h5cf9QieO/LOr0RIMsutQLKclQtPeedS5y055yTtFISo2vqmTLmvTa
         NF6gyTlVF0qnIPIxtb2YIGKKVlINySvhOjSf0m1FenIDg7+O9O4u2MQvcOO65HOSo1o2
         rwshcD8ujb/ZIhdxXfITSkJJmb6XI3pKPbOVkVOUaXSWDfLYBuqoXi/C/e/OI28BnZzR
         N/rP0sBMxuir8lS/c8dJxyzcds2MPkbS/PifaZxB6yabxHLVNvdmsQ7g37LEzSFJYwYK
         F2XpkfcZ7ERFMzJmHQsiy2QzGNF6CBrDn9WELRgrAhv59ucRvbRTWJJRJgiTXqQfPW1Z
         AevQ==
X-Gm-Message-State: AO0yUKXujcXemffYVLn5VvDcLylJsdJpiJ967XZleNffHP9/y/boj8fz
	oCdIl0Nea0cqBXzRpNfJ6j2gzkSE3H8ilL8z7y1TzQ==
X-Google-Smtp-Source: AK7set/1uNdx3H/C0bzGUBXJZfI6dNBQQPXZDg887kz23BezGlvD1OVrmJqSvxKqHJHBZC+aZ0pA8w==
X-Received: by 2002:a17:906:49c7:b0:907:183f:328a with SMTP id w7-20020a17090649c700b00907183f328amr13178045ejv.65.1679072650424;
        Fri, 17 Mar 2023 10:04:10 -0700 (PDT)
Received: from mimas.bytesatwork.ch (162.40.150.83.ftth.as8758.net. [83.150.40.162])
        by smtp.gmail.com with ESMTPSA id l2-20020a50c102000000b004fc24b4a283sm1318117edf.40.2023.03.17.10.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:04:09 -0700 (PDT)
From: Daniel Ammann <daniel.ammann@bytesatwork.ch>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/sftp: Fix fetching URIs with spaces
Date: Fri, 17 Mar 2023 18:03:54 +0100
Message-Id: <20230317170354.971113-1-daniel.ammann@bytesatwork.ch>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 17:04:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14605

Spaces can be used in URIs with %20, but the URI needs to be quoted.

Signed-off-by: Daniel Ammann <daniel.ammann@bytesatwork.ch>
---
 lib/bb/fetch2/sftp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index f87f292e5..7884cce94 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -103,7 +103,7 @@ class SFTP(FetchMethod):
         if path[:3] == '/~/':
             path = path[3:]
 
-        remote = '%s%s:%s' % (user, urlo.hostname, path)
+        remote = '"%s%s:%s"' % (user, urlo.hostname, path)
 
         cmd = '%s %s %s %s' % (basecmd, port, remote, lpath)
 
-- 
2.30.2


