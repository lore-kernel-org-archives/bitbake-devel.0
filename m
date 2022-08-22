Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A1C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 16:08:06 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web12.19950.1661184473941626189
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 09:07:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WnG1/GHJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id
 bd26-20020a05600c1f1a00b003a5e82a6474so6273199wmb.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=Pb1r+IstWxWWMKKtUqwQ7nJ/5vdUGv3H40fX1StC/x8=;
        b=WnG1/GHJIzrulpO0Mg3IEVYkQetPJ5TL8waOEZqRVqxuWkrdhmy5ikD2ugLpIAxNaE
         EnkkLoYJGp55VVLs/eU5qyKd9FXy9J2wHufuVlFK9DwwCIgK73b0QgUJxikIkt4dBKDU
         cQYBKdQ6u3BBhSA9s0VHYz56/3988Yt40Gmk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=Pb1r+IstWxWWMKKtUqwQ7nJ/5vdUGv3H40fX1StC/x8=;
        b=Px880yZ7w94HLYsXBcSzPD/65WQbP2smZg4Q1oa1vVSTgNtRiZ/CJ/EM9PEyMGSD6b
         0MnFIjVbLWXxC1EhuPgzHxAIUGL+tXyYMZX4hiLG6Y7CpV8XjBTGtbykM/T2HT4xVKg+
         rgOzz1pDK95q+b41edtcNkdA6yz6aaRL/W/RjdGYyXtPfvaZb99HvVmbnaoem+A4Sr4G
         Fn3oeMHrBBwuNA5fGzN1e/pLrioBdhaXnudNT0xWkDQbzxivsdw8RNvHtchKi7tGp0D/
         2CM7mu8Gx0Ecw3AUtgIa81l9vQG5EqKXz1kLSVDfZ88fO9wnxsSZzSi3qfb6M77b4WLA
         UstA==
X-Gm-Message-State: ACgBeo1VsbKCgv4s8FBUibGejy96Aom0xAt8vilckTjK0/xKLS+barif
	gvDbdEVC4pfrCwCFdj0NMaOPmw==
X-Google-Smtp-Source: 
 AA6agR6F27Mf3z6wWAvKEk98purgua72k2K68c6CapjwgHCAktmU9JXe38tQAr+d7/sKpzPnM4kxBA==
X-Received: by 2002:a7b:c84c:0:b0:3a5:dde3:2a9e with SMTP id
 c12-20020a7bc84c000000b003a5dde32a9emr16626179wml.84.1661184472286;
        Mon, 22 Aug 2022 09:07:52 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a4a9:e65c:bb6e:14cc?
 ([2001:8b0:aba:5f3c:a4a9:e65c:bb6e:14cc])
        by smtp.gmail.com with ESMTPSA id
 t185-20020a1c46c2000000b003a673055e68sm2487402wma.0.2022.08.22.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 09:07:51 -0700 (PDT)
Message-ID: 
 <1488fe161adc25a2c35d35a72db0c26ba974b12c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>
Cc: bitbake-devel@lists.openembedded.org, Martin Jansa
 <Martin.Jansa@gmail.com>,  Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Date: Mon, 22 Aug 2022 17:07:50 +0100
In-Reply-To: <20220822180241.5f625ed3@booty>
References: <20220819165455.270130-1-marex@denx.de>
	 <20220822180241.5f625ed3@booty>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 16:08:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13926

On Mon, 2022-08-22 at 18:02 +0200, Luca Ceresoli wrote:
> Hi Marek,
>=20
> On Fri, 19 Aug 2022 18:54:55 +0200
> "Marek Vasut" <marex@denx.de> wrote:
>=20
> > The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
> > single object in the remote repository. This works poorly with gitlab
> > and github, which use the remote git repository to track its metadata
> > like merge requests, CI pipelines and such.
> >=20
> > Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
> > and refs/keep-around/* and they all contain massive amount of data that
> > are useless for the bitbake build purposes. The amount of useless data
> > can in fact be so massive (e.g. with FDO mesa.git repository) that some
> > proxies may outright terminate the 'git fetch' connection, and make it
> > appear as if bitbake got stuck on 'git fetch' with no output.
> >=20
> > To avoid fetching all these useless metadata, tweak the git fetcher suc=
h
> > that it only fetches refs/heads/* and refs/tags/* . Avoid using negativ=
e
> > refspecs as those are only available in new git versions.
> >=20
> > Signed-off-by: Marek Vasut <marex@denx.de>
>=20
> Of course this might become irrelevant with whatever implementation
> will be in v2, however when testing with this patch applied I got the
> following warning and wonder whether they are related:
>=20
> WARNING: mesa-2_22.1.6-r0 do_package_qa: QA Issue: File /usr/lib/dri/nouv=
eau_dri.so in package mesa-megadriver contains reference to TMPDIR
>=20
> Full log:
> https://autobuilder.yoctoproject.org/typhoon/#/builders/72/builds/5753/st=
eps/32/logs/stdio
>=20

This is a known issue with an open bug assigned to me (unfortunately),
it isn't related. It is intermittent as it is llvm-native related and
we don't commonly rebuild this codepath.

Cheers,

Richard


