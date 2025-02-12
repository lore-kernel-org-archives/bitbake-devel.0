Return-Path: <louis.rannou@syslinbit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD275C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 07:49:14 +0000 (UTC)
Received: from 8.mo581.mail-out.ovh.net (8.mo581.mail-out.ovh.net [46.105.77.114])
 by mx.groups.io with SMTP id smtpd.web11.9959.1739346545647021819
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 23:49:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=CH7uhwzU;
 spf=softfail (domain: syslinbit.com, ip: 46.105.77.114, mailfrom: louis.rannou@syslinbit.com)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.140.151])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4Yt9Rz57Yyz1HbC
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 07:49:03 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-czdfm (unknown [10.110.188.92])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8A9751FECA;
	Wed, 12 Feb 2025 07:49:02 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.107])
	by ghost-submission-5b5ff79f4f-czdfm with ESMTPSA
	id ZUD9F25SrGdyGgAAoYBbgQ
	(envelope-from <louis.rannou@syslinbit.com>); Wed, 12 Feb 2025 07:49:02 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-107S0019d8cbbba-a5eb-4eda-aa58-7cd199310dbc,
                    74B36F6499D71BB1255966C6406869B815799905) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
Message-ID: <ffb1bcdc-81a1-4f1d-8547-865cc53186b7@syslinbit.com>
Date: Wed, 12 Feb 2025 08:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [scarthgap] backport request for ??= operator for
 variable flags fix
To: Yoann Congal <yoann.congal@smile.fr>,
 Louis Rannou <louis.rannou@non.se.com>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, Steve Sakoman <steve@sakoman.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>
References: <c0723d2e-7742-4746-bc78-b0aee82fb8ed@syslinbit.com>
 <CAMSfU+4cpu9nqUuAS18+1MTBpOnJPd52Yt1jK3XKH66ywJ09+Q@mail.gmail.com>
 <AS4PR04MB9316434BAC675FF7E4B83781A9FD2@AS4PR04MB9316.eurprd04.prod.outlook.com>
 <CAMSfU+6NiWiQfGQE1kt1XSSOB6=vFTuC=e1=z2Tub7NDZNtvmQ@mail.gmail.com>
Content-Language: en-US
From: Louis Rannou <louis.rannou@syslinbit.com>
In-Reply-To: <CAMSfU+6NiWiQfGQE1kt1XSSOB6=vFTuC=e1=z2Tub7NDZNtvmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Ovh-Tracer-Id: 5939966435948879237
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepnfhouhhishcutfgrnhhnohhuuceolhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmqeenucggtffrrghtthgvrhhnpefgkeefgeffhffhhfdvjeefvdetiefhhfevgfdvueefvedtfeetfeduudevuefgffenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdhophgvnhgvmhgsvgguuggvugdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdeghedrkedurdeivddrledpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheplhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdfovfetjfhoshhtpehmohehkedumgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=/g6mK/k2+ANWRwfnh5I+L8s1BGCSH7DiGjcJXEJ53aY=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1739346543; v=1;
 b=CH7uhwzUMv7ksR2yBjOMQzhuQRA8Lzubnq09RwuWK1NsBbMFZvUgjyME0GaLOepuk4Uvv1XT
 VCdOM5XUsM7AHc/YmiN7rxt/EKO2sja7uT61fb6LUKDaB9DihvBwWQJZ3s12SyvDVY83fMeNtOo
 nl3/i8ztQsDtgZtYsqbsdqAVFQzBc/7vWI+4u27MwcmpWRN8OrvFyVYV/AeJ56UDPn5sN9HlKLr
 HGQO9SitWOGCFg9MHAyw7wBHIaB9luP3py0eCRpecMzcJqZTQ4jGLAevn13ywnFFVRWc9hGgNyT
 DNMM9Gcar37GSo2rGbYoMhUrp6Kpy8K1cYN3P8sdE7f6g==
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 07:49:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17197



On 11/02/2025 18:19, Yoann Congal wrote:
> Le=C2=A0mar. 11 f=C3=A9vr. 2025 =C3=A0=C2=A016:33, Louis Rannou <louis.=
rannou@non.se.com=20
> <mailto:louis.rannou@non.se.com>> a =C3=A9crit=C2=A0:
>=20
>     Hello,
>=20
>=20
> Hello,
>=20
>     Please abort the request as I found some issue in relation. The
>     attached patch should confirm the issue.
>=20
>     Weak values are now omitted in getVarFlags (while they were
>     incorrect but present before 052746da9a7e96b43ec45a04322e8576a6cbaa=
b7.
>=20
>=20
> Hello,
>=20
> I've reoppened https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D1568=
5=20
> <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685> with your=20
> infomations, thanks!
>=20
> Weirdly, not all your emails appear in the archive : https://=20
> lists.openembedded.org/g/bitbake-devel/topics <https://=20
> lists.openembedded.org/g/bitbake-devel/topics>
> ... which means, only CC'd people received it.
> You may want to check that both your mail addresses are subscribed to=20
> the list.

Indeed my other mail is not registered, I have to fix that.

>=20
> Do you plan to work on it? If yes, don't hesitate to take the bug or ad=
d=20
> more info :)

