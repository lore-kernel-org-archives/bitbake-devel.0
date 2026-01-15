Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D86D44C7A
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 16:23:04 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40004.1768494183806937772
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 08:23:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=DOqeiRQh;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rcwLmE4kgatSH6Oe7ZPuxSHDP9azRgTuqy1/X5KEBXw=; b=DOqeiRQhQAvIc8zuIrCwWPoMrs
	KpNGPccaMb4diEph0g+bxV7joZLLFCi0BkkIc8MF1WFlcDKT7xLfO9IcAhelarZbza6A4diOJzUR6
	2wZDz9S6WQt7Jdoyf0dsZac0w3EsprLYeDNgxOaF1zIsrtk+UlC70p0H/SQgIrQ49paTWH/Zfx3ye
	Ke/iadLi/wydEXt7FbC+p4n6bf1ktRB/wO/6r5cwn3tKsznLvJVcE7FVsJ/aV73ft8gFwHuEBpUHC
	MpVCpgPRyryQD32NfDZvWxnmYUNUcQ3trA9OO7+twZIynhgmFKUL7DdYjvSamuzWlk5QtwYafFN/+
	bbNSJhbA==;
Received: from [147.129.179.166] (port=57848 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vgQ7i-00000009tCM-3Yy2;
	Thu, 15 Jan 2026 11:23:02 -0500
Date: Thu, 15 Jan 2026 11:26:32 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: remove problematic '_' in reference that breaks the
 build
Message-ID: <71d0ad79-44f1-9e46-90e1-d0aff599905f@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel10.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel10.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel10.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 16:23:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18786


Delete pesky underscore in :ref:`_ref-bbsetup-source-overrides`

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index fcffab812..1347d7de9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -946,7 +946,7 @@ Fixed source revisions

 :term:`Generic Configuration` can set source revisions in ``rev`` to a tag or a branch.
 Bitbake-setup will make sure the actual revision will match the tag or branch when performing
-initializations or updates, and will capture the revisions in a :ref:`_ref-bbsetup-source-overrides`
+initializations or updates, and will capture the revisions in a :ref:`ref-bbsetup-source-overrides`
 file.

 This file is named ``sources-fixed-revisions.json`` and is available in ``layers/``

