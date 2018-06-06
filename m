Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.161.195])
	by mail.openembedded.org (Postfix) with ESMTP id AF7BA77054
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jun 2018 13:37:10 +0000 (UTC)
Received: by mail-yw0-f195.google.com with SMTP id b125-v6so1879441ywe.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Jun 2018 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=I9fcxPuwz6vADfilllaNjfs2ig/f56b7TOwm0P2WkGw=;
	b=rg77xL52lA4DRms5L9Y2Sgy3E+Q1B1OkDtEjBxsm8bIbkYS1MzkUDx5ozaALf/zfkK
	nNGMdFv6I/1CWzRpuxDU2fzFQOehdihbjHlqfY7KgsQpbzCuZB3P6msqdRc6qhjcpVt1
	RLWlljEbeAw6nPDOhE1AzLBt+RjxAxvhrCbnOr1JLAaJeTAIDOQ4QF+XTB0e40ViF6fE
	IPQE2mdZuENcGO7xqc2vHN9xBgUqZtKrmuf8NrWszYYIXHFvs7BXWHorqHxbX//kQsLd
	ncwou3ZWyef1WuIg+8uebXGYH4CPwyG/5ig7K884+gXYgrM9gcvXCTniVSbVBlaB0eaC
	HdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=I9fcxPuwz6vADfilllaNjfs2ig/f56b7TOwm0P2WkGw=;
	b=Ebccgc1Ml96OZXtYl93aAQR/qhr5Bad20awpqnE+SIceaCEynQiMf65rGFJsD7cn55
	HKXsJM1nuLT/63gevLLuNOs3zv5J6fm3E8Skpnvvdb/8FVWTv4aZxvh5jptbFoD1il9q
	FyC82usVY2tjO7ojyPzhbkVZbu2kopn0FZ1Bbyp46/AWTXnP6EN1XltsMuTB+77hsKiY
	L6jDXpD5UtlkJlpDhFtV+J4/nazJzZTy/xRlF8n5L/AoBzhS2cJvGhHCC54AQbO+Vjm4
	d0dsDJmGDQv88clmfHj51YWpLqEqNcr09O8eM8SUpYuekGqlsSitiTXZt99yLhqXfT1A
	VGwQ==
X-Gm-Message-State: APt69E1N0GZXbJfQYTTHiMNZ7tqSJtodJM8yjXyYYs1evKXfZk6EEFY2
	Mm/yaquvnOjrsMm9717cBQTlO8YjjeAiqmL0F/U=
X-Google-Smtp-Source: ADUXVKKaANPPkyvGCuJDvgNvoyRXRJWq6RNYHaw8jzCAlgaXRWr+1wzR55USYmKWCuudizR4CK5no60kG8Hro1lQ/W4=
X-Received: by 2002:a81:6846:: with SMTP id
	d67-v6mr1455040ywc.386.1528292231540; 
	Wed, 06 Jun 2018 06:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
	<03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
In-Reply-To: <03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Wed, 6 Jun 2018 08:36:35 -0500
Message-ID: <CAJgxT3_8t-OKSuAvY_NJKWoiAXfs_YuTmB9S6K-MV9QBYJhh_g@mail.gmail.com>
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Wed, 06 Jun 2018 13:37:10 -0000
Content-Type: multipart/alternative; boundary="00000000000092f498056df94380"

--00000000000092f498056df94380
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 6, 2018 at 5:19 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2018-05-25 at 08:45 -0500, Matt Hoosier wrote:
> > Although the submodules' histories have been fetched during the
> > do_fetch() phase, the mechanics used to clone the workdir copy
> > of the repo haven't been transferring the actual .git/modules
> > directory from the repo fetched into downloads/ during the
> > fetch task.
> >
> > Fix that, and for good measure also explicitly tell Git to avoid
> > hitting the network during do_unpack() of the submodules.
> >
> > [YOCTO #12739]
> >
> > Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> > ---
> >  lib/bb/fetch2/gitsm.py | 84
> > +++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 76 insertions(+), 8 deletions(-)
>
> I hate to say this but we saw another failure from this :(
>
>
> https://autobuilder.yocto.io/builders/nightly-oe-selftest/builds/1099/steps/Running%20oe-selftest/logs/stdio
>
> (the second one, grep for submodule deinit)
>
> This was running on the centos 7 worker so I suspect older git versions
> don't have the options you're using.
>
> Cheers,
>
> Richard
>
>
>
Okay, I'll see what's going on with that. I'm still interested to know if
there's a listing of all the various automated regimens that are used as CI
before accepting Bitbake/Poky patches -- I don't want to keep wasting the
maintainers' time with failures that I could have uncovered independently.

Any comments on the aims and overall technique of this change? So far all
I've really gotten back are copy/pastes of automated builder failures.

--00000000000092f498056df94380
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Jun 6,=
 2018 at 5:19 AM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxf=
oundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Fri, 2018-05-25 at 08:45 -0500, Matt Hoosi=
er wrote:<br>
&gt; Although the submodules&#39; histories have been fetched during the<br=
>
&gt; do_fetch() phase, the mechanics used to clone the workdir copy<br>
&gt; of the repo haven&#39;t been transferring the actual .git/modules<br>
&gt; directory from the repo fetched into downloads/ during the<br>
&gt; fetch task.<br>
&gt; <br>
&gt; Fix that, and for good measure also explicitly tell Git to avoid<br>
&gt; hitting the network during do_unpack() of the submodules.<br>
&gt; <br>
&gt; [YOCTO #12739]<br>
&gt; <br>
&gt; Signed-off-by: Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gmail.c=
om" target=3D"_blank">matt.hoosier@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/gitsm.py | 84<br>
&gt; +++++++++++++++++++++++++++++++++++++++++++++-----<br>
&gt;=C2=A0 1 file changed, 76 insertions(+), 8 deletions(-)<br>
<br>
I hate to say this but we saw another failure from this :(<br>
<br>
<a href=3D"https://autobuilder.yocto.io/builders/nightly-oe-selftest/builds=
/1099/steps/Running%20oe-selftest/logs/stdio" rel=3D"noreferrer" target=3D"=
_blank">https://autobuilder.yocto.io/builders/nightly-oe-selftest/builds/10=
99/steps/Running%20oe-selftest/logs/stdio</a><br>
<br>
(the second one, grep for submodule deinit)<br>
<br>
This was running on the centos 7 worker so I suspect older git versions<br>
don&#39;t have the options you&#39;re using.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br></blockquote><div><br></div><div>Okay, I&#39;ll see what&#39;s going on=
 with that. I&#39;m still interested to know if there&#39;s a listing of al=
l the various automated regimens that are used as CI before accepting Bitba=
ke/Poky patches -- I don&#39;t want to keep wasting the maintainers&#39; ti=
me with failures that I could have uncovered independently.</div><div><br><=
/div><div>Any comments on the aims and overall technique of this change? So=
 far all I&#39;ve really gotten back are copy/pastes of automated builder f=
ailures.</div><div>=C2=A0</div></div></div>

--00000000000092f498056df94380--
