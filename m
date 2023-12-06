Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F67C4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 23:42:02 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.63521.1701906119371834417
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 15:42:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JuKjMH5x;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c2a444311so62495e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 15:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701906117; x=1702510917; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jobEbqNSYCP96EvTfOI1w0TQjCAqWY3j1hdB9z0eFGU=;
        b=JuKjMH5xw3iplkK7zahO2e9CI04Pg/N5GBOo7cH+H2UnAA8Oa32RJ4n4t5MSPmbksu
         kzSwVWCi/gVHkVXxB6Vug88ZzTYJWSbutXKmF5YUEw1/Fyq08mxD/G7NOzN1tO6LgxwA
         DpNEI7JegDfocfLT+OW0+cHix0H4jUCzRmACA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701906117; x=1702510917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jobEbqNSYCP96EvTfOI1w0TQjCAqWY3j1hdB9z0eFGU=;
        b=jianUDcBh0a4hPc7ry+VfggvAQxiS+5q9I08Vcz/dEQhaqd15J8gKsAN2avqnSDTHf
         P0TkBvR14TgyLR54gtgpsdzuTMCCZKyMi8UVQtv1P7ydwpSVuk0fNM0DjONxKiBFpeGQ
         YtQpRHoDy9+7K6CHn5m9bpjBVhzTcRB0Js4Hso6OGrbNzlxTlcw5iLrj62RInER1ZDnf
         HNrdbaUgAV6jz1UJ1xl/+6ZCfJQ22GHrp2SXbLs7XPcM5BCMU8hG+/sf38DoR03Y/q8e
         b33iqRI0Lr4DIyDBUl9wixraTiG215ozgcBiitNjy27H6cM1p0AeJwF6hzL6RPMndjhF
         thiA==
X-Gm-Message-State: AOJu0YwCpqUWnLqv1c9oPr4Cs3B2WeFtP1TZzKkI3WPZH5Xhf/gDvOQI
	gWkKosgtACdrqdR6M6NZJs8/f/pdgNtyAEmo/ts=
X-Google-Smtp-Source: AGHT+IEwkFhqyriFUOy9IpGM19ObdPOZYKvkbFku9B6Jbhw5Mb1Tu1yXybp9TE4qw44UA8A9UyLMOg==
X-Received: by 2002:a05:600c:4395:b0:40c:2328:fb8 with SMTP id e21-20020a05600c439500b0040c23280fb8mr434730wmn.315.1701906117651;
        Wed, 06 Dec 2023 15:41:57 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:30b4:b44a:2cc6:3876? ([2001:8b0:aba:5f3c:30b4:b44a:2cc6:3876])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b004083729fc14sm9373wmq.20.2023.12.06.15.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:41:57 -0800 (PST)
Message-ID: <a086d7dbf22bc3f5106de0276381f006c9411145.camel@linuxfoundation.org>
Subject: Re: [toaster][PATCHv3 3/3] toaster: Update eventreplay
 functionality for new eventlog file structure
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Date: Wed, 06 Dec 2023 23:41:56 +0000
In-Reply-To: <1347387869.1559511.1701905526293.JavaMail.zimbra@savoirfairelinux.com>
References: 
	<20231206224305.34686-1-marlon.rodriguez-garcia@savoirfairelinux.com>
	 <20231206224305.34686-4-marlon.rodriguez-garcia@savoirfairelinux.com>
	 <9e1be8c6a333fcbb50b7e6fdfab98094a341e025.camel@linuxfoundation.org>
	 <1347387869.1559511.1701905526293.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 23:42:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15629

On Wed, 2023-12-06 at 18:32 -0500, Marlon Rodriguez Garcia wrote:
> I think this could be merge as it is now, and another patch will be
> added to update the Views and the eventreplay lib, can you share the
> patch with the new changes ?

It is sub optimal that the series adds the code to views.py in 1/3 and
then moves it again in 3/3 so I'm leaning to reworking the patches to
clean things up.

The patches still need work since they cause two existing tests to
regress too (as far as I can tell anyway).

The changes to eventreplay merged here:

https://git.yoctoproject.org/poky/commit/?id=3D3ee5c86da3773deb091e24b98ad5=
92c5d19274fb

Cheers,

Richard=20

>=20
> ----- Original Message -----
> From: "richard purdie" <richard.purdie@linuxfoundation.org>
> To: "Marlon Rodriguez Garcia" <marlon.rodriguez-garcia@savoirfairelinux.c=
om>, bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
> Sent: Wednesday, December 6, 2023 6:02:09 PM
> Subject: Re: [toaster][PATCHv3 3/3] toaster: Update eventreplay functiona=
lity for new eventlog file structure
>=20
> On Wed, 2023-12-06 at 17:43 -0500, Marlon Rodriguez Garcia wrote:
> > Added class EventPlayer to list of libraries under bitbake/bb/ui/
> > Update file read functionality to match new eventlog format
> >=20
> > Exclude listing of files that don't contain the allvariables definition=
s used to replay builds
> > This part of the feature should be revisited. Over a long period of tim=
e, the BB_DEFAULT_EVENTLOG
> > will exponentially increase the size of the log file and cause bottlene=
cks when importing.
> >=20
> > Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirf=
airelinux.com>
> > ---
> >  lib/bb/ui/eventreplay.py        |  85 +++++++++++++++++++++
> >  lib/toaster/toastergui/views.py | 131 ++++++++++++--------------------
> >  2 files changed, 132 insertions(+), 84 deletions(-)
> >  create mode 100644 lib/bb/ui/eventreplay.py
>=20
> Our patches overlapped!
>=20
> I've merged a patch to fix toaster-eventreplay and it is slightly
> different to the code below. The major tweaks are handling a second
> 'allvariables' entry and adding a eventfile.seek(0) to reset the stream
> before calling the player.
>=20
> We should probably have a standalone patch moving that code from
> toaster-eventreplay to lib/bb/ui/eventreplay.py and making it use it,
> when can then be followed by the patch below to have views.py use it as
> well?
>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6060): https://lists.yoctoproject.org/g/toaster/messa=
ge/6060
> Mute This Topic: https://lists.yoctoproject.org/mt/103023929/7896800
> Group Owner: toaster+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [marlon.rodri=
guez-garcia@savoirfairelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


