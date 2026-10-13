Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92978CC6B08
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 13:53:15 +0000 (UTC)
Received: from prod-mta-13.swg-srv.net (prod-mta-13.swg-srv.net [185.255.28.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7659.1791899589072726421
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 06:53:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=Yg+CWV0q;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.18, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a13589c05b0008425@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=6DW5YjpdgSc5cObx6cCc2zJQ0pSiWjHzYt1yEuct0xU=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=Yg+CWV0qDDwZBRYoKdGZgbw+PlrfYBabgNQlv+3drRkmxpjoPvA0Ew2te3n/gsNQ/HHMnlWT+
 p6++8Usfr8wf9qHxkRyetB7L9z6jaS/ohKegJkfI5eBRs2WXf/iucH15DkRhzwb3h8qHVDoBmbe
 Udi/TMRMaaDxi5LnBpJMveNdatDgnAVAKP1g8W9M9uI1VJKBkJ1QDiBQIOxvQPcUxP6paoI3azU
 tabJnCM41KL2+t8GkexVUnfFiMam5zBAvxHafoT35iHVslaIkmDmlALGnwoZRpQis+mGIc2w/IX
 VMfyrzWSEE8OcZC2X8GoB8xXkRxUCLFOXT4XvsuzXRyw==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a13589c05b0008425.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 13 Oct 2026 13:53:02 +0000
X-Zone-Loop: 22d618f4378e2d66d2be0609c0750662f82ec1b86fae
x-campaign-type: default
x-transaction-id: ba1d4fb9-6f2d-4ee0-b632-ac52153792d2
x-swg-uid: 01-efa228e4-2e8d-4d60-a1d5-606f1f3dd255
X-Mailer: Sweego
Message-ID: 
 <1791899582.8631fc262581453bbf619ec5b2062170.1a13589c05b0008425@vates.tech>
x-swg-bid: 1791899582.8631fc262581453bbf619ec5b2062170.1a13589c05b0008425
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (ip-185-175-148-127.naitways.net [185.175.148.127])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id 0D8BE82B59;
	Tue, 13 Oct 2026 15:53:02 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>,
	docs@lists.yoctoproject.org
Subject: [PATCH v3 4/4] data_smart: restore the ability to use capital letters
Date: Tue, 13 Oct 2026 15:52:17 +0200
In-Reply-To: <20261013135251.168428-1-yann.dirson@vates.tech>
References: <20261012084202.103724-1-yann.dirson@vates.tech>
 <20261013135251.168428-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.16f.cb69ef794b3c75f5.1a13589be9f.63f7ec382b5e166b=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791899582111
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 13:53:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20335

---=Part.16f.cb69ef794b3c75f5.1a13589be9f.63f7ec382b5e166b=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This reverts commit 6eb56624e6d8dc1944e559b4f6584bfe66f566ba=2E

That commit was meant as an ad-hoc band-aid when "_" was used as
override prefix, and it explicitly blocked capital letters from being
usable in the overrides=2E  There is no reason to keep it now we use ":"
as prefix=2E

Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
---
 lib/bb/data_smart=2Epy  | 2 +-
 lib/bb/tests/parse=2Epy | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/data_smart=2Epy b/lib/bb/data_smart=2Epy
index a6e4bddb6=2E=2Ea95c08425 100644
--- a/lib/bb/data_smart=2Epy
+++ b/lib/bb/data_smart=2Epy
@@ -31,7 +31,7 @@ from bb=2ECOW  import COWDictBase
 logger =3D logging=2EgetLogger("BitBake=2EData")
=20
 __setvar_keyword__ =3D [":append", ":prepend", ":remove"]
-__setvar_regexp__ =3D re=2Ecompile(r'(?P<base>=2E*?)(?P<keyword>:append|:=
prepend|:remove)(:(?P<add>[^A-Z$]*))?$')
+__setvar_regexp__ =3D re=2Ecompile(r'(?P<base>=2E*?)(?P<keyword>:append|:=
prepend|:remove)(:(?P<add>[^$]*))?$')
 __expand_var_regexp__ =3D re=2Ecompile(r"\${[a-zA-Z0-9\-_+=2E/~:]+}")
 __expand_python_regexp__ =3D re=2Ecompile(r"\${@(?:{=2E*?}|=2E)+?}")
 __whitespace_split__ =3D re=2Ecompile(r'(\s)')
diff --git a/lib/bb/tests/parse=2Epy b/lib/bb/tests/parse=2Epy
index 7e7dbd923=2E=2E9fc094b16 100644
--- a/lib/bb/tests/parse=2Epy
+++ b/lib/bb/tests/parse=2Epy
@@ -157,7 +157,6 @@ RPROVIDES:perl-ExtUtils-MakeMaker =3D "base"
 RPROVIDES:perl-ExtUtils-MakeMaker:append:pn-ExtUtils-MakeMaker =3D " text=
"
 """
=20
-    @unittest=2EexpectedFailure
     def test_parse_mixedcase_pn_override(self):
         # Recipes named after CPAN distributions have mixed-case PNs, so
         # OVERRIDES contains a mixed-case pn-${PN} entry=2E An operation
--=20
2=2E47=2E3



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.16f.cb69ef794b3c75f5.1a13589be9f.63f7ec382b5e166b=---

