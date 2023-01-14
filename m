Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9921C3DA78
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 14:12:22 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.116241.1673705533562232378
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 14 Jan 2023 06:12:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=47ibodbV;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso3511780pjb.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 14 Jan 2023 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xM7xP9jmhf/UABeJSme/QKaYbf6uiGk0pK0iFqpMNa8=;
        b=47ibodbVC6BW3CuDNuZBb9fUkSjFsAjzBE52+R9apBq8JHs8pFusXKsGoLGrUf/UnS
         tUQKCt1B/2WfMtf5kHnfDNDuGUZUqI9vzRD0Pj0KqUecXTPtt3ysVdeY9FeQtcR9GJzk
         uMjAhWCG134H3ra42hFZjdVTcNPgLzPqL75EkB/3dPw54MqiOJnFf+Bj1VKlZEgh4Wvm
         4mrOWi1/MTpHy4toJPu2CqcyPCJ7DvLCrSc0syQwhHgiMgk/pp4xAuF8MtmAp6cQcPRi
         DI7dVrMus0qF5l8C4DgMzsj6R8n5WiqHvYrAlux1dkedUWtcaihYmjCOLVXxwgNwgDrp
         +g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM7xP9jmhf/UABeJSme/QKaYbf6uiGk0pK0iFqpMNa8=;
        b=3/EdFpPWBiHstqebm6WrCg0zLBrkVock4j6eX9feaVGAmbu25Yt6eOfJN91XsEu9L/
         ElYuGOGyngXPXx94llNz/OmPrgPIFCwoMF4r2mZZNTtZPs1/hwCzFU0hRgb3qWlahKnB
         prtPSlsd4AXncia+EZyhNr9roP6iDvVVxx6bO/MrkUg3tj2n3v/iPvYnRjs2cP8YAyH1
         Sae88qjv/SrznjE49DwXjXZSvxjftRuWLyT35AYW4qTAUG6D0jH7LtXzWxhFaT4BBek5
         0zsyRAYoBoa674pnzWmq2QUSkgXox+rvLPF83WqPOmI620kx2xwTNQNDZJL5x0S4S7g5
         bMSQ==
X-Gm-Message-State: AFqh2kq3ySgDlfqRHcwZxZkac468u/MqP4zlPnSP2iuc9RcIarcypFfs
	2Lowa9wnwMnckv0knzYxbDuwENnEyQ7+OnHQnbU=
X-Google-Smtp-Source: AMrXdXsTbrA9O27IxpW232XqR5TXxTmRJBS3qwAuvG22qFfANOAtYdWcD/8kaRMC6eCHnSDgWA5YOA==
X-Received: by 2002:a05:6a20:a024:b0:b5:a7f7:5b3a with SMTP id p36-20020a056a20a02400b000b5a7f75b3amr33314222pzj.47.1673705532561;
        Sat, 14 Jan 2023 06:12:12 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-5-74.hawaiiantel.net. [72.253.5.74])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b004788780dd8esm12942463pgi.63.2023.01.14.06.12.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 06:12:12 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 1/2] process: log odd unlink events with bitbake.sock
Date: Sat, 14 Jan 2023 04:12:01 -1000
Message-Id: <ec6fd61498b017c353a1a01afcb4b897ca4a2f95.1673705296.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673705296.git.steve@sakoman.com>
References: <cover.1673705296.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 14 Jan 2023 14:12:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14314

From: Frank de Brabander <debrabander@gmail.com>

Log when the socket file already exists and is removed before
recreating a new socket.

Log when unlinking the socket file failed.

Signed-off-by: Frank de Brabander <debrabander@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit cfd7c9899f988bab6d9fe7bbfbdb60603fb5ed34)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 5d02c0b9..2a9fb662 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -248,8 +248,8 @@ class ProcessServer():
         # Remove the socket file so we don't get any more connections to avoid races
         try:
             os.unlink(self.sockname)
-        except:
-            pass
+        except Exception as err:
+            serverlog("Removing socket file '%s' failed (%s)" % (self.sockname, err))
         self.sock.close()
 
         try:
@@ -532,6 +532,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
 
         # Create server control socket
         if os.path.exists(sockname):
+            serverlog("WARNING: removing existing socket file '%s'" % sockname)
             os.unlink(sockname)
 
         sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
-- 
2.25.1


