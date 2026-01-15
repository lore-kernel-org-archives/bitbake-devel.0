Return-Path: <rpjday@crashcourse.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EE3D4114B
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 09:11:12 +0000 (UTC)
Received: from cpanel10.indieserve.net (cpanel10.indieserve.net [199.212.143.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31729.1768468271420960477
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 01:11:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@crashcourse.ca header.s=default header.b=rt6BTA0x;
 spf=pass (domain: crashcourse.ca, ip: 199.212.143.9, mailfrom: rpjday@crashcourse.ca)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U41GW66eZrntXu/1ZjEZIZw1gIw4qOEy65+YaSw25TY=; b=rt6BTA0xXN6tcvH42bup32aoB4
	bifIlFntPVyikT6YVK6G27XcakQEmOa46C3NuS+cp6X/qJqGGFdXOlSBcXfEkWNwz3Qrue/UUP7hg
	QGasJX4Kc4DlA14LDZ3huRbXR0/Va5sACWWgGSuKaZoMLcM3Sc2cLji4l3yno1ari4DtsGOhNkEf4
	taWqKm/rQyOsMpq5gxjb8JZ/6WWb+lLpxiQOH4sdyKkDh3PlTJI+MR0kxL5B81NqWZ4dHpWrs+5Dt
	03y4UHQVT6SUwMiCdFbErrSCXYF0xbmzL3OjkQyehNuwD29XM58OhokaRIxhzGg0gbcJ1bfU6pHdM
	pvmERGUg==;
Received: from pool-174-115-41-146.cpe.net.cable.rogers.com ([174.115.41.146]:49660 helo=rday)
	by cpanel10.indieserve.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1vgJNm-00000008l0i-1P1f;
	Thu, 15 Jan 2026 04:11:09 -0500
Date: Thu, 15 Jan 2026 04:14:38 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: YP docs mailing list <docs@lists.yoctoproject.org>
cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] doc: use "+=" for BBFILE* assignments in layer.conf
 example
Message-ID: <2e02ce72-29bb-272c-fece-49be130611aa@crashcourse.ca>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 09:11:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18768


In a layer.conf file, assignments to BBFILES and BBFILE_COLLECTIONS
should use "+=", not just "=".  Even though this is just an example,
it should still be correct.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index d407f59c0..fc89c3998 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -240,8 +240,8 @@ example, one could easily use them to make one's own local copy of an
 upstream repository, but with custom modifications that one does not
 want upstream. Here is an example::

-  BBFILES = "/stuff/openembedded/*/*.bb /stuff/openembedded.modified/*/*.bb"
-  BBFILE_COLLECTIONS = "upstream local"
+  BBFILES += "/stuff/openembedded/*/*.bb /stuff/openembedded.modified/*/*.bb"
+  BBFILE_COLLECTIONS += "upstream local"
   BBFILE_PATTERN_upstream = "^/stuff/openembedded/"
   BBFILE_PATTERN_local = "^/stuff/openembedded.modified/"
   BBFILE_PRIORITY_upstream = "5"

