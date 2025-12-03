Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B80ED116F3
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 05:09:14 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4909.1764725178929021766
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 17:26:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=REJOScZC;
 spf=pass (domain: gmail.com, ip: 209.85.210.175, mailfrom: swami310@gmail.com)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso4475858b3a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 17:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764725178; x=1765329978; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/2+LDyC2tEzgXOmZtdW6e6af9QBnU/X7otU1S/pYXn8=;
        b=REJOScZCgdp1x1KGdcRDet7wYlFlszUFAAOGC7a9LC3g4KDQI2TCJBetnfTP2iKw66
         KlB6Vqjj3gOgNbeSEdf5uEkp8bb6lJzah7gWkP1ILX5KxrHcn0bpDD60q/D0KxvLhLOD
         kAO17RW2czu6Z7fqiH62ug+Tu7cMkr2S04F/fWozy4/J6U21o9NvJvvRTSS4nNR/doBj
         6I8dEgX92YXC75X6Ex2eSKfcERGvHe6ksKYjVLXKkaWpmhsoJsRq/yPB9PAHnZqqw8m+
         E81QLt2454lg37v1thYP5syP99tDfeEVsyEmYsnpN/VV4XjJ9AisMg4nGIGdA2auIBC1
         amDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764725178; x=1765329978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2+LDyC2tEzgXOmZtdW6e6af9QBnU/X7otU1S/pYXn8=;
        b=cV2wTTNzU8dRhEKdY5J9PL4Hmcm88kR8HGh4+IMvaO6Z1RGCsQWVqcOV24OxhXpfkC
         hSu+Ob6q7dd/El+e8GgiNv2SvXXVN9WOn9/Q20AOmEFaTR6l6qOO8NtKt3CF957cAAIw
         g0S251ZF5bhEp8XNXrwiIG2/0jkpwqsrGAxqOSTm8h7qu8T/dvjk2MHOVMeF0i5Fm5O+
         /Zlj1CkIgkDFnfh9GtiNbmGJUim50KiFqjlmkl95hg2lMeMRyYlu4tDssANZm1kKAYAN
         F2wHEtp/gNhRIOkwZrgdVZg4+wr1tGIvgXVNWBsWzqDtZFmL4v4PEQ/3RbmotsuO0Qo9
         14xg==
X-Gm-Message-State: AOJu0YwyXIky4xe4FDqeWS0LzGbby+7QDJ8rsn3GkKoGmZ1zc0tJaZvz
	ck/XZ3MN3VvNIrFrQAOwoos588ejFRdkcww21KToCrbfN+TzYlZvGomz6FJIR1Z5
X-Gm-Gg: ASbGncsVLFnrDJRNJvvenC+V/0llHUEI9ivBLE9T437tuXuW3We140bl+1R0Hyu8Ek6
	QHgKaitvxvUA1W4UtJFjTPCCg9bCPsXfPqKt77OHmswaBiS/32HEMv853ylHb6mMMDGFMzqQuhr
	LrDmFqNatyYjhaiJuZq3d/uwCuBobFEoGm4gdNhdf2/r7mldcq6GpsD01itVA+7E1ZBNbYfEqT1
	VsJlYp5bpuQcrPHmrfq2u5RfiNocHJGqM/rv7uaVAOoYTHbizBQUOsEqr0qwYPGmeFXf4LFKMxb
	wYWbOYv2PCh0Zb6SchFHdacv3vaoBanLK+dFmjS+z0lE4PuIMQhxwUmzUgvkk393oQvyt1vGO9C
	UBBj2jKnEhf6gyAW8Dz3QKbYDCytL06LjJs5qy0m3eY4yIuEAt3EnJvSycTp0QtjOixYaou3Os6
	3ezEdf1PV9C2WPNJmy2VXjSVjJokW/KNBO59Gl0MuIIChGUiI=
X-Google-Smtp-Source: AGHT+IHDNwYl89EKqQTm60PGHuS4TJL8QNMZaR3LigR9PH3Bbh2db+bNfRHmziRsBiuMRPKEdoC+rg==
X-Received: by 2002:a05:6a20:6a23:b0:35e:11ff:45c1 with SMTP id adf61e73a8af0-363f5d3538amr898114637.18.1764725177893;
        Tue, 02 Dec 2025 17:26:17 -0800 (PST)
Received: from lenovo-ThinkPad-T480.. ([2405:201:e00e:f828:29c2:d715:dbae:7301])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a4821sm16605819a12.29.2025.12.02.17.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 17:26:17 -0800 (PST)
From: "Swami" <swami310@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com,
	Swami <swami310@gmail.com>
Subject: [PATCH] bitbake-user-manual: Documenting BB_CMDLINE Add documentation for the internal read-only variable :term:'BB_CMDLINE'. Fixes [Yocto #15746] Signed-off-by: Swaminathan K <swami310@gmail.com>
Date: Wed,  3 Dec 2025 06:53:43 +0530
Message-ID: <20251203012343.15709-1-swami310@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 05:09:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18517

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

