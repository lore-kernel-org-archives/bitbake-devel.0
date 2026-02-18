Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E634EE9A04D
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 13:15:41 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11587.1771420537257771110
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Feb 2026 05:15:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=h3ZQOkTD;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 55270C23D8E
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C8596074B
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF0FD10368B8A;
	Wed, 18 Feb 2026 14:15:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771420535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EihjeVjz8HLRaZuqRiCvB/nZfjUibujeTDope6pB6VI=;
	b=h3ZQOkTDmV6sWbvoE34pAQpqgzVAe1munIB9N5hfD9Dkh9E/1/uw8QS/cKBvSeR8B7YT0D
	B8nnnHPlglnLEUOqATXUhViy6ods7BVhDLdcOqTpV3UibSh60Hvk3Z0qyqI4YoRuY6NuTJ
	TSOmIsg1idXDgPAYz+Okykdb6xASrfAeRyuGlkh5eZhRQQEcUNDTX7skLc9CHFRIXP5RJl
	c5ax4037fRyMvNsjrWqSur+B4qnLS9ep3eo+SYVji4/QA13AXLWm6mo7RtBq7qnLuJbbE6
	nXGceQA6DLQnS5X75v17LxIFV7j997lcc1NqzNoV6KwPTKlUI+l1bbNtYdgwqw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 18 Feb 2026 14:15:26 +0100
Subject: [PATCH v2 1/4] bitbake-setup: define a color_enabled() helper
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-improve-bbsetup-readability-v2-1-351584e5df9c@bootlin.com>
References: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
In-Reply-To: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=919;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=AYFaZ1u2gByNcSF1OQHT9ZvSOIcpCARVNMv/0nm9k7o=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBplbt0CAC+L1JE4vPr+6Ampc/lAOfM1pgGRLqt2
 ekVPl7HgAyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZW7dAAKCRDRgEFAKaOo
 NuXWEAC9l4pGi5pgkRgkf+Wkr9vibzFCcm/DTBmhcH93lgaYjZyrKiBwzhJUrf82goi0/CKt+4s
 leBzHBA8IJRuE6TDzNXMCqDqUIrpwbtp3ghhsYUdi0nDxjckxJbV5J6EvW9nTcRzRWQQv7JrUhm
 /xuls60Br9PEK4HKgeIQ7VceXe/vuyB1nkvl9HUIrNQQ2zvBZ8gyjA1CqA4tQ2JOdBH/DDxhTI6
 jG0eM2MQGhlkPIVhsiEQVCLJNhP7//Bbe5P+Z3sm1nldmpJrlWq7BboXalLopzgaM3rlkyk9AXj
 FJWRTe5mPkIJDN2HMz2mavN2y/lqE+rmWoushurTIGE9g6m0h5fk8edMbv3MphO0W1ORgfDi2gc
 R92aOUfvp5DVVU0yGsYFbJtOEi+dmjaVxgTXxFJb5B4pjJ38jdckTz8fwOEtfCmhz01+828XuxL
 Oj+AGJKfmpIKrJR4qoSpw/PNVaiOH7suvCVzcBQfN3DwHzFy+OeHFCy1E5/gkrLARiRa03wTTiB
 Q3/UgE5vYPGmdbwnRHMSW+acQ4VQKnxybA2BsouCyrqbgaylTfpjUaPwFgT14GFGijLPrtLfEAN
 +EFOPEwL/PmmnfzgF0SGmAg+Ln4bGaJ6bWQfJZgEF+VwgANWzcFJvHaozfLv4bwwHQQiQk0akTQ
 p4MlfpdiR7dsxeA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19060

This will be re-used in the next commits to force subprocess commands to
color their outputs, as passing --color=auto in them always render
without coloring.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 927c03a1033..3e17e631bfb 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -35,6 +35,13 @@ GLOBAL_ONLY_SETTINGS = (
     "top-dir-name",
 )
 
+def color_enabled() -> bool:
+    """
+    Our logger has a BBLogFormatter formatter which holds whether color is
+    enabled or not. Return this value.
+    """
+    return logger.handlers[0].formatter.color_enabled
+
 # If bitbake is from a release tarball or somewhere like pypi where
 # updates may not be straightforward, prefer to use the git repo as the
 # default registry

-- 
2.52.0


