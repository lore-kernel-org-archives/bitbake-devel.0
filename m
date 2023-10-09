Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F6AE95A9A
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 15:08:20 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.64607.1696863644391527958
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Oct 2023 08:00:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PlYfL2Z5;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: bhstalel@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so12362098a12.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696863642; x=1697468442; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ft5JjVkr9HoSedDv7ecTpn/jZNuRSgtV9hsVuP1NxR0=;
        b=PlYfL2Z5j1Td9AiSmH3FuoFmW67RJgSwz5v9dDLqAFRyjhP2eRWoVePbmr02aTttOS
         RXPwO1TYp75PUxwhIHhg/sO5ZBa2zalj9I2Q1LP8qk40FA1FvUMI28EoAi01ay3x0iGK
         ms4KhXeb0Wi53H0YwcA0vJ5iqKG911eky2WWGcddHpFSp64l9LRDgiAx0WwfGbzWrzra
         aInc73KD2XcztzL7u8EGJpyzOCD7BuUe3WxNfGAdDkQMBDfYA7DEAU1L/9Fa8Egyx/qM
         bUAfNWL6khWpohcmeIelzX7pGY2nToehtive3tov116e7wbuuM8V9NmdYGMW5pBdQyEN
         I7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696863642; x=1697468442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ft5JjVkr9HoSedDv7ecTpn/jZNuRSgtV9hsVuP1NxR0=;
        b=IvmOaDOqWIYCrkpX6MMT2S1d4GRiwBRDoKA+SgNE2HLCenLX4CNnue1CzrqHMC2exc
         Wx6XkfVoCi8dLqHQ4mUQaLC3e0dSdwz6Kz78elsBKDDeochXawDB+dsnohB6CImgIe+D
         TZMVAfzat5yi9AEaktNA0sxN8vgdxJtcx8ypslffPrKd5NK5wKgACz7SY76gtJAMHvrF
         KV8LuckMpDuvsSbsqm/za4t7H0Lh/e0SLHHt7ber5fcMVkRLfYHfTjctfTp34MxoiaMP
         EwjtTTy5lR2l40+nABO+GJiwm+RIk09eRk3UFqcxD004CQfwJAIgNswSqZFRsM9ueBec
         IIHg==
X-Gm-Message-State: AOJu0Yx1P4kzUP5WPBRq3bhf0HeTuHLWSXU+6R7AskDNCBVo3oBRZ6Ju
	qu/Qf0TfxggmP0fn1z4x3my20sdNXhWf/Q==
X-Google-Smtp-Source: AGHT+IFvgA0VW7tLzJv2hui+6xWGPSBhfXHqB/CzKtAFItTr5Yu8vNzBsc3+V1AUshWEEtRdW0arBA==
X-Received: by 2002:aa7:d3cb:0:b0:522:4764:8baa with SMTP id o11-20020aa7d3cb000000b0052247648baamr11540654edr.12.1696863642103;
        Mon, 09 Oct 2023 08:00:42 -0700 (PDT)
Received: from talel.sofia.local ([193.95.99.58])
        by smtp.gmail.com with ESMTPSA id s21-20020aa7d795000000b0053613c8312bsm6224211edq.42.2023.10.09.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:00:41 -0700 (PDT)
From: "BELHADJ SALEM Talel" <bhstalel@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Talel BELHAJSALEM <bhstalel@gmail.com>
Subject: [PATCH] Fix find_bbfiles when BBFILES contains directory
Date: Mon,  9 Oct 2023 15:59:18 +0100
Message-Id: <20231009145918.900167-1-bhstalel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 15:08:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15194

When BBFILES in layer.conf contains a directory, this triggers find_bbfiles function
which will fail on endswith that does not expect a list.

Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
---
 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2adf4d297d..a354f2f0ab 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
             for ignored in ('SCCS', 'CVS', '.svn'):
                 if ignored in dirs:
                     dirs.remove(ignored)
-            found += [os.path.join(dir, f) for f in files if (f.endswith(['.bb', '.bbappend']))]
+            found += [os.path.join(dir, f) for f in files if (f.endswith(tuple(['.bb', '.bbappend'])))]
 
         return found
 
-- 
2.25.1


