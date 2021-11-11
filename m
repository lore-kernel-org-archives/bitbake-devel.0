Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0177AC433EF
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 00:45:41 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.4171.1636591539763274617
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 16:45:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=qKqWhYTp;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f175.google.com with SMTP id g19so4105699pfb.8
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 16:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zBaVnPCZXbeLyclXimaHg6MN/Zz1wBYDcwLjT6gjt+M=;
        b=qKqWhYTp+TncQ/bXW9GuByE42GjiqLfrVegtKT+NGcc2+H551xaobKCru46mUvqOr8
         Zf4YkvuoItvp1hdagE6+Jj6JqSg4FodSgxswrEc2XEa6+HSyqg9VReGcInTEatUuIQRa
         KiEuB8Y5lqgCqIZFkdMNUW3g2CHmwjkLNViyKikdOsAiN3W1m1Mxr3gNATrG0jNhJN+0
         o0gDFSBYhWiI3hMUh8hKrK9EkFKxbm7J426S6coLG8y+R7V3L4pbSbGscKPQ1u2xlT8Y
         VkX9Iahe7zQKVFdESxcE5Sq+c/SEENsxWk6bntVrbCP6Wr1u9oTakbRorFWWibJ7pzCN
         z5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBaVnPCZXbeLyclXimaHg6MN/Zz1wBYDcwLjT6gjt+M=;
        b=LdG4cz/LDPz6xOKHzx8gQQ4PQFmAuFgAc66fQ5ospNV3f3rc060FgX6oa74uS+zrJj
         55Z/YN5Ql95ep916JQLU0Y+raETWcb/trfdRHu12U3asjysa9FWJV11DJ9IvIEqH7uog
         ywMS/cymnLQTIU6Q8nqfNPp32UFjaLgwyb/D6PDqbZ3h7vek016X8Cxr2XBg+Y80A9FJ
         11ZWNpDXYA4v8F8DwZPJmVg4IVh0CwJR3yTZmqvX5aC+QUi5KHC03asZ3MGPwfxkHotM
         fcEJ7FrGrFx2kMYl32uSou78pr6+UqxecaGckTqtXWJtj/cah6H1d/RlCpK6FtuWV2R8
         /ofg==
X-Gm-Message-State: AOAM532GTeje8n+rfHLEtz6kWMCSnBA71QfdvVz3RHg+LPf7HMj0/bp5
	g79QxcIUe6JGYiueTHyvbfwpgoThtftcts7itdQ=
X-Google-Smtp-Source: 
 ABdhPJyDlkB609AvSvem7SpmOm/AO6aQ04RuPKZb6s2reAQayXD57nRXf23JjYVT4atLQz7sR/CuBA==
X-Received: by 2002:a63:6b84:: with SMTP id
 g126mr2072859pgc.110.1636591538634;
        Wed, 10 Nov 2021 16:45:38 -0800 (PST)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 oj11sm3597407pjb.46.2021.11.10.16.45.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 16:45:38 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH] fetch/wget: Add timeout for
 checkstatus calls (30s)
Date: Wed, 10 Nov 2021 14:45:26 -1000
Message-Id: 
 <c8c7678eccee16e6c2ac93ae6c5ba74a62e0a9e9.1636591465.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1636591465.git.steve@sakoman.com>
References: <cover.1636591465.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 00:45:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12997

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We had an issue where a webserver serving sstate had filesystem issues so
would accept connections but effectively not do anything with them. This
causes bitbake to hang whilst processing things like sstate objects inside
the checkstatus() calls. It can be replicated by setting up a server like:

socat -u TCP4-LISTEN:NNN,fork OPEN:/dev/null

and pointing SSTATE_MIRRORS in OE at that address.

Adding a timeout to the checkstatus calls of 15s means that whilst the
system will pause, it will then continue and not hang entirely. Since there
isn't a large transfer here, 30s should be a reasonable response time after
which we should fall back to building things ourselves.

[YOCTO #13716]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index f7d1de26..5676d3fd 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -319,7 +319,7 @@ class Wget(FetchMethod):
             except (TypeError, ImportError, IOError, netrc.NetrcParseError):
                 pass
 
-            with opener.open(r) as response:
+            with opener.open(r, timeout=30) as response:
                 pass
         except urllib.error.URLError as e:
             if try_again:
-- 
2.25.1


