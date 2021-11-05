Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371E9C433FE
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 18:05:57 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web12.9307.1636135553885871420
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 11:05:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=TIRNKHaZ;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
Date: Fri, 05 Nov 2021 19:05:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1636135551;
	bh=2jdoaLRilwZeoATN3+hDaahAlTCnkxpypVPrETX1BBI=;
	h=From:To:CC:Subject:In-Reply-To:References;
	b=TIRNKHaZTATLWff7nufwHAfR6I+XjqLeP0odnkhj3pKZkKpZJTWPZlhrbN/S3VfAR
	 C9p/Pcd1WyOu2GY1cz4rxCdzkeTpU56AW/gKMAFmjIGVlCHQs2Sd4w3gY3Gs1rIOY6
	 5QKcw9zT0IxUIGFdn3nR8Gj0VuYHB5OKPwD203Ba2SmYVlOCu77jxSOri79htAHsPi
	 fl0dHNbr94WvOp+Fi92nVo7jvDQUvSHwOMecnVHU8Oh6vzcgkKpz5R6j1Ty3x9hsTk
	 jnve/xjik2uvZNaJkOXGc1xjg9mIyy+A4gENgeI3OiriNw2tLEZrFh2V663jO4lFXf
	 3QRSEFcpDhNhA==
From: Jasper Orschulko <jasper@fancydomain.eu>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
 Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
CC: "openembedded-core@lists.openembedded.org"
 <openembedded-core@lists.openembedded.org>,
 "martin@mko.dev" <martin@mko.dev>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: =?US-ASCII?Q?Re=3A_=5Bbitbake-devel=5D_=5Boe-core=5D=5BPATCH_1/2=5D?=
 =?US-ASCII?Q?_devtools=3A_Initial_recipe_for_repo_2=2E17=2E3?=
In-Reply-To: 
 <CANNYZj9sxmakRNGKUuH+ZAWDMJs2EhKT5O4f8HRxd=ovhQPpug@mail.gmail.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
 <CANNYZj_s8_PkKfMQnBxNZLs-p0F5xb4StCXiF84OkbE5zpptqw@mail.gmail.com>
 <ea3f24549a6e54f880e925e8f5cf6128fc5629f9.camel@iris-sensing.com>
 <CANNYZj9sxmakRNGKUuH+ZAWDMJs2EhKT5O4f8HRxd=ovhQPpug@mail.gmail.com>
Message-ID: <281CD8F4-9B15-40A6-9AAE-F2C0D633E5AD@fancydomain.eu>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----4XK4ATX5V7LEB7EH07P3FZ88VO7S6E
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 18:05:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12917

------4XK4ATX5V7LEB7EH07P3FZ88VO7S6E
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alex,

> that you invented a custom, proprietary=20
> workflow that you have to support entirely by > yourselves

We are not though=2E We are integrating an established tool for multi-repo=
sitory management into yocto=2E Google repo is not proprietary by the way, =
it is permissive licensed=2E It is just a little "special" in it's modus op=
erandi=2E

> instead of finding ways to do what you need
> with standard yocto tooling, improving the
> tooling where/if necessary=2E

But that is exactly what we are doing, by integrating the repo fetcher int=
o the yocto workflow, thus improving the yocto tooling :)
Why reinvent the wheel, when you can reuse whats already there? You wouldn=
't reinvent git just for yocto, would you?

Best regards,
Jasper


On 5 November 2021 18:46:27 CET, Alexander Kanavin <alex=2Ekanavin@gmail=
=2Ecom> wrote:
>On Fri, 5 Nov 2021 at 16:24, Jasper Orschulko <
>Jasper=2EOrschulko@iris-sensing=2Ecom> wrote:
>
>>
>> In our case some binary which is made up from some 50ish separately
>> versioned sub-components=2E We used to have separate recipes for each o=
f
>> this components and static link them using DEPENDS=2E However, this doe=
s
>> not scale well=2E E=2Eg=2E if you want to create another version with
>> different cmake flags, you would have to create copies of all 50ish
>> recipes=2E You could move all the components into a single recipe and d=
o
>> 50x git fetcher, but keeping this versioned is still painful=2E
>> Especially since the developers mainly don't use yocto but use the SDK
>> for cross-compiling=2E As such this used to mean, that versioning in th=
e
>> development workflow and the release workflow worked differently ->
>> more maintenance work=2E
>>
>> With repo fetcher we can streamline the versioning within the yocto
>> build process and the daily developer workflow, as both can fetch the
>> repo manifest from a central stored git repo=2E The idea is, that the
>> repo manifest defaults to develop branch for all component repos and if
>> we want to create a release we can use repos own tooling to
>> automatically create fixed refspecs from the development manifest=2E
>> something like `repo manifest -r -o release-1=2E0=2E0=2Exml`, push that=
 as a
