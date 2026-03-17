Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD09FD7061
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 10:09:00 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72453.1773742134468932442
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Mar 2026 03:08:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=aueYV5GB;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 15FF4C55055
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:09:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0DDCE5FC9A;
	Tue, 17 Mar 2026 10:08:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 395F51045044E;
	Tue, 17 Mar 2026 11:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773742126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4bhjxJfYr/aYs0FwhIh33DLkeEokScSlFrQbI4IlKkU=;
	b=aueYV5GBJ7WmZPGQa4dTap3SldH5GRG0TXZvC74Utgej/2fRnSEbon+6UHYIDOId1TOl55
	J1xW6cCMzXpDlt/HvcF/CTrPZsSdMVAJrXdN4T/7iETSumFmboUmS4jsOpjcHrqNe05ZbU
	rYKcQSnXDge23W/LUsvmBbpXAr+5vzdmFy4Hn8MaVQEpfXm1ac295Z1yyXbD3pCIyl6be2
	nbhD1DZSBDkMGMMBWlSyDn2CdR5D+lUjcDH/EEsMKThSjBZ02w98kqP7cc0qVOhVMQVLxe
	SWzAaG1dScEAIEhhObb/2imQD5MLJs6za0TLuHdZtMs4e7BeUpsfmRHTHHuJrA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Mar 2026 11:08:36 +0100
Subject: [PATCH 1/5] doc: move the Git repo check to the conf.py file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-docs-releases-json-v1-1-492d0b256349@bootlin.com>
References: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
In-Reply-To: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=FHYmFPUZgMCWrYhvzc9Onprgp/Dog47NjKb0itlRpQA=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuSgqpOP5xwL/9aM3fkPbVl65niN6H3OKqXw6i
 l/eDRs7bT+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCabkoKgAKCRDRgEFAKaOo
 NgGFEACqR8bLn27z2bjcO+zcp/1CaY6YUUdtKW8PmUVs+Htdg5/DBqf1Ui07X8++QOs8oF7AnSo
 ffDqauQExkDlBVzqqHVZCG/62z8tQVTt/UJm0FbquKpMn1gICl8Im5zmkzkyIyA2JBCa3q9VKxA
 k4xvu9hkjmE6HU12uZGtrh5H+K6jPoU+3g4xnisD3MTg1z0oMZgxmjJha2WZ6ec0iH1rjq8Kixh
 ngviwy8EjFmmsYv4f8vveQNbaQLdtqkOkIfxXOPmeDERUYBeaNLMVYKEQQvrhFgEgmNvH6gpJtW
 NZ15Bo/iM9LJ2ZfhfMsDqnB4LGPwmj2jV8h+tZ0M4J+kPQQMs1FhRPtyGI7YiFCKntQnFCveyB0
 kzr7+d/pbpj2wur+UoeneeHYbFhwBXxnZdzxUf2hEtITltADMy2F86IgjzRbCPd3en7yod5uYW8
 dgkfXODXICien/WXCs5/fp9cQKze01ZFLRYYngvuGr7exV6V+UEuFT7obE21Aqu6mglA9fqqN0t
 MiJ/3HRCUTb/mFWW2qEzCZcJm1o6FiaIkPiO4VRv+NHNUnGaXvemRIv1+OjwNAa5L6p4w7+T14m
 uCIhqw/i5UjuwSH8c6iOW/sKwbz6gwtz1BPduotXfsxQKNDGcU+wDTJKOnuRzM/PnRcYp0wiyNW
 7VgM+k81vC85lUg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:09:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19162

This check can be done earlier when building the documentation, and does
not need any version information. Move it to the beginning of conf.py.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/conf.py        | 10 ++++++++++
 doc/setversions.py |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 9318358731c..40a022eaa00 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -8,10 +8,20 @@
 
 import datetime
 import os
+import subprocess
 import sys
 
 from pathlib import Path
 
+# Test that we are building from a Git repository
+try:
+    subprocess.run(["git", "rev-parse", "--is-inside-work-tree"],
+                   stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
+except subprocess.CalledProcessError:
+    sys.exit("Building bitbake's documentation must be done from its Git repository.\n"
+             "Clone the repository with the following command:\n"
+             "git clone https://git.openembedded.org/bitbake ")
+
 sys.path.insert(0, os.path.abspath('.'))
 import setversions
 
diff --git a/doc/setversions.py b/doc/setversions.py
index 9e4138025ac..2ec68ac9945 100755
--- a/doc/setversions.py
+++ b/doc/setversions.py
@@ -43,15 +43,6 @@ BB_RELEASE_TAG_RE = re.compile(r"^[0-9]+\.[0-9]+\.[0-9]+$")
 def get_current_version():
     ourversion = None
 
-    # Test that we are building from a Git repository
-    try:
-        subprocess.run(["git", "rev-parse", "--is-inside-work-tree"],
-                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
-    except subprocess.CalledProcessError:
-        sys.exit("Building bitbake's documentation must be done from its Git repository.\n"
-                 "Clone the repository with the following command:\n"
-                 "git clone https://git.openembedded.org/bitbake ")
-
     # Test tags exist and inform the user to fetch if not
     try:
         subprocess.run(["git", "show", f"{LTSSERIES[0]}.0"],

-- 
2.53.0


