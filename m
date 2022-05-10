Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3CAC433F5
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:53 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.611.1652206005982248248
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=2XDwuEgv;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.173,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f173.google.com with SMTP id d17so17468870plg.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VxKJs/6ndKqV4bAMj6Gsg2R5aK27w2TRYhY4Pwf+dB4=;
        b=2XDwuEgv9Dl19RAX70uXbt6YMk8Fu9qVTYat6JdKljRX/lwdDfikmSzWUKu9X8QDYK
         FdJV4xpkcmPCWuQgq/E0rnwF3v94vOh8MoWgJSqz+zYpUoHC9VGrNdJ5Sznldz7yzbfY
         +at1trM2GOFu5NN0YzLC6YlWjh8T3T8w6CdLqZDhcFF/TiJTqitKv1sWQoqZ2hSIXVtF
         GRmNs/0SQdWfjTjO+7e7RzEe/FA1PraLJ7iMahSO6E1YiV9AsRX94XoE03kMzapwegv/
         ALcf3CxFnt4zHqlA1subnS+qkzg8H25u666wGDK04YDyRjfX2tH81qABXpb+xKTObANK
         veYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxKJs/6ndKqV4bAMj6Gsg2R5aK27w2TRYhY4Pwf+dB4=;
        b=r9xZyamZVosTZNsGS4iHVbO1oup5010OT7sYYr/3kDYYDE8Rl9zTRhi95wlKaq0qrx
         5NUpN3qMvoWctgKxXYjQ6z72FJIrcGoolUSVSkwEsEMXKS/iK7Qw/2LuQ0t4zLTij+SA
         p0K+8NMmNHGElhk1F4ob7iowPskvvIgTUWuBqSPF0mid2GR93CIRndQ/zWNHhlwV17jo
         jw4nurie/oE/7HaWwjbHKSQ1RIqQOMJBPQ2+mXsX9JT62dEbu05AT8EjnXZwqHXZOroR
         uPxc+8Tjs7hXLUzMLfesol2ZW5BgCvWqYozK+5e97fXj2QMov8oMExriInAt/JXI9VAW
         hJsw==
X-Gm-Message-State: AOAM531RkrhMEJLijcvfJHTXPYjRROdhsMSVZTJozGwGOtjQPrF330+A
	7KLzivVlr2fxKhfsUbF+EG0Y9RaHuAoYhWnx
X-Google-Smtp-Source: 
 ABdhPJw6oo1n5IsBZpC9SyOiMVcjrsXXyqkDu2U+kKdpM3S0x/XWTivM9pj2qivyZ39ur6t/8mIgFw==
X-Received: by 2002:a17:90a:9483:b0:1dc:5fb2:9b89 with SMTP id
 s3-20020a17090a948300b001dc5fb29b89mr1063138pjo.235.1652206004631;
        Tue, 10 May 2022 11:06:44 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:43 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 17/18] cache: correctly handle file
 names containing colons
Date: Tue, 10 May 2022 08:05:42 -1000
Message-Id: 
 <11460a5b887762b946eb11e847c1ce70f83f74f7.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13697

From: Roland Hieber <rhi@pengutronix.de>

File names containing colons cause split() to return a list with more
than two elements, which will lead to a stack trace ending in:

    ValueError: too many values to unpack (expected 2)

Split only once at the last colon, thereby making sure that only two
elements are returned.

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a70a7376a8708bde07959deb5d5842d7f84ee5f8)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index fcb15796..92e9a3ce 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -619,7 +619,7 @@ class Cache(NoCache):
                 for f in flist:
                     if not f:
                         continue
-                    f, exist = f.split(":")
+                    f, exist = f.rsplit(":", 1)
                     if (exist == "True" and not os.path.exists(f)) or (exist == "False" and os.path.exists(f)):
                         self.logger.debug2("%s's file checksum list file %s changed",
                                              fn, f)
-- 
2.25.1


