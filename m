Return-Path: <pamathieu@poum.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4463AC87FCC
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 17:44:53 +0000 (UTC)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
 by mx.groups.io with SMTP id smtpd.web10.41894.1753897487607281046
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Jul 2025 10:44:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=pamathieu@poum.ca header.s=zmail header.b=PDi5fURl;
 spf=pass (domain: poum.ca, ip: 136.143.188.15, mailfrom: pamathieu@poum.ca)
ARC-Seal: i=1; a=rsa-sha256; t=1753897482; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n+3mwiUmhXl0rGXoMV8BzJN8wWyW2gyHfAmayzKBhM2TpynrUVBMZBZBXKIm/pHApA6IAdnrsXtGd5M7LXDuJDd/foan28kcU/pKMH2qAimw77gyDo5zC6JzCyOTwK3VioP5im1wE/xGBBmJ2bmgWFNMYpCSChnHIl72fHpoIGI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753897482; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j+uwJhPslhDinXx9Ug+mYDqTdhgrhpB2AnxW0V7A/A8=; 
	b=MYziPnbxwMOnOEtMW5ijcbR5UQLRpl80SA9MbQAbXYHDD1gekEd4R/4nvpO2U7dQakueHU3q3Blv8s7RdTjn9NCPV/63EiKdObR91bG9YxRdfJe1k2BT8649XK3XGB83hv570xN+e67Dr5nXqWDpmhytbCgi8wI6jr0WzoFXLl8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=poum.ca;
	spf=pass  smtp.mailfrom=pamathieu@poum.ca;
	dmarc=pass header.from=<pamathieu@poum.ca>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753897482;
	s=zmail; d=poum.ca; i=pamathieu@poum.ca;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=j+uwJhPslhDinXx9Ug+mYDqTdhgrhpB2AnxW0V7A/A8=;
	b=PDi5fURlVGyLXbCvtke4gXOEA/bDaK/uZkpUPo/LB5q6CQ8o2BaflJIG+9Lbsj+R
	vXgHSkKoL+f9Mjma5M0L/0leglCiSSFoL8EbDDufMzh+HAvPzUr//kNYYZXoz0Ub0IX
	s7B12XOiawxuqxJQBhYHMIQXk9izBwKTfysghJy8=
Received: by mx.zohomail.com with SMTPS id 1753897481293478.3007935165558;
	Wed, 30 Jul 2025 10:44:41 -0700 (PDT)
From: Philippe-Alexandre Mathieu <pamathieu@poum.ca>
To: bitbake-devel@lists.openembedded.org
Cc: Philippe-Alexandre Mathieu <pamathieu@poum.ca>,
	Steve Sakoman <steve@sakoman.com>
Subject: [scarthgap][PATCH] fetch2/wget: Keep query parameters in URL during checkstatus
Date: Wed, 30 Jul 2025 13:44:15 -0400
Message-Id: <20250730174415.35703-1-pamathieu@poum.ca>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Jul 2025 17:44:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17828

When recreating the uri in wget's checkstatus method, we only use the
scheme, host and path. This completely strips the query parameters from
the final URI and potentially breaks the checking functionality for
URLs that require query parameters (such as the AZ fetcher with SAS
token).

This bug was resolved on master in
`096301250455e2a83bdd818a56317c62436c9981`.
This patch is adapted to the scarthgap branch.

CC: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Philippe-Alexandre Mathieu <pamathieu@poum.ca>
---
 bitbake/lib/bb/fetch2/wget.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 5bb3b2f361..2345ba6b49 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -344,8 +344,11 @@ class Wget(FetchMethod):
             opener = urllib.request.build_opener(*handlers)
 
             try:
-                uri_base = ud.url.split(";")[0]
-                uri = "{}://{}{}".format(urllib.parse.urlparse(uri_base).scheme, ud.host, ud.path)
+                parts = urllib.parse.urlparse(ud.url.split(";")[0])
+                if parts.query:
+                    uri = "{}://{}{}?{}".format(parts.scheme, parts.netloc, parts.path, parts.query)
+                else:
+                    uri = "{}://{}{}".format(parts.scheme, parts.netloc, parts.path)
                 r = urllib.request.Request(uri)
                 r.get_method = lambda: "HEAD"
                 # Some servers (FusionForge, as used on Alioth) require that the
-- 
2.39.5


