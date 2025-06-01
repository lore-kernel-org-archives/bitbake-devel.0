Return-Path: <robbinvandamme@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A0BC5B549
	for <webhook@archiver.kernel.org>; Sun,  1 Jun 2025 20:15:20 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.34780.1748808910713745615
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Jun 2025 13:15:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VpOGmMl2;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: robbinvandamme@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4f78ebec8so1418935f8f.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 01 Jun 2025 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748808909; x=1749413709; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkH8PH8UKEbHgvivP2tp2tiV9CCdRbn16G8hGBuf94E=;
        b=VpOGmMl2VlEBRW9xe4i5286nJ7DD/yf7URG4n1J/ue20RR7V9FfFhsyC2pwAqRB1Ej
         KDRAdWfroMu+VeJR3n+/Tg7r7gzqhxQgeiHM3SdE/4OlxV4PPFdbIGu4QPrtJmRHotoK
         oXesfN1sV+hmbcGwrC5uuowFYHrC0Tj2SLy2tMQ97IomAeFHFNrwtz1C4HNdaVoWiicZ
         nbeH77Q4rf5B5whZIYxmUEx0oXZYHzzHlAaefHuFCnN06GI5PclYd2bYuL/slplntHs2
         YM80mExsW/CEcB4Jw3wnVWvo5bsRZidsbnDtHtiyOnhQ+enrcWXdIPykqg3YE6tUiRBX
         VEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748808909; x=1749413709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkH8PH8UKEbHgvivP2tp2tiV9CCdRbn16G8hGBuf94E=;
        b=Q8iHYmV822TlK2N+4El6vfoIVTQ2BQknWowBtrlhk4KL3BEmQdSWdxmvSLqHWr88xo
         1wujH7kVO9Cqqw7WAo9i/8KDezQT5cz5AP696IngUsVyG5SegHw7kwQFuRzql6na4AAI
         +5MDKR5dBJrM8nRBb3+J2I75u538jtp8yzlSHFhQ6eDUa5BdpmucmdAjEmn3SPrx22/j
         XzjJ7U+YbNV42AW0k23BmoSeS806X0/2udNMFFD+PpOvq8+ptxPdKZX7KhKdTMnG37eR
         GHqPSvqEiJWORXzEwN+ZicKrvQUsveDSe1pebDQM3dbIQuN+Mr7xRyEtzPdWgwnZ10eG
         H3Mw==
X-Gm-Message-State: AOJu0YwwtZ2tafrHgz4jKgrVqiFEu841wioxWtQNr0rjVDKIH0RQsF76
	WLNCEPzCCA3hrrxKr0dHRRRElMK2BToPYmoqefp27ZcBAEt4BK0FqRhgI8bgdw==
X-Gm-Gg: ASbGnctQo6qweoaL/XUfSRdx3WOkDjDkil0aZ47XaQoR79S5s02XDieOxEA8lB5V/00
	ad3LVjDniI94cYwwj2XSbvXSztvcc0LjvmJWCatni3W/JuZbFl6zVzW+QZBcXRsnUGvzgs8GrIz
	ljs1b3yehlWQoQHYmdMQnM/Rc1RJwA66j+prmd2a8fCqbp1YgvR/r6Y0Xaam89boyIRakQrEQ3E
	clifyT72LzszFQ3fJ+h6X9xfcLsrWqn0/w5DFr8YvsLYFMbxfSdxJKQ2sW+FbVxfagzITfaniTJ
	axWRofiLJLb5wXBddutdaucTwNiQjv/FmxsKWKhd54IutYS3/fRd7WvdEikKeoAorXCcqBMcPoN
	j0pRbjLWuI5vGpR1fDjQDoVTUzUhFYzbzpuQQeA==
X-Google-Smtp-Source: AGHT+IGhYf2X/4vtYLolHGhDt4106zZlpIwiWevgY58Xivqey5NYlCHTbbZ4iPSjsHUYZEFP9W/tlA==
X-Received: by 2002:a05:6000:2289:b0:3a4:e8bc:5aa with SMTP id ffacd0b85a97d-3a4f89a5bc2mr7872598f8f.11.1748808908853;
        Sun, 01 Jun 2025 13:15:08 -0700 (PDT)
Received: from PC-G502T14.localdomain (78-20-31-164.access.telenet.be. [78.20.31.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c8b4sm12689749f8f.36.2025.06.01.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 13:15:08 -0700 (PDT)
From: Robbin Van Damme <robbinvandamme@gmail.com>
X-Google-Original-From: Robbin Van Damme <robbin.vandamme@renson.be>
To: bitbake-devel@lists.openembedded.org
Cc: Robbin Van Damme <robbinvandamme@gmail.com>
Subject: [PATCH v3] Update documentation and add extra check for az fetcher. AZ_SAS token should be prefixed with a question mark.
Date: Sun,  1 Jun 2025 22:15:05 +0200
Message-ID: <20250601201505.177262-1-robbin.vandamme@renson.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 01 Jun 2025 20:15:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17665

From: Robbin Van Damme <robbinvandamme@gmail.com>

Signed-off-by: Robbin Van Damme <robbinvandamme@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 lib/bb/fetch2/az.py                                      | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index fb4f0a23d..eac3cbdfb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -686,9 +686,9 @@ Such functionality is set by the variable:
    delegate access to resources, if this variable is set, the Az Fetcher will
    use it when fetching artifacts from the cloud.
 
-You can specify the AZ_SAS variable as shown below::
+You can specify the AZ_SAS variable prefixed with a ? as shown below::
 
-   AZ_SAS = "se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>"
+   AZ_SAS = "?se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>"
 
 Here is an example URL::
 
diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
index 346124a8b..1d3664f21 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch2/az.py
@@ -36,6 +36,8 @@ class Az(Wget):
 
         az_sas = d.getVar('AZ_SAS')
         if az_sas and az_sas not in ud.url:
+            if not az_sas.startswith('?'):
+                raise FetchError("When using AZ_SAS, it must start with a '?' character to mark the start of the query-parameters.")
             ud.url += az_sas
 
         return Wget.checkstatus(self, fetch, ud, d, try_again)
@@ -62,6 +64,8 @@ class Az(Wget):
         az_sas = d.getVar('AZ_SAS')
 
         if az_sas:
+            if not az_sas.startswith('?'):
+                raise FetchError("When using AZ_SAS, it must start with a '?' character to mark the start of the query-parameters.")
             azuri = '%s%s%s%s' % ('https://', ud.host, ud.path, az_sas)
         else:
             azuri = '%s%s%s' % ('https://', ud.host, ud.path)
-- 
2.43.0


