Received: from mail-gh0-f175.google.com ([209.85.160.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SocAN-0006WP-E3
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 17:15:55 +0200
Received: by ghbz2 with SMTP id z2so73862ghb.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 08:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:x-gm-message-state;
	bh=xwhCp9wxbzWWQ3873tJTHwjO2COLYP3WlvWoMHA21M4=;
	b=BOaDqYb9mRvUlvLOu2GL/kB+7AGnnpzmvpziVaxkQGtK/Cc7GgM85jITRjiPdGXey4
	guEmk5tQcE3PzownjmhqCba0Z9WaIfHFphmIcm1VBIrfDZyigg7fGH054kEQc9wGGY3i
	aeiMs7PK0dysV20ecV0Kdw1omgHwUNvg5AytYIygIaMvgVh0K1bfiTZBcAtsu2n4pDHx
	G1QsGjeF2b62uvjHyf8+KksOEFpaWtxnAHiZWGrUUQ/QUrQsTXV0gOlMoKZnibSCHf90
	MKhalFiIPL/ro0BQFmlJZ89U++7rjuyME75+0gbU1SJ/Ve357w9FALk7N8+9A1Ni2QNj
	t8cA==
Received: by 10.50.159.196 with SMTP id xe4mr11587883igb.43.1341932684181;
	Tue, 10 Jul 2012 08:04:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.98.162 with HTTP; Tue, 10 Jul 2012 08:04:24 -0700 (PDT)
X-Originating-IP: [89.121.200.106]
In-Reply-To: <1341927208.24837.9.camel@ted>
References: <cover.1341918809.git.andrei@gherzan.ro>
	<1341927208.24837.9.camel@ted>
From: Andrei Gherzan <andrei@gherzan.ro>
Date: Tue, 10 Jul 2012 18:04:24 +0300
Message-ID: <CAK18fxH6HH=HtbFA_xbdgFoUfeeTLtfFJhbY8snUSfBgqetXzQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Gm-Message-State: ALoCoQndL/tyYh4Q+4LW1FxhDgNbSkjXx8kEzdTnnm+mEuUmXadUFZJgQ09lfzh6VP07By0m/3Op
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
X-List-Received-Date: Tue, 10 Jul 2012 15:15:55 -0000
Content-Type: multipart/alternative; boundary=14dae934059bf400f804c47b0c9b

--14dae934059bf400f804c47b0c9b
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jul 10, 2012 at 4:33 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2012-07-10 at 14:15 +0300, Andrei Gherzan wrote:
> > Andrei Gherzan (5):
> >   fetch2/bzr.py: Use "protocol" parameter and warn user if recipe is
> >     using "proto"
> >   fetch2/git.py: Use "protocol" parameter and warn user if recipe is
> >     using "proto"
> >   fetch2/hg.py: Use "protocol" parameter and warn user if recipe is
> >     using "proto"
> >   fetch2/osc.py: Use "protocol" parameter and warn user if recipe is
> >     using "proto"
> >   fetch2/svn.py: Use "protocol" parameter and warn user if recipe is
> >     using "proto"
> >
> >  bitbake/lib/bb/fetch2/bzr.py |    7 ++++++-
> >  bitbake/lib/bb/fetch2/git.py |    4 ++++
> >  bitbake/lib/bb/fetch2/hg.py  |    7 ++++++-
> >  bitbake/lib/bb/fetch2/osc.py |    7 ++++++-
> >  bitbake/lib/bb/fetch2/svn.py |    7 ++++++-
> >  5 files changed, 28 insertions(+), 4 deletions(-)
>
> How about putting this check into __init__.py and then just setting the
> protocol parameter instead if its used? We can then change the backends
> just to use procotol right now.
>
>
I can add the warning in init but how would i define the local proto value
to the one defined with parameter "proto"?

@g

--14dae934059bf400f804c47b0c9b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Jul 10, 2012 at 4:33 PM, Richard Purdie =
<span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org"=
 target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">

On Tue, 2012-07-10 at 14:15 +0300, Andrei Gherzan wrote:<br>
&gt; Andrei Gherzan (5):<br>
&gt; =A0 fetch2/bzr.py: Use &quot;protocol&quot; parameter and warn user if=
 recipe is<br>
&gt; =A0 =A0 using &quot;proto&quot;<br>
&gt; =A0 fetch2/git.py: Use &quot;protocol&quot; parameter and warn user if=
 recipe is<br>
&gt; =A0 =A0 using &quot;proto&quot;<br>
&gt; =A0 fetch2/hg.py: Use &quot;protocol&quot; parameter and warn user if =
recipe is<br>
&gt; =A0 =A0 using &quot;proto&quot;<br>
&gt; =A0 fetch2/osc.py: Use &quot;protocol&quot; parameter and warn user if=
 recipe is<br>
&gt; =A0 =A0 using &quot;proto&quot;<br>
&gt; =A0 fetch2/svn.py: Use &quot;protocol&quot; parameter and warn user if=
 recipe is<br>
&gt; =A0 =A0 using &quot;proto&quot;<br>
&gt;<br>
&gt; =A0bitbake/lib/bb/fetch2/bzr.py | =A0 =A07 ++++++-<br>
&gt; =A0bitbake/lib/bb/fetch2/git.py | =A0 =A04 ++++<br>
&gt; =A0bitbake/lib/bb/fetch2/hg.py =A0| =A0 =A07 ++++++-<br>
&gt; =A0bitbake/lib/bb/fetch2/osc.py | =A0 =A07 ++++++-<br>
&gt; =A0bitbake/lib/bb/fetch2/svn.py | =A0 =A07 ++++++-<br>
&gt; =A05 files changed, 28 insertions(+), 4 deletions(-)<br>
<br>
How about putting this check into __init__.py and then just setting the<br>
protocol parameter instead if its used? We can then change the backends<br>
just to use procotol right now.<br><br></blockquote><div>=A0</div><div>I ca=
n add the warning in init but how would i define the local proto value to t=
he one defined with parameter &quot;proto&quot;?=A0</div><div><br></div><di=
v>

@g</div></div>

--14dae934059bf400f804c47b0c9b--
