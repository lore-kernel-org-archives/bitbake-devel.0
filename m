Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A241BCC6B0F
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 13:53:15 +0000 (UTC)
Received: from prod-mta-13.swg-srv.net (prod-mta-13.swg-srv.net [185.255.28.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7763.1791899585972647445
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 06:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=ESobr9HJ;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.18, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a13589bf9d0008425@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=N92dQ6BeTsoF0wtdsp6xZvZjrO8RXJ1spEHSc1n2IjY=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=ESobr9HJFwSkO3XYW/DiLlqQrUUwRifBW3XSTtkywNJp6JFwoQcu7EpEcyvGZ8RJQXedFg4qg
 XdYzAGAmBAOqLpaEc69j/V3uaHaiAe03OCc0h4xar2McbXoGOGItM9jsowMrDPTIyUKswELuAGO
 Vq1HhQlIyUs2KAksl/SBtFmhjiyHT2+o+MaDTo42Z9KNv0+B4YshnlQQ4i76pA5Fme49nKIPBxM
 6bU8IMRPwDtNPOa/8B84bickMKe5p2D2INpb83yL1y7EnPCjT5vzB67Qonefa6vPQviSh0H6jHC
 gLqiGIRzPAO4fvfixlze1Fu6YiB+N0CG058uN8FRtmuw==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a13589bf9d0008425.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 13 Oct 2026 13:53:02 +0000
X-Zone-Loop: ee5ad23b3d089a50079353ce2ff358538ff31c328825
x-campaign-type: default
x-transaction-id: 4a43ec7e-c50d-4287-8dbf-4942339b1179
x-swg-uid: 01-e5fe1479-7a7c-4430-941b-614724d02920
X-Mailer: Sweego
Message-ID: 
 <1791899582.8631fc262581453bbf619ec5b2062170.1a13589bf9d0008425@vates.tech>
x-swg-bid: 1791899582.8631fc262581453bbf619ec5b2062170.1a13589bf9d0008425
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (ip-185-175-148-127.naitways.net [185.175.148.127])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id DAB6C82B55;
	Tue, 13 Oct 2026 15:53:01 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>,
	docs@lists.yoctoproject.org
Subject: [PATCH v3 3/4] parse: add a (failing) test for a variable override with capital letters
Date: Tue, 13 Oct 2026 15:52:16 +0200
In-Reply-To: <20261013135251.168428-1-yann.dirson@vates.tech>
References: <20261012084202.103724-1-yann.dirson@vates.tech>
 <20261013135251.168428-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.16e.caa625383057b537.1a13589bdfd.53c5c269d48649d9=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791899581949
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 13:53:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20334

---=Part.16e.caa625383057b537.1a13589bdfd.53c5c269d48649d9=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
---
 lib/bb/tests/parse=2Epy | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/bb/tests/parse=2Epy b/lib/bb/tests/parse=2Epy
index 6ac2137e0=2E=2E7e7dbd923 100644
--- a/lib/bb/tests/parse=2Epy
+++ b/lib/bb/tests/parse=2Epy
@@ -150,6 +150,28 @@ exportD =3D "d"
         self=2EassertEqual(d=2EgetVar("exportD"), "d")
         self=2EassertIsNone(d=2EgetVarFlag("exportD", "export"))
=20
+    mixedcase_pn_override =3D """
+PN =3D "${@bb=2Eparse=2Evars_from_file(d=2EgetVar('FILE', False), d)[0]}"
+OVERRIDES =3D "pn-${PN}"
+RPROVIDES:perl-ExtUtils-MakeMaker =3D "base"
+RPROVIDES:perl-ExtUtils-MakeMaker:append:pn-ExtUtils-MakeMaker =3D " text=
"
+"""
+
+    @unittest=2EexpectedFailure
+    def test_parse_mixedcase_pn_override(self):
+        # Recipes named after CPAN distributions have mixed-case PNs, so
+        # OVERRIDES contains a mixed-case pn-${PN} entry=2E An operation
+        # guarded by that override must still be applied=2E
+        with tempfile=2ETemporaryDirectory() as tempdir:
+            recipe =3D os=2Epath=2Ejoin(tempdir, "ExtUtils-MakeMaker=2Ebb=
")
+            with open(recipe, "w") as f:
+                f=2Ewrite(self=2Emixedcase_pn_override)
+            os=2Echdir(tempdir)
+            d =3D bb=2Eparse=2Ehandle(recipe, self=2Ed)['']
+        self=2EassertEqual(d=2EgetVar("PN"), "ExtUtils-MakeMaker")
+        self=2EassertIn("pn-ExtUtils-MakeMaker", d=2EgetVar("OVERRIDES")=
=2Esplit(":"))
+        self=2EassertEqual(d=2EgetVar("RPROVIDES:perl-ExtUtils-MakeMaker"=
), "base text")
+
     overridetest =3D """
 RRECOMMENDS:${PN} =3D "a"
 RRECOMMENDS:${PN}:libc =3D "b"
--=20
2=2E47=2E3



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.16e.caa625383057b537.1a13589bdfd.53c5c269d48649d9=---

