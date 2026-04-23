Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AACFFC0344
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 15:13:57 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22264.1776957227769737903
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Apr 2026 08:13:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fE7lCT/R;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e5bea4045so39480521cf.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776957226; x=1777562026; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TkJbjDzQOi0alp8NFdwxG9IxS7eH/xHw7Foju4F8UFU=;
        b=fE7lCT/RkSjDFp1/6Vm9boe7sFH/19SE+TPW9YbyCvqLFHkOEvIEJ9duEG92fAmMHl
         ISHGJUP9f6wRXxcX07zceSl3VWr+wTczQWBg+aw3uj7ZYZEOjZEtJtog8GFzwtMEux9K
         dkUn3iRcfW8rxaT3XGLwZYd2dLXG3fifj9uHjO9mxuXxQ4RcvkMtzeeJPpvSAZ217Kw0
         Wi/tmyFwDYisT/ZrTnMOa9QnMVidod18nBsgc3fefXof1dubAPNXwhnX4sPOPeteGfj0
         eikj1zbHn55OzA3XXWlvqj8wfwlmyW+LLMhLwS2iXbEcGXlA5T8siv9hNiu4humy4SFf
         wveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957226; x=1777562026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkJbjDzQOi0alp8NFdwxG9IxS7eH/xHw7Foju4F8UFU=;
        b=seP2zE4xfcxa1t3J6OtTd0BEq7/YHDpHYyQKiMxvWvshkhmLWJm32+n5RpLu8J6x/X
         TxDYgiY5RIFjytZFMdTA8AhGRuAnoYnBqB1wwI6BAuleG36L0BbU4xQGewTqVq4OOg9T
         Jw5NR2LhXEzenBBWGpzrW4AM6NHV+tPjDaJNBSHXFrL2ewbcDRF0hmBbx13wT9vSLTj+
         JULfaBgxtMX2SqWduxsOkMkjToWaJwkXho25+EJHcmQgjjz94N9JFKzfAhD42N+QZwkZ
         4JtG001be4Y3bVGcxGR/rgaiFCYJQi9BKQy8kda5e6IZ4F4skdGTdgPkvgkIeRGlW5Zx
         7ALg==
X-Gm-Message-State: AOJu0Yy8nuf0Kuyzp8Ru6ktMwrwRmi9+WcDN1pkwXD45/5W/M4zC4LxP
	kJVSiWAvdAtOKetMT/ve27HIYUzCvvRlEnvFxAi+/mKg/L0fGTVnTrEmM95sxQ==
X-Gm-Gg: AeBDiev3RtMqsgQ8n0LNs5FgfyOrMRErU75agoOo2Tffqo8DabhBXt5s4qzeIXJD1TA
	wH9Iy/cKA3aRUfQYiTROgjcEhzTYlXbpty+oU9ELzmk9wFVX+TbGMBK32PLBC8CcB8ezzSl2uHg
	c5moWocd5DFdu02as4h6fbsJ3ThrhAccAXq+8QsOLgcn2IKXUaI7ACjVz0y7Xuu5IduhslAgI8S
	F1xhRdDMagejI/KL8onl5ErIxl/Dbs+IeXpTMuAKsGNyR+xgnVOPksT3d31Zzs1oZicBCnaUEp0
	ob2XlDJ5qKLpKy1kPNNVEA3fUk6onr1jL8fdKWjaod3y6uZHisRFhudNnw7L/mBCEx+KCcsOl4p
	5TLNB0z9+2GWHdqw1Hj4YFUATrWg/aHxiG5hL3tw13jyXQuZuSdww25SmcAgZ6E3uZwnR+ECfZT
	I5RUzEqjN2L9Px7L3tjAuARHLiLZyWktGhhW0E6yI2rutSJN2AD+Qc6RmvRB4KWYatQadmdL+5Y
	voW
X-Received: by 2002:a05:622a:89:b0:50f:b257:92fe with SMTP id d75a77b69052e-50fb2579f75mr185608591cf.53.1776957225984;
        Thu, 23 Apr 2026 08:13:45 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e61c191basm123811501cf.16.2026.04.23.08.13.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:13:45 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] contrib/vim: highlight inherit_defer and include_all
Date: Thu, 23 Apr 2026 11:13:40 -0400
Message-ID: <20260423151340.2082495-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 15:13:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19382

The vim syntax file's "Includes and requires" rule only matched
inherit, include and require. BitBake also accepts the inherit_defer
and include_all directives, so they should be highlighted the same
way.

Add both keywords to bbInclude and to the bbIncludeLine match
pattern. Longer keywords are listed first in the alternation so the
regex does not match the shorter prefix (e.g. inherit_defer must win
over inherit).

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 contrib/vim/syntax/bitbake.vim | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/vim/syntax/bitbake.vim b/contrib/vim/syntax/bitbake.vim
index 8f39b8f95115..fcf024563a97 100644
--- a/contrib/vim/syntax/bitbake.vim
+++ b/contrib/vim/syntax/bitbake.vim
@@ -62,9 +62,9 @@ syn match bbVarFlagDef          "^\([a-zA-Z0-9\-_\.]\+\)\(\[[a-zA-Z0-9\-_\.+]\+\
 syn region bbVarFlagFlag        matchgroup=bbArrayBrackets start="\[" end="\]\s*\(:=\|=\|.=\|=.|+=\|=+\|?=\)\@=" contained contains=bbIdentifier nextgroup=bbVarEq
 
 " Includes and requires
-syn keyword bbInclude           inherit include require contained 
+syn keyword bbInclude           inherit inherit_defer include include_all require contained
 syn match bbIncludeRest         ".*$" contained contains=bbString,bbVarDeref,bbVarPyValue
-syn match bbIncludeLine         "^\(inherit\|include\|require\)\s\+" contains=bbInclude nextgroup=bbIncludeRest
+syn match bbIncludeLine         "^\(inherit_defer\|inherit\|include_all\|include\|require\)\s\+" contains=bbInclude nextgroup=bbIncludeRest
 
 " Add taks and similar
 syn keyword bbStatement         addtask deltask addhandler after before EXPORT_FUNCTIONS contained
-- 
2.50.0.173.g8b6f19ccfc3a


