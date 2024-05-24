Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CA9C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 18:24:31 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.web10.2623.1716575067392379209
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 11:24:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aPvtBO28;
 spf=pass (domain: gmail.com, ip: 209.85.128.173, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a08270b46so12178527b3.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716575066; x=1717179866; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B9l9kIP4CGpYT2LVeoD3YCdkjpzZqhqH6ypceW9+TM8=;
        b=aPvtBO28jTeh6a4W7htFnhrSYL0oSNa4G7vif62L3kpWC7PaK5MQioxmQKLyDENHC4
         l1M2YphxXimfljL4uFeLkeEaElI3vXru0EYBdKQbLX3bT1w+KU3Vl8lcVZ9cZfLeUNJV
         NLeIu1tYOEjKTGPdC3rOM6C1xLNZr95vEEBOSSSGX9tvhZspUbS7ARWhtHKMfFzvFPnq
         4AxPSSWG/6+rzOPs82uFuHoHSy18GhFaBnFbikxvJ8VorZszRWu3ympNmq30c/Y7LAAY
         QLIyjRNzWMHFDBmtgxjzwrBD/OJDKVnG1XPV31vHB1cMHZsrT7o+mX0jjFDi9rRoIImS
         9HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575066; x=1717179866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9l9kIP4CGpYT2LVeoD3YCdkjpzZqhqH6ypceW9+TM8=;
        b=a/bZvuAGJD5Cj4HQFgv+P5UX4FM6H8m1asy10ghDSw2Xjdbei+/elURX/vUfIYSi90
         qj0l1VC0vmUA0UMjB4aN5BfuK3n22SblhqMaF+bS8GpZRLPgqqKv+Ld2BTPTXx/OyBm9
         kRIWffoYDuzu67zzWYUiF1c5EYE30OAnCWvnQ8dUHOIGI+iH7Jmkp+HZl3wGlK++Logo
         KfHTSxLvU9jMg+w1qn9qQjQP+3MODvGIbpKF6XFjyy0kKMN9BHfmWucpQqAbd5TwVqjl
         2nSX6j0T8C1s9sB8CF1m8dcbDjstJG9SqXaMQ6zgjHJ4pN1vApp90cLX4TnuLintxFg7
         x5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHhTU/E3l/lahCTIOK/17N8aqC+IBW7ynamaE8UAOk4bGIOBn/NATy9aRJtPqUNDL53lLEmTHEDvTY7raMxV29C1iclsu6PNcdVeUEN3p0tl9bLEI=
X-Gm-Message-State: AOJu0YxWymhe4XslVaGMMjJS4MRcw/lO8C/Uqr7DNYGpZ5kN7G/yLlu3
	urEXHA+LKbgnSrQ9Ui6V3SmwAc42iVGe061Imm7ViYYy/GI2SC4UJ48jmc3n1nQTz3+psTA60R1
	jwBgm0TqkSk+MzYEKjjFjEsdpTZk=
X-Google-Smtp-Source: AGHT+IEjWnCXfl2IW9AhTbUUMxxezEcrlfXI8w87M5rAyyXULFkCU7LWKLuu+3aeQ/Cot2WTLc+erYRhmBIo3KdS1T8=
X-Received: by 2002:a0d:d9c9:0:b0:627:a7d7:6d76 with SMTP id
 00721157ae682-62a08f47438mr30549407b3.39.1716575066521; Fri, 24 May 2024
 11:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de>
 <CAMKF1sq9U9VpPPbkmpot7TejVOemWjGqydyWiBn68Dz2vyhEEA@mail.gmail.com>
 <de18f958-d6db-4f90-a49b-a181d046f77e@cherry.de> <CAMKF1spNvMbuy+a-HS7wEbx5D817t6oxb_R12=gBgKgG8Eja1Q@mail.gmail.com>
In-Reply-To: <CAMKF1spNvMbuy+a-HS7wEbx5D817t6oxb_R12=gBgKgG8Eja1Q@mail.gmail.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 24 May 2024 11:24:15 -0700
Message-ID: <CANx9H-CC9YHqTv6LgZE8jP0KVJC5Wsvyc8wmzhnf9crRG7ej4A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] add basic b4 config file
To: raj.khem@gmail.com
Cc: Quentin Schulz <quentin.schulz@cherry.de>, foss@0leil.net, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000012092b0619374716"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 18:24:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16265

