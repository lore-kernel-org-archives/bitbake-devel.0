Return-Path: <pamathieu@poum.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D32C83F1A
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 21:02:57 +0000 (UTC)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
 by mx.groups.io with SMTP id smtpd.web11.6303.1752786174152833479
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Jul 2025 14:02:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=pamathieu@poum.ca header.s=zmail header.b=OpXw7oyF;
 spf=pass (domain: poum.ca, ip: 136.143.188.12, mailfrom: pamathieu@poum.ca)
ARC-Seal: i=1; a=rsa-sha256; t=1752786171; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MHbvt3in+W6EEc81Zt4sc1wznFnwOutFvVCU4yyOoJAdSTrpO9cjLiMT0B5VDb3J9wjJ7A4oFEX/iW9ljkZSMJEJbMb9l8PM9ffM4TkdvMBzy1HspFprDbPz1EOpN08dEbrMrQzaveEAZ5HHgCURCtSvtgFv5+qix4HLHPGz1fE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752786171; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZFysW92BUpBJAz06x/OMjLrsVdcbXgmL98C/Bh/HBnQ=; 
	b=agv7GRmidfaXC9TwSuTT/8MW+ec70iOcNuoZ4jQCX3jOdpTsWb8ZbHUk8C1ehns6o+YtbBSAv7Irpe0YYqN80Y7noUDAP5FDzH57u7JXXSgqmOOBr26nn/+bgyso4eOKsazNSr/5S6R26aJakzEmrid68p2owtyPZ4cFfVTkpbg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=poum.ca;
	spf=pass  smtp.mailfrom=pamathieu@poum.ca;
	dmarc=pass header.from=<pamathieu@poum.ca>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752786171;
	s=zmail; d=poum.ca; i=pamathieu@poum.ca;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZFysW92BUpBJAz06x/OMjLrsVdcbXgmL98C/Bh/HBnQ=;
	b=OpXw7oyFjAlsNXu3On/by+N7Qt+UZe52jKZujHeX4d8vST9RdFAydI1UHo+c5rZH
	xjtKf97fhB9nkIhpGGSIFdN+e7F2rn1RRP0uY49sIfVtU4Z2gSsX9B4rVO3/ZyyiEMr
	KX+7rh9xPaghRT/uavsUud7kHNlQQSAGJ7PirMqU=
Received: by mx.zohomail.com with SMTPS id 175278617017648.6177599077414;
	Thu, 17 Jul 2025 14:02:50 -0700 (PDT)
From: Philippe-Alexandre Mathieu <pamathieu@poum.ca>
To: bitbake-devel@lists.openembedded.org
Cc: Philippe-Alexandre Mathieu <pamathieu@poum.ca>
Subject: [PATCH] fetch2/wget: Keep query parameters in URL during checkstatus
Date: Thu, 17 Jul 2025 17:02:47 -0400
Message-ID: <20250717210247.181580-1-pamathieu@poum.ca>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Jul 2025 21:02:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17788

When recreating the uri in wget's checkstatus method, we only use the
scheme, netloc and path. This completely strips the query parameters
from the final URI and potentially breaks the checking functionality
from certain fetchers.

This is the case for the Azure storage fetcher, as it requires a SAS
token that is formatted as a series of query parameters. The error
manifests itself when using a private storage account as a PREMIRROR or
SSTATE_MIRROR (since regular SRC_URI won't run the checkstatus).

This problem is present in scarthgap, but wasn't in kirkstone.

Signed-off-by: Philippe-Alexandre Mathieu <pamathieu@poum.ca>
---
 bitbake/lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 7e43d3bc97..c8870b18ad 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -372,7 +372,7 @@ class Wget(FetchMethod):
 
             try:
                 parts = urllib.parse.urlparse(ud.url.split(";")[0])
-                uri = "{}://{}{}".format(parts.scheme, parts.netloc, parts.path)
+                uri = "{}://{}{}?{}".format(parts.scheme, parts.netloc, parts.path, parts.query)
                 r = urllib.request.Request(uri)
                 r.get_method = lambda: "HEAD"
                 # Some servers (FusionForge, as used on Alioth) require that the