>> release to the manifest repo, set this release as refspec in the recipe
>> within the meta layer and proceed with the release process=2E So no mor=
e
>> manually maintaining the component versioning within the yocto recipes=
=2E
>>
>
>I see=2E I don't particularly endorse that you invented a custom, proprie=
tary
>workflow that you have to support entirely by yourselves - instead of
>finding ways to do what you need with standard yocto tooling, improving t=
he
>tooling where/if necessary=2E But if that works out ok for you, then fine=
 :)
>
>Alex

------4XK4ATX5V7LEB7EH07P3FZ88VO7S6E
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Hi Alex,<br><br>&gt; that you invented a custom, p=
roprietary <br>&gt; workflow that you have to support entirely by &gt; your=
selves<br><br>We are not though=2E We are integrating an established tool f=
or multi-repository management into yocto=2E Google repo is not proprietary=
 by the way, it is permissive licensed=2E It is just a little "special" in =
it's modus operandi=2E<br><br>&gt; instead of finding ways to do what you n=
eed<br>&gt; with standard yocto tooling, improving the<br>&gt; tooling wher=
e/if necessary=2E<br><br>But that is exactly what we are doing, by integrat=
ing the repo fetcher into the yocto workflow, thus improving the yocto tool=
ing :)<br>Why reinvent the wheel, when you can reuse whats already there? Y=
ou wouldn't reinvent git just for yocto, would you?<br><br>Best regards,<br=
>Jasper<br><br><br><div class=3D"gmail_quote">On 5 November 2021 18:46:27 C=
ET, Alexander Kanavin &lt;alex=2Ekanavin@gmail=2Ecom&gt; wrote:<blockquote =
class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1p=
x solid rgb(204, 204, 204); padding-left: 1ex;">
<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri, 5 Nov 2021 at 16:24, Jasper Orschulko &lt;<a href=3D"mailto=
:Jasper=2EOrschulko@iris-sensing=2Ecom">Jasper=2EOrschulko@iris-sensing=2Ec=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0=2E8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><br>
In our case some binary which is made up from some 50ish separately<br>
versioned sub-components=2E We used to have separate recipes for each of<b=
r>
this components and static link them using DEPENDS=2E However, this does<b=
r>
not scale well=2E E=2Eg=2E if you want to create another version with<br>
different cmake flags, you would have to create copies of all 50ish<br>
recipes=2E You could move all the components into a single recipe and do<b=
r>
50x git fetcher, but keeping this versioned is still painful=2E<br>
Especially since the developers mainly don't use yocto but use the SDK<br>
for cross-compiling=2E As such this used to mean, that versioning in the<b=
r>
development workflow and the release workflow worked differently -&gt;<br>
more maintenance work=2E<br>
<br>
With repo fetcher we can streamline the versioning within the yocto<br>
build process and the daily developer workflow, as both can fetch the<br>
repo manifest from a central stored git repo=2E The idea is, that the<br>
repo manifest defaults to develop branch for all component repos and if<br=
>
we want to create a release we can use repos own tooling to<br>
automatically create fixed refspecs from the development manifest=2E<br>
something like `repo manifest -r -o release-1=2E0=2E0=2Exml`, push that as=
 a<br>
release to the manifest repo, set this release as refspec in the recipe<br=
>
within the meta layer and proceed with the release process=2E So no more<b=
r>
manually maintaining the component versioning within the yocto recipes=2E<=
br></blockquote><div><br></div>I see=2E I don't particularly endorse that y=
ou invented a custom, proprietary workflow that you have to support entirel=
y by yourselves - instead of finding ways to do what you need with standard=
 yocto tooling, improving the tooling where/if necessary=2E But if that wor=
ks out ok for you, then fine :)</div><div class=3D"gmail_quote"><br></div><=
div class=3D"gmail_quote">Alex<br></div></div>
</blockquote></div></body></html>
------4XK4ATX5V7LEB7EH07P3FZ88VO7S6E--

