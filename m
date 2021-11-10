Return-Path: <gabriel.valcazar@digi.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D52FC433EF
	for <webhook@archiver.kernel.org>; Wed, 10 Nov 2021 15:15:33 +0000 (UTC)
Subject: Re: [PATCH 1/2] fetch/git: Handle github dropping git:// support
To: bitbake-devel@lists.openembedded.org
From: gabriel.valcazar@digi.com
X-Originating-Location: =?utf-8?b?TGXDs24sIENhc3RpbGxlIGFuZCBMZcOzbiwgRVMg?=
 =?utf-8?b?KDgxLjQ3LjE2NS40MCk=?=
X-Originating-Platform: Linux Firefox 94
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 10 Nov 2021 07:15:32 -0800
References: 
 <CA+chaQc1n4sZDrNvBN5HGebqWLKLSXFr2w9xDEKhQMEfg_dOrQ@mail.gmail.com>
In-Reply-To: 
 <CA+chaQc1n4sZDrNvBN5HGebqWLKLSXFr2w9xDEKhQMEfg_dOrQ@mail.gmail.com>
Message-ID: <22842.1636557332722004495@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="xsdukeGUvpg9r5KL6SnA"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 15:15:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12988

--xsdukeGUvpg9r5KL6SnA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks all for the suggestions. Indeed, creating a fork of poky and applyin=
g the fix ourselves seems like a reasonable solution if there is no officia=
l fix for old versions.

I've just tested applying the patch to *bitbake 1.18* , and I'm able to bui=
ld my Yocto 1.4 distribution with no problem. Is it not possible to officia=
lly backport the patch all the way back to bitbake 1.18? I could provide th=
e patches, but they're literally just clean cherry-picks of the bitbake 1.4=
0 patch.

Regards,
Gabriel

--xsdukeGUvpg9r5KL6SnA
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks all for the suggestions. Indeed, creating a fork of poky and applyin=
g the fix ourselves seems like a reasonable solution if there is no officia=
l fix for old versions.<br /><br />I've just tested applying the patch to <=
strong>bitbake 1.18</strong>, and I'm able to build my Yocto 1.4 distributi=
on with no problem. Is it not possible to officially backport the patch all=
 the way back to bitbake 1.18? I could provide the patches, but they're lit=
erally just clean cherry-picks of the bitbake 1.40 patch.<br /><br />Regard=
s,<br />Gabriel

--xsdukeGUvpg9r5KL6SnA--