--00000000000012092b0619374716
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 9:28=E2=80=AFAM Khem Raj via lists.openembedded.org
<raj.khem=3Dgmail.com@lists.openembedded.org> wrote:

> On Fri, May 24, 2024 at 8:33=E2=80=AFAM Quentin Schulz <quentin.schulz@ch=
erry.de>
> wrote:
> >
> > Hi Khem,
> >
> > On 5/24/24 5:18 PM, Khem Raj via lists.openembedded.org wrote:
> > > On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via
> > > lists.openembedded.org <foss=3D0leil.net@lists.openembedded.org> wrot=
e:
> > >>
> > >> From: Quentin Schulz <quentin.schulz@cherry.de>
> > >>
> > >> b4[1] is a very nice tool for mail-based contribution. A config[2]
> file
> > >> exists to set up a few defaults. We can use it to set the Cc
> recipients
> > >> to always add, in our case the mailing list.
> > >>
> > >> This shouldn't be necessary if we had a script that b4 prep
> --auto-to-cc
> > >> could call to find the mail address(es) to send to. While we could d=
o
> > >> that, this opens the door to people trying to add a way to notify so=
me
> > >> people (e.g. a MAINTAINERS file) which is not somewhere the project
> > >> wants to go right now, and this also makes sure the address is alway=
s
> > >> added even if one forgets to run b4 prep --auto-to-cc (which is part
> of
> > >> the typical workflow for U-Boot and Linux kernel, but is not necessa=
ry
> > >> thanks to this patch).
> > >>
> > >> [1] https://pypi.org/project/b4/
> > >> [2] https://b4.docs.kernel.org/en/latest/config.html
> > >>
> > >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >> ---
> > >> This adds a basic config file for b4 to avoid to have to add the
> mailing
> > >> list by hand. For documentation patches, one will still need to run
> > >> b4 send --cc docs@lists.yoctoproject.org
> > >> manually for sending it to the docs ML as well.
> > >>
> > >> Note that b4 supports patchwork, c.f.
> > >>
> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-se=
ttings
> > >> though I have no clue what it does with it as I am no maintainer, bu=
t
> > >> maybe something worth having a look at if some maintainer of this re=
po
> > >> wants to use b4 to merge stuff?
> > >
> > > I use b4 regularly for meta-openembedded maintenance and it also
> updates
> > > patchwork when patch is accepted, I have this config.
> > >
> > >     [b4]
> > >      pw-url =3D "https://patchwork.yoctoproject.org/"
> > >      pw-key =3D "<mykey>"
> > >      pw-project =3D "oe"
> > >      pw-review-state =3D "under-review"
> > >      pw-accept-state =3D  "accepted"
> > >      pw-discard-state =3D "rejected"
> > >      send-series-to =3D "openembedded-devel@lists.openembedded.org"
>

This inspired me to revisit the issue I was having with "b4 shazam <
message.id for an AUH upgrade>", where
shazam would stumble because of the "scissors line" (--- >8 ---)

Turns out the solution appears to be
[b4]
    stdin-pipe-sep =3D "--- >8 ---"


