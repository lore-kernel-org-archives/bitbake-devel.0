Return-Path: <zboszor@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB0BCCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 07:14:14 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3959.1762326850352672990
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Nov 2025 23:14:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IHV1t7IS;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: zboszor@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4aed12cea3so1131202066b.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 23:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762326848; x=1762931648; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5oNMmiKZVNa74+XuMaPhw04lPY7bVXVgvSSV3PlTpI=;
        b=IHV1t7ISJJcJJOGQWTtlfgo6Si2tSI4IACsu9qS6ADtFthmL4tJfR+DsKaOMnn3tlP
         UItVwUxWU9cK63klIT+a9PREmPJ+jVzh2365fJttLxw7lQlp8im7LbdQsuBxs1QAl1E6
         f9cmA9vbvGbVTLIGvbf2A1EA+12ZSftvSH2399mlUNrsDbiK7bqJA5Qx1WBbrlBYqLnJ
         wRpKzP3mBqP3QqGmXReq/EyDLpagRGmXY/5s1SZDWxJuEp8xLxShTcy+B35e9L6KcMD5
         CBZhTW113SCIvK4ky7wDxFO3/7GqJiypDOZ+Wb5imWywocxh0elsmneSF4NTDNqeH0FZ
         bCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762326848; x=1762931648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5oNMmiKZVNa74+XuMaPhw04lPY7bVXVgvSSV3PlTpI=;
        b=eQuf5J3NC5KZi/U0+Uq1iNlRnfsxGdIZ0sgQVDrVZkN9Uyp6jvcpaAxuRhC4cbH0tW
         0K0M5oFor6Ja/nyxmqQuhiL6IkBbvIdEOPNZmYc+Drv+Vi/NcH3JptESsUEyhad929Dx
         wwWING8bikzjmNhWSL5Hl2WWiJFoTdXe/+Htg3lgbxSbLg+fe2WQ083OUhPQYV9kNgK9
         /93LOpR6Wx6T219b9MWAR+q7JQkiNGoyWydGwVZN/7BQpuf9UJTzonYe23hI+UE1YxVa
         LVtL7Af86FUd9yI/b9V+ftL2n9cw7q9eB49fR/xZm2P+sv91BjEBJ5doJvH8sOfD2DR7
         qs6w==
X-Gm-Message-State: AOJu0YxplyXEU8XkJEJolzr/ZlUayKa5RRmyYPKC8QvNoPjHVhZo2blk
	QEscbii+Dni4NIplcGMUU+FGonnHdBkzvYlRhp+17CbiGimZAEvYXMmuBBZPoA==
X-Gm-Gg: ASbGnctDCsf/aJqpEEf8k2qL/THgaCDoXEZusk9CqvxuUfVqfsAf6hPSMin2An9d07D
	ME9sM0CH+j+3nazHxXdiwAOmGRgCuxcj+c9hWGbK0GI59ae/IcMfSrrkD7begpSiuqtTIMAIbGq
	2cqFfE1YjIXm/fEP0t0AsZtfBACBn5GOaAiEjjE8p8fNLA9XhKPAYR5IPQz8gNOSF6dDvVhirFy
	XNNJR97WmsQTDDw0hJGwba1uhASitx/nFTC7fr2aY1DrDp9RKf3G2zsKeLtt1LBiGthp0kbcZsH
	0EAFAvu1CaGth37Ga0lcYuh0PZjb9KABzok+4G6quE36pbwxac8CKEBoCuHszqlfLG8xqDei0oJ
	NZpXQvDnTiVb9jqVQRzxIPVgWYWvhepc+eLxjF6Oqhs25nzgObthVe1RmBA+2+zspYXEPed1Kiw
	BIDgbATdWzDLGjV+lAkuVBKA==
X-Google-Smtp-Source: AGHT+IEkkI6N9Igo0kIfLOwCO32bzUzFbXt+usxDH48+4yRI8nMZAKZ8PY3jIZDXp4MMz3QyLYtrqA==
X-Received: by 2002:a17:906:794c:b0:aff:c306:de51 with SMTP id a640c23a62f3a-b72651558famr207515266b.4.1762326848130;
        Tue, 04 Nov 2025 23:14:08 -0800 (PST)
Received: from fedora (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e06edsm432315466b.47.2025.11.04.23.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:14:07 -0800 (PST)
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>
Subject: [PATCH] knotty: Cast two variables to int in integer expressions
Date: Wed,  5 Nov 2025 08:14:05 +0100
Message-ID: <20251105071405.636900-1-zboszor@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 07:14:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18255

Python 3.14 complain about these:

Traceback (most recent call last):
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 722, in main
    termfilter.updateFooter()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 339, in updateFooter
    lines = self.getlines(content)
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 370, in getlines
    lines = lines + 1 + int(len(line) / (self.columns + 1))
                                         ~~~~~~~~~~~~~^~~
TypeError: can only concatenate str (not "int") to str

and

Traceback (most recent call last):
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 722, in main
    termfilter.updateFooter()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 341, in updateFooter
    for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
                                           ~~~~~~~~~~^~~
TypeError: unsupported operand type(s) for -: 'str' and 'int'

Cast self.rows and self.columns to int.

Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
---
 lib/bb/ui/knotty.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 00258c80f..f04607df8 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -338,7 +338,7 @@ class TerminalFilter(object):
             print('', file=self._footer_buf)
         lines = self.getlines(content)
         if not self.quiet:
-            for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
+            for tasknum, task in enumerate(tasks[:(int(self.rows) - 1 - lines)]):
                 if isinstance(task, tuple):
                     pbar, msg, progress, rate, start_time = task
                     if not pbar.start_time:
@@ -367,7 +367,7 @@ class TerminalFilter(object):
     def getlines(self, content):
         lines = 0
         for line in content.split("\n"):
-            lines = lines + 1 + int(len(line) / (self.columns + 1))
+            lines = lines + 1 + int(len(line) / (int(self.columns) + 1))
         return lines
 
     def finish(self):
-- 
2.51.1


