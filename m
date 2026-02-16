Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DCBE7BD95
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 10:36:41 +0000 (UTC)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17103.1771238198611473741
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 02:36:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=j30n8CB2;
 spf=pass (domain: 0leil.net, ip: 185.125.25.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fDzj00ckbzf6s;
	Mon, 16 Feb 2026 11:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771238195;
	bh=yIQJBCIRKTIZcL8e2n+pj8BDhpHIznwDY5fN05sgWHo=;
	h=From:Subject:Date:To:Cc:From;
	b=j30n8CB2XqMqQMUDMe9DzhBXicc3Z+yE9rbHXGsbsiSpRSM/FbrzX4z3+Vsr5G5yb
	 K1arLZj1VVZRkn/7hhfbAQ5Y1yapUY878g/JYTJLfyPb3WrX/sG/gxjY7Fg4SlNWUJ
	 raDUXnLZi17+tzr2L7y5pffj1ScvMTsU3sGPogc0tC3e0G1E63oT5X0qwtM8M2bkCM
	 m0lLOWr+IEJ0HmeRjJkF16uSYv68PrjwK2EgB1pzqq8VB57CinBEoOb2x7g6vdXkm1
	 S1iHGwU2BbGHgtS6RNQcwBqTC016Cof0z+tucLgGFWM101Me6gGZkt7I1mT6rfpdm5
	 tzJIJQmcDlAqA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fDzhz0phhzMM8;
	Mon, 16 Feb 2026 11:36:34 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH v2 0/5] doc: bitbake-user-manual-ref-variables: clarify
 BBMASK examples
Date: Mon, 16 Feb 2026 11:36:21 +0100
Message-Id: <20260216-bbmask-slashes-v2-0-b9bb52f5fd3d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw7CIBBFf6WZtRjABqIr/8N0AXQQfLSGqcSm4
 d8tde3yJOeeuwBhikhwahZImCPFcVhB7hpwwQxXZLFfGSSXikshmLVPQ3dGD0MBiWk0R95arw6
 thnX0SujjZwteuh/T297QTbVSjRBpGtO8PWZRvb/xLBhnVkuhhFOtRn92AVOa9z1CV0r5Ajcp8
 W++AAAA
X-Change-ID: 20260211-bbmask-slashes-7ea904bf6347
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 10:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19036

Robert reported being confused by the leading slash inconsistencies in
our BBMASK examples and wondered if it had any significance. Myself not
being less confused, I went reading the code and testing, and it does
have significance, so this tries to explain the difference and why you
would want a leading slash in most cases.

It also explains that still with only a leading slash there could be
involuntary matches, which one should be able to get rid of by using
BBFILE_PATTERN from the layer they want to mask recipe or append files
from.

While at it, update the meta-ti example such that it matches what's
currently in the repo (migrated in kirkstone from a single meta-ti git
repo layer to a meta-ti git repo with multiple layers, such as
meta-ti-bsp).

This reorganizes examples such that the ones with BBFILE_PATTERN are the
ones we provide as first examples as those are the ones users should
typically be using such that the masks only apply to a specific layer.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- added patch 5,
- completely reorganize patch 3 such that the examples with
  BBFILE_PATTERN are the ones provided by default,
- Link to v1: https://patch.msgid.link/20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de

---
Quentin Schulz (5):
      doc: bitbake-user-manual-ref-variables: clarify BBMASK directory matching
      doc: bitbake-user-manual-ref-variables: have directory examples be consistent
      doc: bitbake-user-manual-ref-variables: expand and reorganize BBMASK explanations
      doc: bitbake-user-manual-ref-variables: update BBMASK example with current meta-ti
      doc: bitbake-user-manual-ref-variables: update Python re doc link to HTTPS

 .../bitbake-user-manual-ref-variables.rst          | 91 +++++++++++++++++++---
 1 file changed, 80 insertions(+), 11 deletions(-)
---
base-commit: 8b635a400152bb40beaa0d7a47181febb43f5c84
change-id: 20260211-bbmask-slashes-7ea904bf6347

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


