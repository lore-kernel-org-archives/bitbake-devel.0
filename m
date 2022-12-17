Return-Path: <yosuke.nky@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCC8C4332F
	for <webhook@archiver.kernel.org>; Sat, 17 Dec 2022 15:52:42 +0000 (UTC)
Subject: Re: [PATCH] Enable to use some bitbake server commands
To: bitbake-devel@lists.openembedded.org
From: yosuke.nky@gmail.com
X-Originating-Location: Tokyo, JP (160.237.142.147)
X-Originating-Platform: Linux Chrome 107
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 17 Dec 2022 07:52:40 -0800
References: <666017467d067ed9473268336311c98dcad4dcad.camel@linuxfoundation.org>
In-Reply-To: <666017467d067ed9473268336311c98dcad4dcad.camel@linuxfoundation.org>
Message-ID: <12037.1671292360153891865@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="f6ikTK01R5MaSf3jqM3n"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Dec 2022 15:52:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14192

--f6ikTK01R5MaSf3jqM3n
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> I'd like to understand which objects are being passed which can't be mars=
halled
AFAIK, the type for the objects which can't be marshelled is `collections.d=
efaultdict`.

> I'm worried that two different behaviours between the transports where on=
e silently drops data isn't a good idea.
I agree. need to see if there is a way to convert to marshallizable object.

> I'd also be interested to learn more about how you're using bitbake if yo=
u can share anything?
I'm developing bbclient ( https://pypi.org/project/bbclient/ ) that=C2=A0pr=
ovides command interface for bitbake server. I'm working this as an part of=
 visual studio language server for bitbake.
I'm sorry. Not very common use, I know=F0=9F=98=85

--f6ikTK01R5MaSf3jqM3n
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<span style=3D"white-space: pre-wrap;">&gt; I'd like to understand which ob=
jects are being </span><span style=3D"white-space: pre-wrap;">passed which =
can't be marshalled <br /></span>AFAIK, the type for the objects which can'=
t be marshelled is `collections.defaultdict`.&nbsp;<br /><br />&gt;&nbsp;<s=
pan style=3D"white-space: pre-wrap;">I'm worried that two different behavio=
urs between </span><span style=3D"white-space: pre-wrap;">the transports wh=
ere one silently drops data isn't a good idea.</span><br />I agree. need to=
 see if there is a way to convert to marshallizable object.&nbsp;<br /><br =
/><span style=3D"white-space: pre-wrap;">&gt; I'd also be interested to lea=
rn more about how you're using bitbake if </span><span style=3D"white-space=
: pre-wrap;">you can share anything?<br /></span>I'm developing <a href=3D"=
https://pypi.org/project/bbclient/" target=3D"_blank" rel=3D"noopener">bbcl=
ient</a> that&nbsp;provides command interface for bitbake server. I'm worki=
ng this as an part of visual studio language server for bitbake.<br />I'm s=
orry. Not very common use, I know=F0=9F=98=85

--f6ikTK01R5MaSf3jqM3n--

