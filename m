Return-Path: <masahiroy@kernel.org>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
	[210.131.2.82])
	by mail.openembedded.org (Postfix) with ESMTP id 124997E5FB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2020 01:55:12 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
	[209.85.222.50]) (authenticated)
	by conssluserg-03.nifty.com with ESMTP id 00G1ski7009258
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2020 10:54:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 00G1ski7009258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1579139687;
	bh=aPmQAy12DQxgl5oqsapchVAINXac6yLwFHFzWR3ADAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ahDticfZlYMZpmETU+Iz0qIyzW+xbMgtFqoqYdK5WGpPqiyN6LNXbYRMfGckNapo+
	wbZmKFb7jcvrnYjN4IW1u/+AQ6/wTFm5SARnb8j6+YO7KyK5Da9LfEaaj3sKYx2LWO
	+VFfEHB2KuEh3CxRJqCX591P6+v6StWMlmETikjjJpjCWKezB+s6ZZTiXXXA1VC0SC
	6OllHa2cAg50vLX6+ylxbmWXV39J/17vMSlnTX5ThBVE8E2vDm3pk50b376VKfle4h
	ANJcOP9ZficpJoUMmxIinUTdI/TPo7+G7Jq81Pb3idb7OZdCr2pu89UrnsJ4e9gANF
	bnjOL3aUOXJsQ==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id y3so7126437uae.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jan 2020 17:54:47 -0800 (PST)
X-Gm-Message-State: APjAAAUuwZN+DRZ/Z/mDU7altqutQD8I9II17BNSz4LkdmN0Q8mE6sOo
	EuRN8VM/2lpox2Eo64WH0xj3mBaDmkGbWpwjDZc=
X-Google-Smtp-Source: APXvYqyCKFQ/BTPmxfKUTmoBbGR5JCKBJw8bX3WSBz+6D/PbxrgfTjouFPwslOEVoMonfjO8McV0Ucq0jDQ4r+IYsJ4=
X-Received: by 2002:ab0:7049:: with SMTP id v9mr19138222ual.95.1579139686316; 
	Wed, 15 Jan 2020 17:54:46 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNARkXaLFq8eJpNkbbkXDnRrVdXjXfYtHuqRA1OdO7AfU4g@mail.gmail.com>
	<d5d59f4d6db40c644c9f827697b38d216b251e8a.camel@linuxfoundation.org>
In-Reply-To: <d5d59f4d6db40c644c9f827697b38d216b251e8a.camel@linuxfoundation.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 16 Jan 2020 10:54:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQcnVQ_V6kH-taJrVnwnfocp=Tev5NTNvHN0NyYcS_6+w@mail.gmail.com>
Message-ID: <CAK7LNAQcnVQ_V6kH-taJrVnwnfocp=Tev5NTNvHN0NyYcS_6+w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Why does recrdeptask delete a task from the dependency graph?
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
X-List-Received-Date: Thu, 16 Jan 2020 01:55:13 -0000
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

On Wed, Jan 8, 2020 at 5:48 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2020-01-08 at 13:26 +0900, Masahiro Yamada wrote:
> > If I add
> >   do_build[recrdeptask] = "do_build"
> > to recipes/bar.bb
> >
> > "bitbake foo" shows
> >
> > baz.do_build
> > foo.do_build
> >
> >
> > So, bar:do_build is dropped from the dependency.
> >
> > What is the intent of this behavior?
>
> Quickly looking at your testcase, I'm not sure it is the intended
> behaviour so it could be a bug.


OK, I do not care about this for now.



-- 
Best Regards
Masahiro Yamada

