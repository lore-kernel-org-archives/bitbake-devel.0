Return-Path: <yocto@vilimpoc.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F740C27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 11:53:09 +0000 (UTC)
Subject: bbappend sanity check
To: bitbake-devel@lists.openembedded.org
From: yocto@vilimpoc.org
X-Originating-Location: Berlin, Land Berlin, DE (158.181.79.224)
X-Originating-Platform: Windows Chrome 125
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 14 Jun 2024 04:53:02 -0700
Message-ID: <0Lyr.1718365982521038121.PqE6@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="5FfwW5NzmvS1tZMdrwBH"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Jun 2024 11:53:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16357

--5FfwW5NzmvS1tZMdrwBH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Would it be possible to add a sanity check warning on bitbake if a bbappend=
 file has `SRC_URI =3D` instead of `SRC_URI +=3D`?
It took me more time than I'd like to admit figuring out why the Linux kern=
el was wiping out its git/ checkout and then failing all subsequent steps s=
tarting with the kernel metadata check, which seemed unrelated to the root =
cause. :-)

Max

--5FfwW5NzmvS1tZMdrwBH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,<br /><br />Would it be possible to add a sanity check warning on bitbak=
e if a bbappend file has `SRC_URI =3D` instead of `SRC_URI +=3D`?<br />It t=
ook me more time than I'd like to admit figuring out why the Linux kernel w=
as wiping out its git/ checkout and then failing all subsequent steps start=
ing with the kernel metadata check, which seemed unrelated to the root caus=
e. :-)<br /><br />Max

--5FfwW5NzmvS1tZMdrwBH--

