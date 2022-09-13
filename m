Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CAAC6FA89
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:10 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web08.5355.1663079222046425186
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=cxe+85es;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.179,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f179.google.com with SMTP id t65so11494855pgt.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=j+u4sAjOX9PEBqwDBHmdM5EDZd8BjQNL8LsN/zLAZxM=;
        b=cxe+85esF7KKAioCdgZKhWMDS0iarakC8/3XT0RmH8LDDu3sJMbv/LOzae4QxXx0BY
         M+FnA0MhA492hQlyYHndp7/dKPvmalQv/+5NXqQwBxXT7unYPxTEtOWsny8IkOg/KEjE
         Vyi5W77BG+WqeeZuh1cBu+EQNJnTZngjsf+178/KUc1vpDlqM9NOB9BhAYsNLplXke+Y
         SruiAedQZQoIXKR0wq4Bob/CdyiuaUhgVnNGlpH21hOEkUctKUQGYzExZKrwCXo69Seh
         MjtJEHwdkjyZE3kwsiE2bXLMkJ4Y1tNkl9bUOg+m4tnqcLHwGrhRTLhzGTAX3w2t1qR4
         UPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=j+u4sAjOX9PEBqwDBHmdM5EDZd8BjQNL8LsN/zLAZxM=;
        b=Yr+1y20oBdqc6JVE7JcQZ7oxi78ZhbrK6pqQOsSXrhSsXwKYHf0q+LLTEhhYDinn2g
         79Dt0zJowK3cnnOzQkO1T2xUDhWuDkhswgFvTLI+aHDSN1bUxWu1AWXofpT4zwsGlHBH
         kc/XqZNdiRDnR9ICfqOrjfJsySQ9Sp12dx/E9ig2zJ+b9khUJnxzWqmSOoo3maWqq+ni
         6NCvVCt0vadBTxmLKZ7mipnIISGdhH/ITer0fKlx5aVT2LgS/mVMxTeaZtXZqWgWpG//
         r0JJyHB9fPkyvX8dYdy2L+awT8KRVDlpRqmhyQR0dkenb8MfaiI1pfAjIYYNquVjseUT
         302A==
X-Gm-Message-State: ACgBeo01Wgki/ol/tw0uGUuyzEmRpLko3kA2R0Zx5ujDGkZllFJi6JsK
	3guwkcGjtDeggH8sXsw/8ZAzdgvqNpdAcOrl
X-Google-Smtp-Source: 
 AA6agR7iKsp/ZhgZBhl2MLHkX1TlLrvwypZZdRrQ5wp2CsXmxnnG30mmDqaXtcsA3wcB0CKZt/pBvQ==
X-Received: by 2002:a63:d94a:0:b0:412:6986:326e with SMTP id
 e10-20020a63d94a000000b004126986326emr28465498pgj.56.1663079221018;
        Tue, 13 Sep 2022 07:27:01 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.26.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:00 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 01/14] runqueue: Fix unihash cache
 mismatch issues
Date: Tue, 13 Sep 2022 04:26:31 -1000
Message-Id: 
 <e348cf75da604b299d04a4d4f86a28428feabb55.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13962

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Very occasionally we see errors in eSDK testing on the autobuilder where the task
hashes in the eSDK don't match what was just built. I was able to inspect one of
these build directories and noticed that the bb_unihashes.dat file in the eSDK
was zero sized. Whilst inspecting the code to understand the cause, I noticed that
updated hashes are not saved out in subsequent updates of the values in the rehash
process.

Add a missing sync call to ensure this happens.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7912dabbcf444a3c3d971cca4a944a8b931e301b)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7eea72e6..111dc0ee 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2381,6 +2381,9 @@ class RunQueueExecute:
                     self.rqdata.runtaskentries[hashtid].unihash = unihash
                     bb.parse.siggen.set_unihash(hashtid, unihash)
                     toprocess.add(hashtid)
+                if torehash:
+                    # Need to save after set_unihash above
+                    bb.parse.siggen.save_unitaskhashes()
 
         # Work out all tasks which depend upon these
         total = set()
-- 
2.25.1


