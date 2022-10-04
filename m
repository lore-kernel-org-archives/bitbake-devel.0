Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606F4C433F5
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 15:55:38 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web08.12417.1664898932267689714
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=KlI/OS+w;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.180,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f180.google.com with SMTP id h10so10302172plb.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=nHVvsCc4sF3f1OELLFL7N9/tPU0TcAzz54wittgRkMc=;
        b=KlI/OS+wIrzAhQ+fEA/478CvhmNT+uCcfiFljCJUroHxOgBDPst8SZZEcp4trVuFkP
         gkrk7l5btCKVLxLsdhg+E43ibjuiJ7pDD/cxKizzLgBCE0NDH9p8f7Jx5N+wNt1ISpAg
         CvGW33vvxSGJdMvkgOUTwXjf38Y40lrpab5xFqu2sFo7gP51tRbCQHMky+j3AFIkwezy
         P/TK6TZ64swkCVsx6oL+p13lex9DnIF0Es50WeTQCAWBP395L80Lq6T8h/E/HK6tkV5G
         p8l3uJCQ+uBg2M75+efop5EYQv0mrOotrNyiwHcCHxHuLjLsu9OhaGQK3uKc27XiPArU
         g8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nHVvsCc4sF3f1OELLFL7N9/tPU0TcAzz54wittgRkMc=;
        b=jUWW0dueWnEdcvCKvKUCaN1SUbZ1gG6D6k6fsVB8/XXj/lXVOpSd/rL0s/VURRJs4n
         IsoF2I9wWcJnHqclrj+MAcqKoimNEmDBlK3+jluCDlhEtB5YstSUrCuLwRyxoUa5HcBT
         mLQUgtLXMb+b/XXhxo69zITVEqTp+VqNSFX8eH14mQhOwhLekoJenr4zeVMOgssKzokZ
         uy5eapJ0xiQH5o/DZu53lEDlFOzJmMLEEjdu1JTz+10sQWPVkpvD2LL+aK+jjSiXb0T/
         bFs13PCP+8JCtjpsoih35R76fQRGQ7SNuftxfmnBySq+AvZh8PShmrYnk/1wfG8mpbZR
         lQug==
X-Gm-Message-State: ACrzQf0JTZi920sSP0Ac+yQ6dvG/FxmMQcQiqW2vdfgbgRddiqnOeR7M
	IVxMWXBlzzpGM9kjrc1tyv+uVpgm4aEiIjeP
X-Google-Smtp-Source: 
 AMsMyM4AdQhCiSG/9qzcscfKRgY/qa6PfqMd5MJjfDwRdCA59CIldjWaE1SekUBOVyffU+MaeENXIg==
X-Received: by 2002:a17:90b:3b44:b0:205:d22a:e94 with SMTP id
 ot4-20020a17090b3b4400b00205d22a0e94mr371379pjb.15.1664898931343;
        Tue, 04 Oct 2022 08:55:31 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b0017e232b6724sm4716457plk.69.2022.10.04.08.55.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:55:30 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 8/8] asyncrpc/client: Fix unix domain
 socket chdir race issues
Date: Tue,  4 Oct 2022 05:54:59 -1000
Message-Id: 
 <6603c3e39f1cf746669ec6c9f0be8c6e6ece426e.1664898736.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664898736.git.steve@sakoman.com>
References: <cover.1664898736.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 15:55:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14023

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The connect_unix() call had a bug where if a relative path to a socket
was passed (which the non-async client always does), and the current
working directory was changed after the initial call, it would fail to
reconnect if it became disconnected, since the socket couldn't be found
relative to the new current working directory.

To work around this, change the socket connection for UNIX domain
sockets to be synchronous and change current working before connecting.
This isn't ideal since the connection could block the entire event loop,
but in practice this shouldn't happen since the socket are local files
anyway.

Help debugging and resolving from Joshua Watt.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5964bb67bb20df7f411ee0650cf189504a05cf25)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/asyncrpc/client.py | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 881434d2..fa042bbe 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -31,7 +31,17 @@ class AsyncClient(object):
 
     async def connect_unix(self, path):
         async def connect_sock():
-            return await asyncio.open_unix_connection(path)
+            # AF_UNIX has path length issues so chdir here to workaround
+            cwd = os.getcwd()
+            try:
+                os.chdir(os.path.dirname(path))
+                # The socket must be opened synchronously so that CWD doesn't get
+                # changed out from underneath us so we pass as a sock into asyncio
+                sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM, 0)
+                sock.connect(os.path.basename(path))
+            finally:
+               os.chdir(cwd)
+            return await asyncio.open_unix_connection(sock=sock)
 
         self._connect_sock = connect_sock
 
@@ -150,14 +160,8 @@ class Client(object):
             setattr(self, m, self._get_downcall_wrapper(downcall))
 
     def connect_unix(self, path):
-        # AF_UNIX has path length issues so chdir here to workaround
-        cwd = os.getcwd()
-        try:
-            os.chdir(os.path.dirname(path))
-            self.loop.run_until_complete(self.client.connect_unix(os.path.basename(path)))
-            self.loop.run_until_complete(self.client.connect())
-        finally:
-            os.chdir(cwd)
+        self.loop.run_until_complete(self.client.connect_unix(path))
+        self.loop.run_until_complete(self.client.connect())
 
     @property
     def max_chunk(self):
-- 
2.25.1