> > >
> >
> > Thanks for the example! Would it make sense for me to add the pw parts
> > to this patch as well (in a v2 for example)?
>
> Maybe, it can be documented like this but I would leave it to the
> maintainers
> to promote using b4 not.
>
> >
> > I'm perplexed about the pw-key though. This is very much something we
> > don't want to version nor potentially leak by mistake. I assume it is
> > not possible to add to the global ~/.config/git/config or ~/.gitconfig
> > because the URL would change for example between projects (I assume we
> > may have a different patchwork for OE and YP, but for sure if people
> > maintain kernel stuff as well, then they would have one for kernel.org
> > for example). Mmmm but maybe a simple
> >
> > git config b4.pw-key "<mykey>"
> >
> > from within the local git repo would be enough :)
>
> right, it must be documented clearly. setting up b4 is not simple like a
> pull
> request merge.
>
> >
> > BTW, I see you have -to instead of what I sent (-cc), is there a
> > preference here? (I took Cc since this is what we document in the
> README).
>
> I used --to because at times to field was being left empty.
> >
> > Cheers,
> > Quentin
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16264):
> https://lists.openembedded.org/g/bitbake-devel/message/16264
> Mute This Topic: https://lists.openembedded.org/mt/106281674/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000012092b0619374716
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 24, 2024 at 9:28=E2=80=AF=
AM Khem Raj via <a href=3D"http://lists.openembedded.org">lists.openembedde=
d.org</a> &lt;raj.khem=3D<a href=3D"mailto:gmail.com@lists.openembedded.org=
">gmail.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Fri, May 24, 2024 at 8:33=E2=80=AFAM Q=
uentin Schulz &lt;<a href=3D"mailto:quentin.schulz@cherry.de" target=3D"_bl=
ank">quentin.schulz@cherry.de</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Khem,<br>
&gt;<br>
&gt; On 5/24/24 5:18 PM, Khem Raj via <a href=3D"http://lists.openembedded.=
org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a> wrote:=
<br>
&gt; &gt; On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via<br>
&gt; &gt; <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" targ=
et=3D"_blank">lists.openembedded.org</a> &lt;foss=3D<a href=3D"mailto:0leil=
.net@lists.openembedded.org" target=3D"_blank">0leil.net@lists.openembedded=
.org</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; From: Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@che=
rry.de" target=3D"_blank">quentin.schulz@cherry.de</a>&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; b4[1] is a very nice tool for mail-based contribution. A conf=
ig[2] file<br>
&gt; &gt;&gt; exists to set up a few defaults. We can use it to set the Cc =
recipients<br>
&gt; &gt;&gt; to always add, in our case the mailing list.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This shouldn&#39;t be necessary if we had a script that b4 pr=
ep --auto-to-cc<br>
&gt; &gt;&gt; could call to find the mail address(es) to send to. While we =
could do<br>
&gt; &gt;&gt; that, this opens the door to people trying to add a way to no=
tify some<br>
&gt; &gt;&gt; people (e.g. a MAINTAINERS file) which is not somewhere the p=
roject<br>
&gt; &gt;&gt; wants to go right now, and this also makes sure the address i=
s always<br>
&gt; &gt;&gt; added even if one forgets to run b4 prep --auto-to-cc (which =
is part of<br>
&gt; &gt;&gt; the typical workflow for U-Boot and Linux kernel, but is not =
necessary<br>
&gt; &gt;&gt; thanks to this patch).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; [1] <a href=3D"https://pypi.org/project/b4/" rel=3D"noreferre=
r" target=3D"_blank">https://pypi.org/project/b4/</a><br>
&gt; &gt;&gt; [2] <a href=3D"https://b4.docs.kernel.org/en/latest/config.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://b4.docs.kernel.org/en/late=
st/config.html</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Quentin Schulz &lt;<a href=3D"mailto:quentin.s=
chulz@cherry.de" target=3D"_blank">quentin.schulz@cherry.de</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt; This adds a basic config file for b4 to avoid to have to add =
the mailing<br>
&gt; &gt;&gt; list by hand. For documentation patches, one will still need =
to run<br>
&gt; &gt;&gt; b4 send --cc <a href=3D"mailto:docs@lists.yoctoproject.org" t=
arget=3D"_blank">docs@lists.yoctoproject.org</a><br>
&gt; &gt;&gt; manually for sending it to the docs ML as well.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Note that b4 supports patchwork, c.f.<br>
&gt; &gt;&gt; <a href=3D"https://b4.docs.kernel.org/en/latest/config.html#p=
atchwork-integration-settings" rel=3D"noreferrer" target=3D"_blank">https:/=
/b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings</a=
><br>
&gt; &gt;&gt; though I have no clue what it does with it as I am no maintai=
ner, but<br>
&gt; &gt;&gt; maybe something worth having a look at if some maintainer of =
this repo<br>
&gt; &gt;&gt; wants to use b4 to merge stuff?<br>
&gt; &gt;<br>
&gt; &gt; I use b4 regularly for meta-openembedded maintenance and it also =
updates<br>
&gt; &gt; patchwork when patch is accepted, I have this config.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0[b4]<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-url =3D &quot;<a href=3D"https://patchwork=
.yoctoproject.org/" rel=3D"noreferrer" target=3D"_blank">https://patchwork.=
yoctoproject.org/</a>&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-key =3D &quot;&lt;mykey&gt;&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-project =3D &quot;oe&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-review-state =3D &quot;under-review&quot;<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-accept-state =3D=C2=A0 &quot;accepted&quot=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-discard-state =3D &quot;rejected&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 send-series-to =3D &quot;<a href=3D"mailto:op=
enembedded-devel@lists.openembedded.org" target=3D"_blank">openembedded-dev=
el@lists.openembedded.org</a>&quot;<br></blockquote><div><br></div><div>Thi=
s inspired me to revisit the issue I was having with &quot;b4 shazam &lt;<a=
 href=3D"http://message.id">message.id</a> for an AUH upgrade&gt;&quot;, wh=
