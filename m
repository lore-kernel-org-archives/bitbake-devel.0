Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38194C6FA8D
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:10 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.5454.1663079228309533411
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=wcH1r7QM;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.169,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f169.google.com with SMTP id iw17so12035898plb.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=wTqbrbFqKaVkZDTJExhPxjsa4511DYnC8E/9s7JLyx0=;
        b=wcH1r7QMmwIKWRPAHnb7Ah2Pzypj91HsJbpiJXIb/0WedSQ4AGX2+A/M75QpzXoBJO
         7jtBmgsTWa49O22RfoRV+qCYclG66+Ey4T6AOLlA1NN4uYodyHydv+I7NSuDqofuDh1U
         +Q6WKGrKHl3jmnz0YdzYkORetFDTTsKFTzcYc19dQWANx34HkeHz5w6fD51ZBIsA7ZzK
         bKO/6gYIJZKQFOm9EnbThprVupbLj/C3gLbTn5LVt9VpG/KsRVykwhyz3C0IMoz0tOp2
         5t54u3eOxb/y3klodWPpcsBlEx3Lafx79YxL6pI2T5704BgbuZxtsaBhWPPDRYpvFYvE
         CuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wTqbrbFqKaVkZDTJExhPxjsa4511DYnC8E/9s7JLyx0=;
        b=R0hzvNuPiH55lFnWyNzEV7n6ry4EzUYQKUxUF8PmIHcHJJ5kRScgCFC12B3fUtPHaN
         jrZt2GfVRagtWfXqt5P19+9QaT34tJJGIlnnz7Pf0rja/JZTLnMPWuYz7OZscJgb0QqC
         lU8FTkyvV75mSQtj0cnjOJW7Ltv2U6jEzu30mNeNJq1dOKw49XvU++ZxVXZKLbhklRzp
         HoGzAiweZ0+3CN2tc/bdn6AKITdLtP99RXLfIiJqmzV/cwNl4kOt8PUxlfhRngufvPOV
         K2aAgjsXL1ERwYPuwFFWdZfnH6VZVQi1zSZowBb6E6mENZa/ZWAxHjIJZtdy3VZPBJxs
         NlPA==
X-Gm-Message-State: ACgBeo3bHj0yVHlzvhVX3ACewbLJaxrGuUEyJXS6SJNvgBH2NIhrTg8E
	Txcbvr5MoTXjdN+hLeGvcHKYBzvMApaDON0n
X-Google-Smtp-Source: 
 AA6agR6/iteuwJercBAHpHDikjbAo+wcoEyD42Uhq4m6expMMiKH03rVIYENGJPl+LqxaNX6G97ygw==
X-Received: by 2002:a17:90b:1c8e:b0:1f7:5250:7b44 with SMTP id
 oo14-20020a17090b1c8e00b001f752507b44mr4306354pjb.212.1663079227289;
        Tue, 13 Sep 2022 07:27:07 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:06 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 03/14] event.py: ignore exceptions
 from stdout and sterr operations in atexit
Date: Tue, 13 Sep 2022 04:26:33 -1000
Message-Id: 
 <0cfb6c219333b6ad8a9a21185c6c506209c3cce8.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13964

From: Mikko Rapeli <mikko.rapeli@bmw.de>

When atexit functions run, stdout and stderr operations may fail, e.g.
when output is piped to less but has been exited by the user.
This removes error print from output of "bitbake -e sqlite3 | less"
if user presses "q" before bitbake has finished processing:

[Errno 32] Broken pipeError in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/home/builder/src/poky/bitbake/lib/bb/event.py", line 135, in print_ui_queue
    sys.stdout.flush()

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 35167536c163eb6b7653cbcaad9f65b834d3e2f8)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/event.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index df020551..97668601 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -132,8 +132,14 @@ def print_ui_queue():
     if not _uiready:
         from bb.msg import BBLogFormatter
         # Flush any existing buffered content
-        sys.stdout.flush()
-        sys.stderr.flush()
+        try:
+            sys.stdout.flush()
+        except:
+            pass
+        try:
+            sys.stderr.flush()
+        except:
+            pass
         stdout = logging.StreamHandler(sys.stdout)
         stderr = logging.StreamHandler(sys.stderr)
         formatter = BBLogFormatter("%(levelname)s: %(message)s")
-- 
2.25.1


