Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91119CA9ED2
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 08:25:51 +0000 (UTC)
Received: from prod-mta-13-01.swg-srv.net (prod-mta-13-01.swg-srv.net [185.255.28.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8816.1791793546152054020
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Oct 2026 01:25:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=oNjMXjn0;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.34, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=33m/fbTNjbrovSO/3F8yvQ1exDtaC56pkANzl24OxUI=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:feedback-id;
 b=oNjMXjn0AIYWGgMfmAb4N3cY92o/Sl4/R7bIABtCJZ1Z0jKRE5tyoB34qhslvfV39ROv+JOQp
 iUF90ibspHSWduEd7DytxcGE+ZgZhupZDJ5embCVEIyGJkW6Znx3H0Ag7wW9MJX/VEcLNrQno7x
 I4lAQUxdpp5y3CzhHs+rcZrgf3aSuUfPnDTz/LRVrqdBGztrzKNS36/UMx9oukpN1wVEpBVGJOk
 nIyho8r7FRKIL3U84xlvfA/ffYvfzySYhABiYQN0Ww93wnECVJ6hRVo33pYtr5Lt/V2NnbqF6Pc
 2SgeeDQ0uA/u+hhKT4hQBVloVsTzyywAFs81IbHjLwXw==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-01.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a12f37b16e00080d7.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 12 Oct 2026 08:25:41 +0000
X-Zone-Loop: f3e44acef3f55a1626ba1ce8d0e1f55108f4e98397c8
x-campaign-type: default
x-transaction-id: 69bc3e1a-b96a-42e8-8c08-555621fedf97
x-swg-uid: 01-1526dd87-cbb0-4339-874b-2da45253ad6c
X-Mailer: Sweego
Message-ID: 
 <1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech>
x-swg-bid: 1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id 9DADF829E5;
	Mon, 12 Oct 2026 10:25:40 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Yann Dirson <yann.dirson@vates.tech>
Subject: [PATCH] doc: document dependency tracking associated with addpylib
Date: Mon, 12 Oct 2026 10:25:24 +0200
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.b9.1a47236ed8edcda3.1a12f37aee7.820c85cfb7901669=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791793540846
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Oct 2026 08:25:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20316

---=Part.b9.1a47236ed8edcda3.1a12f37aee7.820c85cfb7901669=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reported-by: Claude Opus 5=2E5
Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst b/=
doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
index 621aab253=2E=2Eeef1f9624 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
@@ -2264,6 +2264,14 @@ The specified <namespace> is imported automatically=
, and if the imported
 module specifies an attribute named ``BBIMPORTS``, that list of
 sub-modules is iterated and imported too=2E
=20
+Additionally, Bitbake will detect usage of functions from such a
+library and include them in task hashes, so changes in those functions
+trigger task rebuilds=2E  Note that only functions inside modules
+declared using ``BBIMPORTS`` benefit from this dependency tracking,
+any name defined directly in the specified namespace (e=2Eg=2E in
+`<namespace>/__init__=2Epy`, or in a library hat would be defined as
+`<namespace>=2Epy`) would *not* benefit from this tracking=2E
+
 Testing and Debugging BitBake Python code
 -----------------------------------------
=20
--=20
2=2E47=2E3



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.b9.1a47236ed8edcda3.1a12f37aee7.820c85cfb7901669=---

