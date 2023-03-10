Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4EBC6FD1E
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 20:45:41 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.30858.1678481139737926273
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 12:45:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=XcoiOnX6;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id e13so6180693wro.10
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678481138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6y8QF3Fi3E1e9PE5jehWduL3g7jCzMN9yBHJGRnKhY=;
        b=XcoiOnX630HQKJF3NDkkS5tlnPvplexMLC6Qh/5qcrLx0kD+YJuMjXZ5cFhuJnJRXm
         3ZiEXxYwdxowhftVDbWOoFozNGiZ6CBHbz20Ksw44g7wvCpG2Qg5FCxNiKzl7zNCs+79
         Mdz8IU2NG2PIgIsVihIsZsJOeaURRfHVbcJ7u4p88Dsy4mGW+Gtn/6fJwCrFQOE7SyzH
         4zsETUwifqXl92GOQprP5HhuFgi+hNiok3aMq/Zczo7qEnL9cIG6Ic00ybyNzqgetMFq
         RSGO1oNrKev0/M2tfESC52R//Ph2YwQ7aKj9YzyVwWfmQZGTvHDPIN+GdvVMeGt31Ob7
         ty9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6y8QF3Fi3E1e9PE5jehWduL3g7jCzMN9yBHJGRnKhY=;
        b=GdsWlDzPyAQb6Jas3vmbWyMrPQrXsH0XhQQKhILUpodYWyZhxAU5C7OKLHWKexv255
         Dfaw09uy5G9GsqZedGbMOdZwMkI+SI3FiI3ERUAEve5a25l+8olePes9VClhpUBLdA0n
         ohKIvBboy8FnFSyhNI2cHSEnlEWIg61s0YjmYHtPfpYEeuvIRdTeEYeEOHtQROQhzay6
         2s4Jjh68H/hcE7ls67A2sjyLa3OsdY4DIZVuAsyAR/iCoqbbz98tRbfQuQxn5qVW0vIc
         IeSG9LjXhMRljBRwePQANB+xx3tv/ChuPwL7HqRU2gQ25X+FFL/LfU1/0bnVwwh17e89
         lCbw==
X-Gm-Message-State: AO0yUKWk1dUNtfw4DYJ8IAL3I/AW86z1Rv5Fsny0rtb3WHhazvW+u1SI
	wiGP+vt+4SztUD9HrwGWBlamBDPYVbg=
X-Google-Smtp-Source: AK7set+ojtxCdEfzo3O8Odu1b34ycoYtg5sWWmnC7YOkPnoKA73XW9DvlSg+lVcemnGhAI9B/Rjd/A==
X-Received: by 2002:a05:6000:10:b0:2c7:15b6:15b8 with SMTP id h16-20020a056000001000b002c715b615b8mr17016324wrx.10.1678481138136;
        Fri, 10 Mar 2023 12:45:38 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id s10-20020a1cf20a000000b003eb5ce1b734sm895997wmc.7.2023.03.10.12.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:45:37 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.2][PATCH 3/4] cookerdata: Improve early exception handling
Date: Fri, 10 Mar 2023 21:45:18 +0100
Message-Id: <20230310204519.706973-3-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310204519.706973-1-Martin.Jansa@gmail.com>
References: <20230310204519.706973-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 20:45:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14542

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Martin Jansa reported that if you put a syntax error into an imported
module such as qa.py in OE, no error is shown.

Part of the issue appears to be that the catch_parse_error() decorator only
catches certain exceptions and SyntaxError isn't one of them. As far as I can
tell we should remove all the special cases and use the more advanced code
in all cases, not just expansion errors.

I confirmed this now prints a proper error message for a qa.py syntax error.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 3555585c8..25eea827d 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -160,12 +160,7 @@ def catch_parse_error(func):
     def wrapped(fn, *args):
         try:
             return func(fn, *args)
-        except IOError as exc:
-            import traceback
-            parselog.critical(traceback.format_exc())
-            parselog.critical("Unable to parse %s: %s" % (fn, exc))
-            raise bb.BBHandledException()
-        except bb.data_smart.ExpansionError as exc:
+        except Exception as exc:
             import traceback
 
             bbdir = os.path.dirname(__file__) + os.sep
@@ -177,9 +172,6 @@ def catch_parse_error(func):
                     break
             parselog.critical("Unable to parse %s" % fn, exc_info=(exc_class, exc, tb))
             raise bb.BBHandledException()
-        except bb.parse.ParseError as exc:
-            parselog.critical(str(exc))
-            raise bb.BBHandledException()
     return wrapped
 
 @catch_parse_error
-- 
2.39.2


