Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ECDC0015E
	for <webhook@archiver.kernel.org>; Fri, 28 Jul 2023 15:59:48 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web11.36016.1690559979807951169
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jul 2023 08:59:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=IrnXNGqJ;
 spf=pass (domain: gmail.com, ip: 209.85.167.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3a44fae863fso1786876b6e.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Jul 2023 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690559978; x=1691164778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIpz9qHZTBY2aKVgpHqBxx+ELvmEZ8DxQJ69n9L3E+Q=;
        b=IrnXNGqJkF9kPudOpJGlEbxTh5NXMNEWh3HVAIiOt74loKKvU/MoSwbINKT6H18igk
         4iImDYmzyLweNBYILmt3bE1/VoihEwQb8KGvcJydjryAakY6GqUP7hDC2pOKuSuIARGO
         uvU75EHAUOZDIbg0jkNsZUL33/C8iEf4uln3MfAZb0bEShX8X10Dx73aQa0sLcOhs/dx
         wBkVjcEVp6vzfwRwC3JXZv20kZHFTHP8h+7T7VEpfe9ossPwT4oADzTj2h82+3c2gmxS
         QF/pUvfIbqzl47hytAR2Nl/zjeJIbcvUXakrCzI48gHFUhqG/cWiO5dqm0lGefJ3oIEc
         mxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559978; x=1691164778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIpz9qHZTBY2aKVgpHqBxx+ELvmEZ8DxQJ69n9L3E+Q=;
        b=EKo5cQbLRxxspL177XLPkF+lvtV5IHUB2s/z8JBqsFELdD26m1HfTDGBtG0y6kYw3x
         MHG3RhNLkWl1UmYRAoDEcU9SbtkkpBlewSvjk6zfrH057Mn/ZOTALzbBUR4C32BmHHQ6
         UIuzp3YUgBQ4b19aKPwTEF9tdcWGq0Bq0gp2j8J6Mj7IWcwbtl7jS04fzgikJ70pjY9F
         eXJjA/W/xYrZY4IQdL0AC7SRoxvI/2Cv1MG0i6077R3At8uvjh0w6D1k3Yt0ua/0LcWm
         Ah2jfySkSZNZCvHkCS8Xj2o2L85Gr1ANdZ0ymiEFf1/xSW4Lr9tXU4OyXRnohYnxRhV1
         ZlVg==
X-Gm-Message-State: ABy/qLZBfEz1Z/Twr1WmTZJbEigQZsW4E3OlcloEVgu3cg3vXYDwN558
	ru4BT7M9NwxgjLIS9oyfE7ka4choFso=
X-Google-Smtp-Source: APBJJlHFVfOwKdE3OjYi4EjyLkC6mcwNyJRAjdwb2riKUQ40KS1vikDSKsXhqEXPkrPG8GLCN7iTQA==
X-Received: by 2002:a05:6808:19a6:b0:3a1:d3f0:32ed with SMTP id bj38-20020a05680819a600b003a1d3f032edmr3628235oib.23.1690559978437;
        Fri, 28 Jul 2023 08:59:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::65c])
        by smtp.gmail.com with ESMTPSA id bf33-20020a056808192100b003a37372e6b2sm1759840oib.21.2023.07.28.08.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:59:37 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] contrib: vim: Fix up a few errors when reloading
Date: Fri, 28 Jul 2023 09:59:31 -0600
Message-Id: <20230728155931.40207-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Jul 2023 15:59:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14892

Fixes a few errors when the bitbake indent plugin is reloaded:
 1) Define functions with "!" so that vim doens't issue a warning when
    they are replaced
 2) Rename GetPythonIndent -> GetBBPythonIndent to prevent potential
    conflict with other plugins

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 contrib/vim/indent/bitbake.vim | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/vim/indent/bitbake.vim b/contrib/vim/indent/bitbake.vim
index 13810340..7ee9d699 100644
--- a/contrib/vim/indent/bitbake.vim
+++ b/contrib/vim/indent/bitbake.vim
@@ -40,7 +40,7 @@ set cpo&vim
 
 let s:maxoff = 50	" maximum number of lines to look backwards for ()
 
-function GetPythonIndent(lnum)
+function! GetBBPythonIndent(lnum)
 
   " If this line is explicitly joined: If the previous line was also joined,
   " line it up with that one, otherwise add two 'shiftwidth'
@@ -257,7 +257,7 @@ let b:did_indent = 1
 setlocal indentkeys+=0\"
 
 
-function BitbakeIndent(lnum)
+function! BitbakeIndent(lnum)
     if !has('syntax_items')
         return -1
     endif
@@ -315,7 +315,7 @@ function BitbakeIndent(lnum)
     endif
 
     if index(["bbPyDefRegion", "bbPyFuncRegion"], name) != -1
-        let ret = GetPythonIndent(a:lnum)
+        let ret = GetBBPythonIndent(a:lnum)
         " Should normally always be indented by at least one shiftwidth; but allow
         " return of -1 (defer to autoindent) or -2 (force indent to 0)
         if ret == 0
-- 
2.33.0


