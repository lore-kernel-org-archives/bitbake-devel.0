Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>)
	id 1Ti7OU-0005X2-9w; Mon, 10 Dec 2012 18:43:54 +0100
Received: by mail-lb0-f175.google.com with SMTP id gg13so2129818lbb.6
	for <multiple recipients>; Mon, 10 Dec 2012 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=Aucg3N670Y1lZKraBKwnD0544pbqabwjq6eY5tbew2M=;
	b=XLtk6a0f9+P2CXve4lUs0RLWowVNWBTg7yP/JmJbcyZMitQH7LxYigD9Zz5Fc25URt
	cnWMyGTyfxGMQqJJD3IHvL/PMyekkWDQ+zD3nNzlUzw/m5Ova/hiKTo4LKi2gg64Qc76
	WTddR4k6KmEiuZ5rJ5nixc7smeSWH/wd3pVM8Z9cryYcnqU/+TphP1q+EWxrg30eHdmn
	8Rz3S5xDEVt3CJ1obr/pE1CMp05cPainINalVnWwveNvjYrJ7rVYBFe1c3zon+7XklsB
	anX6EH0NtZU03DLppzpqGFvMPN/ATb2Vwtr6mSLFcDj5cGIkLke2R5AvBzqEjcTx7OSH
	dHjA==
Received: by 10.112.87.194 with SMTP id ba2mr6489277lbb.84.1355160563222; Mon,
	10 Dec 2012 09:29:23 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Mon, 10 Dec 2012 09:29:03 -0800 (PST)
In-Reply-To: <1355155747.29967.31.camel@ted>
References: <1355155747.29967.31.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 10 Dec 2012 10:29:03 -0700
X-Google-Sender-Auth: Rmafg7PW7H0tXKRJZOxrlStgk0M
Message-ID: <CABcZANkOXMWf-v=6uEMgcGhnQZrgfOTDgjtJwarM9NRzGUupug@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: EXPORT_FUNCTIONS - change in behaviour proposal
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 10 Dec 2012 17:43:54 -0000
Content-Type: multipart/alternative; boundary=f46d0401fdfffc092f04d082e7ef

--f46d0401fdfffc092f04d082e7ef
Content-Type: text/plain; charset=UTF-8

On Mon, Dec 10, 2012 at 9:09 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> After Enrico's reported problem, I've been poking around the
> EXPORT_FUNCTIONS code. Currently OE-Core metadata generates list A
> below. In particular, this leads to code like:
>
>  do_configure calls gnomebase_do_configure
>  gnomebase_do_configure calls autotools_do_configure
>
> which has a level of indirection. The gnomebase class never references
> do_configure. I can appreciate adding in a default mapping of:
>
>  do_configure calls autotools_do_configure
>
> since it allows a user to call into autotools_do_configure from a custom
> do_configure but I can't see the value of the intermediary
> gnomebase_do_configure. Does anyone know of a use for it?
>
> I have a suspicion that if it ever did do anything useful, it stopped
> being useful long ago.
>
> I'm therefore strongly tempted to remove the intermediaries from the
> code. This would result in list B below which is a more direct set of
> mappings.
>
> Any thoughts/comments from anyone?
>

In theory, I could see a situation where one class inherits another, rather
than just individual components all inherited by the recipe.

E.g. in class alpha:

inherit beta

alpha_do_stuff () {
   pre_stuff
   beta_do_stuff
   post_stuff
}

But this is a theoretical case, and often we hack around things via
_prepend/_append rather than doing things like this, so I doubt this is
actually done anywhere in practice.
-- 
Christopher Larson

--f46d0401fdfffc092f04d082e7ef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Mon, Dec 1=
0, 2012 at 9:09 AM, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxf=
oundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":224">After Enrico&#39;s reported=
 problem, I&#39;ve been poking around the<br>
EXPORT_FUNCTIONS code. Currently OE-Core metadata generates list A<br>
below. In particular, this leads to code like:<br>
<br>
=C2=A0do_configure calls gnomebase_do_configure<br>
=C2=A0gnomebase_do_configure calls autotools_do_configure<br>
<br>
which has a level of indirection. The gnomebase class never references<br>
do_configure. I can appreciate adding in a default mapping of:<br>
<br>
=C2=A0do_configure calls autotools_do_configure<br>
<br>
since it allows a user to call into autotools_do_configure from a custom<br=
>
do_configure but I can&#39;t see the value of the intermediary<br>
gnomebase_do_configure. Does anyone know of a use for it?<br>
<br>
I have a suspicion that if it ever did do anything useful, it stopped<br>
being useful long ago.<br>
<br>
I&#39;m therefore strongly tempted to remove the intermediaries from the<br=
>
code. This would result in list B below which is a more direct set of<br>
mappings.<br>
<br>
Any thoughts/comments from anyone?</div></blockquote></div><br>In theory, I=
 could see a situation where one class inherits another, rather than just i=
ndividual components all inherited by the recipe.</div><div class=3D"gmail_=
extra">

<br></div><div class=3D"gmail_extra">E.g. in class alpha:</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">inherit beta</div><di=
v class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">alpha_do_stuff=
 () {</div>

<div class=3D"gmail_extra">=C2=A0 =C2=A0pre_stuff</div><div class=3D"gmail_=
extra">=C2=A0 =C2=A0beta_do_stuff</div><div class=3D"gmail_extra">=C2=A0 =
=C2=A0post_stuff</div><div class=3D"gmail_extra">}<br clear=3D"all"><div><b=
r></div><div>But this is a theoretical case, and often we hack around thing=
s via _prepend/_append rather than doing things like this, so I doubt this =
is actually done anywhere in practice.</div>

-- <br>Christopher Larson<br>
</div>

--f46d0401fdfffc092f04d082e7ef--
