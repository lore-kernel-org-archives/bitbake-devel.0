Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2DCCE7AB1
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:07:58 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15590.1763118471265269971
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 03:07:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=BB2fR+3K;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8E6F8C10F61
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5EE7B6060E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D066D10371C4F;
	Fri, 14 Nov 2025 12:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763118469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6qrH5V/xZ+ei9JYsuouySUsbWPE5Q7atjAKjVTOUjBA=;
	b=BB2fR+3KOMMwpp4XAcctMi7LXX8OT53fIj600/MFlX8g9UaTa0VhQaKG00psZ4ntZam3qS
	nu+PPtfTAnaDUMy6ywidrWyfdmQyEmKKE0QhKaG2Q/vgBernhuL/v7KB7QgvKTomvQiZlN
	dAsA12CRb0vlXFQSq8WZImu6VOWuBtkqs6ZBt5D8wyLZ/0UNN71d7HLWTj/aSgSVTpO/V+
	EB/3DdNQzALFAzm5vfwhVF95CyRZMyGk3dHTexKokmbcxDSisikWB3QNphZB2KCdBm599m
	e1/jrJW6Ng9J0c54pA3TZFq4kM/gZIFCZ5XIqHxMdlmhTPKnOl2ugtHPGjV61A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Nov 2025 12:07:32 +0100
Subject: [PATCH 1/3] bitbake-setup: fix top_dir creation in create_siteconf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-bitbake-setup-abort-v1-1-d2f9967df3b1@bootlin.com>
References: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8BjhQyAiRWPDh/MyUGfHyM+dGSQ3+JXA/Bx4/WEXWJE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpFw2CTa7NWACQ/E1RgJ/WWTlwIVNns7bMIV8U3
 3buz4RxkXCJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRcNggAKCRDRgEFAKaOo
 NnuzD/9seWgF35sDe+LM977mwZnEhU5qfyJGG4sQwchpp+TVRIxJO/kAp9hM4z+u503ZCdRnjHi
 j1KVoWdgClQDvsbJlHwcUNEqsPk2sPMJsMTJuqijj3II+zqpKsYQgvAmvAGfAOJh5IlxntOpG0V
 JBZE0tGvqH5xpWZ310m/GBtg0Rx60GRb8N7EnTFnZiWkzc37qrIi35KBXAV+TwdDAWywVXwASYS
 2Jk143aM4x4qoQlnibVN+BuOLPbpqKHvgqZBM7cTNSruZUJFnYaDrbpLN8NLLLbD1OxpQeQAQJX
 ARTT7IhzZ7bbDpqKd+4jN94nwhDWhML8Vs2u+dd4LIG5QZillGJCNxN0lWGA3NsmzjKV0jqOZvh
 h5TQUWVjzeCZNcWj0JSHfp2qQ0nv9VR12HHgApUqVs0+u0Reg6bIWWJ2a93q5vtH/O8GV6/qMlp
 bY0Q6T7Nk9zicBUeUT05bobabsqg6H39VFa2lYR4+biByGexxvpwmxQwX+T7HbJQuVzdy1RPIDs
 RrkDbNu2TvufNxZ/C8qfN2c54cN/NXWur0LdFjr013zgr5acXA39htwrmDN1DSTEoI5/hSYsNAU
 ud/3u7u0t6/o/Sd84KHaVrWZBGkTrVO7wHPvOhTa5/KUYVW2KosQVVJiqH3P6vCB4o1ArwodzBY
 gkovpGVvpGnyQCw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18389

The intent of the create_siteconf() is to create the site.conf file
common to all setups. For this it needs the top directory to be created.
Create the top directory instead of its parent.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 5bbe3c0fce..6410504d4f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -677,7 +677,7 @@ def create_siteconf(top_dir, non_interactive, settings):
             if y_or_n != 'y':
                 exit()
 
-        os.makedirs(os.path.dirname(top_dir), exist_ok=True)
+        os.makedirs(top_dir, exist_ok=True)
         with open(siteconfpath, 'w') as siteconffile:
             siteconffile.write(
                 textwrap.dedent(

-- 
2.51.0


