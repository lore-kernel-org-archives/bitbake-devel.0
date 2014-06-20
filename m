Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
	[209.85.215.44])
	by mail.openembedded.org (Postfix) with ESMTP id 708D37020E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 16:09:52 +0000 (UTC)
Received: by mail-la0-f44.google.com with SMTP id ty20so2577197lab.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=lavQ8nMFOUp3Aqjb/MsenuPjWUBRxmc/37zBlCdgQ28=;
	b=MuZK3bCP1Rl0j4uPOzZmtPM5ELsFUr+/GvKZjReUlEaOmujadFdYVrLT3IHxnEKZra
	77zdIietGxzqEKx53vBnvfUidMez0qU8Jza+UuoaY8+cYKPrXA/2vRf5PNvNWj07Vb4N
	koyeIMyyfJbFy6oGkchxGYu+hvgSZKKObTkzDfsLkGTJbyf3jhPIVjI0srFd85zQ+9QI
	GHhWYq2/aoZJ65ud+6etjeHU0LdNR/YyQ2g6+5jIv7zfeoW+8F8febsgIph0pvBqYcrx
	p+qY6y8+0nlhTwdc3HYpO5AtBZHdirj9+S0NRyMRJvmj8FWBpCzYOS6XHdBrZm/ERe9R
	mlfw==
X-Received: by 10.112.160.105 with SMTP id xj9mr2948959lbb.2.1403280592839;
	Fri, 20 Jun 2014 09:09:52 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.31.165 with HTTP; Fri, 20 Jun 2014 09:09:31 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1406201152050.4233@localhost>
References: <alpine.LFD.2.11.1406200725340.5971@localhost>
	<CABcZANn_x7Y9XJ-g861+9YEsXtVNwF-krtf7QBgrG50PxUdEPw@mail.gmail.com>
	<alpine.LFD.2.11.1406201152050.4233@localhost>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 20 Jun 2014 09:09:31 -0700
X-Google-Sender-Auth: wNP8wONy52Bxki4Dnh_asyXTJjs
Message-ID: <CABcZANmTosw+ZZspMawLJEFdUpQPDVeh95W9e+9Yfn3_i6PX2A@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: distinguishing between bitbake and "higher" layers WRT fetching variables [LONG]
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
X-List-Received-Date: Fri, 20 Jun 2014 16:09:55 -0000
Content-Type: multipart/alternative; boundary=001a11c2ab5c41a9e504fc46b9ee

--001a11c2ab5c41a9e504fc46b9ee
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 20, 2014 at 8:55 AM, Robert P. J. Day <rpjday@crashcourse.ca>
wrote:

> On Fri, 20 Jun 2014, Christopher Larson wrote:
>
> >
> > On Fri, Jun 20, 2014 at 8:47 AM, Robert P. J. Day <rpjday@crashcourse.ca>
> wrote:
> >         (note: more annoying pedantry regarding bitbake configuration and
> >       documentation but, if i'm going to explain this to my students, i
> >       really need to understand it completely.)
> >
> >         some questions and observations about how bitbake defines some
> >       fetch-related variables as opposed to how those variables are
> defined
> >       in higher layers such as oe-core and poky. as richard purdie(?)
> >       pointed out recently, the goal should be to document bitbake as
> >       independently as possible from what happens in layers such as oe
> and
> >       poky, but it seems this is not as clean as it could be.
> >
> >         consider first bitbake's current bitbake.conf file. first, can we
> >       agree that this set of variables:
> >
> >
> > Before I dive into the remainder of the email, we should note that
> > the bitbake.conf in bitbake is never used when you use oe, it's
> > solely as an example / starting point for other non-oe projects
> > wanting to use bitbake. Presumably it gets forgotten about when
> > changes to bitbake itself are made, and so it's fallen behind.
>
>   oh, i realize that but (i think) my main point was that it seems
> almost impossible to document bitbake completely stand-alone when
> almost everyone is going to use it in the context of a higher layer
> like OE, and there just seem to be unnecessary inconsistencies between
> bitbake and OE that make the bitbake user manual confusing.


Fair enough. An argument could be made that oe-core *is* the example of how
to use bitbake, but the problem with that is, the bitbake.conf there
doesn't differentiate between what's required for bitbake / what vars are
obeyed specifically by bitbake and the vars that are obeyed by oe-core's
classes, so a non-oe project would have difficulty in paring it down to
what they need for their own projects.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c2ab5c41a9e504fc46b9ee
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 20, 2014 at 8:55 AM, Robert P. J. Day <span dir=3D"ltr">&lt;<a =
href=3D"mailto:rpjday@crashcourse.ca" target=3D"_blank">rpjday@crashcourse.=
ca</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On Fri, 20 Jun 2014, Christo=
pher Larson wrote:<br>
<br>
&gt;<br>
&gt; On Fri, Jun 20, 2014 at 8:47 AM, Robert P. J. Day &lt;<a href=3D"mailt=
o:rpjday@crashcourse.ca">rpjday@crashcourse.ca</a>&gt; wrote:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 (note: more annoying pedantry regarding bi=
tbake configuration and<br>
&gt; =C2=A0 =C2=A0 =C2=A0 documentation but, if i&#39;m going to explain th=
is to my students, i<br>
&gt; =C2=A0 =C2=A0 =C2=A0 really need to understand it completely.)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 some questions and observations about how =
bitbake defines some<br>
&gt; =C2=A0 =C2=A0 =C2=A0 fetch-related variables as opposed to how those v=
ariables are defined<br>
&gt; =C2=A0 =C2=A0 =C2=A0 in higher layers such as oe-core and poky. as ric=
hard purdie(?)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pointed out recently, the goal should be to docum=
ent bitbake as<br>
&gt; =C2=A0 =C2=A0 =C2=A0 independently as possible from what happens in la=
yers such as oe and<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poky, but it seems this is not as clean as it cou=
ld be.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 consider first bitbake&#39;s current bitba=
ke.conf file. first, can we<br>
&gt; =C2=A0 =C2=A0 =C2=A0 agree that this set of variables:<br>
&gt;<br>
&gt;<br>
&gt; Before I dive into the remainder of the email, we should note that<br>
&gt; the bitbake.conf in bitbake is never used when you use oe, it&#39;s<br=
>
&gt; solely as an example / starting point for other non-oe projects<br>
&gt; wanting to use bitbake. Presumably it gets forgotten about when<br>
&gt; changes to bitbake itself are made, and so it&#39;s fallen behind.<br>
<br>
</div>=C2=A0 oh, i realize that but (i think) my main point was that it see=
ms<br>
almost impossible to document bitbake completely stand-alone when<br>
almost everyone is going to use it in the context of a higher layer<br>
like OE, and there just seem to be unnecessary inconsistencies between<br>
bitbake and OE that make the bitbake user manual confusing.</blockquote></d=
iv><br></div><div class=3D"gmail_extra">Fair enough. An argument could be m=
ade that oe-core *is* the example of how to use bitbake, but the problem wi=
th that is, the bitbake.conf there doesn&#39;t differentiate between what&#=
39;s required for bitbake / what vars are obeyed specifically by bitbake an=
d the vars that are obeyed by oe-core&#39;s classes, so a non-oe project wo=
uld have difficulty in paring it down to what they need for their own proje=
cts.<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--001a11c2ab5c41a9e504fc46b9ee--
