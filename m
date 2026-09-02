Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50EBC61DFD
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 07:56:54 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7257.1788335806703438660
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 00:56:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=YbZ00ous;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 79ADF1A1955;
	Wed,  2 Sep 2026 07:56:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CB746053C;
	Wed,  2 Sep 2026 07:56:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C16FB11C792EE;
	Wed,  2 Sep 2026 09:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788335799; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hZwcb+o0KisM9qtix33KlgzA0Kbb42loQrWGsmShmuk=;
	b=YbZ00ousF8g1HfLr4Uuxej3ZtOA+mzUcYgoTOA5aGGpowQqVx1qUiWmsgsSETeH7FDYr10
	XNqodS/vuemtqLS5AABnbAvNLul10XJrzdQntRFtX9ItR58SvyLrGQ35Ro0gbVJyhPPKof
	2NkHsmzRlM6YPCBTAdkzer/JFnR/v1+dGyf9bHtLof0jR/GJTWSEJ5fCqh5Syd5LJ5eBh/
	wneVGpZbuMeHiva7d45AW3w3b5Om9kmcS7DrTy/0c/tzBupZT+HAGdEehIR99HL8icD4sj
	KMIKDrVEUj85NFnbvbZxYbToKhiP1MaNqRyetntV1xbhlKKancjLCLpxS5TCzQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 09:56:38 +0200
Message-Id: <DL4O4S2MTGTD.1UMP987G68AY9@bootlin.com>
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>, "Alexander
 Kanavin" <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH RFC] parse/ast: add support for additive
 built-in fragments
References: <20260901-appending-fragments-v1-1-2e359cf751ce@bootlin.com>
 <afffba8970ad228db773766f7f6c894cbb021279.camel@linuxfoundation.org>
 <CANNYZj8cso=2X3Wi3u=59Xzt92g5V6CvuDtLD-Y8r3HycKBOVQ@mail.gmail.com>
 <bd9bf095e420c01a261a4464b3fb28f96be9a45d.camel@linuxfoundation.org>
In-Reply-To: <bd9bf095e420c01a261a4464b3fb28f96be9a45d.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 07:56:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20145

Hi,

On Tue Sep 1, 2026 at 9:22 PM CEST, Richard Purdie wrote:
> On Tue, 2026-09-01 at 20:28 +0200, Alexander Kanavin wrote:
>> On Tue, 1 Sept 2026 at 14:15, Richard Purdie via
>> lists.openembedded.org
>> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>>=20
>> > It is definitely an interesting one and the syntax isn't too bad..
>> > Are
>> > there uses beyond class inherit though?
>> >=20
>> > machine/distro were added as they are clear variables in common use
>> > which avoided tons of boilerplate in layer definitions. Do we have
>> > similar needs here or are these inherits better captured in config
>> > fragments?
>>=20
>> Antonin first wanted to just add 'real' fragments (that are defined
>> in
>> files) for common class inherits, and it was my idea to implement
>> additive built-ins that make it generic. It's something we can
>> consider and discuss, I don't necessarily insist on a generic
>> implementation.
>>=20
>> I guess we can all look at our various local.conf lying around, and
>> check what's piled up in them over the years. In mine, two variables
>> immediately jump out as candidates for additions: IMAGE_INSTALL,
>> IMAGE_FEATURES. Those certainly will not work with regular fragments.
>
> I guess there are a few things to keep in mind.
>
> Firstly, we're never going to replace local.conf, there are always
> going to be some things which users need to do locally for their work
> and these do belong there.
>
> The alternative is a fragment language which is an abbreviated short
> form of the main bitbake syntax and I'm not sure that is feasible or
> desirable.
>
> The things which should become fragments are commonly used groups of
> settings, things which set set as a group.
>
> The machine/distro shortcuts are nice as they cover the biggest control
> everyone sets immediately but beyond that, is there a pressing case?
>
> I guess some of the "classes" are in fact policy "selections" and kind
> of like fragments in their own right but are there enough of them to
> justify specific syntax.

I think the main purpose of such a class fragment would be for classes that
provide build settings, such as the retain or buildstats classes, or rm_wor=
k,
etc. Those classes do not mean anything for the target image, they only twe=
ak
what happens during the build. I think it makes sense to set those in
bitbake-setup configuration files.

However, I think classes that affect the build output, such as useradd, sho=
uld
probably be part of a distro configuration file rather than bitbake-setup f=
iles.

With that in mind, I agree that there aren't that many use-cases for a clas=
s
fragment, and maybe we should provide everything from our distro configurat=
ion
files. But aren't distro conf files supposed to represent policy for the
target image, and only that? Would it be relevant to delegate all build sys=
tem
settings to bitbake-setup? I guess this patch would somewhat aim to achieve=
 this
separation.

> Once you get above a handful of image features or image install
> packages, that is a packagegroup or a config fragment in their own
> right and I'm worried about the abuse such things might get...
>
> I'm not saying "no" but I do have worries.

I agree that this mechanism could be abused. If this exists, maybe we shoul=
d
limit this _only_ to adding/removing global classes?

Antonin

