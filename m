Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC84C52D7C
	for <webhook@archiver.kernel.org>; Tue, 13 Aug 2024 13:09:43 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.71625.1723554581842491130
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Aug 2024 06:09:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=JxeHS/bC;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.176, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d28023accso4339264b3a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Aug 2024 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1723554581; x=1724159381; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTual0PhcyAWFcPvwUyZN3yXN04TwriN/UV3cOdQiDE=;
        b=JxeHS/bC4E2zM7BGM8qDEucx96dYScdYrxvBSBSjMmaAblHzcWaTrARgt63Tohf7eC
         CHw+dRJXCQPEcJzMt9Q75WPney2ELgR3QVCPcvsL4RWrBDZ3z/k0D9gUkAaYHNUHTgQx
         2DuBbGoSY7hrcFqyMMw94uF5a60ude40zJdeHAqKQQZeNWao76JxIpTnObmBlAPqBJ4B
         Ayn8zEjuRUQuhB2dEpQBc3vbhavVy+4TI2FDwuTNm4TTDgn6JWgdMtHY+RTIcbev2hpC
         1l7Ea11WRTzULhSUD6uMMYqfNydz/k4eLgHmSqjD8cndF9J8/yh7DuaHHI4nQzpbTq7U
         h5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723554581; x=1724159381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTual0PhcyAWFcPvwUyZN3yXN04TwriN/UV3cOdQiDE=;
        b=KpxL1qJRH3McdHhsQqzk2QkA3oaybC/fQ0mx6dG9UjlCeq092RprxDGwUOgGM7Qw/1
         WF/xMc50yEaOwk79YCR3L3In2j+60lO+QlEMNa/S/id1kUSxOYRrCUxRwJA09aTQ+JRY
         9/VxxbXcBTGJY+OGOI06FAM4APlxYddlN51I/C7a7iRg7D0RVMdZnFRLa04Z/1t9ZGz5
         S7GmyXTVF1tqAmph9lfXuvBBZVDbnFQre3MM5d9bzIdDrtFjbXfM2T5u20N2kSol3t0p
         6MhvS0BXqwTCjvixygUQ9NrZ/DwD+arpU2JDh7mM19nYGnXbx9Eik8mEWUqYiAPor19a
         D3EA==
X-Gm-Message-State: AOJu0YwqDCbxHheOHsQ3veeioRkcgLvsqViEzJ8YTfclira9vLe/b6Av
	e7fyw61+Jg11uSYmwm9djAu45LaI0ISUHIYtIDphg63nrBgjwY8IvR8woU6NJ4Lxg/gQeS4g0X5
	qkQM=
X-Google-Smtp-Source: AGHT+IEcKzK20u2kRj1q6kCaEeKMl8IdUH/tHLDNW4Z3r/akUNT8QF7GlX1Hs7SyQJepGmWUUKwHfA==
X-Received: by 2002:a05:6a00:2349:b0:70d:1432:16d3 with SMTP id d2e1a72fcca58-712552165b3mr3949509b3a.20.1723554580985;
        Tue, 13 Aug 2024 06:09:40 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874d01sm5871606b3a.16.2024.08.13.06.09.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:09:40 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/1] data_smart: Improve performance for VariableHistory
Date: Tue, 13 Aug 2024 06:09:31 -0700
Message-Id: <ec2a99a077da9aa0e99e8b05e0c65dcbd45864b1.1723554034.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723554034.git.steve@sakoman.com>
References: <cover.1723554034.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Aug 2024 13:09:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16479

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
index dd20ca557..111377a75 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -261,12 +261,9 @@ class VariableHistory(object):
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
@@ -325,7 +322,8 @@ class VariableHistory(object):
                     flag = '[%s] ' % (event['flag'])
                 else:
                     flag = ''
-                o.write("#   %s %s:%s%s\n#     %s\"%s\"\n" % (event['op'], event['file'], event['line'], display_func, flag, re.sub('\n', '\n#     ', event['detail'])))
+                o.write("#   %s %s:%s%s\n#     %s\"%s\"\n" % \
+                    (event['op'], event['file'], event['line'], display_func, flag, re.sub('\n', '\n#     ', str(event['detail']))))
             if len(history) > 1:
                 o.write("# pre-expansion value:\n")
                 o.write('#   "%s"\n' % (commentVal))
@@ -379,7 +377,7 @@ class VariableHistory(object):
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


