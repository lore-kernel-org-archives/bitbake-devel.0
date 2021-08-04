Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web09.10218.1628089404516579588
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Aug 2021 08:03:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ARpLwmz1;
 spf=pass (domain: gmail.com, ip: 209.85.167.177, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f177.google.com with SMTP id u10so3196684oiw.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Aug 2021 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sDCAY4GwQ/OhRtYI3+qNujknrPsvZUmEmonooBDKDu8=;
        b=ARpLwmz1K1hr52NkOre6O1L40a5u2sde7qvWRHImTAcsGwyFV0LqFurIKjKCK5q90q
         yVno1THqE2dXn8rcWz9Zo1nPd4BoRn50fMQ6QQ+rw0BHAmpcQxj2RcyLFpoF7QTCZfSy
         Tvw+LHkpkAYU9Kus4ub5ZUFvap0OYsp5JjhyeG4ct+PdqTje8gke4xO1VuK/6cuSntYj
         xhaYt9pfcwyz7TQmK5URaPnAwGVxcoxbj8+jKB+8gveF/sX7GIeo7Z4GOGvp+EYTtk3w
         KA3BesneYpxgZAXo9hvD2Yvm+BbGuuZIwpYoW2fWiSYIszG/hysoXXFxyYHUN5vkkvLw
         uyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sDCAY4GwQ/OhRtYI3+qNujknrPsvZUmEmonooBDKDu8=;
        b=cqLU3l+VusEE9oJqUQUEre1NoZ9qTX+bTmYmEannYJyl+uBi1gGwkpfIO0Ea63Io3T
         nebZ34jStNq1sRkuz3WQmQwyS4NHI+sVVz9cUDKYZJFjz6htc2w7zABM5jl0ri/uQ8Ie
         7geDfRKFvS7QxkjRbLALSJneZLbzPCGnjx6iHnORNa1YBqXakJm46IaF5YzBAhtuNpYT
         Ipcd/5jRD9p6O2aHLQ/l7E7wiirYKS7RpPg3qDQQpdXFZZU2L1tyeXohZr9BhXZ2Maz1
         Qj0VBl/lMPSPesuPLK59tjWmHf3BRVeTkGADhipJo2AlA9zij7192hy8ENm6WFiRh531
         PhVQ==
X-Gm-Message-State: AOAM532ZfJjNeR/T3pXXhE0vn/g0MumFWD6Qn217G7TXauBGRMvLgfMa
	fX53ojNc/MyHimwRjIoSjtNCJr5tTi1Rpw==
X-Google-Smtp-Source: ABdhPJzMjwvsS8XImckq8LlsE64bZ49tZVn8GwkLYksEez+i9HKWtI36icptPG8mWcSTvmC2209oTg==
X-Received: by 2002:a05:6808:114f:: with SMTP id u15mr18049375oiu.163.1628089403442;
        Wed, 04 Aug 2021 08:03:23 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id t24sm429166otq.66.2021.08.04.08.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:03:22 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] contrib: vim: Update for new override syntax
Date: Wed,  4 Aug 2021 10:03:18 -0500
Message-Id: <20210804150318.18533-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates the Vim syntax highlighting to account for the new override
syntax and also highlight "append" and "prepend" overrides

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 contrib/vim/syntax/bitbake.vim | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/vim/syntax/bitbake.vim b/contrib/vim/syntax/bitbake.vim
index f964621..d8aa0f1 100644
--- a/contrib/vim/syntax/bitbake.vim
+++ b/contrib/vim/syntax/bitbake.vim
@@ -51,9 +51,9 @@ syn region bbString             matchgroup=bbQuote start=+'+ skip=+\\$+ end=+'+
 syn match bbExport            "^export" nextgroup=bbIdentifier skipwhite
 syn keyword bbExportFlag        export contained nextgroup=bbIdentifier skipwhite
 syn match bbIdentifier          "[a-zA-Z0-9\-_\.\/\+]\+" display contained
-syn match bbVarDeref            "${[a-zA-Z0-9\-_\.\/\+]\+}" contained
+syn match bbVarDeref            "${[a-zA-Z0-9\-_:\.\/\+]\+}" contained
 syn match bbVarEq               "\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)" contained nextgroup=bbVarValue
-syn match bbVarDef              "^\(export\s*\)\?\([a-zA-Z0-9\-_\.\/\+]\+\(_[${}a-zA-Z0-9\-_\.\/\+]\+\)\?\)\s*\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)\@=" contains=bbExportFlag,bbIdentifier,bbVarDeref nextgroup=bbVarEq
+syn match bbVarDef              "^\(export\s*\)\?\([a-zA-Z0-9\-_\.\/\+][${}a-zA-Z0-9\-_:\.\/\+]*\)\s*\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)\@=" contains=bbExportFlag,bbIdentifier,bbOverrideOperator,bbVarDeref nextgroup=bbVarEq
 syn match bbVarValue            ".*$" contained contains=bbString,bbVarDeref,bbVarPyValue
 syn region bbVarPyValue         start=+${@+ skip=+\\$+ end=+}+ contained contains=@python
 
@@ -77,13 +77,15 @@ syn keyword bbOEFunctions       do_fetch do_unpack do_patch do_configure do_comp
 " Generic Functions
 syn match bbFunction            "\h[0-9A-Za-z_\-\.]*" display contained contains=bbOEFunctions
 
+syn keyword bbOverrideOperator  append prepend contained
+
 " BitBake shell metadata
 syn include @shell syntax/sh.vim
 if exists("b:current_syntax")
   unlet b:current_syntax
 endif
 syn keyword bbShFakeRootFlag    fakeroot contained
-syn match bbShFuncDef           "^\(fakeroot\s*\)\?\([\.0-9A-Za-z_${}\-\.]\+\)\(python\)\@<!\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbFunction,bbVarDeref,bbDelimiter nextgroup=bbShFuncRegion skipwhite
+syn match bbShFuncDef           "^\(fakeroot\s*\)\?\([\.0-9A-Za-z_:${}\-\.]\+\)\(python\)\@<!\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbFunction,bbOverrideOperator,bbVarDeref,bbDelimiter nextgroup=bbShFuncRegion skipwhite
 syn region bbShFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@shell
 
 " Python value inside shell functions
@@ -91,7 +93,7 @@ syn region shDeref         start=+${@+ skip=+\\$+ excludenl end=+}+ contained co
 
 " BitBake python metadata
 syn keyword bbPyFlag            python contained
-syn match bbPyFuncDef           "^\(fakeroot\s*\)\?\(python\)\(\s\+[0-9A-Za-z_${}\-\.]\+\)\?\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbPyFlag,bbFunction,bbVarDeref,bbDelimiter nextgroup=bbPyFuncRegion skipwhite
+syn match bbPyFuncDef           "^\(fakeroot\s*\)\?\(python\)\(\s\+[0-9A-Za-z_:${}\-\.]\+\)\?\(\s*()\s*\)\({\)\@=" contains=bbShFakeRootFlag,bbPyFlag,bbFunction,bbOverrideOperator,bbVarDeref,bbDelimiter nextgroup=bbPyFuncRegion skipwhite
 syn region bbPyFuncRegion       matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@python
 
 " BitBake 'def'd python functions
@@ -122,5 +124,6 @@ hi def link bbStatement         Statement
 hi def link bbStatementRest     Identifier
 hi def link bbOEFunctions       Special
 hi def link bbVarPyValue        PreProc
+hi def link bbOverrideOperator  Operator
 
 let b:current_syntax = "bb"
-- 
2.32.0

