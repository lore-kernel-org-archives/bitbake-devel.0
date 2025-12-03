Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D42D116F3
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 09:10:15 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10573.1764752193040970545
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 00:56:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HZW6ADKL;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: swami310@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29844c68068so71905715ad.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 00:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764752192; x=1765356992; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JmdbTh8v/5w3rPHCHCAhv0T7iLwoWdTcr8imBcQ/a/w=;
        b=HZW6ADKLrhJx23qMc801y3eLGuiOow1/xV8KkmEJga6I+iihAwsnzF+LYsBkvIyHBq
         RlL6K4ANtSRVaiMuFQbfOP1jrk0pqfd0ACKqoQbNDFQ+3snelsTaeH9vZhhFvJyeiGy6
         r3DEYTaSSFpa9sn1Qrb3BERZULCnxs7EmGgj1Wg/WwG2GOH/L9QBy1kk2Z2prBY1OWSW
         OnJJSznw2DX4GVqn6sJoFRxXQQc+q57s/xpFHw8sUHKo6coXXONY45i1If7fnL0CjSyh
         qkCRyWHId3IcDINi6zdICszDctMtJX90UnRXCSP7tSAiwHx4zv2Z0DS2zTWdogsZUA+1
         I0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764752192; x=1765356992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmdbTh8v/5w3rPHCHCAhv0T7iLwoWdTcr8imBcQ/a/w=;
        b=WipTgq+wbikizO5jGSnqNrA0m5KUaXMEI6si3r8vJwryNkZ7cRYiyQuqxYMMfHjt8h
         E7IsWp07w5yA/nvTNztfUROkX2s3L08JrDMBYKlEOFGvePg4lFqvCVw712LZ+o17Q1af
         bvijGFh+R+qYHfdmGp6/XPJtSKC0obR5A9It/50kXSXP0ln++gS1iaeIkvNF4jhBrl5+
         lYv4hCRGopej3IiCymYU+jKh8Ogxfp6SPaU+huEwFLiQa52k01y761smMXu8bgWPQ5/j
         7se7hmmG3R1TXFJBb9SKXZwxIC+in3iRnA/a0TBt/O4KkZTEoG1KPTANs6FMDKCn5zmb
         SIkw==
X-Gm-Message-State: AOJu0YzBB0TLIocxakzupV/DSlPcAQ919AIHaqQ34xadd77ywUXQMOxT
	i6WB9AxEHGF6uaaTGmEXwg+5/0csSAzEv58KiuN6OLeRXCJd9+ADVjILKYndmtIV
X-Gm-Gg: ASbGnctJpFnr6dUKz5citoVVvDhEcjm5vZO0PgXRyG01moaQR4zq6gZf2oRrgyrNcxJ
	2AcRUrAC92Y/1OaqddoTXzH4tFNYBkkb9eNL93FP3K3HT8aqProNzf1uMKlpQMRD/hBPfeLZ6mM
	S8oI8dgJabq+3r0FbjDURirvTahhh2seFVcVUn1E7vcbe9Nk8ku2VgV21LDlIdbJa2PdmE0ML+q
	hu+wnIqcWfPmZD8UBfdzxPt+OTHwub2OR/D+UmZe9BmKRlaqy0eEPYBdYmvHPbtf9Xv9xCYehe4
	UvGxF65GU220gAcQ+IPz11+wtKKN/5Nc44NKR97KO+gncTJv96UCGgDfoaKZHqwsrGrftU2wte4
	z44RYwLyRbY2zUrC1HplNUV/zvuz53zaLyjJdW3Q866YZdYE0kSzHknLU0d7Tg48ZgPLFA4o0Lu
	Ys6VGi5eU7BCRwHrqPcOggweDxT4XoLKIOcSQ=
X-Google-Smtp-Source: AGHT+IEMSP1QrmhGFZGykRfHeZJd7hUL/pDcK6CDvhZoSVXuGINFRk8A8eMOVTRe4MVBEBcpPHhwpg==
X-Received: by 2002:a17:903:94e:b0:29d:7f69:2861 with SMTP id d9443c01a7336-29d7f6929cbmr2284935ad.44.1764752192076;
        Wed, 03 Dec 2025 00:56:32 -0800 (PST)
Received: from lenovo-ThinkPad-T480.. ([2405:201:e00e:f828:f2ef:c7a:ed96:173f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54449sm177616915ad.87.2025.12.03.00.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 00:56:31 -0800 (PST)
From: "Swami" <swami310@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com,
	Swami <swami310@gmail.com>
Subject: [PATCH v3] bitbake-user-manual: Documenting BB_CMDLINE
Date: Wed,  3 Dec 2025 14:25:40 +0530
Message-ID: <20251203085540.18826-1-swami310@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 09:10:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18519

Add documentation for the internal read-only variable :term:'BB_CMDLINE'.
Fixes [YOCTO #15746]
Signed-off-by: Swaminathan K <swami310@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a..f756c436d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -116,6 +116,10 @@ overview of their function and contents.
       Specifies if SSL certificates should be checked when fetching. The default
       value is ``1`` and certificates are not checked if the value is set to ``0``.
 
+   :term:`BB_CMDLINE`
+        :term:'BB_CMDLINE' is an internal variable and is read-only.It captures the exact
+        command line used for the current invocation of BitBake.
+      
    :term:`BB_HASH_CODEPARSER_VALS`
       Specifies values for variables to use when populating the codeparser cache.
       This can be used selectively to set dummy values for variables to avoid

