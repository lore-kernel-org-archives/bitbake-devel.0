Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284ADC3601A
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 09:13:09 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.3931.1743585186610125947
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Apr 2025 02:13:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YxGCfGpd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso44205925e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Apr 2025 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743585184; x=1744189984; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=thV26S2xUB85eahWK2IYxw7/M/ZB2TYgC+ZW7JdCEso=;
        b=YxGCfGpdhUhlfpy3evpLMeILZ0CFIPheBXgncu+ItOylijKGmNfoyXhX8mVbUGoUpm
         w0VRC0IgIL3iNkMnGTWNoiunMyJVibR5mxTADZkouf9gNCVfUXcK57rviJLZIF85eaBX
         2ZXx897zScNqdqR7heGuFyatl4aXUd/ZdGz+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743585184; x=1744189984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thV26S2xUB85eahWK2IYxw7/M/ZB2TYgC+ZW7JdCEso=;
        b=uEj+1/28dzsR3mwU6/fh2rl2dnyud3eUoSoxJB7enkFzSy9Hp5kW1khCgpFRDYc2gK
         FfcBqSyzTxd/MWlmp4DMGMhG9YLsikkSLXilt4cMn0ndYFNKJvths6adivI5uRCEBRpG
         zQx1D2zJvMyJWD4VH7gVJveSgSZpgK42JJ0yGkN6rudQXwPf8Bo5F/Wyw+HoYZ7XXfaB
         xAbOC6/rRwr+UIfEPjrWwCggsi38GNBGlqW0uFDgyApBBx594hh9Ox7+vN03ZxIHkNur
         yMXh7h+ETZorhpv32IxfjZRxfEZ243lREaSEbc2ukMAXfsivAoh3HitiDjE1htLMEFm3
         PCJw==
X-Gm-Message-State: AOJu0Yy548dnfRP7XEPOiXikQO7Cf0XyuezEFjeWxf7prkKxAoCe5kJd
	66H+4WdGpAwVgrrd7mgUDQaTYlzEAuIJEjd+FFlzGXCQ8BmHu2vuUEEPp+/+iC5d6QRanz/qq/E
	6
X-Gm-Gg: ASbGncutB2P6KmUZJLvrBlEqLwmDyFKR6cRw1r8agGxrQ8tTIhAbRFlrkcyKp+jbXht
	ttO41RjiIGQs7OSCsYUZeJbd91T9sXksmT4vRLT4MEe9xOLnXUKJatxCO3nwqbeQAALDjgcFmDY
	h3Dzu+p9doE2fv8VM3UrnJ4vGWpZGsk1NohCcesR0pLh1mjARg5kbygQtekXsjXBWwvERk5fD1C
	q0AssNCHVl2qDf/HR0Lm4oUFNYBtBfRHUMZB0Owt0nIxiRcygDjDagTMwS96A5IqO0XI5CVJBRw
	vPlx7nca6ruEXmHk+TECrWxz2CvudOSUgelOQxYI/oSTizw9dYZA9Xh9yDbEd9k4J6ab6SKtDlq
	YZfr8TqLW
X-Google-Smtp-Source: AGHT+IGHEwHdJVWuZeBm8IdCbUeMpCbRgZt4naDkN/DcDl3hnehtNCpzmxFsOEuTkmg1dN54RR9oXQ==
X-Received: by 2002:a05:600c:83c3:b0:43c:ef13:7e5e with SMTP id 5b1f17b1804b1-43db62bd98bmr131471375e9.26.1743585184525;
        Wed, 02 Apr 2025 02:13:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:24b8:b374:749c:8558])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a42a3sm16616257f8f.91.2025.04.02.02.13.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 02:13:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] parse/ConfHandler: Add warning for deprecated whitespace usage
Date: Wed,  2 Apr 2025 10:13:02 +0100
Message-ID: <20250402091303.2346229-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Apr 2025 09:13:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17508

A lack of whitespace around variable assignment operators makes the
files harder to read.

There is a deeper issue in that a "+" character can sometimes be confused
between the variable name and the assignment operator.

Start showing warnings for such usage so we encourage people to use
consistent whitespace which helps with file readability in general.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/parse_py/ConfHandler.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 1bde597254..675838d845 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -23,7 +23,7 @@ __config_regexp__  = re.compile( r"""
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]*?)
     (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)\])?
 
-    \s* (
+    (?P<whitespace>\s*) (
         (?P<colon>:=) |
         (?P<lazyques>\?\?=) |
         (?P<ques>\?=) |
@@ -32,7 +32,7 @@ __config_regexp__  = re.compile( r"""
         (?P<predot>=\.) |
         (?P<postdot>\.=) |
         =
-    ) \s*
+    ) (?P<whitespace2>\s*)
 
     (?!'[^']*'[^']*'$)
     (?!\"[^\"]*\"[^\"]*\"$)
@@ -168,6 +168,8 @@ def feeder(lineno, s, fn, statements, baseconfig=False, conffile=True):
         groupd = m.groupdict()
         if groupd['var'] == "":
             raise ParseError("Empty variable name in assignment: '%s'" % s, fn, lineno);
+        if not groupd['whitespace'] or not groupd['whitespace2']:
+            logger.warning("%s:%s has a lack of whitespace around the assignment: '%s'" % (fn, lineno, s))
         ast.handleData(statements, fn, lineno, groupd)
         return
 

