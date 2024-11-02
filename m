Return-Path: <rpurdie@rpsys.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6631EE67809
	for <webhook@archiver.kernel.org>; Sat,  2 Nov 2024 19:50:41 +0000 (UTC)
Received: from dan.rpsys.net (dan.rpsys.net [217.169.23.60])
 by mx.groups.io with SMTP id smtpd.web11.23736.1730577032137738441
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Nov 2024 12:50:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rpsys.net header.s=default header.b=pHjpZU4k;
 spf=pass (domain: rpsys.net, ip: 217.169.23.60, mailfrom: rpurdie@rpsys.net)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rpsys.net; s=default;
	t=1730577029; bh=KYU2XCtl6X1t9S/hixQSsdMvw5QBTq6Wa2yxEt7YKa4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=pHjpZU4k5HzGBZwVHBCgAhst2dPSrHXCoPhcYbL+hfck3ag8iky5vvtuDNr6AaYGC
	 MSTJBK8WHk2v6IdE5IlFXRn64IOBI4u9C0u9umLmcVs6XctEREicHGwdhC4gUWKYvz
	 bdad5Puq6qyVF68EHN/ucdTtkDPHgJyk+VIxC7/T9xVQKNigqqPDC/+lNGFKkVcLma
	 kvI4Fv9O8PcItw6yRy9NcWhSq7bzdHo83ClLHTEoC7VY2tg8FR2W32HVDzgxWa9ZQi
	 G4Bi68BcIq224IXcmDOfySAEBAzUMc1koZpRPUfboX04X8sVSbrQVZcVr6pY1GQgYH
	 I3aI6hVHxqo4A==
Received: from [192.168.1.7] (dan.rpsys.net [217.169.23.61] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4A2JoR7v2838916
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 2 Nov 2024 19:50:29 GMT
Message-ID: <aaaa7953e8d11224fb6ca4608577720b896c7251.camel@rpsys.net>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-getvar: Expand keys and run
 anonymous functions to get identical result to "bitbake -e"
From: Richard Purdie <rpurdie@rpsys.net>
To: yoann.congal@smile.fr, bitbake-devel@lists.openembedded.org
Date: Sat, 02 Nov 2024 19:50:21 +0000
In-Reply-To: <20241102162124.2048662-1-yoann.congal@smile.fr>
References: <20241102162124.2048662-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.12 at dan
X-Virus-Status: Clean
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 Nov 2024 19:50:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16772

On Sat, 2024-11-02 at 17:21 +0100, Yoann Congal via
lists.openembedded.org wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
>=20
> With this path, outputs of
> =C2=A0 bitbake-getvar DISTRO_FEATURES
> and
> =C2=A0 bitbake -e |grep '^DISTRO_FEATURES=3D'
> are the same.
>=20
> Fixes [YOCTO #15638]
>=20
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>=20
> ---
> RFC:
> * I don't know if a "sync command" is the right choice here.
> * Maybe the runAnonFunc call needs to be more integrated in the
> default
> =C2=A0 flow?

This looks like the right direction.

I'm a bit concerned this modifies cooker.data on the server side
though. That is not meant to be expanded like this and may cause some
interesting other issues if left like this.

We therefore need to work on a copy of the datastore, so the sequence
is:

newdata =3D d.createCopy()
bb.data.expandKeys(newdata)
bb.parse.ast.runAnonFuncs(newdata)

and we just need to make that happen over the IPC. I think tinfoil's
datastore connector does already support this.

Also, it may be more efficient and a lot faster to run the expandKeys
on the server side. We might want to combine both operations into a
single piece of new tinfoil API?

A sync command should fine.

Cheers,

Richard

> ---
> =C2=A0bin/bitbake-getvar | 5 +++++
> =C2=A0lib/bb/command.py=C2=A0 | 4 ++++
> =C2=A0lib/bb/tinfoil.py=C2=A0 | 6 ++++++
> =C2=A03 files changed, 15 insertions(+)
>=20
> diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
> index 8901f99ae..1002d827b 100755
> --- a/bin/bitbake-getvar
> +++ b/bin/bitbake-getvar
> @@ -45,6 +45,11 @@ if __name__ =3D=3D "__main__":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
tinfoil.prepare(quiet=3D2, config_only=3DTrue)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
d =3D tinfoil.config_data
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Expand keys and run anonymo=
us functions to get identical
> result to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # "bitbake -e"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.data.expandKeys(d)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tinfoil.runAnonFuncs()
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D None
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if args.flag:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
value =3D d.getVarFlag(args.variable, args.flag,
> expand=3Dnot args.unexpand)
> diff --git a/lib/bb/command.py b/lib/bb/command.py
> index 1fcb9bf14..27e99a584 100644
> --- a/lib/bb/command.py
> +++ b/lib/bb/command.py
> @@ -24,6 +24,7 @@ import io
> =C2=A0import bb.event
> =C2=A0import bb.cooker
> =C2=A0import bb.remotedata
> +import bb.parse
> =C2=A0
> =C2=A0class DataStoreConnectionHandle(object):
> =C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, dsindex=3D0):
> @@ -582,6 +583,9 @@ class CommandsSync:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return DataStoreConnecti=
onHandle(idx)
> =C2=A0=C2=A0=C2=A0=C2=A0 parseRecipeFile.readonly =3D True
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 def runAnonFuncs(self, command, params):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.parse.ast.runAnonFuncs(com=
mand.cooker.data)
> +
> =C2=A0class CommandsAsync:
> =C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0=C2=A0 A class of asynchronous commands
> diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
> index dcd3910cc..4d6d07539 100644
> --- a/lib/bb/tinfoil.py
> +++ b/lib/bb/tinfoil.py
> @@ -633,6 +633,12 @@ class Tinfoil:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D self.get_recipe_f=
ile(pn)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.parse_recipe=
_file(fn)
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 def runAnonFuncs(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Run anonymous functions
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.run_command('runAnonFunc=
s')
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 def parse_recipe_file(self, fn, appends=3DTrue, =
appendlist=3DNone,
> config_data=3DNone):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Parse the specified reci=
pe file (with or without bbappends)
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16771):
> https://lists.openembedded.org/g/bitbake-devel/message/16771
> Mute This Topic: https://lists.openembedded.org/mt/109354058/1686473
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[richard.purdie=
@linuxfoundation.org
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


