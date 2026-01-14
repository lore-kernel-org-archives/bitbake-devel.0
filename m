Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF02D29FF3
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 11:39:24 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8045.1768390760009454575
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 03:39:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TA+rV5+L;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563e28a3so4906725e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 03:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768390758; x=1768995558; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=115CKfd2PHyKpUkxwBuLvIaCjOcSfyOszf4QvUiEn9c=;
        b=TA+rV5+LCresPm7lbepQDJN5Bcmw1/GRATrosZvHWQ+jj7hhcBAmINQ5XISA9Fpeu4
         dL4WQ/dvPzR301YmSbv4EVMRhP2kY2jrOeLC62cy2LA+v7gxFIDH1MuWyLz3DISs6R3W
         hlDEuDd/NXE+xb4YMD8zR87Lh815lTdMArvTaGc25Z4YvkIxK9ljyRx1oK9gG95UsRxj
         6lyYInoi5vkJmKaYNs2WfkoR1u+X4imCxXOUGtximxv0nddmfUT5Z95vsqjXIxvC+Ga6
         s9dJ3GY+v6CVWQe6mgHtbgZe+Cr3N7PDzVcwHLOZ1Ns+M/pFasDRzbvg9S1DcM7UsK6w
         Kf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390758; x=1768995558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=115CKfd2PHyKpUkxwBuLvIaCjOcSfyOszf4QvUiEn9c=;
        b=kioeYJHVjJ3tfg2x5iRHo1CCh0yHsEV4iK09XnZhLhPbG6sD/ReUcLYiuU/7pN+el1
         p6Lc+fr7hUlxeMdKCNXcPTe1MUEHTFS4WStsIusdMRouYKziINypyKVAGEUpVILjZ87O
         LLZnKT9gJPERJK8kVGm4JTyJDCcNQpaTxM6EI1mAk6epsACYEeYzHN0M8/OuPP3XR5dU
         5bv4JXGS9g0M+Cd6fZ5pYb+LHRNSVxQU5hSo/Ts6ggy+zNWQKUzUyiLgzmIkw++qHBwS
         T6J5mR6VNGwiUSmmZvvgP+DohwsnCtUhago1CJDKQ7hD08MYUtsxaNtKXqO8076sJzzx
         2bFw==
X-Gm-Message-State: AOJu0Yxt+mT2yJMdj2cJD+N1/P/hTDapSmNyfK2+S8TQ+wNIqZKRDkYj
	OP0JcPG1XoQAT/K6+Nf4ieKnR1ke7KVbxucm2LLOsdAkCF/xSkj/zFTNnMnaOBZU
X-Gm-Gg: AY/fxX6z3mliLv7+q8Zx3Zxap1v3rEuWLy17Xqk91ju4fNcinTlfKk2LpB6KtjWUIRF
	/SzAkxrFfzy9PBXQzC6PGBlRB8EiNqC9Ov/rQUDccBNOB0b90qVS+5GkoJqkuM2YwQbWIRpiy3I
	/oGW7fHnK+4LmgvaCHCAjnovv8NGM6KWP57yHpmuNo0UG0l2tKaUPIbwZMo2IKd5bXFmXdVb05H
	anaMpJRJlFvT0crRl7L4Th6SDglHawIOlqVNc5V6b/IUU7vY8bt1sfqRZdunYjg6EVT16HSyvji
	Lsexo5DghyEBcnBhonPkBGFscfze/hdFZxeSxpus7bhRzY1BFnvTZiByHQk8TrEpw45YEmLVqv6
	s3U8u7gLGnd2x8J++4bKfb5TZqcHX5iy/em7vJyUuL2O4oDQxrdIN44RqNivSdLEc5RbManErFG
	sBdMSJ9n6dzuWZ3B+Fwi13F91KM3mnZpWsl0FjSBvQzczj4L8=
X-Received: by 2002:a05:600c:c48e:b0:477:a53c:8ca1 with SMTP id 5b1f17b1804b1-47ed7c386e5mr72004845e9.14.1768390758181;
        Wed, 14 Jan 2026 03:39:18 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee5613cfbsm24289165e9.0.2026.01.14.03.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:39:17 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: ensure 'list' does not write anything into top dir
Date: Wed, 14 Jan 2026 12:39:13 +0100
Message-ID: <20260114113914.2998470-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 11:39:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18754

From: Alexander Kanavin <alex@linutronix.de>

The goal for the 'list' command is to not leave any files or directories
behind, as it may be issued before the user has decided where to
place the top directory. 'list' redirects the top directory
to a temporary location, but it didn't do the same for the downloads,
which led to the default top directory being polluted with them.
This has now been fixed.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 4ed06fc62..4d709ed8c 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -785,6 +785,7 @@ def list_registry(registry_path, with_expired):
 def list_configs(settings, args):
     import tempfile
     top_dir = tempfile.mkdtemp(prefix="bitbake-setup-list-")
+    settings['default']['dl-dir'] = os.path.join(top_dir, '.bitbake-setup-downloads')
     d = init_bb_cache(top_dir, settings, args)
     registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
     json_data = list_registry(registry_path, args.with_expired)
-- 
2.47.3


