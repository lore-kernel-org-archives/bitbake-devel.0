Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBD9C3DA6F
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 21:23:58 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by mx.groups.io with SMTP id smtpd.web10.146.1692825831566138459
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Aug 2023 14:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=ti-com-17Q1 header.b=vRV5A5kT;
 spf=pass (domain: ti.com, ip: 198.47.23.249, mailfrom: rs@ti.com)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NLNndZ081835;
	Wed, 23 Aug 2023 16:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692825830;
	bh=4vrJ2kcPyycZpgD6c6UFNF4AE4Rh/y4ld4NebgtETgM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vRV5A5kTqSMgPRI1YjGWDoBbUsZW7LnCLlZsxMFelUnatJD4zh8jPoYc+HcExrJAf
	 j29VeSBbOyjjTkOK0QgNNco03VqRwNjEbcXRcRuJb4NHgm5f9VKOQwUh/nbX2+3dx+
	 x6uA0kdsMWTXEpi2xHiDlfZPeEcKBSxw74S9TmuE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NLNnvq026030
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Aug 2023 16:23:49 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 16:23:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 16:23:49 -0500
Received: from [128.247.81.144] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NLNnIa016112;
	Wed, 23 Aug 2023 16:23:49 -0500
Message-ID: <a11ec80e-d5d7-4004-806d-157cbec725c4@ti.com>
Date: Wed, 23 Aug 2023 16:23:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [bitbake-devel] [PATCH] bitbake-worker:
 export_proxies if network flag = 1
Content-Language: en-US, en-US-large
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>,
        <richard.purdie@linuxfoundation.org>
References: <20230823210438.2172797-1-rs@ti.com>
 <CANNYZj9BH9i8z9XhHxX_bGSRkZBM+Bateb-i8jxqZXCFThGphg@mail.gmail.com>
From: Randolph Sapp <rs@ti.com>
In-Reply-To: <CANNYZj9BH9i8z9XhHxX_bGSRkZBM+Bateb-i8jxqZXCFThGphg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by lelv0142.ext.ti.com id 37NLNndZ081835
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 21:23:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14961

Because fetchers explicitly sets proxies through a different mechanism,=20
partially because different fetch mechanisms may have different ways to=20
set proxies. The variables set by export_proxies are the most common,=20
widely accepted ones though so I figured they should be set by default=20
for tasks that need network access.

On 8/23/23 16:20, Alexander Kanavin wrote:
> Something doesn=E2=80=99t compute here. How did it work all this time i=
n tasks=20
> like fetch?
>=20
> Alex
>=20
> On Wed 23. Aug 2023 at 23.04, Randolph Sapp via lists.openembedded.org=20
> <http://lists.openembedded.org> <rs=3Dti.com@lists.openembedded.org=20
> <mailto:ti.com@lists.openembedded.org>> wrote:
>=20
>     From: Randolph Sapp <rs@ti.com <mailto:rs@ti.com>>
>=20
>     Call the export_proxies() function if the network flag is set. Not =
sure
>     why anyone would want to enable access without passing proxy variab=
les
>     if they are set.
>=20
>     Signed-off-by: Randolph Sapp <rs@ti.com <mailto:rs@ti.com>>
>     ---
>      =C2=A0bin/bitbake-worker | 4 ++++
>      =C2=A01 file changed, 4 insertions(+)
>=20
>     diff --git a/bin/bitbake-worker b/bin/bitbake-worker
>     index 451e6926..ba199ef9 100755
>     --- a/bin/bitbake-worker
>     +++ b/bin/bitbake-worker
>     @@ -285,6 +285,10 @@ def fork_off_task(cfg, data, databuilder,
>     workerdata, extraconfigdata, runtask):
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for =
e, v in exports:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0os.environ[e] =3D v
>=20
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # if netwo=
rk is true we should assume proxy
>     variables are to be passed through
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if the_dat=
a.getVarFlag(taskname, 'network', False):
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 bb.utils.export_proxies(the_data)
>     +
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for =
e in fakeenv:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0os.environ[e] =3D fakeenv[e]
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0the_data.setVar(e, fakeenv[e])
>     --=20
>     2.41.0
>=20
>=20
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>     Links: You receive all messages sent to this group.
>     View/Reply Online (#14959):
>     https://lists.openembedded.org/g/bitbake-devel/message/14959
>     <https://lists.openembedded.org/g/bitbake-devel/message/14959>
>     Mute This Topic: https://lists.openembedded.org/mt/100924096/168648=
9
>     <https://lists.openembedded.org/mt/100924096/1686489>
>     Group Owner: bitbake-devel+owner@lists.openembedded.org
>     <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
>     Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>     <https://lists.openembedded.org/g/bitbake-devel/unsub>
>     [alex.kanavin@gmail.com <mailto:alex.kanavin@gmail.com>]
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


