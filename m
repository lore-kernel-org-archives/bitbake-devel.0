Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD9C46467
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 14:12:22 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.116242.1673705535927670395
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 14 Jan 2023 06:12:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=sb2MwGZ8;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.178, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f178.google.com with SMTP id jl4so26159526plb.8
        for <bitbake-devel@lists.openembedded.org>; Sat, 14 Jan 2023 06:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXQOa8K+OkeZKNnSlmjd027psc+TXgS/zlMRa8NoJ58=;
        b=sb2MwGZ8fXFugkd48HAbxTFJ9LtehDtm6vQIwACeNNTsNAtT0o949U4mKs6VRYnWml
         43ilAEqqOuzwZgVgDEj2T8nl8hERV/rEdoqMI8jhMYQBYY40lheBLnRb/H5/NE3CF8wq
         M+WZAimeU+OHAoquMeA0rJ9kfl5F7UPlCiwwNEOfhL/9/mdinMpp5SiiOsQ1pDkKDjiY
         83x/luYA7cZZxbDJQ3PUqU+2gQ4qtd/9miKeFWhOjW2CRF496MqMlguWttZuAF4Hy1Hb
         XyFhCngtJeRA3bqsI4rVtvvpTQYA0oId9BdcKelX/Qfc0f2RgT++wK4CebhnjKouc5/D
         /rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXQOa8K+OkeZKNnSlmjd027psc+TXgS/zlMRa8NoJ58=;
        b=zZda8Z7vnETwF6zSuDy4NsOfK2CSCFzYyv6lKTw7ph0zvCGCMKaRq6zTxHK+PZjB9r
         9xCnbMPIix/ppo6hMouHN1R/H3PixTH5JO/e7nYDxYUfizERBUorB+C5SXtyNvtCzvMz
         fwwzWlk580ymxFu1bwIMDzIEQfMsRx0u+LTcvBCAOTkcaeUcoNy6sCbKiOVhae+HgZLd
         N0m0DODTsSJ75nhEarRcE1BJJCMMJNhqA3RYHHZ5oHSlo7c/ZzkQtkqV99toR1CkaqEm
         2Xf9E9DqFPSTPwF6HWwcq+phnQm4+L7H5brWDyrM11UnHXk5PgyGwplajZ/9AlDCGRZn
         cn4Q==
X-Gm-Message-State: AFqh2krcFllRTh0twWYAeUsIPdByZt6NNStR2D48wbqIzb5qnBBTQP1O
	q8e0COZVVgPpWzQLXbxaI7k6KbBQsFIJ5PvANNc=
X-Google-Smtp-Source: AMrXdXuJRacNCgDdX+5QluQ/udKH+HokBE5cRb9D+1u9Q7i2Xlj/Wa1+O0BhfSGGOastPDyfXQ2m5w==
X-Received: by 2002:a05:6a20:a024:b0:b5:a7f7:5b3a with SMTP id p36-20020a056a20a02400b000b5a7f75b3amr33314350pzj.47.1673705534766;
        Sat, 14 Jan 2023 06:12:14 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-5-74.hawaiiantel.net. [72.253.5.74])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b004788780dd8esm12942463pgi.63.2023.01.14.06.12.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 06:12:14 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 2/2] server/process: Add bitbake.sock race handling
Date: Sat, 14 Jan 2023 04:12:02 -1000
Message-Id: <525a0208705de1a8dbd5dc65d911ab0a4fc99631.1673705296.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673705296.git.steve@sakoman.com>
References: <cover.1673705296.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 14 Jan 2023 14:12:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14315

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've seen cases where the bitbake.sock file appears to disappear but the
server continues to hold bitbake.lock. The most likely explaination is
that some previous build directory was moved out the way, a server there
kept running, eventually exited and removed the sock file from the wrong
directory.

To guard against this, save the inode information for the sock file and check
it before deleting the file. The new code isn't entirely race free but should
guard against what is a rare but annoying potential issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b02ebbffdae27e564450446bf84c4e98d094ee4a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 2a9fb662..3668a32b 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -28,6 +28,7 @@ import datetime
 import pickle
 import traceback
 import gc
+import stat
 import bb.server.xmlrpcserver
 from bb import daemonize
 from multiprocessing import queues
@@ -64,6 +65,9 @@ class ProcessServer():
         self.bitbake_lock_name = lockname
         self.sock = sock
         self.sockname = sockname
+        # It is possible the directory may be renamed. Cache the inode of the socket file
+        # so we can tell if things changed.
+        self.sockinode = os.stat(self.sockname)[stat.ST_INO]
 
         self.server_timeout = server_timeout
         self.timeout = self.server_timeout
@@ -246,8 +250,14 @@ class ProcessServer():
 
         serverlog("Exiting")
         # Remove the socket file so we don't get any more connections to avoid races
+        # The build directory could have been renamed so if the file isn't the one we created
+        # we shouldn't delete it.
         try:
-            os.unlink(self.sockname)
+            sockinode = os.stat(self.sockname)[stat.ST_INO]
+            if sockinode == self.sockinode:
+                os.unlink(self.sockname)
+            else:
+                serverlog("bitbake.sock inode mismatch (%s vs %s), not deleting." % (sockinode, self.sockinode))
         except Exception as err:
             serverlog("Removing socket file '%s' failed (%s)" % (self.sockname, err))
         self.sock.close()
-- 
2.25.1


