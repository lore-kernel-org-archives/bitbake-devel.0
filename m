Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB9D33A0B
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:32:31 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31245.1768465948244108498
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 00:32:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=LmOMYW1k;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OuDoBSPZU5KEVT0mfS3+2Lc9+EL27qb22QaUjAWvjGg=; b=LmOMYW1k1AGb0pySueVfiMKedn
	bWoBRI7snIA5cpRAHkUsMucF46fev8JawNIu5PIXkgAc0MI0V8eLXxCizxydXJ88DfzcPRGIxE8kq
	uz/Aj09xQ1vLpR8PDWzVJ9cgidcMFw+puUyo6QaPPBcQghEh7I0+CD0nIZNPoB9aZsrQ/DJthe8Kj
	rDpR739nQhscRTjAxPzY8JQlV5it424FqdSjR+hSwjRMpqDt+9YRXnRNPQWJM3wt7VSX3+amYET/E
	Tr0Nngh2c3DmWrFsCayiEpZ8LQc9pxjsYmIGftpHbAVOjBMKUZfKOTbpatIVlSOzyrgnF7TKcr24l
	HUP29zqw==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:37840 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vgImI-00000008ec5-3aRD;
	Thu, 15 Jan 2026 03:32:26 -0500
Date: Thu, 15 Jan 2026 03:35:55 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: BBFILE_COLLECTIONS assignment should use "+=", not
 "="
Message-ID: <9b447baa-be7b-7eac-d5f2-bca5cf82a397@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 08:32:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18766


In a layer.conf file, the assignment to BBFILE_COLLECTIONS should use
"+=", not simply "=". Even though this is just meant as an example, it
should still be correct.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index d407f59c0..b624fe8f6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -241,7 +241,7 @@ upstream repository, but with custom modifications that one does not
 want upstream. Here is an example::

   BBFILES = "/stuff/openembedded/*/*.bb /stuff/openembedded.modified/*/*.bb"
-  BBFILE_COLLECTIONS = "upstream local"
+  BBFILE_COLLECTIONS += "upstream local"
   BBFILE_PATTERN_upstream = "^/stuff/openembedded/"
   BBFILE_PATTERN_local = "^/stuff/openembedded.modified/"
   BBFILE_PRIORITY_upstream = "5"

