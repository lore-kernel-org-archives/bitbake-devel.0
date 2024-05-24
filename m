Return-Path: <mlynch@hi-techniques.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B34C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 13:57:51 +0000 (UTC)
Subject: Dependencies ?
To: bitbake-devel@lists.openembedded.org
From: "Michael Lynch" <mlynch@hi-techniques.com>
X-Originating-Location: Madison, Wisconsin, US (24.159.236.186)
X-Originating-Platform: Windows Chrome 94
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 24 May 2024 06:57:42 -0700
Message-ID: <lfcT.1716559062178660500.wc5p@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="5pYR2DyrmRU4bGigECY0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 13:57:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16252

--5pYR2DyrmRU4bGigECY0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I hope this is the correct place to ask this.=C2=A0 I'm in the process of u=
pdating from yocto kirkstone branches to yocto scarthgap branches and ran i=
nto an issue that brought up a question about yocto/bitbake dependencies.=
=C2=A0 My normal work flow for updating is to start with an empty directory=
 tree, clone all of the layers, checkout the specific branch (scarthgap)=C2=
=A0 for each and do a fresh build of core-image-minimal.=C2=A0 That all wen=
t smoothly except for a couple of recipes in the meta-intel layer.=C2=A0 Af=
ter messing around with it a bit and not finding a solution on my own I pos=
ted a message in the meta-intel forum.=C2=A0 The response was that the reci=
pes I was trying to build are not compatible with the version of clang from=
 the scarthgap branch of meta-clang and that I needed to use the mickeldore=
 branch of meta-clang.=C2=A0 So here are my questions, first, is there some=
 way to find out if a recipe depends on specific versions of items?=C2=A0 S=
econd, is there a way for yocto/bitbake to inform the user when there is a =
specific version dependency issue instead of the recipe simply failing to b=
uild?=C2=A0 Thanks and mostly just curious.

-- Mike

--5pYR2DyrmRU4bGigECY0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,<br /><br />I hope this is the correct place to ask this.&nbsp; I'm =
in the process of updating from yocto kirkstone branches to yocto scarthgap=
 branches and ran into an issue that brought up a question about yocto/bitb=
ake dependencies.&nbsp; My normal work flow for updating is to start with a=
n empty directory tree, clone all of the layers, checkout the specific bran=
ch (scarthgap)&nbsp; for each and do a fresh build of core-image-minimal.&n=
bsp; That all went smoothly except for a couple of recipes in the meta-inte=
l layer.&nbsp; After messing around with it a bit and not finding a solutio=
n on my own I posted a message in the meta-intel forum.&nbsp; The response =
was that the recipes I was trying to build are not compatible with the vers=
ion of clang from the scarthgap branch of meta-clang and that I needed to u=
se the mickeldore branch of meta-clang.&nbsp; So here are my questions, fir=
st, is there some way to find out if a recipe depends on specific versions =
of items?&nbsp; Second, is there a way for yocto/bitbake to inform the user=
 when there is a specific version dependency issue instead of the recipe si=
mply failing to build?&nbsp; Thanks and mostly just curious.<br /><br />-- =
Mike

--5pYR2DyrmRU4bGigECY0--

