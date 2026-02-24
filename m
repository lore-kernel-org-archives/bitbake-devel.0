Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E625F4BB63
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 17:20:55 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25620.1771953645267709728
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Feb 2026 09:20:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=mudDCm9v;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CXlEO0FjHH8z06IPZK8Ax+vbftsDaltFCw4Yx0zQqyY=; b=mudDCm9vbrdLTnVD6eVCPq78SJ
	K3jFm6X4VZB/T5tSARNRM6X+LIJ8Dyy+yr0KbDrIHsIMj9WqjXzW4UbVfhb9gTRT9wz/bTzoFZg9B
	1CrbiJ3Fx+jG4agoDg5XN3sSZATFCnPyweT+ZPzcgKuDzHrJjLUSArQ4NCSUS4nX95YPzhMSbctK6
	T1NFkNm0/vT1j0m/Mo/RIt7Xs9dZdwQjWc80wrNZ0cxghkCffst68d8/+fcybvGdHy5SH/rguhyNR
	pFhrL0Wh96rjhgfC+dv5VksE+csR2XwnGfsYVcUh9YdlCgdB8MSofI3RFssOvNRinOxZGGlG9f6nF
	n2bnus3w==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:51114 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vuw5U-000000003V8-0CdB
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Feb 2026 12:20:44 -0500
Date: Tue, 24 Feb 2026 12:23:00 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] correct small number of "Bitbake" to "BitBake"
Message-ID: <10c820e1-5872-f256-d5ad-13316afa6d19@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Feb 2026 17:20:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19083


Use correct spelling of "BitBake" in a few places.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 8e1a232cd..1dcdc0ffe 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -402,7 +402,7 @@ Here are some example URLs::
    easy to share metadata without removing passwords. SSH keys, ``~/.netrc``
    and ``~/.ssh/config`` files can be used as alternatives.

-Using tags with the git fetcher may cause surprising behaviour. Bitbake needs to
+Using tags with the git fetcher may cause surprising behaviour. BitBake needs to
 resolve the tag to a specific revision and to do that, it has to connect to and use
 the upstream repository. This is because the revision the tags point at can change and
 we've seen cases of this happening in well known public repositories. This can mean
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 6bcab4870..6801323e2 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -233,7 +233,7 @@ BitBake supports class files installed in three different directories:

 For details on how BitBake locates class files, see the
 :ref:`bitbake-user-manual/bitbake-user-manual-metadata:Locating Class Files`
-section of the Bitbake User Manual.
+section of the BitBake User Manual.

 Layers
 ------
@@ -539,7 +539,7 @@ Following is the usage and syntax for BitBake::
                            make dependency graphs more appealing.

 ..
-    Bitbake help output generated with "stty columns 80; bin/bitbake -h"
+    BitBake help output generated with "stty columns 80; bin/bitbake -h"

 .. _bitbake-examples:

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 18f293f4b..f8bdf19a8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1158,7 +1158,7 @@ Like include files, class files are located using the :term:`BBPATH` variable.
 The classes can be included in the ``classes-recipe``, ``classes-global`` and
 ``classes`` directories, as explained in the
 :ref:`bitbake-user-manual/bitbake-user-manual-intro:Class types` section of the
-Bitbake User Manual. Like for the :ref:`include <ref-include-directive>` and
+BitBake User Manual. Like for the :ref:`include <ref-include-directive>` and
 :ref:`require <require-inclusion>` directives, BitBake stops and inherits the
 first class that it finds.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 3a01144ff..2071b904e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1339,7 +1339,7 @@ overview of their function and contents.

       -  When recipes are parsed - then for each parsed recipe.

-      Bitbake ignores changes to :term:`INHERIT` in individual recipes.
+      BitBake ignores changes to :term:`INHERIT` in individual recipes.

       For more information on :term:`INHERIT`, see the
       ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:\`\`inherit\`\` configuration directive`"

