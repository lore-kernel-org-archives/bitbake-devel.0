Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC3ED1D47F
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 15:44:33 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9294.1767887068343348298
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 07:44:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=A7sl8QWi;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rUuh9tIL/Bl51FojX6L6OXQXtATv8sClKVj0ZXXfHeI=; b=A7sl8QWitvdQDxiUyCVXNifV9K
	lR9+SuT7XlWmSF1nRuoEKCmhC26B9SH5wBEc7gBUTn9+06/KXnME7+/jj9dlcE2N5jVffzkJnO7eJ
	Ot4uJ7B7qBIg+cSMrDFEpR6Raii4hsRIcAkfLMVbY4c0/oyo+aNtGSJCtOtPAMfQUpdNjYL+NlmZR
	TVKCTYYqSKPbBd2jYVxjMlVKRwfEcX15JredmnaOGnoYuzBlNvqUIsrFehW2GxWF1O/nmdQPHg3BU
	AhQzwmq9DIHdiQMJDK7DT9zv9AEOvQEedu2fagqmUe+7ZLT1jjuxgTjjBfk4Jgj3nvW1Kqg6HQCVU
	GfoiSrkA==;
Received: from [147.129.179.166] (port=55510 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vdsBW-00000001wBe-0tqB
	for bitbake-devel@lists.openembedded.org;
	Thu, 08 Jan 2026 10:44:26 -0500
Date: Thu, 8 Jan 2026 10:47:30 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: fix a couple minor typos in Chapter 1
Message-ID: <134b011e-5652-1609-cbba-4e29e7f95a48@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 15:44:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18713


Just some verb tense stuff.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 329b02829..729acc433 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -198,7 +198,7 @@ Class files, which are denoted by the ``.bbclass`` extension, contain
 information that is useful to share between metadata files. The BitBake
 source tree currently comes with one class metadata file called
 ``base.bbclass``. You can find this file in the ``classes`` directory.
-The ``base.bbclass`` class files is special since it is always included
+The ``base.bbclass`` class file is special since it is always included
 automatically for all recipes and classes. This class contains
 definitions for standard basic tasks such as fetching, unpacking,
 configuring (empty by default), compiling (runs any Makefile present),
@@ -228,7 +228,7 @@ BitBake supports class files installed in three different directories:
       inherit myclass

 -  ``classes/``: this final directory is meant for classes that can be used in
-   the two contexts explain above. In other words, they can be inherited either
+   the two contexts explained above. In other words, they can be inherited either
    globally or in a recipe.

 For details on how BitBake locates class files, see the


