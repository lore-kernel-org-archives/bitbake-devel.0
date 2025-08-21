Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D4CA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 08:33:30 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.4416.1755765203621585613
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Aug 2025 01:33:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fycUfaDL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c380aa1ad0so415682f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755765202; x=1756370002; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EIyvsZ+ksBPtwh93vbMPxyFB3M3aJw2b491zLxXbSaU=;
        b=fycUfaDLRxH9quKpLoIkiCB/2v2VFrvHiFLYgmgH3/Ip+oHT6ZcdbI9n852qF6kBKC
         leqXNkL8C3mvQVWfDJvXsTL/c3fqouy9nM9iBC7CNA/WWz4SG0Ic3++47ACg5nvjULCk
         Z4sTLu41iPaC8Rl8m1qkcx2YYweLjpMdmZ//Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765202; x=1756370002;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIyvsZ+ksBPtwh93vbMPxyFB3M3aJw2b491zLxXbSaU=;
        b=ukgRRG69fl/DpC0tZchMkvGaRMoE4Q9rVavJ1pNg3GFQTsYGN8vmt6A/QQDenYYYkS
         OcFOuP95nLIdQohLTcXrq52oBqY+Tit73tvihrkBkF+K6tlXPa+0H8vJVhHdu3jGSip/
         RLQHykAdtPJOFXMTLjPaVOyPfxleuqq6Ip8oOOA+T0pzS8OLwvBqnAwtYnA6mZqnuX63
         jOeizPzQ8Se7zfn9dWIYLK+hSaId9lfQ/0julZFWJw8BQ4w7U/tSVsXE12Qt7TyrnvOB
         t/PKgdzbsbUnvBejlSaqi/Nfcvmn4+DGfPsd53wFri2XLRYcPndJ4ymXaVusDJCOcWEv
         KfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2Td0KWqhlgw2eHnzvhWeowOhO+hn6zrOo2JIJf1bLJ8qkrVhi0q+13QIvHElDRHWDHvu8fpJYPVvg74L@lists.openembedded.org
X-Gm-Message-State: AOJu0YzuFiMctxgUlR8j+B6Gf0uv0hg871gKyNlMPitH52Xd3T+nI/hK
	AwL7fYwOfxSl9+seWu9tcHa4dfm5Gu7iJSPGdPAKvxpFqmhgAC7dmXz7Da1nXNonUZo=
X-Gm-Gg: ASbGnctB34zpz2hU4ltXjCpGSS1MFcXO8XJ3hrrd1uE4/PTIS5lhitU6/92AJjvTZ+2
	rEZZfLpTgtjQJkpZw5qvVbumhjxpn9R+sefxnn9UwYxHt9DMGo3LV6tchIz7sWWi34m0DRO8hFF
	k64hjIO8KGejgXfj04lnBYVJ3devYhzmy978unNxFMCH3ir8mcul9q+57QWQ4yTW2NW4BT7JpM9
	qxzB5ButiZ68FWNni1HJeNrtToVA4JpQoBYkdDvD/3lpLnC1HZDuTr7Riq9mxZCwAkUBjvaDNh6
	bXX0jasiUOvkjnm7ayy7rF8gE7TqJ5YaN75yOIcAhyZdMcAf0QiRseF64n52lM2C31298RWXPjt
	UCMhu048cs8Py0tfYErtA5cMFFCB1L77MVRTIVw4uKL862+bFDgugnJoK/8tJvpxnQNYFdoMVys
	3y0DbI6YcZuz+w3FbAxOKu8LKeBQQ4tb3d
