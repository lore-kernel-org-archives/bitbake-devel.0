Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A7C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 14:30:00 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web12.3853.1668004195470038238
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Nov 2022 06:29:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=cxtxw0aU;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.178, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f178.google.com with SMTP id d20so16177979plr.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 06:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ih6NBxKOxF9OIBcKOQ2JpJwOJJIhjlRzXLEOKPm8Czk=;
        b=cxtxw0aUlfK+9tluQbn3TsXRae94k/tQrb6XXk4bGnsXqnXSo+zz9UxYW1kO8dG9R+
         J39WYddKhcKR88I4QtLYXx8AbNnHW3Zep8eY+otA455oY5CxhsjdTKDO18N36gNoG5RL
         YotFkUvezvD+kdcXaJEyH31AiqGG68y9/S+8/smuDZuTgNjAiJdtVOsODby1D5UQOqLh
         Q24QNbdSio4e74dssm+yRiIldNKzZOrQCFy90Z6R1mm/GDr4CMlrZegvuMd2SwKbvTap
         dkQe2xmOIUJSbpRSP5CywLbqhl4Wft+SjWaIu0S3vh6Jgz64KKniUpPspg/Oy7I88taX
         BIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ih6NBxKOxF9OIBcKOQ2JpJwOJJIhjlRzXLEOKPm8Czk=;
        b=H6miiZovjiNZ6QUIHD2J2DFd3UIZWsLmo2zoU+rj7FJ4Mc3/NkyQqrU/np3zUAfvLt
         8CLLL/4kxKgTdm8ulvMbYilK1ZiwDtVMWMykFgrQMkUmVE4/rtIu/qkpetquOWXQdWxB
         XCa95vUNFcHnphxXB50Wk5C5jxjfD6CLnr/rdHDU8rx5xkH2n6AwdjrZm9GcfOteYa6P
         0saML3SS3zLvVpNBhe2XKUVIrup0Mcbkah2rQE+bDbvEF/3dFLj/8mB/uT8q0M7WTvz+
         Ajd74DQKWqjg13uE6qkzki3/nLsxkEW6pSVct4UfJUq44+Zqii+DZ7E3b/D8NroYwdXO
         7Hhg==
X-Gm-Message-State: ACrzQf1aL77PGmH6TLydd6ZEDfW44Pmj7fR4G8XIK3XpkE4iVkYHcJsS
	cDHS5jnD8fpMtIJOyVmlt70VF6vNy69V129z
X-Google-Smtp-Source: AMsMyM7WfSOvk3yH/uNmdEhL3sCLCHX9CCiLL9BLuMxhCQXXDElAhzT6EsDkkfLGlzoKC0485zQBsg==
X-Received: by 2002:a17:90a:f306:b0:213:b191:f3bf with SMTP id ca6-20020a17090af30600b00213b191f3bfmr60622422pjb.237.1668004194615;
        Wed, 09 Nov 2022 06:29:54 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id nn14-20020a17090b38ce00b00213d28a6dedsm1308611pjb.13.2022.11.09.06.29.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:29:54 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 3/4] asyncrpc: serv: correct closed client socket detection
Date: Wed,  9 Nov 2022 04:29:35 -1000
Message-Id: <22b8ec06e61d058a0775957702204f1331e47210.1668003926.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668003926.git.steve@sakoman.com>
References: <cover.1668003926.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 14:30:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14064

From: Justin Bronder <jsbronder@cold-front.org>

If the client socket is closed, asyncio.StreamReader.readline() will
return an empty bytes object, not None.

This prevents multiple tracebacks being logged by bitbake-hashserv each
time bitbake is started and performs a connection check.

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2d07f252704dff7747fa1f9adf223a452806717f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/asyncrpc/serv.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 5cf45f90..d2de4891 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -42,7 +42,7 @@ class AsyncServerConnection(object):
 
             # Read protocol and version
             client_protocol = await self.reader.readline()
-            if client_protocol is None:
+            if not client_protocol:
                 return
 
             (client_proto_name, client_proto_version) = client_protocol.decode('utf-8').rstrip().split()
@@ -59,7 +59,7 @@ class AsyncServerConnection(object):
             # an empty line to signal the end of the headers
             while True:
                 line = await self.reader.readline()
-                if line is None:
+                if not line:
                     return
 
                 line = line.decode('utf-8').rstrip()
-- 
2.25.1


