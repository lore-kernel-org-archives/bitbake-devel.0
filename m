Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7572CF11FA
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 15:00:10 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.45682.1728572404453068608
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Oct 2024 08:00:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PxhOzKj9;
 spf=pass (domain: gmail.com, ip: 209.85.166.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a367da1f8cso3900635ab.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 10 Oct 2024 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728572403; x=1729177203; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnVFd5Fy1Ww/23vvdrQogeR2Y829BoikxGIzO22Bxn0=;
        b=PxhOzKj9jWBLfYtM/sm8arVyeCKVUeW8PJNrmpaN8NDfyUhOCEi0ESrffdquGnCu2K
         Nw1OJpijupCtaZ0mQPr3fJsEAVoIDmBwPn5yifwuVix+Q8Al2wnAOI7zd5eBmj22jDXi
         asslaclVq4jEIzDQ7KvadnVULUFMZ6gFGK1wTA9/BWrnvNIukc3ox+KXDHfskILEhfJM
         7fXZL184tH0MLMRo78fS+aaTau6JllVBY/8eMyk2oiQK5fvIy8zdZzQUqANpE7owHwQ4
         nLTa0YOMjqyApnlhh9rGNfwBjaA0dd9w8sRQs95G3Z+ePcXPcBVJzX2arHF4aAIJ9/EU
         DwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728572403; x=1729177203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnVFd5Fy1Ww/23vvdrQogeR2Y829BoikxGIzO22Bxn0=;
        b=e/GiBPseafGx8XXK/0QtQPHYgZOTg5Dii18iXirSrqkyvZBt1vSF5UTAsnSAAvfEnV
         4WOxF7p0kcZZs/rOdvbeKdF2CU6+fAApAGeOiEG0sU7+894WcFyIgnZIpyvLyTOTFATA
         WUaf5doYggAuHeziBmiD9z19OhWZzKGmvZLhLMEQRucewb4MBNg9OzQOOMEZ9bPWKU2r
         GrmJvy7jL2pc7UDTSY02KidjG1opjhpWIV2U8biW4v5KNXCCQbrO2I4NRg3pmulR3D54
         2OK4VdAYy2+7MfQVzAeIuv+8PSJThXqmgwaDQbVh1QJxmGEZl3aG65bcd77oRMrKaxvd
         NTyw==
X-Gm-Message-State: AOJu0Yy7VJnxb8uae9UBIrb5eNeC/sovHZsgK3CZlQRZ0eauDRBm2E4K
	sue45WI0vEpHV4YD7LobgscHuKv3qEpku3JkjChaTb26UBGGYHR/WSZczg==
X-Google-Smtp-Source: AGHT+IGYtbTYlfsnDVWFPkuR5WsxdnocWn30UWqm3hjTsdupD0ZfIzEpCkqecUJdaXd17NY1okkmIw==
X-Received: by 2002:a05:6e02:148e:b0:3a0:7687:8c2d with SMTP id e9e14a558f8ab-3a397d1d1b8mr52544355ab.26.1728572402931;
        Thu, 10 Oct 2024 08:00:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::15f6])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afde8d0csm3043935ab.74.2024.10.10.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:00:01 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][2.0][PATCH] hashserv: tests: Omit client in slow server start test
Date: Thu, 10 Oct 2024 08:59:55 -0600
Message-ID: <20241010145955.1220836-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Oct 2024 15:00:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16667

On Fedora 39 and Fedora 40 hosts, this version of the hash server
exhibits different behavior on exit when using Unix Domain sockets.
Instead of closing the client connections and exiting immediately, the
server will wait until all clients have disconnected before exiting. It
is unknown why this changed, or why it only affects Unix Domain sockets
and not TCP sockets.

Because of this behavior change, the Slow Server Start test is failing
on these hosts. This test is primarily concerned with ensuring that the
server will actually exit, even if it gets a termination signal before
it enters its main loop, and doesn't really care about clients. As such,
modify the test so that a client is not pre-connected to the server.
This allows the server to actually exit so that the test can verify the
signal behavior.

The latest version of the hash equivalence server (on master) does not
exhibit this behavior. Speculation is that the more standardized usage
of asyncio allows the server to properly exit, even if clients are still
connected. Regardless, this patch is only intended for the older
versions, and should not be applied to master

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/tests.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index f6b85aed85a..07e1c30a338 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -30,7 +30,7 @@ class HashEquivalenceTestSetup(object):
 
     server_index = 0
 
-    def start_server(self, dbpath=None, upstream=None, read_only=False, prefunc=server_prefunc):
+    def start_server(self, dbpath=None, upstream=None, read_only=False, prefunc=server_prefunc, need_client=True):
         self.server_index += 1
         if dbpath is None:
             dbpath = os.path.join(self.temp_dir.name, "db%d.sqlite" % self.server_index)
@@ -54,8 +54,11 @@ class HashEquivalenceTestSetup(object):
         def cleanup_client(client):
             client.close()
 
-        client = create_client(server.address)
-        self.addCleanup(cleanup_client, client)
+        if need_client:
+            client = create_client(server.address)
+            self.addCleanup(cleanup_client, client)
+        else:
+            client = None
 
         return (client, server)
 
@@ -341,7 +344,7 @@ class HashEquivalenceCommonTests(object):
         old_signal = signal.signal(signal.SIGTERM, do_nothing)
         self.addCleanup(signal.signal, signal.SIGTERM, old_signal)
 
-        _, server = self.start_server(prefunc=prefunc)
+        _, server = self.start_server(prefunc=prefunc, need_client=False)
         server.process.terminate()
         time.sleep(30)
         event.set()
-- 
2.47.0


