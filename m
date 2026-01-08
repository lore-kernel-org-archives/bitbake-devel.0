Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E8DD1D483
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 16:25:23 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10299.1767889521545286870
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 08:25:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=UsNLIu3Z;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EY6vQvKdyUZiivRkLLrulowXoXl87ITmU+0j+LoL5b8=; b=UsNLIu3Zy11LWSY1anoJGAURRS
	9Bgs1NM7NdG5/6WYybSFpis9aVKby9bRZN6LrET+j8CGFKk/qL0Xgen54QgvYJq0YprzSjs/S9Eo0
	9XKvwruG/ViGcnCFN92NXsqbjScrLEBN31+mi7KHyomLArzhXC/wPMaFflyrk9x/sXadaLkjB8gPg
	Qhs0pJpeSBevK1Hemiy+4tdDs+p2hdc9Ikd1UsNgWC46qdrUsfbOS7olOwlCeqmZts24fKsAgUPgD
	nIumTDVO1oqf38regKBbGlEnYi9J1oUCP9LoFpqoXhqS/xn/ok8PZeYHVCEOwtbG1pWpfIW85l3te
	Df0lMfrw==;
Received: from [147.129.179.166] (port=46840 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vdsp5-0000000232P-2GS2;
	Thu, 08 Jan 2026 11:25:19 -0500
Date: Thu, 8 Jan 2026 11:28:26 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: use monospaced font for visual clarity of options
Message-ID: <569a2da6-6603-5c64-bf27-da55484a7966@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 16:25:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18714


Use monospaced font for command options, to make it clear when double
dashes are being used.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  since i saw an example of this being done in the same chapter
of the bitbake manual without quotes, i chose to do it that way.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 329b02829..4e70eaf9d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -538,7 +538,7 @@ The following command runs the clean task on the ``foo.bb`` recipe file::

 .. note::

-   The "-b" option explicitly does not handle recipe dependencies. Other
+   The ``-b`` option explicitly does not handle recipe dependencies. Other
    than for debugging purposes, it is instead recommended that you use
    the syntax presented in the next section.

@@ -553,7 +553,7 @@ dependencies, both for build-time and runtime. There must be a way for
 you to express recipe preferences when multiple recipes provide the same
 functionality, or when there are multiple versions of a recipe.

-The ``bitbake`` command, when not using "--buildfile" or "-b" only
+The ``bitbake`` command, when not using ``--buildfile`` or ``-b`` only
 accepts a "PROVIDES". You cannot provide anything else. By default, a
 recipe file generally "PROVIDES" its "packagename" as shown in the
 following example::
@@ -561,7 +561,7 @@ following example::
   $ bitbake foo

 This next example "PROVIDES" the
-package name and also uses the "-c" option to tell BitBake to just
+package name and also uses the ``-c`` option to tell BitBake to just
 execute the ``do_clean`` task::

   $ bitbake -c clean foo

