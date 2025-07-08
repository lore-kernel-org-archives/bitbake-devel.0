Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D536C83F0F
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 11:29:43 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.web10.16144.1751974180729274237
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 04:29:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=hlw/1lxL;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5UtyqZuvpz+YkTTspfEcExnbojmDsQw9kqwvoMXWBAc=; b=hlw/1lxLINmaJQBYdO0StQwhSi
	ylnokOZf0lrSEghuBj/Kv/RrBtKvFWRIcyD3q++95jeSLJvwzwHaEk+BTqyxJE54v3b33u6Cm+eX7
	Bx8AhH3DxwQHMqTsK8WNINADwOag0JhIXxHq+l0wIe0YCk9qt/MYm2MeWXOSCV0mos3MU0vuLPoZv
	dvKfC2+X+nRn9X+3rZwAkwrDkRe24StPq8bQhmyqWvVUIQN5oSIKWggzZbbm/nx2ovROvCj9jyedM
	ckn48nGrvoxu1Ir2qUb/TP7/+AHVihAZ8UUYKTo6rn4076Ud0G+Agl6qBK6XCKeNLVW7vaF7i4cbS
	TBz9l8mQ==;
Received: from pool-174-114-102-5.cpe.net.cable.rogers.com ([174.114.102.5]:50150 helo=asus)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1uZ6W1-00000006yHs-27DW;
	Tue, 08 Jul 2025 07:29:39 -0400
Date: Tue, 8 Jul 2025 07:29:33 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] Mention existence of three supported "classes" directories
Message-ID: <7f7b0bf4-2fdf-d216-6488-7576a79b19ed@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 11:29:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17754


Early in Section 1, mention that BitBake supports three related
classes directories.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  I'm not thrilled with this explanation in terms of where it is, but
it's better than not explaining this at all.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 539bb62d8..feab1df9d 100644
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
+   will automatically search all three directories for a selectd class
+   file.
+
+   This means that, in this documentation, when you see a reference to
+   class files being in the ``classes`` directory, you can interpret that
+   as meaning in any one of the above three directories.
+
 Layers
 ------


