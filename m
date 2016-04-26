Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
	[209.85.223.195])
	by mail.openembedded.org (Postfix) with ESMTP id 51FB27317C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Apr 2016 14:38:57 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id x35so2382798ioi.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Apr 2016 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=/F5vfq57VpbZVeRld44biUu+YKzWZK42QNOUycMf8tk=;
	b=cGocQGXN5y033OEmBh7+iaB5Z1efbWbGu7MaFuFBNiBB/wrRz/a7gcqtf4h2VvMmAJ
	H0h6s0/v19SZ16gLE4O4vBc3BHtneOUoigf/EaGWFS54+y9TgRFsY3KBn/cu0DRjoqUb
	+ZbtYf1dcsidrExcGHuBrcGfwFL4CUdlERYFzLgOG7XB+iQeE3334o4myf53YvPCi+JV
	jSAGB9YlJJfM8orBiuRTVrpps01CfqNNNAJbh7sF4009mOCypuOgcF0EjQvgDm98Ks6f
	aAglCnKiWvzkqUGMW2BzihmS3nTL1C97F0CsuToVTxwBbA+zLnRRFAwrAwwBcoRUGNZA
	MaSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=/F5vfq57VpbZVeRld44biUu+YKzWZK42QNOUycMf8tk=;
	b=ZURVA27Ib7aKnX7o5evnmScZZxz3C5Ptps0tui5UBg0e8E/qhRV0Tc3+z7Y6UT2npZ
	58/Y9zDhr5Po32FIlauijXzdwhe4xc1UT8QDDcz5bvVjV5TijJ3VXAIvW6ozfCNhddQh
	4NoqILm2LkujL3vNMnfbQ38XqWm8dnY+C2Newi4BaRoxuxD2PB5Z0KmJXB/L7rIr7jcY
	XkQJoztwl2P5+gH8Dt026ioZWmyAZFyJ2z8UBl1RCPLxrG0FXc7Sp46/lE/3nOcl6lGP
	/dtPHSQL0MG3uFz1EtG6ekVdTJqhY4X1+sc5PNh3w+19ATZxNIDd4yhm2kgINo8CtUCC
	Vs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=/F5vfq57VpbZVeRld44biUu+YKzWZK42QNOUycMf8tk=;
	b=L17Ym9z4E5CKurwycm7LcuqbKS54f8JsPtFkWHv7ninRKRa8ObvC8CuPqzqCwO4+84
	nUPfunU216J/FGgcb6T4MKDF9xKicehuFmLKQjlXBY6LobxDmZdM56xG6CVImaXTvblR
	m+hWXq9sFUm6pJEBGnbtiBacGJ9wgfu0VElc299iKo5UnVuOowK3RIYJ8uxxLjdw7PCs
	RIk3GopKUqV9hwbvZDUJekgxVWdrpcDcyJx80pEOV9/2d1iwceAnJnm2OlpzeLBJ9T1W
	6HA5W/VyIj67vjIwtVqGDxlVHj7cEGYjAlYHFfLCJqPmUIbn/n/onIKxiJI9i1biY3lp
	gjMg==
X-Gm-Message-State: AOPr4FXfbxrCabwmdMl4cavanKQoYZsQ6O8AQXf2WFT+B/kijmtW1Xz9I1Z7I9Y7RNP1ga8JkctrQ9XzNF7HRg==
X-Received: by 10.107.2.70 with SMTP id 67mr4164478ioc.70.1461681538325; Tue,
	26 Apr 2016 07:38:58 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Tue, 26 Apr 2016 07:38:38 -0700 (PDT)
In-Reply-To: <1461667457.31320.160.camel@linuxfoundation.org>
References: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
	<1461667457.31320.160.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 26 Apr 2016 07:38:38 -0700
X-Google-Sender-Auth: kEk0tbKynzy-gS6Sm74HgRaIGJQ
Message-ID: <CABcZANkZpERuoVp8ATNpP2MrUGzt6deJYmi4QyMv5gqAcHvPgw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/4] bitbake: main: fix bad-witespace pylint warnings
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
X-List-Received-Date: Tue, 26 Apr 2016 14:38:59 -0000
Content-Type: multipart/alternative; boundary=001a11396814dde26b0531644055

--001a11396814dde26b0531644055
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 26, 2016 at 3:44 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> This patchset triggered a lively discussion between a few of us about
> whether we should or shouldn't make whitespace changes to the codebase.
>
> There is one viewpoint which is that we should state we're aiming for
> PEP8 and modify the codebase to match.
>
> Unfortunately there are pieces of API and conventions we have which do
> make sense for us and don't match PEP8. For example the use of "d" as
> our datastore variable (its a short variable name) or the camelcase in
> the datastore methods (getVarFlag) which happens to have worked really
> well for the variable dependency analysis.
>
> Personally, I also really don't like unnecessary changes in the history
> so that git blame and code annotation get distorted to the whitespace
> change commits. I probably spend more time doing that than most.
>
> My general thought is that we should aim for something PEP8 like,
> particularly around argument and keyword spacing. I'd prefer to do this
> as we add new code or modify existing code and I have been doing that
> in my own changes for a while to try and improve consistency.
>
> That said, I personally don't get worked up about line length limits
> and even the short variable names aren't that bad, *if* they're limited
> in scope to a handful of lines or follow a codebase wide convention (fn
> is filename, lf is lockfile, e is exception are the main bitbake ones
> that come to mind).
>


Indeed, and 'd' of course in many functions. I think there are a number of
instances in which short variable names are perfectly valid. List
comprehensions, generator expressions, and personally I think it's still
reasonable to use 'i' when iterating over a range in some cases.


