Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494F8CA9ED2
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 08:42:43 +0000 (UTC)
Received: from prod-mta-13-01.swg-srv.net (prod-mta-13-01.swg-srv.net [185.255.28.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8974.1791794557134733320
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Oct 2026 01:42:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=eeFFX4Zn;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.34, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a12f47133e00080d7@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=++1isgSd+y57fFjahCyn/LEzCDEwx3SUeIhnIqKv5Bg=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=eeFFX4Znqm69nfLYKLGepG/OBwwE/WD3F/Md02yoqRIqPHNvCy6+bhSI3WuXZwYfSPduX4hBS
 X7HpGySY67yFCYGJGSzKQyPZdQ498+QW8GwgaJ7NfL1ODP31Tllv7DSZM57swRqXutdMjBlXrNP
 8T3LjWy3ZuRWZV8npLLmK60+hjbPNxDAyWy+xVV3CDXLySD+PcytYlfPQRxJ89ibd/TkJLcttKZ
 bVCgyx7tWdhHWxVrXABMgMxtWAcZNPgiIhqrIgyDh54WJ6eyJYpCtxNNkVSlusma1XaM+/Emclw
 UE1+t0qNBlgy5QQM1PZzb61hS+oxyNVmDtG7xVaCrdrQ==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-01.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a12f47133e00080d7.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 12 Oct 2026 08:42:29 +0000
X-Zone-Loop: d3810584fc780c9827337c55dcf94961358db78d0d76
x-campaign-type: default
x-transaction-id: 630e5a15-fca3-4354-b0d4-a7259bd42157
x-swg-uid: 01-a82a7864-2d97-4d06-a04c-ca1f19ae85f5
X-Mailer: Sweego
Message-ID: 
 <1791794549.8631fc262581453bbf619ec5b2062170.1a12f47133e00080d7@vates.tech>
x-swg-bid: 1791794549.8631fc262581453bbf619ec5b2062170.1a12f47133e00080d7
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id A290A81EBC;
	Mon, 12 Oct 2026 10:42:28 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>,
	docs@lists.yoctoproject.org
Subject: [PATCH v2 0/2] capital letters in overrides
Date: Mon, 12 Oct 2026 10:39:38 +0200
In-Reply-To: <20261007125138.59937-1-yann.dirson@vates.tech>
References: <20261007125138.59937-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.bc.9b3ebc57e4765bb7.1a12f4710b2.2165ab826264efb8=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791794548915
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Oct 2026 08:42:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20317

---=Part.bc.9b3ebc57e4765bb7.1a12f4710b2.2165ab826264efb8=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

New in v2:
- use @unittest=2EexpectedFailure

Yann Dirson (2):
  parse: add a (failing) test for a variable override with capital
    letters
  data_smart: restore the ability to use capital letters

 lib/bb/data_smart=2Epy  |  2 +-
 lib/bb/tests/parse=2Epy | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

--=20
2=2E47=2E3



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.bc.9b3ebc57e4765bb7.1a12f4710b2.2165ab826264efb8=---

