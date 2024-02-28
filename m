Return-Path: <cordlandwehr@kde.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2EBC54E41
	for <webhook@archiver.kernel.org>; Wed, 28 Feb 2024 18:30:47 +0000 (UTC)
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by mx.groups.io with SMTP id smtpd.web11.4371.1709145044658758009
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Feb 2024 10:30:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kde.org header.s=users header.b=PbLD1upc;
 spf=pass (domain: kde.org, ip: 46.43.1.242, mailfrom: cordlandwehr@kde.org)
Received: from [IPv6:::1] (unknown [IPv6:2a01:599:612:7563:5f7d:47ab:abdd:6b1e])
	(Authenticated sender: cordlandwehr)
	by letterbox.kde.org (Postfix) with ESMTPSA id E531F33F3EF;
	Wed, 28 Feb 2024 18:30:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
	t=1709145042; bh=4PR2bdl0+Gc4jAQ1X+tMlrZFu4SBkFEZVgC56UFlSyQ=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=PbLD1upcd+ZJ2Yx9STz5cHygOMY3rIdeQBkknox7Hk4zKTYYy8r38Q0a54qiDgLcc
	 lmEcsB6we4moGmw+KbK5wb/DCDaFY1eUWQKYRn+3r/rwrHojyCKWOhdj0bhSAj0xvo
	 sFG+9Lxnr4miTrSRIUijK3uMF1frqwEL9Uibt7zLezAA3XFGVODpiF0FJdVwrrXqxn
	 PlaVYQdYvRutMgZ2js36qkmDWgTahx3OkCFXIS6lz6HAqIT/PCqLuo9blFhpuIH/dN
	 Ft/4dEpnHrX5QzE2BZufJ0gGBkeW5Szd15eTduMPf7eBB+qmZawnkplwLOk3yndZeQ
	 3oNvYJf4dyMAA==
Date: Wed, 28 Feb 2024 19:30:37 +0100
From: Andreas Cord-Landwehr <cordlandwehr@kde.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Andreas Cord-Landwehr <cordlandwehr@kde.org>,
 bitbake-devel@lists.openembedded.org
Subject: =?US-ASCII?Q?Re=3A_=5Bbitbake-devel=5D_=5BPATCH=5D_fetch2/gitsm=2E?= =?US-ASCII?Q?py=3A_handle_spaces_in_git_repository_paths?=
User-Agent: K-9 Mail for Android
In-Reply-To: <abb50c8c7e143d2e7154d3ab89a240fc2a5ce981.camel@linuxfoundation.org>
References: <20240227173527.726401-1-cordlandwehr@kde.org> <abb50c8c7e143d2e7154d3ab89a240fc2a5ce981.camel@linuxfoundation.org>
Message-ID: <6D17B283-88D3-40D5-8BB9-AFA2CFA493EC@kde.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Feb 2024 18:30:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15976

Hi Richard, thank you for the fast response!
At the moment I only have access to a closed server (AzureDevOps based) wh=
ich allows creation of repositories with spaces=2E For GitHub eg=2E I check=
ed that they replace spaces with a hyphen and so avoid any problems=2E Prob=
ably a simple rewrite rule may work though=2E=2E=2E? But I do not have a st=
able server at hand that I could offer as a permanent source for tests=2E B=
ut I will check if I can find a solution=2E

Regarding the issue itself=2E Already the git fetcher requires %20 spaces =
to be encoded as %2520 in SRC_URI statements=2E So I expected that URLs are=
 always expected to be double encoded=2E Is that not the case?

Best regards,
Andreas

Am 28=2E Februar 2024 10:21:19 MEZ schrieb Richard Purdie <richard=2Epurdi=
e@linuxfoundation=2Eorg>:
>On Tue, 2024-02-27 at 18:35 +0100, Andreas Cord-Landwehr wrote:
>> Handle encoding of spaces for the obscure but real-world scenario of
>> having a git repository with submodules, where the urls to submodules
>> contain spaces, eg=2E https://example=2Ecom/foo/repo%20with%20space=2Eg=
it
>>=20
>> Git submodules are referenced with single escaping, yet the fetcher
>> requires double-escaping of spaces=2E
>>=20
>> Signed-off-by: Andreas Cord-Landwehr <cordlandwehr@kde=2Eorg>
>> ---
>> =C2=A0bitbake/lib/bb/fetch2/gitsm=2Epy | 6 ++++++
>> =C2=A01 file changed, 6 insertions(+)
>>=20
>> diff --git a/bitbake/lib/bb/fetch2/gitsm=2Epy b/bitbake/lib/bb/fetch2/g=
itsm=2Epy
>> index f7f3af7212=2E=2Ee37be055eb 100644
>> --- a/bitbake/lib/bb/fetch2/gitsm=2Epy
>> +++ b/bitbake/lib/bb/fetch2/gitsm=2Epy
>> @@ -23,6 +23,7 @@ import copy
>> =C2=A0import shutil
>> =C2=A0import tempfile
>> =C2=A0from=C2=A0=C2=A0 bb=2Efetch2=2Egit import Git
>> +from=C2=A0=C2=A0 bb=2Efetch2 import URI
>> =C2=A0from=C2=A0=C2=A0 bb=2Efetch2 import runfetchcmd
>> =C2=A0from=C2=A0=C2=A0 bb=2Efetch2 import logger
>> =C2=A0from=C2=A0=C2=A0 bb=2Efetch2 import Fetch
>> @@ -93,6 +94,11 @@ class GitSM(Git):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newud=2Epath =3D os=2Ep=
ath=2Enormpath(os=2Epath=2Ejoin(newud=2Epath, uris[m]))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uris[m] =3D Git=2E_get_=
repo_url(self, newud)
>> =C2=A0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 # Double-encode before handing over to git to handle =
spaces in URLs
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 double_encoded_uri =3D URI(uris[m])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 double_encoded_uri=2Epath =3D double_encoded_uri=2Epa=
th_quoted
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uris[m] =3D str(double_encoded_uri)
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for module in submodul=
es:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 # Translate the module url into a SRC_URI
>
>Thanks for the patch, I think this may need some work though=2E
>
>Double encoding feels like a workaround for the issue and this probably
>needs a different fix where we only decode the data once=2E That is
>likely more invasive but ultimately more correct else I worry we'd have
>to triple encode second level submodules or other horrible things=2E
>
>Also is there a testcase we could add to bitbake-selftest to cover
>this? The fetcher is tricky to work on due to all the corner cases so
>we do try to cover them in the testsuite=2E
>
>Cheers,
>
>Richard
>
>
>

