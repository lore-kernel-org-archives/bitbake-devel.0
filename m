Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC23ECAAD7
	for <webhook@archiver.kernel.org>; Fri, 26 Aug 2022 08:41:14 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by mx.groups.io with SMTP id smtpd.web11.34816.1661503266503976885
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Aug 2022 01:41:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=Z5DWjmAJ;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.25, mailfrom: pavel@zhukoff.net)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B0DF35C0134;
	Fri, 26 Aug 2022 04:41:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 26 Aug 2022 04:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1661503265; x=1661589665; bh=vKZl7wlpof4Bl/RybLmnOPx8i
	j5HpqGDpuhTkb3I4oA=; b=Z5DWjmAJEYVrNdePznGpAOUrAfDo2h1zQSElLRHR5
	EN0c8it5fpmQtsQyKPxup0JeESTgZEHb6Ts4HOBxHCLSkpoHV404/DYseAABLjEj
	etG4OUF+TkZzBuxNmtqWEC/nXkN4Xp1mAacxrveGlDemv5CiJ2GRgD+RA1Wjl4oz
	hCwRUsafgsgRhZ/mp7fE7Z6ncAVCN07C0BAGB91jYmBtEnR9DAMJ9AuIQhxLqVxX
	Q/XZW2dLZRSNSgFDte3v25PN+ki9Miv8V8VI79koT9eIeeENrfDcSFekfuz+oKXV
	xNK82yreiaQCxHNLC5uXx7fTl4kq0f1Jn2Ad7tAUZ1wtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1661503265; x=1661589665; bh=vKZl7wlpof4Bl/RybLmnOPx8ij5HpqGDpuh
	Tkb3I4oA=; b=GjgE3HzJHgbRpILf022BPoGx4sSdaXatyOl+v3lMI+mqh+NRfMC
	hQExb9BGKOzpzf+p7moooPrgK+ClJS5stQDpXJfDTyFtQqs+NtAQtxsgNdeMnAgO
	w512e5I6diDjVZBGrgEeOKl0xIGqLhydzeJ7diCvOuftIbw2LkjnFMPeiIfSFnqT
	NgVFPY1TmtpgxOmkxNBNicT+6kRfY84tfVFQylPHUP2mvcw1o6UPx/D6iATxB5WG
	LKJxAnlzfdfFwYVi/OyjZZBqc6bRT0G0mX2L8s7RuFP8jbN2DrY9kMxY/ba+dp0c
	fcJfwlvjWQ3mLjJo93sIgQy/i4vDpJzEzcg==
X-ME-Sender: <xms:IYcIYxnE3xCDwe2nSwPTe8Yiq7JwN-JVF6tymEe1Pr6eExRwtqVdxg>
    <xme:IYcIY80Qd_ab9koQIl48XTY48VQ1VfRm1pha_1gJQK3ELGRV0RpHOtE8WuD6FBmfI
    KnOncuJMRcQ10_3GzY>
X-ME-Received: 
 <xmr:IYcIY3qtJiRJrVHyZCduKowovbJPrQDC-a694zrHI2eFkaVtlAUmaLwcEbJ5Hbafa0TiwO1_yUA6AJBxYx-iTbg>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefrrghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhukhho
    fhhfrdhnvghtqeenucggtffrrghtthgvrhhnpeevfeejkeejudegledtkeejhfettdefje
    euffehieekvddugfdtffffledvvdefhfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:IYcIYxnlriED3xtEDS3Hkz-YfNYVpzX7nCZgOo1dnZa3xvcSA9fHPQ>
    <xmx:IYcIY_3Fm5ZRn8m2tQAzlP-LmQ1QA9P_55J66odQCRwAtXcnKSDhPg>
    <xmx:IYcIYws3V4BRCe1SyebW9poPgxR4G_hC_KlgrQxXIFXxQby_fKmwSA>
    <xmx:IYcIY88_qq9ppE7p4H01oaZd4sAHEKpPQuOUSNEWu283MbWIgZ-zMQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 04:41:04 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH 1/3] gitsm: Error out if submodule refers to parent repo
Date: Fri, 26 Aug 2022 10:40:29 +0200
Message-Id: <20220826084031.11919-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Aug 2022 08:41:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13934

If submodule refers to specific revision of the parent repository it
causes deadlock in bitbake locking mechanism (lock is acquired to fetch
the parent and cannot be released before all submodules are fetched).
raise FetchError in such situation to prevent deadlocking.

[Yocto 14045]

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 lib/bb/fetch2/gitsm.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c1950e48..25d5db0e 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -115,6 +115,9 @@ class GitSM(Git):
                     # This has to be a file reference
                     proto = "file"
                     url = "gitsm://" + uris[module]
+            if "{}{}".format(ud.host, ud.path) in url:
+                raise bb.fetch2.FetchError("Submodule refers to the parent repository. This will cause deadlock situation in current version of Bitbake." \
+                                           "Consider using git fetcher instead.")
 
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
-- 
2.35.1