X-Google-Smtp-Source: AGHT+IFhAQfmLCdUu1b86nqOAgMFbgMK7nUZp9OUU5r8iCrOBORIeVrsMKpjtTS2HYIOKyLXWSu+bA==
X-Received: by 2002:a05:6000:2c07:b0:3b7:886b:fb76 with SMTP id ffacd0b85a97d-3c49433e9fbmr1327098f8f.12.1755765201894;
        Thu, 21 Aug 2025 01:33:21 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5327:b358:4159:41f6? ([2001:8b0:aba:5f3c:5327:b358:4159:41f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4e6d4d439sm1222024f8f.6.2025.08.21.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:33:21 -0700 (PDT)
Message-ID: <37ebf6a3dea7e6e975762888a381329d0da936d6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Scott Murray <scott.murray@konsulko.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org, Tim Orling <tim.orling@konsulko.com>
Date: Thu, 21 Aug 2025 09:33:20 +0100
In-Reply-To: <4f3b985b-4b54-7e5d-a21f-887f8587a495@konsulko.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
	 <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org>
	 <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com>
	 <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
	 <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com>
	 <CANNYZj8y-VCKnzUD2OLihbt4KtYPqdBK4zE3-5mQE84844fYjw@mail.gmail.com>
	 <647b238c-cf12-eb7b-d243-038854180192@konsulko.com>
	 <CANNYZj_RWrJxXx6+WZ_px_EWOd9+Wr1TgUEHgGg3rspY5wEECw@mail.gmail.com>
	 <8db52408-8867-0b10-bc23-114ea02bdd66@konsulko.com>
	 <3216445584018ee9b8f2b49ff5554624a69c604b.camel@linuxfoundation.org>
	 <4f3b985b-4b54-7e5d-a21f-887f8587a495@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 08:33:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17902

On Wed, 2025-08-20 at 19:58 -0400, Scott Murray wrote:
> On Wed, 20 Aug 2025, Richard Purdie wrote:
>=20
> > On Wed, 2025-08-20 at 16:49 -0400, Scott Murray wrote:
> > > On Wed, 20 Aug 2025, Alexander Kanavin wrote:
> > >=20
> > > > On Wed, 20 Aug 2025 at 22:15, Scott Murray <scott.murray@konsulko.c=
om> wrote:
> > > > > Sure, but my point is that's what I'll be doing every time I set =
up
> > > > > any project (and maybe reconfiguring it?), so effectively for me =
the
> > > > > default behavior is not useful.=C2=A0 I doubt I am alone in doing=
 all my
> > > > > development work on a different disk than where /home is on my de=
v
> > > > > and build machines.
> > > >=20
> > > > Then there's the option of setting BITBAKE_SETUP_TOP_DIR in environ=
ment.
> > >=20
> > > I'll not bother pressing this further since you seem set on the curre=
nt
> > > design, but my original concern that I pointed out was that I'll alwa=
ys
> > > having to configure that, and likely document doing the need to do so=
 for
> > > users of any project I may want to use bitbake-setup for.=C2=A0 The d=
efault
> > > behaviors of other tools in this space do not require that.
> >=20
> > You'd always have to configure it because you want no external
> > interference in builds even if that was limited to sstate/sstate
> > mirrors/dl_dir? Or you don't believe dl_dir/sstate can be shared
> > between builds/projects?
>=20
> I will always have to configure it because I don't want those in some
> default directory in $HOME, and there's going to be times I don't want
> them shared at all.

Keep in mind there are two levels to the config. One level is the basic
site.conf, the second is the use of defaults in .cache.

Personally, I think we should put DL_DIR/SSTATE_DIR where the user
asks, defaulting to $HOME/.cache. Like you, I have dedicated specific
spaces for these but that is fine and I can just set those in my
site.conf and be happy, I won't need to specify it on the command every
time.

> =C2=A0 With respect to sharing, IMO it depends on the
> project.=C2=A0 I tend to keep downloads and sstate split by branch, as
> master branch has so much churn that it complicates pruning (which is to
> some degree an unsolved problem that everyone has their own ad hoc
> approach for).=C2=A0 I also tend to not share sstate across significantly
> different customer projects that use less common layers, again because
> it makes pruning easier.

state pruning is a valid concern and I do tend to do that myself with
older releases but we should really work to improve the cleanup tools
too. I'm not sure that issue should change the base design.

> > I do understand your point but I also suspect there is some level of
> > common user setting we should start trying to take account of. If that
> > means adding some sanity check mechanism to only allow certain
> > variables from site.conf, that is something we can look at.
>=20
> I'm not sure I follow your train of thought here?=C2=A0 If you mean not
> allowing overriding DL_DIR or SSTATE_DIR from site.conf, I'd be strongly
> against that idea.

I'm meaning only allowing setting certain variables from site.conf such
as DL_DIR and SSTATE_DIR.

Cheers,

Richard



