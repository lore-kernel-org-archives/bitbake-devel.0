Return-Path: <pamathieu@poum.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2678C83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:43:53 +0000 (UTC)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
 by mx.groups.io with SMTP id smtpd.web11.435.1752849831755913158
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 07:43:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=pamathieu@poum.ca header.s=zmail header.b=Xm9t16hZ;
 spf=pass (domain: poum.ca, ip: 136.143.188.12, mailfrom: pamathieu@poum.ca)
ARC-Seal: i=1; a=rsa-sha256; t=1752849828; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TLPlp18EVKDVCCza/SodfUlr0+JS42QothmTKE4l2Oee1KHzbz4L4fcFVu0Mps9ukrkpqkjszuVePIzJimYNiY8aHPDvzPcRea8HKXZhl+Iwib6lth3K7kxdW1BbXYU3y1tz4seKUkviIpojuWaWhrk5TiR5PhauVdodv496+3g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752849828; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kkibJkMk3yG0znavsJBJqaIW/nDbPRhSsDHExEA76Tk=; 
	b=hQIzH/Gb6za79hZjChOcGd2cRktSSY3+uOXaLC1La2yB3xmGhtLE2IW1+M36wXngZhIq0Lxt+gPgCgJFVoQxyAd8FtmuQyASJ7WzSOBZ5K5171/3rUEPOo4cwZOf1AoTdKTQks5qlmCIpczPs3/ETnWzrwRIJwdMCiL6f6YL7Pc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=poum.ca;
	spf=pass  smtp.mailfrom=pamathieu@poum.ca;
	dmarc=pass header.from=<pamathieu@poum.ca>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752849828;
	s=zmail; d=poum.ca; i=pamathieu@poum.ca;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=kkibJkMk3yG0znavsJBJqaIW/nDbPRhSsDHExEA76Tk=;
	b=Xm9t16hZwuBQvCnS4cQsZpPJKDtzEUU7cntHTUpNJsTsiZqTE9EstAcziFc0Z2ka
	fnxPtfXuaOGP3vWp+Dch22k4/SSsfrHFAaDB5JodnemfVYsNGvCTHfYJhAgYZAos7vt
	TtrLpErQnJjcUAC+dcTXoOOi76KAMOX4btRXMjew=
Received: by mx.zohomail.com with SMTPS id 1752849826245931.0221881721401;
	Fri, 18 Jul 2025 07:43:46 -0700 (PDT)
From: Philippe-Alexandre Mathieu <pamathieu@poum.ca>
To: bitbake-devel@lists.openembedded.org
Cc: Philippe-Alexandre Mathieu <pamathieu@poum.ca>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2] fetch2/wget: Keep query parameters in URL during checkstatus
Date: Fri, 18 Jul 2025 10:43:37 -0400
Message-Id: <20250718144337.82440-1-pamathieu@poum.ca>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 14:43:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17796

When recreating the uri in wget's checkstatus method, we only use the
scheme, netloc and path. This completely strips the query parameters
from the final URI and potentially breaks the checking functionality
from certain fetchers.

This is the case for the Azure storage fetcher, as it requires a SAS
token that is formatted as a series of query parameters. The error
manifests itself when using a private storage account as a PREMIRROR or
SSTATE_MIRROR (since regular SRC_URI won't run the checkstatus).

This problem is present in scarthgap, but wasn't in kirkstone.

CC: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Philippe-Alexandre Mathieu <pamathieu@poum.ca>
---
 bitbake/lib/bb/fetch2/wget.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 7e43d3bc97..4d19e2134b 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -372,7 +372,10 @@ class Wget(FetchMethod):
 
             try:
                 parts = urllib.parse.urlparse(ud.url.split(";")[0])
-                uri = "{}://{}{}".format(parts.scheme, parts.netloc, parts.path)
+                if parts.query:
+                    uri = "{}://{}{}?{}".format(parts.scheme, parts.netloc, parts.path, parts.query)
+                else:
+                    uri = "{}://{}{}".format(parts.scheme, parts.netloc, parts.path)
                 r = urllib.request.Request(uri)
                 r.get_method = lambda: "HEAD"
                 # Some servers (FusionForge, as used on Alioth) require that the
-- 
2.39.5


