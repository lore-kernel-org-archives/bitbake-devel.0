Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4774C5DF9C
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 16:36:15 +0000 (UTC)
Received: from prod-mta-13-02.swg-srv.net (prod-mta-13-02.swg-srv.net [185.255.28.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1861.1787589372461200885
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 09:36:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=llHb0ML5;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.35, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a034a1109a000c4f3@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=1C6jj5c0OR/L85n8NZkJQ9i5U2y9LrYemCh3daBtvHw=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=llHb0ML5FCmspBtgmsPoqTB2EbRBPCDBnKz41KegQgMygIKBvROn5dxttLNLf4esnD3ZFfv52
 Ca61bTBWCNIXj8gIlco9zn3P7FuFS9DQevrYYL/sKwh8h4L6wyQWn6ay+jdy+1/FaqtyWIQwhrR
 b05bRnzvV6nz6ZlecHQYkXzP65azah1jRckUWMJ9dU1sxfQeptFyCWNfW7waqAKsiudwbtwaqdN
 QR9Y0kWJ8tCC8se6VQBEg5SSJz8MQkzgDTjN7d5sqJ7SfUGsPHW1H0XDzJJckJwM9Lk1W4LbYnj
 G+I44eKDWizbzB9Taa5Y4e/5/olhtoTj6266q2H6u5Jw==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-02.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a034a1109a000c4f3.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 24 Aug 2026 16:36:05 +0000
X-Zone-Loop: 51a9abbe0e1030d23c392e00f454480c404810bb2d4a
x-campaign-type: default
x-transaction-id: b22534c1-6e49-40e3-8f0c-75aff642a150
x-swg-uid: 01-e5f02a51-f54b-4d22-b250-34331cb92495
X-Mailer: Sweego
Message-ID: 
 <1787589365.8631fc262581453bbf619ec5b2062170.1a034a1109a000c4f3@vates.tech>
x-swg-bid: 1787589365.8631fc262581453bbf619ec5b2062170.1a034a1109a000c4f3
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id CCD82823F2;
	Mon, 24 Aug 2026 18:36:04 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Yann Dirson <yann.dirson@vates.tech>
Subject: [PATCH v2] doc/bitbake-user-manual-ref-variables: document PREFERRED_RPROVIDER
Date: Mon, 24 Aug 2026 18:35:48 +0200
In-Reply-To: <20260824101219.119627-1-yann.dirson@vates.tech>
References: <20260824101219.119627-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.2a61.e8f55bbbae082756.1a034a10cbc.a258c71cfd8b4840=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1787589364925
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 16:36:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20030

---=Part.2a61.e8f55bbbae082756.1a034a10cbc.a258c71cfd8b4840=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
---
 =2E=2E=2E/bitbake-user-manual-ref-variables=2Erst          | 14 +++++++++=
+++++
 1 file changed, 14 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Er=
st b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
index 5395ce5e3=2E=2Efd75275bb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
@@ -1558,6 +1558,20 @@ overview of their function and contents=2E
          PREFERRED_PROVIDER_xxx =3D "yyy"
          PREFERRED_PROVIDER_aaa =3D "bbb"
=20
+   :term:`PREFERRED_RPROVIDER`
+      Determines which *recipe* should be given preference when
+      multiple packages declare runtime-providing (:term:`RPROVIDES`)
+      the same item=2E Some examples::
+
+         PREFERRED_RPROVIDER_initd-functions ?=3D "initscripts"
+         PREFERRED_RPROVIDER_virtual-libegl-icd ?=3D "mesa"
+
+      The former will select as the package built by the `initscripts`
+      recipe declaring to be runtime-provider for `initd-functions`,
+      which is in this case `initscripts-functions`::
+
+          =2E=2E=2E/initscripts_1=2E0=2Ebb:RPROVIDES:${PN}-functions =3D =
"initd-functions"
+
    :term:`PREFERRED_VERSION`
       If there are multiple versions of a recipe available, this variable
       determines which version should be given preference=2E You must alw=
ays
--=20
2=2E47=2E3



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.2a61.e8f55bbbae082756.1a034a10cbc.a258c71cfd8b4840=---

