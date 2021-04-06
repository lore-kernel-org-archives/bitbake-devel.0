Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web12.13173.1617720224282430885
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Apr 2021 07:43:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=NFVsADpx;
 spf=softfail (domain: sakoman.com, ip: 209.85.166.49, mailfrom: steve@sakoman.com)
Received: by mail-io1-f49.google.com with SMTP id k25so8901669iob.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Apr 2021 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XIcQHoVQMg4B0zX1DHIOLHqwHA+wxA8TyX3CBLbEW1I=;
        b=NFVsADpxdNzVtFO4bAYLJTsgVU+rn9aAbwo088Xy6ddGwi7r28ElZBDcLdbs2FGx+V
         a7/8XZZ0xwZG7Its7xZJ+2zZCgNmfWw6wXwnNtauJqPmSv7ef96/o9B8/v7IQ3EpBnr+
         /poJqhsjdgQN7DaWP13NhKEohjBE+fWY0y/ga2zlreiSoLvxPOYXaFSU3ZNezZsRQeNP
         qqDppaF1/VfdlFaKP6owYZ5y/TUqW68MkHoEi85yNRV0pVEAg9dneku0xIkM88BzHJQE
         3H7XJKyBkQCa6SjvWxA47JJy0WDy/sHkuWxMX/b73Tft6lu7jEmKYo5jNzGpEkrdvz2S
         YTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIcQHoVQMg4B0zX1DHIOLHqwHA+wxA8TyX3CBLbEW1I=;
        b=PeO0y/rFjgArcX+1N/0zOGw7LFcAtGVNzkwFKNEbX7bck3R41lxVZiGC+9K2nE5613
         BTP6GkIcrwy6mOcgHyT08bJAniGY8orF8Ir4jN++F748yCLpqL5lhyNDDQotKcJtTWOi
         2NCyAvWoa7n5E5s2XWrEiNOJru0PYLqGH+4EVqiX7tu4CgceNz1WYLLkEOessPU7KezV
         nVmBwgwIB1ncB0KelqMXCDNjJCNjHUXrQ861rwTtSYJ6zUYpP8YHhV/JU70N83ZBdY7K
         czTqRP8SuZJgRRgauOWwyguieMXm9218CIx+jCL7yu8AQVmS9JqV6RK9vY7B+EP4+eoq
         0w/g==
X-Gm-Message-State: AOAM531t9veO2uBJjciTvGECCUrNZBTQAtaxi8lTF4XcAfxMRS1uz2XF
	13D7h3gAJpEXdh06ZyelXX3267tvhKGfNFzfxTQ=
X-Google-Smtp-Source: ABdhPJzlclQVFQveqJ+CVCeTG9rHGD7MfbB6l2GHp4T0A02BxF+7rX6GOqxnzQU8trqX7ygLx1aGFA==
X-Received: by 2002:a6b:b7cd:: with SMTP id h196mr23639800iof.59.1617720223234;
        Tue, 06 Apr 2021 07:43:43 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id g11sm6195059ilj.84.2021.04.06.07.43.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:43:42 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/1] Force parser shutdown after catching an exception
Date: Tue,  6 Apr 2021 04:43:02 -1000
Message-Id: <eb77f8bc133ffb3a46f6832181c48fcbb35e80e2.1617720075.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1617720075.git.steve@sakoman.com>
References: <cover.1617720075.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Brzezanski <jan.brzezanski@gmail.com>

Commit bebef58b21bdff7a3ee1fa2449b7df19144f26fd introduced forcing
parser shutdown as default in case of build abort.

In this case bitbake sometimes hangs after facing error during parsing,
waiting for child processes to finish. Killing it then will spawn zombie
processes.

Thus we force the shutdown after catching an exception.

Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 915330e1dbae1ee8fd9a0358decf2c294f771961)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d90bd394..11cc2b95 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2126,18 +2126,18 @@ class CookerParser(object):
         except bb.BBHandledException as exc:
             self.error += 1
             logger.error('Failed to parse recipe: %s' % exc.recipe)
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
         except ParsingFailure as exc:
             self.error += 1
             logger.error('Unable to parse %s: %s' %
                      (exc.recipe, bb.exceptions.to_string(exc.realexception)))
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
         except bb.parse.ParseError as exc:
             self.error += 1
             logger.error(str(exc))
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
         except bb.data_smart.ExpansionError as exc:
             self.error += 1
@@ -2146,7 +2146,7 @@ class CookerParser(object):
             tb = list(itertools.dropwhile(lambda e: e.filename.startswith(bbdir), exc.traceback))
             logger.error('ExpansionError during parsing %s', value.recipe,
                          exc_info=(etype, value, tb))
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
         except Exception as exc:
             self.error += 1
@@ -2158,7 +2158,7 @@ class CookerParser(object):
                 # Most likely, an exception occurred during raising an exception
                 import traceback
                 logger.error('Exception during parse: %s' % traceback.format_exc())
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, force=True)
             return False
 
         self.current += 1
-- 
2.25.1

