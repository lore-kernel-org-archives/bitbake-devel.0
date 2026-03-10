Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D85EB1054
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 14:10:48 +0000 (UTC)
Received: from mx-relay16-hz2.antispameurope.com (mx-relay16-hz2.antispameurope.com [83.246.65.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40220.1773150063632357663
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Mar 2026 06:41:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=softfail (domain: ew.tq-group.com, ip: 83.246.65.158, mailfrom: prvs=05227c41ac=alexander.feilke@ew.tq-group.com)
ARC-Authentication-Results: i=1; mx-gate16-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=fail header.from=ew.tq-group.com orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=3odScZoSkzXUrOSa0ukpuddkvzi81Dp/0OwtRznWeU4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1773149824;
 b=K2xNILNefDaKGuQ190809uGlGPHy8vq/tHABpS73xQ1boBZH2qZ83NFlWF25ECwVY1yX94Yc
 UtQ7k9HP0Prxhs0nnS99CC4rvP+e/y7gKWADb/d9gWPy0iMe9lBWWucjr6euEeo++eMtFkoC9rb
 DXScDZroLgHeKnHBUr/t+84SoeD0Hys0zD/qvF0OIhDO7ZeRNXL9J+k4fBCv86WKG/QXPLF4/9O
 2NbjKf6VeWVvMkpCbpyH9l9vBAHkPLN4O/V9d6iikK8x02eDt5Qp06sK8vGD9mgPYOrHjPGqee2
 LcQLz8oiumPIq+vP9+r0+ihZnm/zANBDLldA4bgMbyLDg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1773149824;
 b=fl0/Zt1hpBvC8Cpw3K6kGVaqsVGs4R40nfSnjVDFghUpM/3T8oeoV85KbnE2/sH4b0X0t/OS
 UdOkrGf8HeOMduw/2qUxQ4Mksth6GuYlJ+KMkWBQlhYveeQbhSo9uHEsi/aY48Fv8iU66iQvP+U
 ta4+foBPZdNr5Ok80D5U+NfIifc6zI9uYpDUVIc9JK+2wXIZpdGN4sDAsgo4Of7oM1AwTkeePS8
 C8TJnqm8C/cBUCVrRRbhabJo0quz35fup6DSMmiygKQdxo8J6lzHGRvyEyAIjG9h5M/6NX2IuYF
 XeNXAwOhlhyUFlE1G1tcGQO7im5W+udJvOuLfozeso//Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay16-hz2.antispameurope.com;
 Tue, 10 Mar 2026 14:37:04 +0100
Received: from FEILKEA-LNX-W.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.feilke@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 0F352A41032;
	Tue, 10 Mar 2026 14:37:01 +0100 (CET)
From: alexander.feilke@ew.tq-group.com
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Subject: [PATCH 0/1] Backport to 2.8: fetch2: don't try to preserve all
Date: Tue, 10 Mar 2026 14:35:37 +0100
Message-ID: <20260310133540.874469-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: bitbake-devel@lists.openembedded.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay16-hz2.antispameurope.com with 4fVZg12t9nz29dP1
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest: 6cf02520ab81d0e609784201d8c17206
X-cloud-security: scantime:1.293
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Mar 2026 14:10:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19141

This patch would be nice to have in version 2.8 as it wasn't backported yet

Ross Burton (1):
  fetch2: don't try to preserve all attributes when unpacking files

 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


