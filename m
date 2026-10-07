Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7FCA5FF1
	for <webhook@archiver.kernel.org>; Wed,  7 Oct 2026 12:52:05 +0000 (UTC)
Received: from prod-mta-13-02.swg-srv.net (prod-mta-13-02.swg-srv.net [185.255.28.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8805.1791377517717529915
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Oct 2026 05:51:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=Ptusn4La;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.35, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a1166b9ac40003f66@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=tgIqicREyNakz5eHthAPeGCf2RSJNIMr+a75ZuNPoCM=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:feedback-id;
 b=Ptusn4LaR6sRYV+a7kAWv/SrQQiburaB735hdzaXDuXqJ2K2X266Y13j2dS3c8AXvYYw1BiIx
 RNGTmVZ+2DoDMtZQKg7/codTVpGAc3T9ravdWOsYehNW4RMDj7hYj7DMeIDNaL2bJDyr1qQjYN4
 RavJXdPvTHX4IoMkSqe8cN2kBijc6xdq0RLNgUpaAAm+iC2l5x7+9WNkp0/p8JPnYp2l1y9WCtr
 AzBbmhvnp9SVDJAr/tUjVrvXQ7Tl4XynMW0CkX2PjT494si3xMxdOXOjR9dUeQokRNDlp8nmLZO
 /ltqFxxPNzJBr0GxABIjkM98t9n4rdgw7voHZxLral1A==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-02.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a1166b9ac40003f66.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 07 Oct 2026 12:51:53 +0000
X-Zone-Loop: 4e9dc14ded47e79d79651ce1c2581b8d33ff034ad62f
x-campaign-type: default
x-transaction-id: d01a6246-d080-4f49-84b5-b86af8c823d3
x-swg-uid: 01-f0277b71-f836-47ba-a083-f1a0ee9e0038
X-Mailer: Sweego
Message-ID: 
 <1791377513.8631fc262581453bbf619ec5b2062170.1a1166b9ac40003f66@vates.tech>
x-swg-bid: 1791377513.8631fc262581453bbf619ec5b2062170.1a1166b9ac40003f66
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id 5574781EBB;
	Wed,  7 Oct 2026 14:51:52 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>
Subject: [PATCH 1/2] parse: add a (failing) test for a variable override with capital letters
Date: Wed,  7 Oct 2026 14:51:36 +0200
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.6e8.55acd22cccba0b41.1a1166b97e4.bb6cb4c9dabc7c54=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791377512425
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Oct 2026 12:52:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20303

---=Part.6e8.55acd22cccba0b41.1a1166b97e4.bb6cb4c9dabc7c54=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
---
 lib/bb/tests/parse=2Epy | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/tests/parse=2Epy b/lib/bb/tests/parse=2Epy
index 6ac2137e0=2E=2E9fc094b16 100644
--- a/lib/bb/tests/parse=2Epy
+++ b/lib/bb/tests/parse=2Epy
@@ -150,6 +150,27 @@ exportD =3D "d"
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
---=Part.6e8.55acd22cccba0b41.1a1166b97e4.bb6cb4c9dabc7c54=---

