Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31428C5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 10:12:52 +0000 (UTC)
Received: from prod-mta-13-01.swg-srv.net (prod-mta-13-01.swg-srv.net [185.255.28.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13530.1787566365021728176
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 03:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=MmWlI5zT;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.34, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a033420133000c4f3@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=l8Qv4koCPMJOp8FyqW9TLxha4CnMRAL+SK6rvfSt4KM=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:feedback-id;
 b=MmWlI5zTO6kC2cuj7YVu0r4E85eOPUy6aX7vnhEW80LcBb5FdHQkhO6TuyqyJEeLEEuqrIYnR
 M65bHN6VtxqGo7fW3s3zUmF1eM/76W+r4xcHIv5IvQRDgj7mCyiBRMcpp/NvCCN1jRHpvv4lhWu
 LK1BSO6yBG+5cCY7glEKJ+xp24TLxqZggTKeiPIBOiIsrT3CDDExc5xQ/Hyhxk2VbMQOgjJZMkn
 w8O+t1suobjTkOEmoJLYD0j3nIMtKPC0jJQI5yGonTfri+0CdDwEWxIcs+QqM1yC3o/Cu2OUlZF
 aVP7lry8VVUbChIBczmmM1RCZZ3skMBTE3PDImrvEBng==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-01.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a033420133000c4f3.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 24 Aug 2026 10:12:38 +0000
X-Zone-Loop: c21db4f66a4fd617724d1f90f1b8e913dcc3a7d009ae
x-campaign-type: default
x-transaction-id: 922b10f0-5393-4589-a6e9-b7bb353cc059
x-swg-uid: 01-f2117c9b-125e-4eff-a4ee-be8952a53578
X-Mailer: Sweego
Message-ID: 
 <1787566358.8631fc262581453bbf619ec5b2062170.1a033420133000c4f3@vates.tech>
x-swg-bid: 1787566358.8631fc262581453bbf619ec5b2062170.1a033420133000c4f3
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id CB38A82083;
	Mon, 24 Aug 2026 12:12:37 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Yann Dirson <yann.dirson@vates.tech>
Subject: [PATCH] doc/bitbake-user-manual-ref-variables: document PREFERRED_RPROVIDER
Date: Mon, 24 Aug 2026 12:12:19 +0200
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.29af.77d4775ab564adc.1a03341fd9d.9af5d1a67d6a0560=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1787566357918
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 10:12:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20021

---=Part.29af.77d4775ab564adc.1a03341fd9d.9af5d1a67d6a0560=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
---
 =2E=2E=2E/bitbake-user-manual-ref-variables=2Erst                | 9 ++++=
+++++
 1 file changed, 9 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Er=
st b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
index 5395ce5e3=2E=2E2756fc0c4 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
@@ -1558,6 +1558,15 @@ overview of their function and contents=2E
          PREFERRED_PROVIDER_xxx =3D "yyy"
          PREFERRED_PROVIDER_aaa =3D "bbb"
=20
+   :term:`PREFERRED_RPROVIDER` Determines which recipe should be given
+      preference when multiple packages rprovide the same item=2E Beware
+      this should contain the name of the *recipe* producing the
+      package that rprovides the item, not that of the package=2E Some
+      examples::
+
+         PREFERRED_RPROVIDER_initd-functions ?=3D "initscripts"
+         PREFERRED_RPROVIDER_virtual-libegl-icd ?=3D "mesa"
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
---=Part.29af.77d4775ab564adc.1a03341fd9d.9af5d1a67d6a0560=---

