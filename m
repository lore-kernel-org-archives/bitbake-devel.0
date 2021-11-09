Return-Path: <gabriel.valcazar@digi.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F93CC433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 15:40:27 +0000 (UTC)
Subject: Re: [PATCH 1/2] fetch/git: Handle github dropping git:// support
To: bitbake-devel@lists.openembedded.org
From: gabriel.valcazar@digi.com
X-Originating-Location: =?utf-8?b?TGXDs24sIENhc3RpbGxlIGFuZCBMZcOzbiwgRVMg?=
 =?utf-8?b?KDgxLjQ3LjE2NS40MCk=?=
X-Originating-Platform: Linux Firefox 94
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 09 Nov 2021 07:40:26 -0800
References: 
 <6a5db3389ed956233ca71f9b72b2fc051386ac34.camel@linuxfoundation.org>
In-Reply-To: 
 <6a5db3389ed956233ca71f9b72b2fc051386ac34.camel@linuxfoundation.org>
Message-ID: <450.1636472426380500781@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="JPmf7DVX2m2bQ5u7O7GT"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 15:40:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12982

--JPmf7DVX2m2bQ5u7O7GT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Are there any plans to backport this fix to older versions of bitbake/poky?=
 My company has a line of legacy embedded products that are only supported =
in older versions of our Yocto distribution (1.3 in the most extreme case),=
 and although we can manually change the protocol from git to https in the =
recipes in our layer, we can't do the same for other third party layers our=
 distribution depends on (meta-qt5, meta-freescale, poky...). Since backpor=
ting the fix to older bitbake versions is trivial, do you intend to incorpo=
rate it in older bibake/poky versions in the near future?

Otherwise, are there any alternative approaches we can take to ensure that =
users that depend on our legacy products can continue to build our Yocto di=
stribution? Upgrading our entire legacy line to newer Yocto versions is not=
 a viable solution for us.

Thanks and best regards,
Gabriel

--JPmf7DVX2m2bQ5u7O7GT
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,<br /><br />Are there any plans to backport this fix to older ve=
rsions of bitbake/poky? My company has a line of legacy embedded products t=
hat are only supported in older versions of our Yocto distribution (1.3 in =
the most extreme case), and although we can manually change the protocol fr=
om git to https in the recipes in our layer, we can't do the same for other=
 third party layers our distribution depends on (meta-qt5, meta-freescale, =
poky...). Since backporting the fix to older bitbake versions is trivial, d=
o you intend to incorporate it in older bibake/poky versions in the near fu=
ture?<br /><br />Otherwise, are there any alternative approaches we can tak=
e to ensure that users that depend on our legacy products can continue to b=
uild our Yocto distribution? Upgrading our entire legacy line to newer Yoct=
o versions is not a viable solution for us.<br /><br />Thanks and best rega=
rds,<br />Gabriel

--JPmf7DVX2m2bQ5u7O7GT--

