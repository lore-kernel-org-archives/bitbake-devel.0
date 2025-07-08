Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C78AC83F0A
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 11:33:43 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.web10.16210.1751974417458042552
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 04:33:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=MGUmRaCb;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5fAdYsPjNfw1rwaipFfoyXPHAVdzfWh0D0EBBeHnr2A=; b=MGUmRaCbPbb1A38XcaO/e3Uajh
	VOq9OAf7FK0G40BMUE+xpSH6kSFqBGbDcd6K09ixgG3P7g4QXXaUfKk8w/jB8l3PQ6/7deUVouqo6
	lQL0undWn0juLY26BFMEEal4zYrCxjeJ425QSO6a6FplpYKWpfUuJdB2ZdMMO24pfImLjY0G1oT9M
	cKTaKwpk22z16WEytkpHVu8ZmTurGfkTTD1IGSiOJL+s/fgPl78aYhQE2nqbgT0TGBWItm81y2aDC
	J4surRwVPHT04VaKvN/fNHswCgQPQpLhXx4runo9pKSiTwW0OqaHtiYmTiHt8lhtOVZCOWq5W4XJZ
	fmogWznA==;
Received: from pool-174-114-102-5.cpe.net.cable.rogers.com ([174.114.102.5]:34668 helo=asus)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1uZ6Zq-00000006ynf-1V9N;
	Tue, 08 Jul 2025 07:33:35 -0400
Date: Tue, 8 Jul 2025 07:33:29 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2] Mention existence of three supported "classes"
 directories
Message-ID: <c5f80e07-16fe-d9fa-b3e5-a8a6b1506278@crashcourse.ca>
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
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 11:33:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17755


Early in Section 1, mention that BitBake supports three related
classes directories.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  fix typo in first submission

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 539bb62d8..d25f07ff9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -206,6 +206,18 @@ installing (empty by default) and packaging (empty by default). These
 tasks are often overridden or extended by other classes added during the
 project development process.

+.. note::
+
+   While BitBake comes with just the one ``base.bbclass`` file in the
+   ``classes`` directory, it supports class files also being installed
+   in related directories ``classes-global`` and ``classes-recipe`` and
+   will automatically search all three directories for a selected class
+   file.
+
+   This means that, in this documentation, when you see a reference to
+   class files being in the ``classes`` directory, you can interpret that
+   as meaning in any one of the above three directories.
+
 Layers
 ------


