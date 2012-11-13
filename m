Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <seth.boll@gmail.com>) id 1TYHxc-00036B-88
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 15:59:32 +0100
Received: by mail-ie0-f175.google.com with SMTP id c13so10911090ieb.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2012 06:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=wlbpttgXGIraGLOVf3Mx8wiJyTxV7EgLsB4s4BOdFfU=;
	b=FaWU/ABL8ubaFLiSpissjYA1ScoNudiQCbTY6Khs0cj+ZPr7/EOMLYQKlSxAUTOe2F
	YGqvEhPQRXGBjHDvaSqKOEZSoI62rHOS7YNzwPFP8f81NSkJl6nAZXpj/nwis2Z26rYZ
	udJg6cDOSJVnk2JmRgviA0R4oGcQeDzY0/7KS3lou4uQPbgcwupeDne98EJXHinzy4hf
	NJDmbsQhMXFkPnl9AzWiNFZ7xw3BxEJM8WnGmS+PTtLsHQuqLwQQuYDkZxG5UaFzz+zg
	kTbXDZyTRJVZrihVARnpSm2ckbJD5G1MojcExegBwX716nhSPzxCpNsUMDEyeNAREXoS
	OTgA==
MIME-Version: 1.0
Received: by 10.50.89.162 with SMTP id bp2mr11255269igb.7.1352817937470; Tue,
	13 Nov 2012 06:45:37 -0800 (PST)
Received: by 10.64.35.170 with HTTP; Tue, 13 Nov 2012 06:45:35 -0800 (PST)
In-Reply-To: <1352816623.24487.128.camel@ted>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
	<1352816623.24487.128.camel@ted>
Date: Tue, 13 Nov 2012 08:45:35 -0600
Message-ID: <CA+JN8xOF_iVQb30NVdrXEtqieh0E6m2-tSE2uG6UiG+f9C6qHw@mail.gmail.com>
From: Seth Bollinger <seth.boll@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake: Colorize knotty interactive console output
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
X-List-Received-Date: Tue, 13 Nov 2012 14:59:32 -0000
Content-Type: multipart/alternative; boundary=e89a8f3baef59bd5ff04ce61789a

--e89a8f3baef59bd5ff04ce61789a
Content-Type: text/plain; charset=ISO-8859-1

I'm not sure how best to resolve this.  Would you like me to add some code
to try and detect background color?  This seems like it might be more
complex than it's worth...

Or would it be better to have a selectable light background color set?  If
you think light background is more common (I dislike staring at large
blocks of white :)) it could default to the light color set.

Thanks!

Seth


On Tue, Nov 13, 2012 at 8:23 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Sun, 2012-11-11 at 09:17 -0600, Seth Bollinger wrote:
> > Add bold color output to log level name and standard color output to
> > log msg
> > when bitbake is run from an iteractive console.  Color output is only
> > enabled
> > if the terminal supports color.
> >
> > Signed-off-by: Seth Bollinger <seth.boll@gmail.com>
> > ---
> >  bitbake/lib/bb/msg.py       |   40
> > ++++++++++++++++++++++++++++++++++++++++
> >  bitbake/lib/bb/ui/knotty.py |    6 +++++-
> >  2 files changed, 45 insertions(+), 1 deletions(-)
>
> I love the idea. I tried testing it and realised that it doesn't work in
> my black text on a white background terminals though, the result of the
> patch was unreadable :(
>
> Cheers,
>
> Richard
>
>
>

--e89a8f3baef59bd5ff04ce61789a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;m not sure how best to resolve this. =A0Would you like me to add some=
 code to try and detect background color? =A0This seems like it might be mo=
re complex than it&#39;s worth...<div><br></div><div>Or would it be better =
to have a selectable light background color set? =A0If you think light back=
ground is more common (I dislike staring at large blocks of white :)) it co=
uld default to the light color set.<div>
<br></div><div>Thanks!</div><div><br></div><div>Seth</div></div><div class=
=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, Nov 13, 2012 at=
 8:23 AM, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.pu=
rdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.=
org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Sun, 2012-11-11 at 09:17 -0600, Seth Boll=
inger wrote:<br>
&gt; Add bold color output to log level name and standard color output to<b=
r>
&gt; log msg<br>
&gt; when bitbake is run from an iteractive console. =A0Color output is onl=
y<br>
&gt; enabled<br>
&gt; if the terminal supports color.<br>
&gt;<br>
&gt; Signed-off-by: Seth Bollinger &lt;<a href=3D"mailto:seth.boll@gmail.co=
m">seth.boll@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0bitbake/lib/bb/msg.py =A0 =A0 =A0 | =A0 40<br>
&gt; ++++++++++++++++++++++++++++++++++++++++<br>
&gt; =A0bitbake/lib/bb/ui/knotty.py | =A0 =A06 +++++-<br>
&gt; =A02 files changed, 45 insertions(+), 1 deletions(-)<br>
<br>
I love the idea. I tried testing it and realised that it doesn&#39;t work i=
n<br>
my black text on a white background terminals though, the result of the<br>
patch was unreadable :(<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div><br></div>

--e89a8f3baef59bd5ff04ce61789a--
