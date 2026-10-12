Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55799CA9ED1
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 08:42:43 +0000 (UTC)
Received: from prod-mta-13.swg-srv.net (prod-mta-13.swg-srv.net [185.255.28.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9059.1791794556983147932
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Oct 2026 01:42:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=tMTSELu8;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.18, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a12f4716e800080d7@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=zt4SNAn0vt3ZZjPPTimzAcPhvNbiJqdiW4u4m/nAT8c=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=tMTSELu8l3BL3gfWZmOhap1sRYbhFTFooozOwsA2kieyiOoNw3KDK7lABS4EdAz3ClJuD+/Yq
 35rZ/qlXKMzjcidP26u2u9wQEZRUm/7tVyAqXYAV252LugarHqZTiQzY5Wc6gKYmAA8OmLe46XM
 o8lhQN1jr6JoJaRSisjqz9U4s5qBVLX+LfrJmOxmJ2k5mkEWh+RtLM9FVwTWAPzhZx36VvaRwm8
 K1t+s4Nx0tUOg7Q+IBrIN4zHV3TdHyg1RPYU2zRNZQMtd8UOAukNNRSkJkGlYSYePtvtvUro9u4
 ZRVGSX/SRB9Vw6q88chHCrMaP1I8aBEuM8YVzH0kIiSQ==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a12f4716e800080d7.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 12 Oct 2026 08:42:30 +0000
X-Zone-Loop: 6ec53215f987eb791d31e8ab0a28afa34db83848ad32
x-campaign-type: default
x-transaction-id: cbbbdc05-acdf-4009-a486-2e7cff752547
x-swg-uid: 01-d2454380-3f57-4046-89c0-e147215fa72e
X-Mailer: Sweego
Message-ID: 
 <1791794550.8631fc262581453bbf619ec5b2062170.1a12f4716e800080d7@vates.tech>
x-swg-bid: 1791794550.8631fc262581453bbf619ec5b2062170.1a12f4716e800080d7
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id D5FE3829EF;
	Mon, 12 Oct 2026 10:42:29 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>,
	docs@lists.yoctoproject.org
Subject: [PATCH v2 2/2] data_smart: restore the ability to use capital letters
Date: Mon, 12 Oct 2026 10:39:40 +0200
In-Reply-To: <20261012084202.103724-1-yann.dirson@vates.tech>
References: <20261007125138.59937-1-yann.dirson@vates.tech>
 <20261012084202.103724-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.be.bf77c033c60c9820.1a12f471532.bb323f8d9a9cb0cd=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791794550067
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Oct 2026 08:42:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20318

---=Part.be.bf77c033c60c9820.1a12f471532.bb323f8d9a9cb0cd=-
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
index 8aa7c1f99=2E=2E3c149239f 100644
--- a/lib/bb/data_smart=2Epy
+++ b/lib/bb/data_smart=2Epy
@@ -31,7 +31,7 @@ from bb=2ECOW  import COWDictBase
 logger =3D logging=2EgetLogger("BitBake=2EData")
=20
 __setvar_keyword__ =3D [":append", ":prepend", ":remove"]
-__setvar_regexp__ =3D re=2Ecompile(r'(?P<base>=2E*?)(?P<keyword>:append|:=
prepend|:remove)(:(?P<add>[^A-Z]*))?$')
+__setvar_regexp__ =3D re=2Ecompile(r'(?P<base>=2E*?)(?P<keyword>:append|:=
prepend|:remove)(:(?P<add>=2E*))?$')
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
---=Part.be.bf77c033c60c9820.1a12f471532.bb323f8d9a9cb0cd=---

