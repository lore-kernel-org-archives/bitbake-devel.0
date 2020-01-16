Return-Path: <masahiroy@kernel.org>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
	[210.131.2.83])
	by mail.openembedded.org (Postfix) with ESMTP id 452D67D2D6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2020 02:11:59 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
	[209.85.217.44]) (authenticated)
	by conssluserg-04.nifty.com with ESMTP id 00G2BZsm014943;
	Thu, 16 Jan 2020 11:11:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 00G2BZsm014943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1579140696;
	bh=/4nbUBCzZ+zsdxmPNzTbs4dZMXyaNNA+iR0LQZG7yyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=yfo9cqwY2ok/9+hIJUl60g3/WCQQ4AIF3jBU0Po4RrBncJCOb9ssYN4MpwTmfIErP
	slgHLTr2obBkOJmjO8BDdlyaVkLXi64M+LpZ7gOFytTr+TLWFMWafzUF10sZu8dNss
	fLj5wWB45v9w5bVoK3gtwp8HTRJEUn+a8ld7hSn3+66He0EcblSQ0d8LTNFimJT6KX
	m8TZ3JjgAsdprr+ACphmXGeBlE6PpTgK4OtkcNjM7aY7EzTGSE5wARJY5BZCLC6L1h
	hT23aDk/CGukXvEzV/omXVnLjafKm5WPEehRcUc6nAchLaJ2EMIWdbdwpujUmQxzcS
	zljOGwrrDDGVg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id s16so11714381vsc.10;
	Wed, 15 Jan 2020 18:11:36 -0800 (PST)
X-Gm-Message-State: APjAAAXQZWZK4CC1VTg6AYBMBTXcVrbajo0OwwsAlb9H57zC7pOuK/hJ
	vDCsO9Jn3gJ+O8HuXg7wW76jnoeQ7hjtoBR8wVg=
X-Google-Smtp-Source: APXvYqxS5y386w5DB4fjS9dgAUZJi0ShgEr0qfDkkSxamBivHX0l6uSaOpdGMwnmaMOgw4kvTmHziciO7Ln5OZDbkZ8=
X-Received: by 2002:a05:6102:48b:: with SMTP id
	n11mr101784vsa.181.1579140695384; 
	Wed, 15 Jan 2020 18:11:35 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNATpVF28nWZ1NsOhe7btPs5Gu7eAjsFjz9AuYncLu+EUyg@mail.gmail.com>
	<7825085b36a17ad9010339af39d4647f866786cd.camel@linuxfoundation.org>
In-Reply-To: <7825085b36a17ad9010339af39d4647f866786cd.camel@linuxfoundation.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 16 Jan 2020 11:10:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQkLVykdxsY1RgcXNDP8zzLb+uSXkAsqdHo722iUEmyw@mail.gmail.com>
Message-ID: <CAK7LNARQkLVykdxsY1RgcXNDP8zzLb+uSXkAsqdHo722iUEmyw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: Question about the behavior and intent of recrdeptask
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 16 Jan 2020 02:11:59 -0000
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 8, 2020 at 5:45 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2020-01-08 at 12:14 +0900, Masahiro Yamada wrote:
> > So, the concept of  "recursive dependency" sounds
> > somewhat odd to me.
> >
> > I guess I am missing important use-cases.
> > I'd like to know the reason why we need recrdeptask.
>
> FWIW your description sounds right. We need this flag for several
> reasons. Firstly, it models the behaviour older bitbake had before we
> switched to the full task model so it was partly there for
> compatibility.
>
> Secondly, it does serve a purpose. For example, if you do "bitbake
> core-image-sato" and have PACKAGE_CLASSES = "ipk deb rpm".
>
> In this case the user expects debs, rpms and ipks to all be generated
> (the do_package_write_{ipk|deb|rpm} tasks) to be run for all recipes
> involved in core-image-sato.
>
> Since we only build the rootfs for ipk, the debs and rpms wouldn't bet
> triggered unless we have the do_build[recrdepends] on do_build.
>
> If you really wanted the other behaviour you would run "bitbake core-
> image-sato -c image_complete" as in that sense the build task is
> otherwise pointless.
>
> It is a weird dependency though, I agree.


Thanks for the reply.
I see do_package_write_* works based on recrdeptask.

I do not like this complicated feature honestly,
but I am not skilled enough to propose any alternative
solution, so I will live with it.


-- 
Best Regards
Masahiro Yamada

