Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D76CD4F5B
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 07:17:36 +0000 (UTC)
Subject: Re: [PATCH 1/2] fetch2: Add gomod fetcher
To: bitbake-devel@lists.openembedded.org
From: "Christian Lindeberg" <christian.lindeberg@axis.com>
X-Originating-Location: =?UTF-8?B?THVuZCwgU2vDpW5lIENvdW50eSwgU0U=?= (195.60.68.152)
X-Originating-Platform: Linux Chrome 127
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 05 Sep 2024 00:17:32 -0700
References: <aedee457-1262-4399-a12f-b9d0d3f7867b@windriver.com>
In-Reply-To: <aedee457-1262-4399-a12f-b9d0d3f7867b@windriver.com>
Message-ID: <8999.1725520652582634441@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="F1cAHwNI0Rk9FVRXOgwc"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Sep 2024 07:17:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16539

--F1cAHwNI0Rk9FVRXOgwc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 08:19 AM, Chen Qi wrote:

>=20
> Can the mods be re-used (serving as some kind of mirror) from an
> existing download directory?
>=20
> Regards,
> Qi

The module zip files and go.mod files are fetched with the underlying wget
fetcher (or git fecher in the git vcs repository case) so the same principl=
es
with download cache and mirrors apply.

Thanks,
Christian

--F1cAHwNI0Rk9FVRXOgwc
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Tue, Sep 3, 2024 at 08:19 AM, Chen Qi wrote:</div>
<div>
<blockquote>Can the mods be re-used (serving as some kind of mirror) from a=
n <br />existing download directory?<br /><br />Regards,<br />Qi</blockquot=
e>
The module zip files and go.mod files are fetched with the underlying wget<=
br />fetcher (or git fecher in the git vcs repository case) so the same pri=
nciples<br />with download cache and mirrors apply.</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Christian</div>

--F1cAHwNI0Rk9FVRXOgwc--

