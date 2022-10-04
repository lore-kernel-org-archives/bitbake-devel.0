Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6071EC4332F
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 15:55:38 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.12293.1664898930090141835
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=DV5ajeYV;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.53,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f53.google.com with SMTP id
 x1-20020a17090ab00100b001fda21bbc90so19005571pjq.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=gebORtQXX9mXxvhJ88KIdWlFpm9g069u8KhIW60lErE=;
        b=DV5ajeYVG5IrVxTKxpscB7RrDXMrkeQH6VFysj9k4oJ+/09e16DqkpN9l1HE/sAckf
         V5m1dgHeB2jz74DzG79YR3F7yIR2rBSFaCHQkVHW/BFkvGK8tKQVkVOw9dtFjy81lNEb
         i65DhL4RsFEZgAsvF9odJ9m7YDfjr+GcGsVn7uob/IjLW4Kp+yyrqMjWS3jp597CB+qV
         4Im5unsBviA/egsiQGDHfOsHTbIbWgFc9hHUYURdC5gZ/k7hUoPnqIhammq9R/Xzt4Cp
         D+ElROBJQ9v1/Gn7fctllheTvoFdJ77Vlcbvcvx+TYImQetgSBiPSwyJJHRSBri2RYeX
         6olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gebORtQXX9mXxvhJ88KIdWlFpm9g069u8KhIW60lErE=;
        b=1r1Dd1ZsqJdZ0XqXyOFPKzHHMVFqW3/GDigyUflA563W14bF/r9O4R6YH1D5ldDXSN
         qXG++g2TP7IsuyeqCmM1GSkNut9cOg41Vu9Gn86GXw8rxyDnOj7dXMVW4a5/WtB65/fU
         5P7Gvpp+jRNeyGKRPV2xy//uQavlaThuGf5iKinwplQ6RMRnmHZ0G9hrP2sTGk5DmXb8
         D0OVbcpGBhskMubc53u15mOU+4igcyyUdf3sp0q5zAKjO6BcP70O/mS1KHRCOxk4fsnr
         fPKJEUlkFbPFUZJuBzTeXo/Z5IaiLtwrcA5cbHXkA+jqHhPR5CM2HtVYWRh1aEt2KPIX
         NOhQ==
X-Gm-Message-State: ACrzQf3yBkVYsbW4nNqWpP5L7A1EQEfZ3V0iEBprHThmour3eVK+Ljdg
	pwzu23QFCcqbiKamHOTQpztv/rxNW0WxOYNG
X-Google-Smtp-Source: 
 AMsMyM7v2kWOUw3HJBaguJtXKIIBZf2DlJ59GAAdKEy3KwupxUSPs2IMcPTQim+MVivqln2ZP31dRQ==
X-Received: by 2002:a17:90a:50:b0:20a:b146:e75e with SMTP id
 16-20020a17090a005000b0020ab146e75emr384322pjb.216.1664898929170;
        Tue, 04 Oct 2022 08:55:29 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b0017e232b6724sm4716457plk.69.2022.10.04.08.55.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:55:28 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 7/8] gitsm: Error out if submodule
 refers to parent repo
Date: Tue,  4 Oct 2022 05:54:58 -1000
Message-Id: 
 <987712c4c8fefd86a1f5116c11ee86e296e852ee.1664898736.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664898736.git.steve@sakoman.com>
References: <cover.1664898736.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 15:55:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14022

From: Pavel Zhukov <pavel@zhukoff.net>

If submodule refers to specific revision of the parent repository it
causes deadlock in bitbake locking mechanism (lock is acquired to fetch
the parent and cannot be released before all submodules are fetched).
raise FetchError in such situation to prevent deadlocking.

[Yocto 14045]

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0361ecf7eb82c386a9842cf1f3cb706c0a112e77)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/gitsm.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c1950e48..25d5db0e 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -115,6 +115,9 @@ class GitSM(Git):
                     # This has to be a file reference
                     proto = "file"
                     url = "gitsm://" + uris[module]
+            if "{}{}".format(ud.host, ud.path) in url:
+                raise bb.fetch2.FetchError("Submodule refers to the parent repository. This will cause deadlock situation in current version of Bitbake." \
+                                           "Consider using git fetcher instead.")
 
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
-- 
2.25.1


