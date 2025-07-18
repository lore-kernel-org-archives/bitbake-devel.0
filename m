Return-Path: <pamathieu@poum.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4457C83F17
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:50:13 +0000 (UTC)
Subject: Re: [PATCH v2] fetch2/wget: Keep query parameters in URL during checkstatus
To: bitbake-devel@lists.openembedded.org
From: "Philippe-Alexandre Mathieu" <pamathieu@poum.ca>
X-Originating-Location: =?UTF-8?B?UXXDqWJlYywgUXVlYmVjLCBDQQ==?= (70.83.120.90)
X-Originating-Platform: Windows Firefox 140
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 18 Jul 2025 07:50:08 -0700
References: <20250718144337.82440-1-pamathieu@poum.ca>
In-Reply-To: <20250718144337.82440-1-pamathieu@poum.ca>
Message-ID: <29250.1752850208301921790@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="rEfU6qzLj3XcID6REJtc"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 14:50:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17797

--rEfU6qzLj3XcID6REJtc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I accidentally overwrote the changelog from my patch, here it is again:
changes in v2: check if url contains query parameters; v1 would erroneously=
 add a trailing question mark for URLs without a query

--rEfU6qzLj3XcID6REJtc
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>I accidentally overwrote the changelog from my patch, here it is again=
:</div>
<div>changes in v2: check if url contains query parameters; v1 would errone=
ously add a trailing question mark for URLs without a query</div>

--rEfU6qzLj3XcID6REJtc--

