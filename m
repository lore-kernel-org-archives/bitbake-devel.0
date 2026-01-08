Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1947D185DC
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 22:08:34 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18727.1767910112950791167
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 14:08:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=Ta5a+5tJ;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iboHvAWAHU24SHmzGmnp2cycJhy2VDbiNGJcw0TizHo=; b=Ta5a+5tJizQ7FoJVNnc081K8qx
	ERs7TQYbSyYRNSIVq2UFYzXHXJx7S03aAEBjO6/CLJf+Ewh7IcdQ9w5QwBRFjNqMNssIEm+HsSJpQ
	nO1fa51iNwdeG8i73JJujsS/cXg3p3UWm5ymwPVxYBrlgFdgympm8fDl9JLV7t8MzNHGiBohNmN1q
	2QgTYHIz/PIDPCqFOsne1gDY9Mc3A6XedAhI8dv+0fJz7doMl30JG89/5nDQ+NSwap2LkB5BWWHXM
	Ou0VbhrszZEA7aTHhCOUP02B6A7MUclnR6Sx3NRdrI9805Bnmj2fgHB0HCEVn168Jwq+E/4q/noiT
	2jY7xvOQ==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:41982 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vdyB9-00000002v6g-4A1l;
	Thu, 08 Jan 2026 17:08:31 -0500
Date: Thu, 8 Jan 2026 17:11:35 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
cc: YP docs mailing list <docs@lists.yoctoproject.org>
Subject: [PATCH] doc: bitbake ch 2: use example of nginx to explain
 DEFAULT_PREFERENCE
Message-ID: <5113f81f-1b33-a4ac-f71d-432caf8e709a@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 22:08:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18716


At the moment, the section on explaining DEFAULT_PREFERENCE uses an
example of busybox, which does not even use this feature anymore.
Replace this with an example using "nginx", which does.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index d407f59c0..1638a8f5c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -337,21 +337,22 @@ file that BitBake parses, you can change that preference::

 .. note::

-   It is common for a recipe to provide two versions -- a stable,
-   numbered (and preferred) version, and a version that is automatically
-   checked out from a source code repository that is considered more
-   "bleeding edge" but can be selected only explicitly.
-
-   For example, in the OpenEmbedded codebase, there is a standard,
-   versioned recipe file for BusyBox, ``busybox_1.22.1.bb``, but there
-   is also a Git-based version, ``busybox_git.bb``, which explicitly
-   contains the line ::
-
-     DEFAULT_PREFERENCE = "-1"
-
-   to ensure that the
-   numbered, stable version is always preferred unless the developer
-   selects otherwise.
+   It is not uncommon for a given recipe to provide more than one
+   version -- a stable (and preferred) version that should be selected
+   by default, and a newer, development or "bleeding edge" version that
+   will be selected only explicitly by the developer.
+
+   For example, at the moment, in the OpenEmbedded codebase, there are
+   two versions of the ``nginx`` webserver: a stable "1.28.0" version
+   that would be selected by default, and a newer "1.29.1" development
+   version that a developer would need to choose explicitly.
+
+   This can be seen based on this snippet from the ``nginx`` 1.29.1
+   recipe file::
+
+      # 1.28.x branch is the current stable branch, the recommended default
+      # 1.29.x is the current mainline branches containing all new features
+      DEFAULT_PREFERENCE = "-1"

 .. _bb-bitbake-dependencies:


