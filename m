Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1Soi3B-0002dV-8M
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 23:32:54 +0200
Received: by yenl13 with SMTP id l13so504110yen.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 14:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:x-gm-message-state;
	bh=2UOsNu79CxwVVS4Wo5HUVB2NVdoFQtHy7PlrHXTRtKA=;
	b=ELL1YjsESSVNI8T7R/iRut7aRu38FOQMe8mRYO8omiFjaHKe/SCYE0N9+qcqBZFUrY
	gNgRsGU3XdheYJQ/Cwm4bGv6cKbWgyw63N7eLpg2zqHQO+8W6FRuTjK+HQH5cOSP9buB
	h/wQ2p9z71dOn3BbRVNQ2+vlQFUEXqRiNqvANWpOSgYz7wObvvJMCpKjM0p7Y5mgjupN
	FLZrmsqtHrUwmkvbAadMJrD1WcSQUlUDnRHjN6HdI0gbWU4ghqHrR0B0/pKLRQWMh89s
	MobfwHkKIlqJM6DuIXqCx0R3lDRaUy0WO4VwHz4Hv24mqIw8GGdxVT544ZEGv0jwRLdJ
	MvXw==
Received: by 10.50.87.138 with SMTP id ay10mr12584913igb.43.1341955300174;
	Tue, 10 Jul 2012 14:21:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.98.162 with HTTP; Tue, 10 Jul 2012 14:21:18 -0700 (PDT)
X-Originating-IP: [79.117.115.156]
In-Reply-To: <1341936529.1294.5.camel@ted>
References: <cover.1341918809.git.andrei@gherzan.ro>
	<1341927208.24837.9.camel@ted>
	<CAK18fxH6HH=HtbFA_xbdgFoUfeeTLtfFJhbY8snUSfBgqetXzQ@mail.gmail.com>
	<1341936529.1294.5.camel@ted>
From: Andrei Gherzan <andrei@gherzan.ro>
Date: Wed, 11 Jul 2012 00:21:18 +0300
Message-ID: <CAK18fxGPb4rbTYQWYke6AYnsh3gviSrDZOrqH7iqng_yhchP8w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Gm-Message-State: ALoCoQlCw8wDGnUZw1vJesAouH1rFZMjjd6P9lV77+oawnmyOWwSKG4ZCb/CAlsXWE/2+9Dg2b8N
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Modify fetchers to warn user if "param" is used
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
X-List-Received-Date: Tue, 10 Jul 2012 21:32:55 -0000
Content-Type: multipart/alternative; boundary=e89a8f3ba673f8ab4904c48050de

--e89a8f3ba673f8ab4904c48050de
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jul 10, 2012 at 7:08 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2012-07-10 at 18:04 +0300, Andrei Gherzan wrote:
> > On Tue, Jul 10, 2012 at 4:33 PM, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> >         On Tue, 2012-07-10 at 14:15 +0300, Andrei Gherzan wrote:
> >         > Andrei Gherzan (5):
> >         >   fetch2/bzr.py: Use "protocol" parameter and warn user if
> >         recipe is
> >         >     using "proto"
> >         >   fetch2/git.py: Use "protocol" parameter and warn user if
> >         recipe is
> >         >     using "proto"
> >         >   fetch2/hg.py: Use "protocol" parameter and warn user if
> >         recipe is
> >         >     using "proto"
> >         >   fetch2/osc.py: Use "protocol" parameter and warn user if
> >         recipe is
> >         >     using "proto"
> >         >   fetch2/svn.py: Use "protocol" parameter and warn user if
> >         recipe is
> >         >     using "proto"
> >         >
> >         >  bitbake/lib/bb/fetch2/bzr.py |    7 ++++++-
> >         >  bitbake/lib/bb/fetch2/git.py |    4 ++++
> >         >  bitbake/lib/bb/fetch2/hg.py  |    7 ++++++-
> >         >  bitbake/lib/bb/fetch2/osc.py |    7 ++++++-
> >         >  bitbake/lib/bb/fetch2/svn.py |    7 ++++++-
> >         >  5 files changed, 28 insertions(+), 4 deletions(-)
> >
> >         How about putting this check into __init__.py and then just
> >         setting the
> >         protocol parameter instead if its used? We can then change the
> >         backends
> >         just to use procotol right now.
> >
> >
> > I can add the warning in init but how would i define the local proto
> > value to the one defined with parameter "proto"?
>
> In FetchData::__init__(), add
>
>         proto = self.parm.get("proto", None)
>         if proto and "protocol" not in self.param:
>             self.parm["protocol"] = proto
>
> before urldata_init?
>
> Yes. It makes sense this way. V2 is on it's way.

