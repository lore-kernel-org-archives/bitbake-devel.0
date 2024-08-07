Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C4C3DA7F
	for <webhook@archiver.kernel.org>; Wed,  7 Aug 2024 14:58:19 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.35622.1723042695040395421
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Aug 2024 07:58:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d6BWNNuZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3685a564bafso1032060f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Aug 2024 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723042693; x=1723647493; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efK0WygMnyw7iOk3jtUKkdAeS5Tkl64ZvQ9X8h6NHLs=;
        b=d6BWNNuZxvjNMwJyyPcDWhSrwpjRAqf4Tkp87/ZmTmDnp1hWSwQRzgs3PJtrPicYKo
         pFOcr4okGgeHB9FV3r9nW935ONHrd0Sc5ySTE7YxN+O4YIau1lqTqT/sG6XCjulheySj
         I9uPOxzYl1xCL+dihNQak2t1SAjCb0C/v6prs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042693; x=1723647493;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=efK0WygMnyw7iOk3jtUKkdAeS5Tkl64ZvQ9X8h6NHLs=;
        b=UmA97xMvrJbAc5rTYe12wDskad93EOHgbkh2+SGLgkwoYxhyIYSzKekVQvqbDxUQef
         hJsyc8ebshSTjhEdvB1JcXxAKOi97xqOqdE36NF8rAZPZywWH0XS6lX9X8oMEvhs4/Px
         HiQXwfwwhYrdf19I8qMqRWnyXNgUiEAIphtncCp8nxg/akxd78vMgmgC0pu0jHB79TPX
         Y+RU0TLfYe2dmEIAlDgbTnKn/DtkU4SShbmfFKGGet/umnpaV9DO/fjM8dGsdIxcW25H
         vH+YaWRkkjLDodA393zgAgPRWySAEk+/GnvFdCFtAtr78UVsnkz9Rhii/26GqWd62X4M
         +lqg==
X-Forwarded-Encrypted: i=1; AJvYcCUyMN6zS2l1rZty0mrTJ84HCPdiWXZrcMajioyjzcdIsb7rUiZ+3LT4ZZl6Ds1GJamHokrCAiQ1D1PIu4Op2YGePkVKI9Js8ddlIAx7V1yfoFmwIO0=
X-Gm-Message-State: AOJu0Yyd1W7DHfBrQgX9hQJOVf38hhxGRxrU/BYahVWUZPonPVJBy2Jx
	ZMa23vJq4zvbLXStKdBm4LyFk5HEd4r0x/V53yoSD1lUEIMkNokFBfoaV/d45X4=
X-Google-Smtp-Source: AGHT+IG4erSQEEgko7mSkUCuo3nbICXCHSQMsUT6ylpZ0bngahkVlO76B2K4oqNch4P6OEY717L13Q==
X-Received: by 2002:adf:b357:0:b0:368:3079:4282 with SMTP id ffacd0b85a97d-36bbc0c2cddmr11108429f8f.11.1723042693279;
        Wed, 07 Aug 2024 07:58:13 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:db20:52fd:c091:c903? ([2001:8b0:aba:5f3c:db20:52fd:c091:c903])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd059932sm16261167f8f.69.2024.08.07.07.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:58:12 -0700 (PDT)
Message-ID: <f68db41eb115c9aec41eb049e29cd8a2b04aa38e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org, Ross
 Burton <ross.burton@arm.com>
Date: Wed, 07 Aug 2024 15:58:11 +0100
In-Reply-To: <833f4ebf-3bd0-413f-94ce-9d03a4d615f2@windriver.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
	 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
	 <24cba6a8909e5b3470ca8e51812dc6f3138538dd.camel@linuxfoundation.org>
	 <e089ca2e-5834-42bb-998b-3515b2fccaed@windriver.com>
	 <0aa2cd5ba0a59dfeb5810beb34130a0b9bd803db.camel@linuxfoundation.org>
	 <833f4ebf-3bd0-413f-94ce-9d03a4d615f2@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Aug 2024 14:58:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16452

On Wed, 2024-08-07 at 10:23 +0800, Robert Yang via
lists.openembedded.org wrote:
> Hi RP,
>=20
> On 8/6/24 22:10, Richard Purdie wrote:
> > On Tue, 2024-08-06 at 21:42 +0800, Robert Yang wrote:
> >=20
> > The trouble is that this doesn't just affect local repos, the
> > contents
> > of DL_DIR can and will be shared as a public mirror so it is any
> > two
> > repos with the same name, not just two local repos.
>=20
> This only affects protocol=3Dfile, without this patch, the
>=20
> git://path/to/local/path/gitrepo.git:protocol=3Dfile
>=20
> after do_fetch, it will be:
>=20
> downloads/git2/path.to.local.path.gitrepo.git

Currently we don't support mirroring of file protocol git urls as they
don't really make sense.

> The above name can't be used on public mirror because it can't be
> matched, unless different people and projects use the same local
> path, but this isn't the reality, for example, my local path is:
>=20
> git://home/robert/to/gitrepo.git;protocol=3Dfile

Correct, but the path is uniquely identified.

> When I upload it to a public mirror, it will be:
> home.robert.to.gitrepo.git
>=20
> For you, it might be:
> git://home/rp/to/gitrepo.git;protocol=3Dfile
>=20
> What your do_fetch looking for is:
> home.rp.to.gitrepo.git
>=20
> So it can't be fetched from public mirror, unless you use:
> git://home/robert/to/gitrepo.git;protocol=3Dfile
>=20
> But this isn't the reality


Agreed, they simply don't work today and are not supported.

> > This is partly why I still think mirrors of local file repos don't
> > make
> > sense.
>=20
> It's not only for mirror, but will cause "Filename too long error"
> for normal build's do_fetch when:
>=20
> len(/home/robert/to/long/dir/gitrepo.git) > 256
>=20
> You can simulate the error with the following command on Ubuntu
> 20.04 or 22.04:
> $ touch $(for i in $(seq 1 30); do echo -n longpart$i; done)
>=20
> File name too long
>=20
> This is because the current code changes the path to filename, and
> len(filename) > 256.

Sure, but this isn't a good reason to adopt an unsafe naming scheme for
something we don't currently support and don't really want to add
support for.

Cheers,

Richard

