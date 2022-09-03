Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BBCECAAD4
	for <webhook@archiver.kernel.org>; Sat,  3 Sep 2022 11:59:08 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.2430.1662206347194176000
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Sep 2022 04:59:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iQZfK9OS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id e13so5367742wrm.1
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Sep 2022 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=hIajl9MVlwk3PFQlyM5RdmopzOId8d9ydWdNkMf7jEo=;
        b=iQZfK9OSPUpYICm4lc3Uir6z2JExT/MKW3IqqfOc9bZiZ/RWwM95nB/lFXfCelQf64
         4AcsE2sy15/bc7fo64xgV/UbxNOAY2VDwc0DBd+DTEtQ84Rcqanb1XuaIcLVjteZjANG
         8izuczmdgXN3iFtF369VK1FYhTAgie82PCITo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hIajl9MVlwk3PFQlyM5RdmopzOId8d9ydWdNkMf7jEo=;
        b=POr/gLHGyzb+9k7caINbF8lDy0EPfk2HaWl4Wlind4wScvj69ZXU7L/SwMhLPQ8z1K
         hQ7TbK93AenCk0idBXoQG61lPIm3Cayp136PKPCCReqcfxz4h4avdK4rxfZ+wujgIHzG
         xB2Wm9/a4+7uNzxjYvKWscmoR9az2VgGUkSe+CvTO8AbDkuNHb4kSzOScPGvL3Il7un2
         R/W3OXDBZeT17y5sR5+6x1UWVn7PEKBu0DIHS46s3iBBBC92rf+7PXw7xveR03Z8QZCe
         IeBt/VkC9Czs4UzpHeyNXFfX6dwdohmZCTJgBEvBMiN8EcTmech2TX1HQwCj4aGDAL97
         IHTg==
X-Gm-Message-State: ACgBeo1VWURMiasyUh8gy1QfedyX4NlEpw16hso/KbXpxbacHiuyC799
	gzmmoQbbrC5TQ792Hqd+sqZUBlrbDq4s8A==
X-Google-Smtp-Source: 
 AA6agR4W+nVsXKuQFZN5MVRBVqnTykbCSaOsz5uV10GvDhcG5QH6SErdlbSCpNRM11UVBlOh8GbrIg==
X-Received: by 2002:adf:eb02:0:b0:225:2b94:d14c with SMTP id
 s2-20020adfeb02000000b002252b94d14cmr20493916wrn.291.1662206344943;
        Sat, 03 Sep 2022 04:59:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b434:62b3:32b4:c2b0])
        by smtp.gmail.com with ESMTPSA id
 s8-20020a1cf208000000b003a83fda1dc5sm4844753wmc.44.2022.09.03.04.59.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 04:59:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] asyncrpc/client: Fix unix domain socket chdir race issues
Date: Sat,  3 Sep 2022 12:59:01 +0100
Message-Id: <20220903115901.377912-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220903115901.377912-1-richard.purdie@linuxfoundation.org>
References: <20220903115901.377912-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 03 Sep 2022 11:59:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13956

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
---
 lib/bb/asyncrpc/client.py | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 881434d2e9..fa042bbe87 100644
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
2.34.1


