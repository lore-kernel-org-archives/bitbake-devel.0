Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBD2C54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 14:17:56 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.51001.1748873868266953210
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 07:17:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FBfxr600;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4f379662cso3435295f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748873866; x=1749478666; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd2Bbr4+fq1O+G5pFZksV5wPCPa65HhitHzRBwP/QkU=;
        b=FBfxr600DeV+mzSg8Dy5BI6d6dXCFHWIAMGzztPx1sGPsTqEeaUWjUJ+jFwiQP7OE2
         CAoKxNOVqk+z03oCDE0AAswkW3zyPWGVGVFCSlDt4r/z+WxiUEl1Lczmv5q8jSSIhqzd
         IWFuFHhArywdYb73LujM22ofsKJtGRqHBn17U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748873866; x=1749478666;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bd2Bbr4+fq1O+G5pFZksV5wPCPa65HhitHzRBwP/QkU=;
        b=N71INC2TGDayiTusC2ANUZvdZGkWeYcaL+IVBFOAIue6eaOCtZizUdfqlnvjMR8V/E
         42/2DoHRv7fF1T1sxNTShE84/prX3Ofh26QLfJpi1hTy+GoAzF1HYBROyk4ePsaJnXYS
         hgAO3fzSE9dtyg8/VUBr9QIxjrgr66PrhbxF5IsxDTv7KHXSWLhlVpHzYGI8KGqi9Oei
         ehZ/SSiISz+dPyA67oiEqJ4KLSswLKEB23+Zh3JE3raKV30901HqXsWcG7tnUYS10nBz
         UAYTOP1UF6pZzWqwp/gqmvRdGkx1hXYiiYRExF4Y1g6kabAzfuq+HdSTu2GDFHPEnUKA
         tP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUUgouVPiy23Zg+Ge9YRAVuwdoHCW99ugzO1EljT7rEF3wPYkrmqTvK7dugV9yB7JfudkOLWu1wF8GLjTj@lists.openembedded.org
X-Gm-Message-State: AOJu0YznETBPqBIDsyugYzo/wmiX826VwUm+IAx4Vy5LSHza1NAKwm2s
	Avitq8G4HT3/aHtgvtkE9l0lQwDjFeaG/ciccaX2pjBnsIiJBmTIkG3O9jgiHuGADKI=
X-Gm-Gg: ASbGncs1Ij544EBTxJQTX8Azx/OLl3CH5S67137dGBMAZQW9IHwBBKUU372/1a/MNPr
	dwZ1TJ85fG5XIo//AQbi/YvK5mVoWHrV5mscxhFsfHfaYyswEbcrobgGCF++6MDMuwmy7QAHvmR
	cd8K0kc1zNQRTPjSl8ht+YdvyvnSf9pve6szdBd5qMPEP6tqBY5DATtP2s3ZFcnidQjvXJNq3fQ
	P/yun+8uyb7c1GT4gEuLTj4ibe3tO8DItHSYaDI+Ket5yxOOWDFNm1t2vyviNdzRlTXTMYWsmDp
	oYELd5co4RkJVBzp+kSgD4XJHDtK0qq5AQpanUcDgdxWDkU3BPPTnE3P6s4BXZrCdnKpOyqiXzY
	YI72fyw7m3dvMdjEfhV6VsSphQDusLfhc/wJApTKe
