Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF54ECD6D3
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 18:06:38 +0000 (UTC)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25756.1770833191606378143
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 10:06:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=XfvdTC9r;
 spf=pass (domain: 0leil.net, ip: 185.125.25.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fB5wP3KQjzCCt;
	Wed, 11 Feb 2026 19:06:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1770833189;
	bh=DQs3IIDR2kYwh8J9vIm8okx41gD8sElb7HJV3I+CS3g=;
	h=From:Subject:Date:To:Cc:From;
	b=XfvdTC9rJhO1dx+3C8t2HtI97yeuGPsFB/a+uYe52G+STXIJui5SkpOAm5uvrMDOO
	 vRPM93OG+TMFbUHC5oHtuyjOCpEaJbbP5zuRx4yaa3o6/ILUuUsEAK2tgyH7rgeBxl
	 bQyTlNBbFWijBN/0kc7UDFDkmLRpcWRDfOifoMOgu3v7RYhWEvjYVmqQAp1B7LxCRn
	 wV3g0ek4AdQBe4Y3VTxDeYwX86cLSMEloQuEkO1H859IQrqm1TCQL2RTyPunlxwc8S
	 vt0tIfxFCI8SyCdQivPS4JVq4zEZObRUCg3hv3fgVOyuEmJuqOU0ssCu3YvqWhO1qK
	 Z61pGEb9R5qsQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fB5wN1Vjvzg0P;
	Wed, 11 Feb 2026 19:06:28 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH 0/4] doc: bitbake-user-manual-ref-variables: clarify BBMASK
 examples
Date: Wed, 11 Feb 2026 19:06:19 +0100
Message-Id: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDVpSwhXEYuWwfhPB5GIuyuW3
 +K9CxgdIUMeXODwIKZl9lBhAFVn5hYF1d6gpU6kVkpYOxkeBI+GO2SRoslkbJskilPw0eqwofM
 bFuVv3m2P1fZe4L4fbmv9wHIAAAA=
X-Change-ID: 20260211-bbmask-slashes-7ea904bf6347
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 18:06:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19008

Robert reported being confused by the leading slash inconsistencies in
our BBMASK examples and wondered if it had any significance. After
reading the code and testing, it does, so this tries to explain the
difference and why you would want a leading slash in most cases.

It also explains that still with only a leading slash there could be
involuntary matches, which one should be able to get rid of by using
BBFILE_PATTERN from the layer they want to mask recipe or append files
from.

While at it, update the meta-ti example such that it matches what's
currently in the repo (migrated in kirkstone from a single meta-ti git
repo layer to a meta-ti git repo with multiple layers, such as
meta-ti-bsp).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (4):
      doc: bitbake-user-manual-ref-variables: clarify BBMASK directory matching
      doc: bitbake-user-manual-ref-variables: have directory examples be consistent
      doc: bitbake-user-manual-ref-variables: clarify BBMASK matching patterns
      doc: bitbake-user-manual-ref-variables: update BBMASK example with current meta-ti

 .../bitbake-user-manual-ref-variables.rst          | 30 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)
---
base-commit: af9dd012e7f4d16dccd1d6118be5da94ede68f85
change-id: 20260211-bbmask-slashes-7ea904bf6347

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


