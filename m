Return-Path: <elliot.smith@intel.com>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id 891F165D6E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Oct 2015 08:32:06 +0000 (UTC)
Received: by iodv82 with SMTP id v82so44532807iod.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Oct 2015 01:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=ckVW7MrZRy5k0KYaBXG9/sDvlrL1VqRrJ6mP8IUsx3k=;
	b=eNKuDIdB7giYA3rMbtAMzFSXuR2yLV50cIZcK9Of7z+DFt/vhGidTu+pdvhdYkJOJL
	CqU8usB0lW269DVBwE1PDBnhjNq0HEgjPeRzz0mnVisrQGcJogp3q0X3q+q0dZLEk1dT
	T39g35pa/l1hY9nmDCdRChIhW02dMBnxYCBmThPP9wVROtS5sGTWZmi+16WTSHfMWV5+
	v96WtQmWIqw1COf/Fi2KF8xLllOgvq3VB05JLUsMBGdy58IQdHIvZ4/e7eVM0BbMfM+L
	rQIx4NqDxHuFcxIMjvvPT+P5iS6CPr39WDeQ7cEIVG4GO5zm3HoJh0nx1e/WtiyDk2gg
	AkZA==
X-Gm-Message-State: ALoCoQk/EccLggQIijYQk8IS0yQIWupwR/PlOJrjqsjryusFhh60vPyTt8X6YuX/6j2TvYVcxmQN
MIME-Version: 1.0
X-Received: by 10.107.137.92 with SMTP id l89mr24114059iod.38.1444638726065;
	Mon, 12 Oct 2015 01:32:06 -0700 (PDT)
Received: by 10.64.7.77 with HTTP; Mon, 12 Oct 2015 01:32:06 -0700 (PDT)
In-Reply-To: <1444547527.14364.8.camel@linuxfoundation.org>
References: <1444383523-23550-1-git-send-email-elliot.smith@intel.com>
	<1444547527.14364.8.camel@linuxfoundation.org>
Date: Mon, 12 Oct 2015 09:32:06 +0100
Message-ID: <CA+1hgUiHhUMCXz9rxOWcGmzryyOxR_0_oCyhRimvP9Fo_MptJA@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: update meta-yocto to jethro and drop dizzy
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
X-List-Received-Date: Mon, 12 Oct 2015 08:32:07 -0000
Content-Type: multipart/alternative; boundary=001a113ebdb418d0230521e42a74

--001a113ebdb418d0230521e42a74
Content-Type: text/plain; charset=UTF-8

On 11 October 2015 at 08:12, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2015-10-09 at 10:38 +0100, Elliot Smith wrote:
> > From: brian avery <avery.brian@gmail.com>
> >
> > Toaster only supports building 2 branches back. This
> > updates the conf file for meta-yocto to support
> > master, jethro, and fido.
> >
> > Signed-off-by: brian avery <avery.brian@gmail.com>
> > Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> > ---
> >  meta-yocto/conf/toasterconf.json | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
>
> This should actually go to the poky list and say something like
> "toasterconf:" in the subject rather than "toaster:" however I've sorted
> this out in this case.
>

Thanks Richard. I'll be more attentive to the commit subject line in future.

Elliot

-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a113ebdb418d0230521e42a74
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 1=
1 October 2015 at 08:12, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@l=
inuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On Fri, 2015-10-09 at 10:38 +0100, Elliot Smith wrote:<br>
&gt; From: brian avery &lt;<a href=3D"mailto:avery.brian@gmail.com">avery.b=
rian@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Toaster only supports building 2 branches back. This<br>
&gt; updates the conf file for meta-yocto to support<br>
&gt; master, jethro, and fido.<br>
&gt;<br>
&gt; Signed-off-by: brian avery &lt;<a href=3D"mailto:avery.brian@gmail.com=
">avery.brian@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Elliot Smith &lt;<a href=3D"mailto:elliot.smith@intel.c=
om">elliot.smith@intel.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 meta-yocto/conf/toasterconf.json | 30 +++++++++++++++-----------=
----<br>
&gt;=C2=A0 1 file changed, 15 insertions(+), 15 deletions(-)<br>
<br>
This should actually go to the poky list and say something like<br>
&quot;toasterconf:&quot; in the subject rather than &quot;toaster:&quot; ho=
wever I&#39;ve sorted<br>
this out in this case.<br></blockquote><div><br></div><div>Thanks Richard. =
I&#39;ll be more attentive to the commit subject line in future.</div><div>=
<br></div><div>Elliot</div></div><div><br></div>-- <br><div class=3D"gmail_=
signature"><div dir=3D"ltr"><div>Elliot Smith<br>Software Engineer<br>Intel=
 Open Source Technology Centre</div></div></div>
</div></div>

--001a113ebdb418d0230521e42a74--
