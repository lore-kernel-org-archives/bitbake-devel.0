Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0800BCC6B14
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 13:53:16 +0000 (UTC)
Received: from prod-mta-13.swg-srv.net (prod-mta-13.swg-srv.net [185.255.28.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7763.1791899585972647445
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 06:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=Jnh8xYzi;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.18, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a13589bf0a0008425@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=DIDYvgDtiEt05j+vbdf8755BE/obL6CwpyJOOFCjXKI=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=Jnh8xYzioSYEIWRC4WWwl6nZElFq4/61TQZtuDfRxMMDXB6u+iLrOYjwB1NBqcB8frs0UG3ZU
 26mEtzHWzEBUOm4LHdyc8HP0q+VVZ4NvUtsAK0fjkM6inYQA65FIMU9LVuAmjkO1xGtORlUcoRc
 8F5cv+hX9NeCaKJRrJxgfhgyQST1ruMqk9otEZI2VK8lI31+KR891Gmlqy1k2/Bvl92ilP2GfVG
 WbK3aZeYfTIBG7W4l2edlU9tdZEbE7mAmEOL/LZGPDosAg96RP9GQTyyTLy1PtpKddNLOjdfm8o
 B44jtpfn4TSHXWIjYj4NmaZjYXzvS1hzAdBB/UCd901Q==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a13589bf0a0008425.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 13 Oct 2026 13:53:02 +0000
X-Zone-Loop: 3e2df7026fb984b8926370d374d1c425c9d9331eebc5
x-campaign-type: default
x-transaction-id: 019ca3bd-e2e9-4861-9c53-5b204e65edcc
x-swg-uid: 01-4a7069e2-79c3-4606-a14b-00423f5e53f4
X-Mailer: Sweego
Message-ID: 
 <1791899582.8631fc262581453bbf619ec5b2062170.1a13589bf0a0008425@vates.tech>
x-swg-bid: 1791899582.8631fc262581453bbf619ec5b2062170.1a13589bf0a0008425
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (ip-185-175-148-127.naitways.net [185.175.148.127])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id AF8D082B46;
	Tue, 13 Oct 2026 15:53:01 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>,
	docs@lists.yoctoproject.org
Subject: [PATCH v3 2/4] data_smart: differ taking overrides with unexpanded variables into account
Date: Tue, 13 Oct 2026 15:52:15 +0200
In-Reply-To: <20261013135251.168428-1-yann.dirson@vates.tech>
References: <20261012084202.103724-1-yann.dirson@vates.tech>
 <20261013135251.168428-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.16d.4b227ad84c6a33d1.1a13589bd53.5562f51b151b000f=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791899581779
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 13:53:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20332

---=Part.16d.4b227ad84c6a33d1.1a13589bd53.5562f51b151b000f=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In original code, in a setVar call for, say, "TEST:foo-${MACHINE}",
the __setvar_regexp__ regexp does not match *because of capitals*, so
it stores a variable name including $ and caps=2E Later during
finalization expandKeys then calls renameVar and setVar, at which
point the regexp matches and the override is detected=2E

The reason why this works is not because there is a variable in the
override text, but because there are uppercase letters, so it would
break with lowercase, as well as if we want to change the regexp to
allow uppercase in an override string=2E

Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
Assisted-by: Claude Opus 5=2E5
---
 lib/bb/data_smart=2Epy | 2 +-
 lib/bb/tests/data=2Epy | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/data_smart=2Epy b/lib/bb/data_smart=2Epy
index 8aa7c1f99=2E=2Ea6e4bddb6 100644
--- a/lib/bb/data_smart=2Epy
+++ b/lib/bb/data_smart=2Epy
@@ -31,7 +31,7 @@ from bb=2ECOW  import COWDictBase
 logger =3D logging=2EgetLogger("BitBake=2EData")
=20
 __setvar_keyword__ =3D [":append", ":prepend", ":remove"]
-__setvar_regexp__ =3D re=2Ecompile(r'(?P<base>=2E*?)(?P<keyword>:append|:=
prepend|:remove)(:(?P<add>[^A-Z]*))?$')
+__setvar_regexp__ =3D re=2Ecompile(r'(?P<base>=2E*?)(?P<keyword>:append|:=
prepend|:remove)(:(?P<add>[^A-Z$]*))?$')
 __expand_var_regexp__ =3D re=2Ecompile(r"\${[a-zA-Z0-9\-_+=2E/~:]+}")
 __expand_python_regexp__ =3D re=2Ecompile(r"\${@(?:{=2E*?}|=2E)+?}")
 __whitespace_split__ =3D re=2Ecompile(r'(\s)')
diff --git a/lib/bb/tests/data=2Epy b/lib/bb/tests/data=2Epy
index 31a1ec323=2E=2Efb455be98 100644
--- a/lib/bb/tests/data=2Epy
+++ b/lib/bb/tests/data=2Epy
@@ -417,7 +417,6 @@ class TestOverrides(unittest=2ETestCase):
         self=2EassertEqual(self=2Ed=2EgetVar("TEST"), "base appended")
=20
     # Test an :append whose override name is lowercase
-    @unittest=2EexpectedFailure
     def test_append_in_expanded_lowercase_override(self):
         self=2Ed=2EsetVar("machine", "qemux86")
         self=2Ed=2EsetVar("PN", "gizmo")
--=20
2=2E47=2E3



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.16d.4b227ad84c6a33d1.1a13589bd53.5562f51b151b000f=---

