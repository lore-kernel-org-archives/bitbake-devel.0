Return-Path: <vvavrychuk@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EDAC3DA6E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 21:52:16 +0000 (UTC)
Subject: how to appendVar via Tinfoil API
To: bitbake-devel@lists.openembedded.org
From: "Vasyl Vavrychuk" <vvavrychuk@gmail.com>
X-Originating-Location: Lviv, Lviv Oblast, UA (185.219.78.170)
X-Originating-Platform: Windows Chrome 120
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 08 Jan 2024 13:52:08 -0800
Message-ID: <rjF5.1704750728530444364.AHOb@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="mcPHkx1NLYhY6HBBMaLE"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 21:52:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15753

--mcPHkx1NLYhY6HBBMaLE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I would like temporary appendVar before parsing recipes via Tinfoil API. Sp=
ecifically, I want to do using Tinfoil API:

BB_MULTI_PROVIDER_ALLOWED +=3D "..."

and then call Tinfoil API to get all providers including skipped one.

Can I do appendVar using Tinfoil?

--mcPHkx1NLYhY6HBBMaLE
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I would like temporary appendVar before parsing recipes via Tinfoil API. Sp=
ecifically, I want to do using Tinfoil API:<br /><br />BB_MULTI_PROVIDER_AL=
LOWED +=3D "..."<br /><br />and then call Tinfoil API to get all providers =
including skipped one.<br /><br />Can I do appendVar using Tinfoil?

--mcPHkx1NLYhY6HBBMaLE--

