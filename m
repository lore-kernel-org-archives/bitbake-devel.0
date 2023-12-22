Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61322C41535
	for <webhook@archiver.kernel.org>; Fri, 22 Dec 2023 17:01:27 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.web11.27597.1703264481394248593
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Dec 2023 09:01:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cpT+gdM0;
 spf=pass (domain: gmail.com, ip: 209.85.161.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5918f11099dso1252556eaf.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 22 Dec 2023 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703264479; x=1703869279; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mpNamYLuCNkxREWjc6x8bWfzUHkAnQOA2oAol6Xr3mQ=;
        b=cpT+gdM05JbgUAzzNAT8gUOJiTEU2z4wvok71pBfKm3J3SlalmGQEYF22AoT/7EPy4
         Ddw0hjt46RVfwVTExZ0JAhyEDe25pl+roaZetpPtMYCljPWzlx+rt75+b/dQYrhn3BJx
         R05herhgdI/nH1FPIf/uoKppRlFkH4YMKPfQuv8sTGML4ut6c6zRXL2I3ipD6hOCLY49
         87BVLAn5GlwAjUVZXQs4YOzBBqLhVAsq5FT3xzTWrK4DYgZdOOkoaJTSkHy8P7B5pbyA
         C65lqBleNvGCndOcAh+vEsQbXuniZSKAfGGTz9WxKPXyly02f8PCbxxPi69ol5D1HgtQ
         MD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264479; x=1703869279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpNamYLuCNkxREWjc6x8bWfzUHkAnQOA2oAol6Xr3mQ=;
        b=GmfZjE2vQOuTjxEUaaAx7xOm8Bq0odL4am6IiSa/uJw+dGFgsJUq4UbvizuZDcUpOc
         BX/67n5CqKWAb6Fg/NW0g/lwnYv3/G6eHyFP+GSBPkwaLo9tU6VEex579cSNt2+Qznle
         z2OzVT7jXzjfSaqKolxUDVBiM0ircf/88xtAJt0vPZBZWDQ7LyPkvvPgdMN2xBsZ/BdA
         IESRO5BqfG/8WqS5QVf2YYKnWzHa1kpf/o7VYKRRuL5hTAv81Dm001zufnel2h3C2p5V
         fr/Etl6BT+z4ZCxYQ1GOJgR4UgFzK+03hlMDcNzFffb0hzlMEkVCkrVLctkDKz0fElAz
         hU2A==
X-Gm-Message-State: AOJu0YzheH05b+YrHsAzINPJdPRAUeNd5tzOoV0lRkl26q7wJKKPLnRZ
	6yW6SMhqobd8nANfCO4TCnzl+jjOOSU=
X-Google-Smtp-Source: AGHT+IF7FvpHOlMpX7SzWiTMchX22qvlVP3d/4bBoPIdamv48p8ghhZGmKIlazWdDNI/sPxR5JS3QQ==
X-Received: by 2002:a05:6820:545:b0:591:5457:ff4d with SMTP id n5-20020a056820054500b005915457ff4dmr1324281ooj.16.1703264479584;
        Fri, 22 Dec 2023 09:01:19 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::d6e0])
        by smtp.gmail.com with ESMTPSA id r3-20020a4a4e03000000b00586c4324f5dsm837208ooa.35.2023.12.22.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:01:18 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] contrib/vim: Syntax improvements
Date: Fri, 22 Dec 2023 10:01:12 -0700
Message-Id: <20231222170112.2059047-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 22 Dec 2023 17:01:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15700

Makes a few improvments to the vim Bitbake syntax plugin:
 1) Highlight python expansion expressions "${@...}" in
    inherit/include/require
 2) Highlight variables "${..}" and python expressions "${@...}" in
    addtask/deltask/addhandler
 3) Correctly handle multi-line sequences in addtask/deltask/addhanlder

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 contrib/vim/syntax/bitbake.vim | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/vim/syntax/bitbake.vim b/contrib/vim/syntax/bitbake.vim
index c5ea80f..8f39b8f 100644
--- a/contrib/vim/syntax/bitbake.vim
+++ b/contrib/vim/syntax/bitbake.vim
@@ -63,13 +63,14 @@ syn region bbVarFlagFlag        matchgroup=bbArrayBrackets start="\[" end="\]\s*
 
 " Includes and requires
 syn keyword bbInclude           inherit include require contained 
-syn match bbIncludeRest         ".*$" contained contains=bbString,bbVarDeref
+syn match bbIncludeRest         ".*$" contained contains=bbString,bbVarDeref,bbVarPyValue
 syn match bbIncludeLine         "^\(inherit\|include\|require\)\s\+" contains=bbInclude nextgroup=bbIncludeRest
 
 " Add taks and similar
 syn keyword bbStatement         addtask deltask addhandler after before EXPORT_FUNCTIONS contained
-syn match bbStatementRest       ".*$" skipwhite contained contains=bbStatement
-syn match bbStatementLine       "^\(addtask\|deltask\|addhandler\|after\|before\|EXPORT_FUNCTIONS\)\s\+" contains=bbStatement nextgroup=bbStatementRest
+syn match bbStatementRest       /[^\\]*$/ skipwhite contained contains=bbStatement,bbVarDeref,bbVarPyValue
+syn region bbStatementRestCont  start=/.*\\$/ end=/^[^\\]*$/ contained contains=bbStatement,bbVarDeref,bbVarPyValue,bbContinue keepend
+syn match bbStatementLine       "^\(addtask\|deltask\|addhandler\|after\|before\|EXPORT_FUNCTIONS\)\s\+" contains=bbStatement nextgroup=bbStatementRest,bbStatementRestCont
 
 " OE Important Functions
 syn keyword bbOEFunctions       do_fetch do_unpack do_patch do_configure do_compile do_stage do_install do_package contained
@@ -122,6 +123,7 @@ hi def link bbPyFlag            Type
 hi def link bbPyDef             Statement
 hi def link bbStatement         Statement
 hi def link bbStatementRest     Identifier
+hi def link bbStatementRestCont Identifier
 hi def link bbOEFunctions       Special
 hi def link bbVarPyValue        PreProc
 hi def link bbOverrideOperator  Operator
-- 
2.34.1


