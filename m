Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540E1C6FA99
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 20:46:21 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.30871.1678481172022217925
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 12:46:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=N7zFyMi1;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id j2so6177891wrh.9
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 12:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678481170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6RU+VIYMT5575yPXmujdQFQJ8D04u0PjkQaCVacV6E=;
        b=N7zFyMi1IYqN9va76e0GMROryDXPkStdP2m7i9oKhpsQY3/4XPPq+kpefC0jcbLupc
         2Ansrp/A3QFNlFcPriomPJX2fHKR44XR5UfxLUSZQh0vRdYbQJLyhZd+77ltriC/MDxt
         vqz6GUCtIxur1ZYv369/V10a9eV5aLKMiBMbrz0VkDBlCqvmzu77CyWZNKle6+9zKoD9
         0dlrUgqDerT+AuyolMEE7IrPwYMi0sVr1ARn9Gouo48U/a4hMqcw4bhuoz7vuFhOCWZn
         QAkBuUT9ILLHIG7BC9lFW1ZdlSJJZPvikki8WZQg6taiNXukf+Xkm2+I3QL2aYt2o62X
         IxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6RU+VIYMT5575yPXmujdQFQJ8D04u0PjkQaCVacV6E=;
        b=jwEodk48EaSAFjJmk9qkp3qM6e0ogG2jRBY0eTBiixBmU+iGjBcq420zqQC/M+CVVJ
         0Glr448E7pLpnsTtW71UemSasDP/lnZX8FboCTqqBIquwAPIhlUOu+zHm3dunmDJJAdk
         A3brLnUt6BEei379115k77YtV6sNZBYvArGEwqkfeKWzIROpqqZLJHDr8sowYMObLac/
         r48Vm6n7vxcMcByoV0ffESzo3+3EsxZ7QYWEJLBJy44/ZtwVw40y5PnXEJCOBw0ZvNB3
         BaYZcRbGT74qdWy0dEz6RsoC6Wrn2p6TgWQmmko8+Rrqlo+9BRRCRG+EZAyM7kB3Ashh
         GXtQ==
X-Gm-Message-State: AO0yUKVrOvDTTVbjL/v0mOm2FPutgk2H/JZyLMyWBokLiLW0pSlLfIus
	rNbgfbY0pValjhOTePWJmOeyaukM9ro=
X-Google-Smtp-Source: AK7set//1lZbC17/wnTYGEU+CnXSmKCYtjF3+oz1TMugOzwuDh2kaepALK1V/DvIW+YnlCbjBz1JZQ==
X-Received: by 2002:a05:6000:1146:b0:2ce:9f35:59c7 with SMTP id d6-20020a056000114600b002ce9f3559c7mr332493wrx.45.1678481170531;
        Fri, 10 Mar 2023 12:46:10 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id z4-20020a056000110400b002c71a32394dsm647040wrw.64.2023.03.10.12.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:46:10 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH 3/4] cookerdata: Improve early exception handling
Date: Fri, 10 Mar 2023 21:46:00 +0100
Message-Id: <20230310204601.730833-3-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310204601.730833-1-Martin.Jansa@gmail.com>
References: <20230310204601.730833-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 20:46:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14546

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
index efa671aa0..e2dbb3b21 100644
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