@g

--e89a8f3ba673f8ab4904c48050de
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Jul 10, 2012 at 7:08 PM, Richard Purdie =
<span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org"=
 target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">

<div class=3D"HOEnZb"><div class=3D"h5">On Tue, 2012-07-10 at 18:04 +0300, =
Andrei Gherzan wrote:<br>
&gt; On Tue, Jul 10, 2012 at 4:33 PM, Richard Purdie<br>
&gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purd=
ie@linuxfoundation.org</a>&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 On Tue, 2012-07-10 at 14:15 +0300, Andrei Gherzan wrot=
e:<br>
&gt; =A0 =A0 =A0 =A0 &gt; Andrei Gherzan (5):<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 fetch2/bzr.py: Use &quot;protocol&quot; param=
eter and warn user if<br>
&gt; =A0 =A0 =A0 =A0 recipe is<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 using &quot;proto&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 fetch2/git.py: Use &quot;protocol&quot; param=
eter and warn user if<br>
&gt; =A0 =A0 =A0 =A0 recipe is<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 using &quot;proto&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 fetch2/hg.py: Use &quot;protocol&quot; parame=
ter and warn user if<br>
&gt; =A0 =A0 =A0 =A0 recipe is<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 using &quot;proto&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 fetch2/osc.py: Use &quot;protocol&quot; param=
eter and warn user if<br>
&gt; =A0 =A0 =A0 =A0 recipe is<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 using &quot;proto&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 fetch2/svn.py: Use &quot;protocol&quot; param=
eter and warn user if<br>
&gt; =A0 =A0 =A0 =A0 recipe is<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 using &quot;proto&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0bitbake/lib/bb/fetch2/bzr.py | =A0 =A07 ++++++=
-<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0bitbake/lib/bb/fetch2/git.py | =A0 =A04 ++++<b=
r>
&gt; =A0 =A0 =A0 =A0 &gt; =A0bitbake/lib/bb/fetch2/hg.py =A0| =A0 =A07 ++++=
++-<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0bitbake/lib/bb/fetch2/osc.py | =A0 =A07 ++++++=
-<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0bitbake/lib/bb/fetch2/svn.py | =A0 =A07 ++++++=
-<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A05 files changed, 28 insertions(+), 4 deletions=
(-)<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 How about putting this check into __init__.py and then=
 just<br>
&gt; =A0 =A0 =A0 =A0 setting the<br>
&gt; =A0 =A0 =A0 =A0 protocol parameter instead if its used? We can then ch=
ange the<br>
&gt; =A0 =A0 =A0 =A0 backends<br>
&gt; =A0 =A0 =A0 =A0 just to use procotol right now.<br>
&gt;<br>
&gt;<br>
&gt; I can add the warning in init but how would i define the local proto<b=
r>
&gt; value to the one defined with parameter &quot;proto&quot;?<br>
<br>
</div></div>In FetchData::__init__(), add<br>
<br>
=A0 =A0 =A0 =A0 proto =3D self.parm.get(&quot;proto&quot;, None)<br>
=A0 =A0 =A0 =A0 if proto and &quot;protocol&quot; not in self.param:<br>
=A0 =A0 =A0 =A0 =A0 =A0 self.parm[&quot;protocol&quot;] =3D proto<br>
<br>
before urldata_init?<br><br></blockquote><div>Yes. It makes sense this way.=
 V2 is on it&#39;s way.</div><div><br></div><div>@g=A0</div></div><br>

--e89a8f3ba673f8ab4904c48050de--
