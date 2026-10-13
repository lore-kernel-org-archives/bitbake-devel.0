Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF306CC6B10
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 13:53:15 +0000 (UTC)
Received: from prod-mta-13.swg-srv.net (prod-mta-13.swg-srv.net [185.255.28.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7764.1791899585972883330
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 06:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=lsREqYb6;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.18, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a13589bd930008425@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=BAI3xZtmlTjD8Gopgm11R1NjpPsfX6x5bwwLTg/1eNQ=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=lsREqYb67CBVNe33UMWcFasYrFl+vWdMwYsE8OKd4D5i8gz+JN4vufNzYgKEyVENugxfZn06y
 cc2PKKCvvRSgT4CjGgPwgtjBNqhLXByj6w2KJNhQB9FLksrrX5dr85cAI9yYZPGVOAGOntvuQLR
 VNtvA1SdU/uR9JEgdt7YTk1vJ1C0a3o3zCAxFNgk0VfITC1JRlDbPaizPr/mbwRYpL4JFyISmEj
 z89ZKbeCOO/HmvupmyMDjnfu+yNh8nTuQdYLXZ2+LfEqxXLLdaBCiQ4pV9spG6AUA2B1Aq9tleb
 3UnKpxA5RQy+6skC6bD84MpjMl/QSsMTxgRfP0Bg3+pg==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a13589bd930008425.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 13 Oct 2026 13:53:01 +0000
X-Zone-Loop: 8b40f0ecad915b4d07c84e7052bfd9b94de276303d5e
x-campaign-type: default
x-transaction-id: 3276bd32-37ad-4f80-97de-15498ec3c873
x-swg-uid: 01-d510cbeb-a96c-4c8b-8232-538d6155ca05
X-Mailer: Sweego
Message-ID: 
 <1791899581.8631fc262581453bbf619ec5b2062170.1a13589bd930008425@vates.tech>
x-swg-bid: 1791899581.8631fc262581453bbf619ec5b2062170.1a13589bd930008425
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from work-vates.gpn.vates.fr (ip-185-175-148-127.naitways.net [185.175.148.127])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id DA7FB81F61;
	Tue, 13 Oct 2026 15:53:00 +0200 (CEST)
From: Yann Dirson <yann.dirson@vates.tech>
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann.dirson@vates.tech>,
	docs@lists.yoctoproject.org
Subject: [PATCH v3 0/4] capital letters in overrides
Date: Tue, 13 Oct 2026 15:52:13 +0200
In-Reply-To: <20261012084202.103724-1-yann.dirson@vates.tech>
References: <20261012084202.103724-1-yann.dirson@vates.tech>
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.16b.e0e6fdece8b686a8.1a13589ba48.10cb90970aaf3dc0=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791899581000
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 13:53:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20333

---=Part.16b.e0e6fdece8b686a8.1a13589ba48.10cb90970aaf3dc0=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

New in v3:
- add a test showing non-expansion of lowercase variable in override
- fix that, which also fixes the regression observed in v2

New in v2:
- use @unittest=2EexpectedFailure

Yann Dirson (4):
  data: add a (failing) test showing non-expansion of lowercase variable
    in override
  data_smart: differ taking overrides with unexpanded variables into
    account
  parse: add a (failing) test for a variable override with capital
    letters
  data_smart: restore the ability to use capital letters

 lib/bb/data_smart=2Epy  |  2 +-
 lib/bb/tests/data=2Epy  | 10 ++++++++++
 lib/bb/tests/parse=2Epy | 21 +++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

--=20
2=2E47=2E3



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.16b.e0e6fdece8b686a8.1a13589ba48.10cb90970aaf3dc0=---