So my feeling is we continue to try and improve the style but not go as
> far as large whitespace changes just for the sake of it.
>
> There are some sections which might be worth considering such as Ed's
> changes here to the continuation and line too long pieces of main.py
> specifically as it is currently a mess. I think the short variable
> change may actually confuse some conventions more than fixing them
> though.
>
> Certainly I don't want to see a ton of "PEP8" style cosmetic patches
> hitting the list.
>


I'd agree with all of this. Personally, I'm a fan of leaving the code
better than you found it, rather than doing blanket fixes (admittedly I've
been guilty of the latter in the past on a number of occasions, though :),
so clean up the areas we're working on for other reasons while we're in the
vicinity.

PEP8 specifically outlines that there are valid reasons to deviate from it.
See the "A Foolish Consistency is the Hobgoblin of Little Minds" section.

Regarding line length: "Some teams strongly prefer a longer line length.
For code maintained exclusively or primarily by a team that can reach
agreement on this issue, it is okay to increase the nominal line length
from 80 to 100 characters (effectively increasing the maximum length to 99
characters), provided that comments and docstrings are still wrapped at 72
characters."

It's also worth noting that a number of the things pylint recommends really
have nothing to do with pep8. I'd advise use of 'pep8' or 'flake8' rather
than pylint if you want to avoid potentially unnecessary changes.

Personally, I like to use vim with the syntastic plugin backed by flake8,
and fix the things it identifies when I'm modifying a piece of code already.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11396814dde26b0531644055
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Tue, Apr 26, 2016 at 3:44 AM, Richard Purdie <span dir=
=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=
=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">This pa=
tchset triggered a lively discussion between a few of us about<br>
whether we should or shouldn&#39;t make whitespace changes to the codebase.=
<br>
<br>
There is one viewpoint which is that we should state we&#39;re aiming for<b=
r>
PEP8 and modify the codebase to match.<br>
<br>
Unfortunately there are pieces of API and conventions we have which do<br>
make sense for us and don&#39;t match PEP8. For example the use of &quot;d&=
quot; as<br>
our datastore variable (its a short variable name) or the camelcase in<br>
the datastore methods (getVarFlag) which happens to have worked really<br>
well for the variable dependency analysis.<br>
<br>
Personally, I also really don&#39;t like unnecessary changes in the history=
<br>
so that git blame and code annotation get distorted to the whitespace<br>
change commits. I probably spend more time doing that than most.<br>
<br>
My general thought is that we should aim for something PEP8 like,<br>
particularly around argument and keyword spacing. I&#39;d prefer to do this=
<br>
as we add new code or modify existing code and I have been doing that<br>
in my own changes for a while to try and improve consistency.<br>
<br>
That said, I personally don&#39;t get worked up about line length limits<br=
>
and even the short variable names aren&#39;t that bad, *if* they&#39;re lim=
ited<br>
in scope to a handful of lines or follow a codebase wide convention (fn<br>
is filename, lf is lockfile, e is exception are the main bitbake ones<br>
that come to mind).<br></blockquote><div><br></div><div><br></div><div>Inde=
ed, and &#39;d&#39; of course in many functions. I think there are a number=
 of instances in which short variable names are perfectly valid. List compr=
ehensions, generator expressions, and personally I think it&#39;s still rea=
sonable to use &#39;i&#39; when iterating over a range in some cases.</div>=
<div>=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex">
So my feeling is we continue to try and improve the style but not go as<br>
far as large whitespace changes just for the sake of it.<br>
<br>
There are some sections which might be worth considering such as Ed&#39;s<b=
r>
changes here to the continuation and line too long pieces of main.py<br>
specifically as it is currently a mess. I think the short variable<br>
change may actually confuse some conventions more than fixing them<br>
though.<br>
<br>
Certainly I don&#39;t want to see a ton of &quot;PEP8&quot; style cosmetic =
patches<br>
hitting the list.<br></blockquote><div><br></div><div><br></div><div>I&#39;=
d agree with all of this. Personally, I&#39;m a fan of leaving the code bet=
ter than you found it, rather than doing blanket fixes (admittedly I&#39;ve=
 been guilty of the latter in the past on a number of occasions, though :),=
 so clean up the areas we&#39;re working on for other reasons while we&#39;=
re in the vicinity.</div><div><br></div><div>PEP8 specifically outlines tha=
t there are valid reasons to deviate from it. See the &quot;A Foolish Consi=
stency is the Hobgoblin of Little Minds&quot; section.</div><div><br></div>=
<div>Regarding line length: &quot;Some teams strongly prefer a longer line =
length. For code maintained exclusively or primarily by a team that can rea=
ch agreement on this issue, it is okay to increase the nominal line length =
from 80 to 100 characters (effectively increasing the maximum length to 99 =
characters), provided that comments and docstrings are still wrapped at 72 =
characters.&quot;</div><div><br></div><div>It&#39;s also worth noting that =
a number of the things pylint recommends really have nothing to do with pep=
8. I&#39;d advise use of &#39;pep8&#39; or &#39;flake8&#39; rather than pyl=
int if you want to avoid potentially unnecessary changes.</div><div><br></d=
iv><div>Personally, I like to use vim with the syntastic plugin backed by f=
lake8, and fix the things it identifies when I&#39;m modifying a piece of c=
ode already.</div></div>-- <br><div class=3D"gmail_signature">Christopher L=
arson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, Ope=
nZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics<=
/div>
</div></div>

--001a11396814dde26b0531644055--