ere</div><div>shazam would stumble because of the &quot;scissors line&quot;=
 (--- &gt;8 ---)</div><div><br></div><div>Turns out the solution appears to=
 be<br>[b4]<br>=C2=A0 =C2=A0 stdin-pipe-sep =3D &quot;--- &gt;8 ---&quot;</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; &gt;<br>
&gt;<br>
&gt; Thanks for the example! Would it make sense for me to add the pw parts=
<br>
&gt; to this patch as well (in a v2 for example)?<br>
<br>
Maybe, it can be documented like this but I would leave it to the maintaine=
rs<br>
to promote using b4 not.<br>
<br>
&gt;<br>
&gt; I&#39;m perplexed about the pw-key though. This is very much something=
 we<br>
&gt; don&#39;t want to version nor potentially leak by mistake. I assume it=
 is<br>
&gt; not possible to add to the global ~/.config/git/config or ~/.gitconfig=
<br>
&gt; because the URL would change for example between projects (I assume we=
<br>
&gt; may have a different patchwork for OE and YP, but for sure if people<b=
r>
&gt; maintain kernel stuff as well, then they would have one for <a href=3D=
"http://kernel.org" rel=3D"noreferrer" target=3D"_blank">kernel.org</a><br>
&gt; for example). Mmmm but maybe a simple<br>
&gt;<br>
&gt; git config b4.pw-key &quot;&lt;mykey&gt;&quot;<br>
&gt;<br>
&gt; from within the local git repo would be enough :)<br>
<br>
right, it must be documented clearly. setting up b4 is not simple like a pu=
ll<br>
request merge.<br>
<br>
&gt;<br>
&gt; BTW, I see you have -to instead of what I sent (-cc), is there a<br>
&gt; preference here? (I took Cc since this is what we document in the READ=
ME).<br>
<br>
I used --to because at times to field was being left empty.<br>
&gt;<br>
&gt; Cheers,<br>
&gt; Quentin<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16264): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16264" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16264</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/106281674/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/106281674/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--00000000000012092b0619374716--

