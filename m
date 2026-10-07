Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06553CA5FFC
	for <webhook@archiver.kernel.org>; Wed,  7 Oct 2026 12:52:06 +0000 (UTC)
Received: from prod-mta-13-02.swg-srv.net (prod-mta-13-02.swg-srv.net [185.255.28.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8806.1791377517717733389
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Oct 2026 05:51:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=Vb96uXVX;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.35, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a1166b9b2a0003f66@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=/GGacat9nNtLPkGQ1BtiBvBbKjntGajxObvqv9O3/QI=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=Vb96uXVXk2IheQaKj0o+UAI4uTTB3hg9iNsodKSrS9DnbFPymrkgBqfjWd9WaNLKWa5ystxb1
 UYIioKjNwkJVGAJIhlLmxVu6cLNRoYGdtRwQh2BxxceygWrVwMdV5pYFU0mrkLrobVFXydNn/eE
 Nhg2exbUCLUECDZZw6Vk4GI5l75zl8/RiHQJ05rwNZH1sJg8RRU4VRMH7eHjJYhRLKvgPyTL5FO
 WFDCCFNCmdKtvr8N1C3LuLqx/wT17gV68rk53shneHb8HVWqtxu+LZvedk6Zt8fhNpl/snfSEsx
 yKJZ4eEUbn41hFxejQ0HyQUsG8Tuw2kPm8PL18POq+7g==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-02.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a1166b9b2a0003f66.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 07 Oct 2026 12:51:53 +0000
X-Zone-Loop: 6df842d85acc7db2a78c301415dbf321df4a71eb829a
x-campaign-type: default
x-transaction-id: f6d0feb6-ddfb-486d-bf88-f6011eeffdfe
x-swg-uid: 01-84b907fd-09c9-42c1-ae45-46d4a74815cc
X-Mailer: Sweego
Message-ID: 
 <1791377513.8631fc262581453bbf619ec5b2062170.1a1166b9b2a0003f66@vates.tech>
x-swg-bid: 1791377513.8631fc262581453bbf619ec5b2062170.1a1166b9b2a0003f66
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id BEC8C823F7;
	Wed,  7 Oct 2026 14:51:52 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>
Subject: [PATCH 2/2] data_smart: restore the ability to use capital letters
Date: Wed,  7 Oct 2026 14:51:37 +0200
In-Reply-To: <20261007125138.59937-1-yann.dirson@vates.tech>
References: <20261007125138.59937-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.6e9.7858d6331adaab14.1a1166b998a.5b7e8ae6ed47f872=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791377512842
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Oct 2026 12:52:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20304

---=Part.6e9.7858d6331adaab14.1a1166b998a.5b7e8ae6ed47f872=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This reverts commit 6eb56624e6d8dc1944e559b4f6584bfe66f566ba=2E

That commit was meant as an ad-hoc band-aid when "_" was used as
override prefix, and it explicitly blocked capital letters from being
usable in the overrides=2E  There is no reason to keep it now we use ":"
as prefix=2E

Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
---
 lib/bb/data_smart=2Epy | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
--=20
2=2E47=2E3



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.6e9.7858d6331adaab14.1a1166b998a.5b7e8ae6ed47f872=---

