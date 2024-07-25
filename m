Return-Path: <andrii.sosiuk@seco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98157C3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 14:29:17 +0000 (UTC)
Subject: Re: Bitbake does not perform to unpack tarball after second and other downloads for PREMIRRORs and MIRRORS
To: bitbake-devel@lists.openembedded.org
From: andrii.sosiuk@seco.com
X-Originating-Location: Grosshaslach, Bavaria, DE (176.95.71.126)
X-Originating-Platform: Windows Chrome 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 25 Jul 2024 07:29:13 -0700
References: <CANNYZj9rgXQ-FgK_BiCip=_yA-m3AG8aMQDLZMNuM0=nMt5Bag@mail.gmail.com>
In-Reply-To: <CANNYZj9rgXQ-FgK_BiCip=_yA-m3AG8aMQDLZMNuM0=nMt5Bag@mail.gmail.com>
Message-ID: <19753.1721917753465007832@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="7NjmdXdbHFTWjxiO3uGv"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jul 2024 14:29:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16436

--7NjmdXdbHFTWjxiO3uGv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the reply!
I have analyzed the issue further and created tests in bitbake/lib/bb/tests=
/fetch.py.
The initial version in which I encountered this issue was 1.46.
As the tests showed the issue exist in the 1.46 but the latest version does=
 not have this issue.

I also found the commits that resolve the issue:

* b47ecab3e3aad5c5c376ec023aa82a51aa0f3b86
* 69588e2a5c7c200e47b02b2391498dcb72388bd2

I am unsure if version 1.46 is still supported and whether it makes sense t=
o backport the fix to 1.46.

Best regards,=C2=A0 =C2=A0Andrii

--7NjmdXdbHFTWjxiO3uGv
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Thanks for the reply!</div>
<div>I have analyzed the issue further and created tests in bitbake/lib/bb/=
tests/fetch.py. <br />The initial version in which I encountered this issue=
 was 1.46. <br />As the tests showed the issue exist in the 1.46 but the la=
test version does not have this issue. <br /><br />I also found the commits=
 that resolve the issue:</div>
<ul>
<li>b47ecab3e3aad5c5c376ec023aa82a51aa0f3b86</li>
<li>69588e2a5c7c200e47b02b2391498dcb72388bd2</li>
</ul>
<div><br />I am unsure if version 1.46 is still supported and whether it ma=
kes sense to backport the fix to 1.46.<br /><br />Best regards,&nbsp; &nbsp=
;Andrii</div>

--7NjmdXdbHFTWjxiO3uGv--

