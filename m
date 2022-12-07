Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454A7C63705
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 21:49:34 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.29969.1670449772377701363
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Dec 2022 13:49:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=awmueEAo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id n7so14853745wms.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 13:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7FaR63/2oqiuzUEqfVF93oIorOso0myShyd4KIeSiPw=;
        b=awmueEAoeH30Dn5UkbB/uKPTeeUBjQr0jD8nQfF3jb2XV/OT/JCiCHTLnQwg0h7oGx
         AoPBaJfgFT0/mepSNT3fKcrkjP+nAFuQmqgdKBb9zOUzPd/aGfnJFshtz2OpFuwjaS+b
         f5ThZo3xVEaQakTzAfXrEJJVjYGjGm9vxU2pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FaR63/2oqiuzUEqfVF93oIorOso0myShyd4KIeSiPw=;
        b=cVfXRNjkjMle8DpFkEeLS5h0xl8uIWK80z0Yenp46dpKBvqgKZuW5nzoXGRLnvY4Ro
         cO9QtIFLe1o1oX90SqHUoJblNFxj6IfyzvLKgiFr2EI3FcHGV08cueU1dhMTWCAZ4bhK
         WEHEaIZ0CE1UlggkCiD1CKPKzTsiCO2vo3Wd1N4JuJxQd/PfKxiE56n7cabgSH7SNPM2
         8B42OCekx/cHP+KmxmrytipaOgChkTbUkZZX7mWQsnUddo6L5L0qHPEm1YQhtZeORPWA
         Oo5vfPgXWMGliTH8oZu73Rl5Q66oS+1Yz3+loLeH7+mLtSuy6cYMfMV0sKDi9QS9yfoK
         ID3Q==
X-Gm-Message-State: ANoB5pm90qudCkMVKPdPfABGqDz77aIvDDK6dtosw/NfogkPv0jO3RKm
	XDpaw1ftbcKCgtaslvUlQ/3YaQ==
X-Google-Smtp-Source: AA0mqf4ng5V1c9FuNHOtJS3GhMsWF2B8RdjC67NKApFIHUaXDoS7rHmX7v0khh/6IJATl1a5SgVtrA==
X-Received: by 2002:a05:600c:154e:b0:3c7:1422:d56a with SMTP id f14-20020a05600c154e00b003c71422d56amr38789128wmg.107.1670449770743;
        Wed, 07 Dec 2022 13:49:30 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:50bb:c4ee:bb3b:bc91? ([2001:8b0:aba:5f3c:50bb:c4ee:bb3b:bc91])
        by smtp.gmail.com with ESMTPSA id t12-20020adfeb8c000000b0023662245d3csm20378800wrn.95.2022.12.07.13.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 13:49:30 -0800 (PST)
Message-ID: <fafd955b61a56e8f9ecc1565da11496cd54c0475.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with pseudo
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Nicholas Jackson <nicholas.jackson@zii.aero>, Ross Burton
	 <ross.burton@arm.com>, Alexander Kanavin <alex.kanavin@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 07 Dec 2022 21:49:29 +0000
In-Reply-To: <818df083-80bb-e189-6466-ea161d35d566@zii.aero>
References: 
	<BYAPR12MB2710069E5D018DBB8F800AECF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
	 <CANNYZj_Cr5QO31dqnrNV9051M4fVh79Z3ayq8xF9DxLyRriDgA@mail.gmail.com>
	 <BYAPR12MB2710359C1636EC9716B3EB83F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
	 <CANNYZj9ETtBH1mY3x3G2Fe4Fjyni7zkRMcA9UsYtpBcTznUQDg@mail.gmail.com>
	 <BYAPR12MB2710778AF2346FD1E8FAD51AF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
	 <1719BDC7DCD0DABC.17026@lists.openembedded.org>
	 <CANNYZj95vsnNLd97LzL7ix=JC9HCReJo7VNa80EymiSRYNgRiQ@mail.gmail.com>
	 <BYAPR12MB27105A444B6963892070AE56F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
	 <CANNYZj9RuBP-btf5ATGx7pTqiP=-bzeHttY2GM=A9t+HQLo=5A@mail.gmail.com>
	 <EE055CF5-FB7C-436B-A526-3A05FE023513@arm.com>
	 <9cb6f8f622cfcc8a9fc68846acceb89734889ef2.camel@linuxfoundation.org>
	 <818df083-80bb-e189-6466-ea161d35d566@zii.aero>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 21:49:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14148

On Mon, 2022-10-10 at 11:19 -0700, Nicholas Jackson wrote:
> On 10/1/22 4:01 PM, Richard Purdie wrote:
> > On Sat, 2022-10-01 at 19:57 +0000, Ross Burton wrote:
> > > On 30 Sep 2022, at 22:36, Alexander Kanavin via
> > > lists.openembedded.org
> > > <alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:
> > > > Thanks, I've reproduced this too using plain python3 and .netrc
> > > > with tweaked permissions (e.g. run python as regular user, set
> > > > .netrc ownership to root). I am not sure why fetching sstate items
> > > > happens under pseudo, or whether the fix is correct, but the issue
> > > > is real.
> > > My hunch response would be that setscene tasks shouldn=E2=80=99t be f=
akeroot
> >=20
> > Since the setscene tasks replicate things like do_package whch need to
> > preserve fileownership, they very much need fakeroot.
>=20
>=20
> So do you think that getting netrc to work with pseudo is a necessary
> fix after all?

We need to run the setscene tasks under pseudo. We don't need to fetch
the objects under pseudo so we may need to look at something along
those lines, dropping the pseudo environment for the fetching.

Cheers,

Richard

