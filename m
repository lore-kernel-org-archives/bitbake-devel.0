Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF01BC3DA4A
	for <webhook@archiver.kernel.org>; Wed, 14 Aug 2024 12:06:10 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.96385.1723637169927592238
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Aug 2024 05:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=0+N8AJf/;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.176, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo2469194a12.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Aug 2024 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1723637169; x=1724241969; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzkiZbcyH0JgWrH2cAXtpaAI+O8EPObFZDrFA6NI4Dw=;
        b=0+N8AJf/v++DJTnByUGcwuygWzpXtsPYth78os4AjJS6I0jfxCiHzTvUZjQ1c9CMS7
         C6xB3R3uwoKMhL+p1h2mPe4hVE1Utzb8zJemlGwUZ9heYIJRnkKqkYdBYUPT5f/hIgjf
         87DwlfS74D/mC/QEjJONi53WFSB5JSLjTOAxc+Xq6RUtz7facQH9cR5LFYR93vZMkvB8
         vT/OtAZ5rBYk0+x1UNNxcHffOcH0FJz4rixhuJT2ioXJpk7iCwQkqU0awpDv38PC/X0u
         DgWQZXk/fhnI7oGXrOFb3mZSEnDd5e0+e7kxgFQJmKKk/ri+LYrlWj4wbNUyv6YPTQz3
         WKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637169; x=1724241969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzkiZbcyH0JgWrH2cAXtpaAI+O8EPObFZDrFA6NI4Dw=;
        b=DJOagI5RfrrKDrSjQabnHcBQd081ehJCjDqr28+6vVGDUIs7zTFHonYVJF2qolEUDq
         13pFxGW+Zff4Goq7CXJ88R9nqOu6B874OHy2RTsHEGNySiL1Z0du+gjPwYWJ7CODPj8f
         Go2/SkhuWXEnUgZGJiMrIgzrn0IiaQ6xbK4feUwZj6Imkbr7WQa1iXNk04LQ9pIXTZdu
         gXp8+1gbQ4dvyPDc+GNcByak7CVfdQkqSSPUyO9zbqhbT0afaJckWFy0dV8IwD5lUa64
         Z66/81jPcFzwh1ylVGCPmHTBLJXkzWEP3yOcSlqpw9uv7PRdt+pOBdHZvk916+AYus19
         J6ow==
X-Gm-Message-State: AOJu0YzM6FyDQ0IwoHtfA3mA7q6o+hVZXTAbqvAz0IKqgDbXzALvVfTf
	jinkohq0QmWC9MKvYOqtEcAmduqBAcYbte/0cC/hNhSSHH//YoiBYTcN5CXObBfhpuVq9vXqyEQ
	OBtY=
X-Google-Smtp-Source: AGHT+IH2BbOZ5AIWuCU0JFQCUsTVs/t3/j1nV4RlDB3HX30YifwDiTgoVqepbJkKPkFNEbeMvMAv8A==
X-Received: by 2002:a17:90b:17d1:b0:2cb:5112:740 with SMTP id 98e67ed59e1d1-2d3aab74f59mr2764191a91.26.1723637169032;
        Wed, 14 Aug 2024 05:06:09 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7cf227sm1548930a91.3.2024.08.14.05.06.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:06:08 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/1] data_smart: Improve performance for VariableHistory
Date: Wed, 14 Aug 2024 05:05:51 -0700
Message-Id: <d251668d9a7a8dd25bd8767efb30d6d9ff8b1ad3.1723637014.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723637014.git.steve@sakoman.com>
References: <cover.1723637014.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Aug 2024 12:06:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16482

From: Robert Yang <liezhi.yang@windriver.com>

Fixed:
- BBMULTICONFIG = "qemux86-64 qemuarm64" and more than 70 layers in BBLAYERS
$ bitbake -p -P
Check profile.log.processed, the record() cost more than 20 seconds, it is less
than 1 second when multiconfig is not enabled, and there would be the following
error when more muticonfigs are enabled:

Timeout while waiting for a reply from the bitbake server

Don't change the type of loginfo['detail'] or re-assign it can make record()
back to less than 1 second, this won't affect COW since loginfo is a mutable
type.

The time mainly affected by two factors:
1) The number of enabled layers, nearly 1 second added per layer when the
   number is larger than 50.

2) The global var such as USER_CLASSES, about 1 ~ 2 seconds added per layer
   when the layers number is larger than 50.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0596aa0d5b0e4ed3db11b5bd560f1d3439963a41)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/data_smart.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 0128a5bb1..c6049d578 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -272,12 +272,9 @@ class VariableHistory(object):
             return
         if 'op' not in loginfo or not loginfo['op']:
             loginfo['op'] = 'set'
-        if 'detail' in loginfo:
-            loginfo['detail'] = str(loginfo['detail'])
         if 'variable' not in loginfo or 'file' not in loginfo:
             raise ValueError("record() missing variable or file.")
         var = loginfo['variable']
-
         if var not in self.variables:
             self.variables[var] = []
         if not isinstance(self.variables[var], list):
@@ -336,7 +333,8 @@ class VariableHistory(object):
                     flag = '[%s] ' % (event['flag'])
                 else:
                     flag = ''
-                o.write("#   %s %s:%s%s\n#     %s\"%s\"\n" % (event['op'], event['file'], event['line'], display_func, flag, re.sub('\n', '\n#     ', event['detail'])))
+                o.write("#   %s %s:%s%s\n#     %s\"%s\"\n" % \
+                    (event['op'], event['file'], event['line'], display_func, flag, re.sub('\n', '\n#     ', str(event['detail']))))
             if len(history) > 1:
                 o.write("# pre-expansion value:\n")
                 o.write('#   "%s"\n' % (commentVal))
@@ -390,7 +388,7 @@ class VariableHistory(object):
             if isset and event['op'] == 'set?':
                 continue
             isset = True
-            items = d.expand(event['detail']).split()
+            items = d.expand(str(event['detail'])).split()
             for item in items:
                 # This is a little crude but is belt-and-braces to avoid us
                 # having to handle every possible operation type specifically
-- 
2.34.1


