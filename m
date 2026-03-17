Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE37FB5EBD
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 10:09:00 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72450.1773742130472701401
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Mar 2026 03:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=HeYOtn7I;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D88594E42649
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:08:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF1F06003C;
	Tue, 17 Mar 2026 10:08:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E072A1045044D;
	Tue, 17 Mar 2026 11:08:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773742128; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ObKiYMGXzfPvo4X/7e1kaXMQ4ot7f1QVtdrt3phofG4=;
	b=HeYOtn7I64aVl/Ae5peri/jOgTHMkKAFOWZ99c1j6k+g6y+h4qLTaRp8sAKYy66nc2d4vh
	3Jqi7RiQWMxFaBUBJGqEpfoMoCA/ds0dfdsne99Koh590D++ZAaXIe0wGbig+Vw4XfZHkf
	9FyMlRK3bcuICYi8tlELWuyL1ZQraXC7IckpzLB2fGCSxbvw1uVfBMmlJefLkk3WKlrOvT
	VlVjRWBFnyGagfeYYmQg/Un11bCqi0f0x7dCMiWzxoBvr+37t70R1sdPslLH4gnjNYq03L
	RQNeVu+QKI8WB25HePymMGZPweWFoKLXn2tAznWM2HWOd97P7sE2CvbaZWHixA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Mar 2026 11:08:38 +0100
Subject: [PATCH 3/5] doc/setversions.py: fix an f-string without
 placeholders
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-docs-releases-json-v1-3-492d0b256349@bootlin.com>
References: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
In-Reply-To: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=dQnOrT832+pQWerwYny4ZFWT9XJRE7QMbZm19hTNOQg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuSgrSwhyqRyiXc6HOoclpwusIW75xWCdP5X0E
 vh0tUClAQaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCabkoKwAKCRDRgEFAKaOo
 Nnz9D/9CTKYjePPaWtHKRWl+vvRaZArz5eeJOdgmMwpe1sm6eVfm8XJkyCldhU6xbXzhAFo1k21
 xdVUHoe+1g1//wFWJVZJjiP1832wNxedWAxy/NyE6xUckwGj90TjkfXqSy0eAtG2H4dAXbFOT5d
 NJWznzuBYrdUGUEC6FU7bGgnZkugMHdKvTYEuVKL82LqqdErwNwWJlYOyDmLdA0xl30D310YycW
 Kv1BpjQXs9FbndXggr3b0MqXeyIiy08L2c1C2graJxhucx/hqyYDLhUBm5RkgdOQq5aOT2wuBSC
 XQC4wwPzp5ayblIqSxYvtUr0sI7uMhu8rS1G+Z5njnURw/6IJIg+DbP+1LKpPqpsKxzVIRoxb7s
 0l2e9BAuroEuYfnoTETqP09UpyoJclAbFoWflh0OIXX7isjRBbsnZILJmHoPE1rTVufFu+2Lik8
 xq4v4xcY0LDQdAl2RZhElk+28cWvdgbGXiAez77g/wR0l9Ip6OSh5Hhf7Qa/Zpj7MgaJ1JATCmY
 XYErm2SCD0pKHjKJ2BCdLSE7KvFi/nAU43e+skMJJoucXBLcbnnq1A6Zgnzf8La1cDzDljBFOyD
 fUe4wqqFymqZ0hNCCIjHTMndqAuDWrYBt++XT5dlltel2geuzF+37IIO/1yY+NVBz5cctKONCsR
 wnYzb+xzi7EQGkg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:09:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19160

This f-string does not have any placeholders. Turn it into a regular
string.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/setversions.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/setversions.py b/doc/setversions.py
index 4130df67695..967a0ba5a64 100755
--- a/doc/setversions.py
+++ b/doc/setversions.py
@@ -107,7 +107,7 @@ def write_switchers_js(js_in, js_out, current_version):
         for line in lines:
             if "VERSIONS_PLACEHOLDER" in line:
                 if current_version != "dev":
-                    w.write(f"    'dev': 'Unstable (dev)',\n")
+                    w.write("    'dev': 'Unstable (dev)',\n")
                 for series in ACTIVERELEASES:
                     w.write(f"    '{series}': '{series} ({YOCTO_MAPPING[series]})',\n")
             else:

-- 
2.53.0


