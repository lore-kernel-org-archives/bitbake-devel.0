Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630A4C27C4F
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 23:34:14 +0000 (UTC)
Subject: Re: [PATCH] fetch2/wget: Add user_agent parameter so it can be used optionally
To: bitbake-devel@lists.openembedded.org
From: "Livius" <egyszeregy@freemail.hu>
X-Originating-Location: Budapest, HU (80.98.74.198)
X-Originating-Platform: Windows Chrome 125
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 10 Jun 2024 16:34:09 -0700
References: <29B1D1C3-2E2F-467F-85BC-B265097BB933@arm.com>
In-Reply-To: <29B1D1C3-2E2F-467F-85BC-B265097BB933@arm.com>
Message-ID: <26684.1718062449079491240@lists.openembedded.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 23:34:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16344

On Fri, Jun  7, 2024 at 05:23 PM, Ross Burton wrote:

>=20
> What happens if we=E2=80=99re mostly truthful and have a useragent of =E2=
=80=9CBitbake=E2=80=9D
> instead of wget (which could be throttled) or faking a browser?
>=20
> Ross
>=20
>

Rules of user-agent says libraries like wget, curl etc just need to use the=
ir name and version number, so it means it can be BB_FETCH_USER_AGENT ??=3D=
 "bitbake/2.8.0" for Bitbake.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent#librar=
y_and_net_tool_ua_strings

But in case of crazy HTTP servers it is completely unpredictable how good i=
t will be in general. For example wget, curl has this format also but there=
 were some servers which denide them to use based on their user-agent.
All in all bitbake should use a default like BB_FETCH_USER_AGENT ??=3D "bit=
bake/2.8.0" and if there are any recipe which has issue, need to use a fake=
 browser user-agent to solve it, sure.