I'm taking it, thank you

Louis

>=20
>     Louis Rannou
>     Schneider Electric
>=20
>=20
>     General
>     ________________________________________
>     De : Yoann Congal <yoann.congal@smile.fr <mailto:yoann.congal@smile=
.fr>>
>     Envoy=C3=A9 : mardi 11 f=C3=A9vrier 2025 11:07
>     =C3=80 : louis.rannou@syslinbit.com <mailto:louis.rannou@syslinbit.=
com>
>     Cc : bitbake-devel@lists.openembedded.org <mailto:bitbake-
>     devel@lists.openembedded.org>; Steve Sakoman; Pascal EBERHARD; Loui=
s
>     Rannou
>     Objet : Re: [bitbake-devel] [scarthgap] backport request for ??=3D
>     operator for variable flags fix
>=20
>     [External email: Use caution with links and attachments]
>=20
>     ________________________________
>=20
>=20
>=20
>     Hello,
>=20
>     Le mar. 11 f=C3=A9vr. 2025 =C3=A0 10:31, Louis Rannou via
>     lists.openembedded.org <http://lists.openembedded.org><http://
>     lists.openembedded.org/ <http://lists.openembedded.org/>>
>     <louis.rannou=3Dsyslinbit.com@lists.openembedded.org
>     <mailto:syslinbit.com@lists.openembedded.org><mailto:syslinbit.com@=
lists.openembedded.org <mailto:syslinbit.com@lists.openembedded.org>>> a =
=C3=A9crit :
>     Hello,
>=20
>     May we apply the commit following commit to scarthgap as the issue =
also
>     exist:
>=20
>     commit 0329a7e3ac694737f2d2c1861f65492551360663
>     Author: Yoann Congal <yoann.congal@smile.fr
>     <mailto:yoann.congal@smile.fr><mailto:yoann.congal@smile.fr
>     <mailto:yoann.congal@smile.fr>>>
>     Date:=C2=A0 =C2=A0Sat Jan 11 15:13:51 2025 +0100
>=20
>      =C2=A0 =C2=A0 =C2=A0data_smart: fix ??=3D operator for variable fl=
ags
>=20
>     I suppose the other commit that came along for tests is also fine:
>=20
>     commit e3536b3c67ad1a4195fcbd5485d2dc8308014fff (HEAD -> 2.8)
>     Author: Yoann Congal <yoann.congal@smile.fr
>     <mailto:yoann.congal@smile.fr><mailto:yoann.congal@smile.fr
>     <mailto:yoann.congal@smile.fr>>>
>     Date:=C2=A0 =C2=A0Sat Jan 11 15:13:50 2025 +0100
>=20
>      =C2=A0 =C2=A0 =C2=A0tests/parse: add test for ?=3D and ??=3D opera=
tors for variable flags
>=20
>     Here is the path link for details
>     https://lore.kernel.org/bitbake-devel/20250111141351.3993834-1-
>     yoann.congal@smile.fr/#t <https://lore.kernel.org/bitbake-
>     devel/20250111141351.3993834-1-yoann.congal@smile.fr/#t><https://
>     lore.kernel.org/bitbake-devel/20250111141351.3993834-1-
>     yoann.congal@smile.fr/#t <https://lore.kernel.org/bitbake-
>     devel/20250111141351.3993834-1-yoann.congal@smile.fr/#t>>
>=20
>     Thanks,
>     Louis Rannou
>=20
>     To clarify, you target the "2.8" bitbake branch (the one Scarthgap
>     poky uses)
>     I could not find the doc for this but we usually have "[2.8]" in
>     mail title for bitbake backport requests (for example: https://
>     lists.openembedded.org/g/bitbake-devel/message/16872 <https://
>     lists.openembedded.org/g/bitbake-devel/message/16872><https://
>     lists.openembedded.org/g/bitbake-devel/message/16872 <https://
>     lists.openembedded.org/g/bitbake-devel/message/16872>>)
>=20
>     You may also want to state explicitly that this is related to the
>     bug https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685
>     <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685><https:/=
/
>     bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685 <https://
>     bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685>>
>=20
>     Thanks (always nice to see my patches getting used :) )!
>     --
>     Yoann Congal
>     Smile ECS - Tech expert
>=20
>=20
>=20
> --=20
> Yoann Congal
> Smile ECS - Tech expert