X-Google-Smtp-Source: AGHT+IHiZwtS1pMq6PsPoeNtpyXpShM1Snhitu2DeWnvMg4Vahgk488yQ15Fjj+ZVtJ2hntfDAYHLg==
X-Received: by 2002:a05:6000:310f:b0:3a4:f744:e01b with SMTP id ffacd0b85a97d-3a4fe395603mr6114009f8f.39.1748873866352;
        Mon, 02 Jun 2025 07:17:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:667d:b2b4:8044:9175? ([2001:8b0:aba:5f3c:667d:b2b4:8044:9175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c525sm14998200f8f.23.2025.06.02.07.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 07:17:45 -0700 (PDT)
Message-ID: <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mac@mcrowe.com, Quentin Schulz <quentin.schulz@cherry.de>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 02 Jun 2025 15:17:44 +0100
In-Reply-To: <aD2ByO73juj7zy7I@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
	 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
	 <aD2ByO73juj7zy7I@mcrowe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 14:17:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17673

On Mon, 2025-06-02 at 11:49 +0100, Mike Crowe via lists.openembedded.org wr=
ote:
> On Monday 02 June 2025 at 12:15:57 +0200, Quentin Schulz wrote:
> > Hi Mike,
> >=20
> > On 5/30/25 7:17 PM, Mike Crowe via lists.openembedded.org wrote:
> > > I seem to be running into a problem in Scarthgap that relates to outd=
ated
> > > stamp files not being removed. I think this results in tasks not runn=
ing
> > > when they should in later builds. I don't believe that this problem h=
appens
> > > with Dunfell[1], though it does still happen with current master (bot=
h
> > > Bitbake and openembedded-core) too[2].
> > >=20
> > > In case my description below isn't clear, the files required are avai=
lable
> > > in
> > > https://github.com/mikecrowe/openembedded-core/tree/stamps-not-remove=
d-repro
> > > though
> > > https://github.com/mikecrowe/openembedded-core/commit/8fd8055ab3e1d2d=
429c6076481952bace251750c
> > > is probably the most interesting to look at.
> > >=20
> > > My reproduction requires a package to have two different recipes with
> > > different COMPATIBLE_MACHINEs and swapping between building for those=
 two
> > > different MACHINEs. I'm using dummy recipes called lictest_one.bb and
> > > lictest_two.bb because I'm able to reproduce this problem with licenc=
e
> > > files, though I suspect that it is not limited to them. I have two ma=
chines
> > > named qemuarm64 and qemuarm64b.
> > >=20
> > > # PREPARATION
> > >=20
> > > I first start by running the cleansstate task for the recipe for both
> > > MACHINEs in order to ensure we're starting from a sensible state:
> > >=20
> > > =C2=A0 MACHINE=3Dqemuarm64 bitbake -c cleansstate lictest
> > > =C2=A0 MACHINE=3Dqemuarm64b bitbake -c cleansstate lictest
> > >=20
> > > # FIRST MACHINE BUILD 1
> > >=20
> > > I build for the first machine:
> > >=20
> > > =C2=A0 MACHINE=3Dqemuarm64 bitbake core-image-minimal
> > >=20
> > > At this point tmp-glibc/deploy/licenses/cortexa57/lictest contains th=
e
> > > licence files and tmp-glibc/stamps/cortexa57-oe-linux/lictest/ contai=
ns
> >=20
> > Intuitively I would say that your recipes also need to have PACKAGE_ARC=
H =3D
> > "${MACHINE_ARCH}" set and then this wouldn't be an issue at all I belie=
ve
> > (because different directories for each recipe). I'm not entirely sure =
what
> > is the recommendation for when to start using PACKAGE_ARCH =3D
> > "${MACHINE_ARCH}", like what's the thing that should trigger this addit=
ion
> > in the recipe?
>=20
> Hi Quentin,
>=20
> Thanks. I had been holding that back as a somewhat-hacky solution to the
> problem. It would reduce the amount setscene tasks running when switching
> though.
>=20
> In reality the situation is more complex than the one I described above. =
We
> actually have multiple machines and two sets of recipes. Some machines us=
e
> one set of recipes and some use the other set. Using PACKAGE_ARCH =3D
> "${MACHINE_ARCH}" might work, but it would result in more builds than
> necessary. I had considered changing setting PACKAGE_ARCH =3D
> "${TUNE_PKGARCH}-suffix" or PACKAGE_ARCH:append =3D "-suffix" or similar
> would work, but I haven't tested that.
>=20
> It's also not been clear to me where the divide between PACKAGE_ARCH =3D
> "${TUNE_PKGARCH}" and PACKAGE_ARCH =3D "${MACHINE_ARCH}" is. There are lo=
ts
> of ways (e.g. setting PACKAGECONFIG:pn-package) that could cause a
> PACKAGE_ARCH =3D "${TUNE_PKGARCH}"-specific recipe to vary between MACHIN=
Es.
>=20
> > I'm also not saying that this isn't a bug or a bigger issue, even if my
> > suggestion may work around the issue.
>=20
> Thanks for the suggestion. If Dunfell had behaved as Scarthgap or master
> currently do then we probably would have just considered that to be the
> expected behaviour.

I have a feeling there were some changes in this area to fix bugs but
I'm not remembering specifics. It sounds like some issue could have
crept in.

What you're supposed to be able to do is define your own package
architectures so that you could have two here, one for each of your
configs. You could then switch between them and the appropriate
packages would be used.

As it stands, you're relying on the sstate code to swap things out,
which is meant to be a fallback, not a default way of operating. Far
too many people rely on that doing the right thing now though.

So I'd say there is probably a bug somewhere here but you're also not
using the system quite as intended.

Thanks for a test case btw, that really helps. I will try and take a
look if I can find time but that is hard atm :/.

Cheers,

Richard


