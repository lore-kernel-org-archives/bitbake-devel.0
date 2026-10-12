Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD400CA9ED0
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 08:42:41 +0000 (UTC)
Received: from prod-mta-13-01.swg-srv.net (prod-mta-13-01.swg-srv.net [185.255.28.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9061.1791794557135011156
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Oct 2026 01:42:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=DaeftPHE;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.34, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a12f47156500080d7@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=b9ziPedj3+ByUwsuveDFXL6pMqDjPEmogxwuzAOeeXo=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=DaeftPHE1viScbrDyBmH8MGrPouB6oZArmMN1phTomXPgnzFkPguYGQ8rVY2AJwIYkZLXWdtM
 btLtdmmm/+K8LoDs5cZpSsLmY2BBddnvIqfC7kBZBDpNDjsENrBuG06yQreJ2rxDfP+5WvqF/X7
 XPn+7DfXivwabtv9bKmxS+9AODWs3d+WW6Ox0BOw5kpc8JzUIseLcwu9piQwY0/FKeENxYQAy+o
 0HbzEubDLf8ioAlt0J9Kerha651vY2sUI8RBfUaTchmtgJvdWgM7LPfMRXateCGldSukzdPy8+G
 ScZayXJ1+rLWpPFtcfmADgi0uVR0oDws1XOE1qLbri0A==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-01.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a12f47156500080d7.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 12 Oct 2026 08:42:30 +0000
X-Zone-Loop: 0fb947bbdc6ec62734cf16cefb0c1686ef1c3b4b2a73
x-campaign-type: default
x-transaction-id: 1f7936b9-d2d6-48a4-a272-8215c4927ec2
x-swg-uid: 01-791b8940-42c1-4ed1-ac35-2ace2bbfcd4f
X-Mailer: Sweego
Message-ID: 
 <1791794550.8631fc262581453bbf619ec5b2062170.1a12f47156500080d7@vates.tech>
x-swg-bid: 1791794550.8631fc262581453bbf619ec5b2062170.1a12f47156500080d7
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id 77081829E5;
	Mon, 12 Oct 2026 10:42:29 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>,
	docs@lists.yoctoproject.org
Subject: [PATCH v2 1/2] parse: add a (failing) test for a variable override with capital letters
Date: Mon, 12 Oct 2026 10:39:39 +0200
In-Reply-To: <20261012084202.103724-1-yann.dirson@vates.tech>
References: <20261007125138.59937-1-yann.dirson@vates.tech>
 <20261012084202.103724-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.bd.1b4010e75d145c37.1a12f4713ba.a716aadf86ee4c5f=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791794549690
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Oct 2026 08:42:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20319

---=Part.bd.1b4010e75d145c37.1a12f4713ba.a716aadf86ee4c5f=-
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
---=Part.bd.1b4010e75d145c37.1a12f4713ba.a716aadf86ee4c5f=---

