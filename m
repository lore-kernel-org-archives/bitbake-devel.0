Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509C3C5478C
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 21:00:08 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.5970.1708722007873870240
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Feb 2024 13:00:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PABcCg1j;
 spf=pass (domain: konsulko.com, ip: 209.85.214.180, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db6e0996ceso10417275ad.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Feb 2024 13:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1708722006; x=1709326806; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YId+dsYEm2phJIe8Sp/c+R9hKKWUiZHahtMr69uQhKI=;
        b=PABcCg1j2hZF80N/TcCVQdqLzXY/r71bpunRjzo8pVOBXTiqD2AnYYvd6ObuaBcX5M
         oYH1QgZr8Ul7nR95NZOfVLfvynqu0TIfKAslUDUE69J8exuQ4dwoLR6TYd2jmsJIQt/v
         Dn5WWS85g1T31HaSvsP2jm5BOn9subNHIYmrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722006; x=1709326806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YId+dsYEm2phJIe8Sp/c+R9hKKWUiZHahtMr69uQhKI=;
        b=wWqGHSp6tmALoO7y1lknmMV/tSzalH2IdvADX89zvs+OwzNLRaAsTImv+IlW23HU9u
         rGCCFhYrx7rkBaSsysdxtxpJmNr/ptWORUNHx/Vr//7zN4hAPaXtFyh/tZmuuPdQMepX
         kNx3XV/sTWPIBPOInp4H3yT5pb95lZ/9NE99i8d1Pe7HeiG8CFUSbe5NoYTv7IV7P2h8
         WwjWXL3yvxugO5D+8d6u6eyIEG3Yx3xg6SBjeCUGs9fSFMA1LH1AUZzjb70/F3QHOnTL
         vU0Z6RnZ3i6bBSKP6/nsp8yyWHiRZudqhBsnXnrLG+CGJST+VZFXxR2pMw89P0xGByBp
         gCzA==
X-Gm-Message-State: AOJu0YzqJX8d8gTOmVDPvvuyRdL4KT0DEKuk8xU8Kk9+wqmO9bcBQ5b6
	a9qhqLX+3X87eIUFIxsoAXVid2E8PygJAyy77eu5uN3R3wlcJPNREs827MctgN+GDlg+xTeLBAL
	HlZQ=
X-Google-Smtp-Source: AGHT+IGe/dOaLkiKaKzNwyrOBS0elLo/2VRnHe4j5VEoBREN/E5Cxg89Rru3L79ww6al4YvhjFz9rA==
X-Received: by 2002:a17:902:e743:b0:1db:f941:c9a with SMTP id p3-20020a170902e74300b001dbf9410c9amr1366821plf.45.1708722006186;
        Fri, 23 Feb 2024 13:00:06 -0800 (PST)
Received: from localhost ([2601:1c0:ca01:19f0::d846])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001d8fe6cd0f0sm12018235plw.150.2024.02.23.13.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:00:05 -0800 (PST)
From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mark Hatle <mark.hatle@kernel.crashing.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] layerindexlib: fix missing layer branch backtrace
Date: Fri, 23 Feb 2024 12:58:35 -0800
Message-Id: <20240223205833.2442592-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Feb 2024 21:00:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15957

When a LayerBranch (a specific layer at a specific release) does not
exist in the layerindex database ("Layerindex Metadata"), the dependency
would throw a backtrace. Instead fail early and provide an error message.

Since layerindexlib will also check the local layers, inform the user that
a local checkout might resolve the situation. Recommend that they reach
out to the layer maintainers and layer index admins to properly fix it for
everyone.

While we are here, remove some trailing whitespace.

[YOCTO #15365]
[YOCTO #13954]

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/layerindexlib/__init__.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index ac03d8987..8b3af156b 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -178,9 +178,9 @@ class LayerIndex():
         '''Load the layerindex.
 
            indexURI - An index to load.  (Use multiple calls to load multiple indexes)
-           
+
            reload - If reload is True, then any previously loaded indexes will be forgotten.
-           
+
            load - List of elements to load.  Default loads all items.
                   Note: plugs may ignore this.
 
@@ -383,7 +383,14 @@ layerBranches set.  If not, they are effectively blank.'''
 
                 # Get a list of dependencies and then recursively process them
                 for layerdependency in layerbranch.index.layerDependencies_layerBranchId[layerbranch.id]:
-                    deplayerbranch = layerdependency.dependency_layerBranch
+                    try:
+                        deplayerbranch = layerdependency.dependency_layerBranch
+                    except AttributeError as e:
+                            logger.error('LayerBranch does not exist for dependent layer {}:{}\n' \
+                                '       Cannot continue successfully.\n' \
+                                '       You might be able to resolve this by checking out the layer locally.\n' \
+                                '       Consider reaching out the to the layer maintainers or the layerindex admins' \
+                                .format(layerdependency.dependency.name, layerbranch.branch.name))
 
                     if ignores and deplayerbranch.layer.name in ignores:
                         continue
@@ -846,7 +853,7 @@ class LayerIndexObj():
                     continue
 
                 for layerdependency in layerbranch.index.layerDependencies_layerBranchId[layerbranch.id]:
-                    deplayerbranch = layerdependency.dependency_layerBranch
+                    deplayerbranch = layerdependency.dependency_layerBranch or None
 
                     if ignores and deplayerbranch.layer.name in ignores:
                         continue
-- 
2.34.1


