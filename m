Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B2CCF9FE
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 14:19:17 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web11.26280.1761833952348789434
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Oct 2025 07:19:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KeUU+37h;
 spf=pass (domain: gmail.com, ip: 209.85.160.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3c97709a4fbso450166fac.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761833951; x=1762438751; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yM/e3DtPnXajny9tEpOyO2yJY6otleFKg59MwE69uEw=;
        b=KeUU+37hFdmZVmDlaHkTa8YeZpDFECynJACBa1IDM46QcQuj9r+n/jVgrEOq8kg42e
         ib0kaqzjBg5/cyJMa49YqIB79AZbv1GHBMmSvPHQ2qxTXkyFtQGXeraO139c2nNjMMrf
         PwcRPzB/HiPUDsmKt3GOXpAeTez1Eb34ETRUv7//f6mHwBr5gJgCyUR3XZyw5Gc1701i
         ni0wgXEQD5zuycZ29/NwPw3ShzKBF81/3l2vfzgfVc4YCht7QwzyIHMtEPCdmYp55ihT
         ZvZwMJSm1meB9hQzBd4c0Kkcuuyv1TvVeneQPoIv66QOpVAjCorpIvy65FrUtrWk8Hwy
         W4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833951; x=1762438751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM/e3DtPnXajny9tEpOyO2yJY6otleFKg59MwE69uEw=;
        b=SFWYgFoZnVVQwfEZDz4totsXv7LqFY+ErdClfLCJ+UdEs4mMrYeX3msTrtZok00TQ2
         IA6hbDVvQkEhPAMMC5kYDVhPnQD1ZXVKDPmvK0Wp1BcTRbSYqfAwV8XCQzMNzv+MtDN7
         MELAL+IWPjYF0m/VltcUBN9vtrmiRa3anGaq2SPJ4PYZb9JsZktI8MkUTwwsnqtjWErk
         0Msx2fZW4fhYkcgC648wz7orh8U5/sKy3e5QVDwNIGIDJtaBJjkRuHNVwBN8SgqxrzsY
         Bz71ZHUC2dOMCI4zM+hDG/Q5O/ymgsgtqMVp6AUQmvE/MXckraDgZO5eFVdjnNzFhEBJ
         0wPQ==
X-Gm-Message-State: AOJu0YwcYhJD4hx2qby9PvXsOLcDXgCxk2BanpNBLGAZcrW6kfd4cueK
	Q+vpPpTTlpZj8Fxiyof8VFxZ625iPbg6GwF0WLPk6Yi+uRAF7iMtySzngGWBXA==
X-Gm-Gg: ASbGncscnRZsYPhau4DVuDxvRvB+m4MKeudE13loYqnemEvHtrZT6p6C6/Eq9kbI7Mn
	7SzgJJ2HCATkDj+sE/o9sBwFl/qZf9xRiPMScASLJBrvmiwYhgDPGyKGx3EXS3hJY/RYk3IfJpq
	IPhz0YJ/ZUYC9P5bwSfY4oTO+9tmP2OyFTm+foalJ7CP+YNDP2J/ewyvhjHCGAzDn4aNIgfsUyp
	Yo7RwqJYocrZg0+TasSTzRBATkgiaaPJXyg5LYXct0m4lLW2ZhOplX8Rsw776gtcHXbtJq2faIv
	P3MQuFXzWZvhcottCc4wc05RwmPly35lAXY2Xr/qp03416DiwT09Nv51POvfl5OXzVRotqt0zR9
	hJe26gxsksdnWnk5q2H6lsQNNXwbbZQD7DUSoDRrviNmWAaX3ZtEtFKF90B+bJQyTqBQ5LQ7Jew
	==
X-Google-Smtp-Source: AGHT+IGxNFaYCUAaJn1/4s0I/azfJRzHePSdAYgqkhsNz9vtqfJTa9Ex5koRMSDGti6Ms5Tqlvmx+Q==
X-Received: by 2002:a05:6871:a6a9:b0:3d4:5306:bb33 with SMTP id 586e51a60fabf-3d745fa543amr3467725fac.15.1761833951287;
        Thu, 30 Oct 2025 07:19:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::7772])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-654ef2c2608sm4347724eaf.14.2025.10.30.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:19:10 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC] cookerdata: Include "originating" recipe data when parsing
Date: Thu, 30 Oct 2025 08:19:04 -0600
Message-ID: <20251030141904.69494-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 14:19:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18226

Parse out PN, PV, and PR from the "originating" recipe (the .bb file
being parsed) and provide them at parse time. This allows .bbappends,
.inc, etc. files to know what recipe is currently being parsed.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/cookerdata.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 65c153a5b..8abf5e56e 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -504,6 +504,12 @@ class CookerDataBuilder(object):
         bb_data.setVar("__BBMULTICONFIG", mc)
         bb_data.setVar("FILE_LAYERNAME", layername)
 
+        pn, pv, pr = bb.parse.vars_from_file(bbfile, bb_data)
+
+        bb_data.setVar("ORIG_PN", pn or "defaultpkgname")
+        bb_data.setVar("ORIG_PV", pv or "1.0")
+        bb_data.setVar("ORIG_PR", pr or "r0")
+
         bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
         bb.parse.cached_mtime_noerror(bbfile_loc)
 
-- 
2.51.1


