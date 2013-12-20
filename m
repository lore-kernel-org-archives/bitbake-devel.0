Return-Path: <david.good1@gmail.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 581C760D39
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 22:42:35 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id j9so705894wiv.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=Jf98VkvVB4Mtp1/E/M//nqQMYhUiPe5Lnzlvp13o6sI=;
	b=M8XjXIPglOfYWvMeXrPRKCf+Ken6iIzbexBtPfCa7YZlhGOr6uuvU/xNd2XGFaIL1g
	NHMSkX8a4RW085+Yej6tG8dmHNkoNpsmb1BxMjBt5TfeaE+1nJOjBNdpPh8NuoeQ378W
	TAnN/j01LylSzfRINL9CW/W1l10jPzebnLcbsQix/dpDSM0ZuHNBh7A22A9UXtEkmIyE
	w5hGJUFIW+UBBMnlp4GDuIgmxqq6Nfihyr0j1+Gc2oTdSUXvAQyx3Tn2+p2tJYlu39SH
	u8afcppANjjOxTpx+gjMpUl4ZKhbSDUP9A38trGP586BS3yHRTOlTsGdTHZOHD8nGf9w
	MA2g==
X-Received: by 10.180.206.108 with SMTP id ln12mr9984583wic.16.1387579355637; 
	Fri, 20 Dec 2013 14:42:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.171.202 with HTTP; Fri, 20 Dec 2013 14:42:15 -0800 (PST)
In-Reply-To: <1387539469.6402.89.camel@ted>
References: <CALMFhSzPCspAJ6BbgD0dYk7EVP780zQPb8enJ7YCYY05mBdf8g@mail.gmail.com>
	<1387539469.6402.89.camel@ted>
From: David Good <david.good1@gmail.com>
Date: Fri, 20 Dec 2013 16:42:15 -0600
Message-ID: <CALMFhSw9sRA2BVcmOh3gJQTT6EtVSFddd3JCEBQW1kBeNvOyGQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Running configure script up one dir
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
X-List-Received-Date: Fri, 20 Dec 2013 22:42:36 -0000
Content-Type: multipart/alternative; boundary=001a11c258e2972f2804edfefe97

--001a11c258e2972f2804edfefe97
Content-Type: text/plain; charset=ISO-8859-1

Richard,

Thanks for the suggestion!  I'm getting somewhere now, but will post the
rest of my questions to the OE-Core mailing list.

Thanks!

--David


On Fri, Dec 20, 2013 at 5:37 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Hi,
>
> On Thu, 2013-12-19 at 23:18 -0600, David Good wrote:
> > I hope that this is the right list for my question.
>
> Its really a question that should go to the openembedded-core list since
> its about the metadata which is part of OE-Core.
>
> >   I'm trying to write a bb recipe for Angstrom v2012_12 (BeagleBone
> > Black) for the tDOM package which uses autotools in a strange way (to
> > me anyhow).  configure is expected to be run from /(project
> > root)/unix, like this:
>
> It tricky to do but the freetype recipe in OE-Core shows one way of
> handling this.
>
> Cheers,
>
> Richard
>
>
>

--001a11c258e2972f2804edfefe97
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Richard,<br><br>Thanks for the suggest=
ion!=A0 I&#39;m getting somewhere now, but will post the rest of my questio=
ns to the OE-Core mailing list.<br><br></div>Thanks!<br><br></div><div>--Da=
vid<br>

</div></div></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gm=
ail_quote">On Fri, Dec 20, 2013 at 5:37 AM, Richard Purdie <span dir=3D"ltr=
">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blan=
k">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<div class=3D"im"><br>
On Thu, 2013-12-19 at 23:18 -0600, David Good wrote:<br>
&gt; I hope that this is the right list for my question.<br>
<br>
</div>Its really a question that should go to the openembedded-core list si=
nce<br>
its about the metadata which is part of OE-Core.<br>
<div class=3D"im"><br>
&gt; =A0 I&#39;m trying to write a bb recipe for Angstrom v2012_12 (BeagleB=
one<br>
&gt; Black) for the tDOM package which uses autotools in a strange way (to<=
br>
&gt; me anyhow). =A0configure is expected to be run from /(project<br>
&gt; root)/unix, like this:<br>
<br>
</div>It tricky to do but the freetype recipe in OE-Core shows one way of<b=
r>
handling this.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div><br></div>

--001a11c258e2972f2804edfefe97--
