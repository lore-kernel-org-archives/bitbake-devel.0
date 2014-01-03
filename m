Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
	[209.85.214.174])
	by mail.openembedded.org (Postfix) with ESMTP id 5B0DC6B7C0
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jan 2014 12:57:19 +0000 (UTC)
Received: by mail-ob0-f174.google.com with SMTP id wn1so15441179obc.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2014 04:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=YTmxgqxSK89hPFhDU2JVxgcPwHX/0WZov9UiqHBnyhE=;
	b=Sm/n5r/pNN3+bstWt7eb1+mmoKipj00vSLChVJJi1eP/JcnnDit//6kxo4ebuF0wK1
	7WJbU2nQs/un2xMd6s5jwwqocz10UIaZTQ3bKlCV+WCtXoEzJ33jc3EWMXHj3ZXv/xd5
	TF4qHDNo7aHaXBgpPoFHFlM4GByOq5SUtMRknIXfolkxKKHVDtycbKnh9e8AISPRLM9d
	7ZJDiivuPk6USEFWNyimjjTZQNy1zg1ucJPXN4j0gbyQAyguX84IsYG6Rv0rmkwR/T9E
	wuXdEZiiRADpix6dKhywhO0UYUajFTsMZv99ZVPudWC80HCh2ASoyE3zylbQRFrBmUAU
	4Niw==
X-Gm-Message-State: ALoCoQl3UXcpndWjIwXiS8FNBzRg0flFVjkO6vsbSuEB8/1PpbVAcvKkYL4y2bWsTGI9X00s8SGy
X-Received: by 10.182.43.161 with SMTP id x1mr58558007obl.5.1388753839973;
	Fri, 03 Jan 2014 04:57:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.86.193 with HTTP; Fri, 3 Jan 2014 04:56:59 -0800 (PST)
In-Reply-To: <1387488104.6402.75.camel@ted>
References: <1387394811-24196-1-git-send-email-alexandru.damian@intel.com>
	<1387488104.6402.75.camel@ted>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Fri, 3 Jan 2014 12:56:59 +0000
Message-ID: <CAJ2CSBs-RHy9-rc10Xk46zUYGP-yFk44abfCFEYS+yMn9Yj5tw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] toaster: add buildstats to toaster config file
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
X-List-Received-Date: Fri, 03 Jan 2014 12:57:19 -0000
Content-Type: multipart/alternative; boundary=001a11c30ce24ff9fe04ef10734b

--001a11c30ce24ff9fe04ef10734b
Content-Type: text/plain; charset=UTF-8

Just now saw this email - sorry for the delay,

I used USER_CLASSES just because this is how it's enabled in the default
local.conf ...

Alex


On Thu, Dec 19, 2013 at 9:21 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2013-12-18 at 19:26 +0000, Alex DAMIAN wrote:
> > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> >
> > Toaster needs buildstats to be enabled in order to
> > be able to collect task running stats. This patch
> > adds buildstats to the running configuration in toaster mode.
> >
> > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> > ---
> >  bin/toaster | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/bin/toaster b/bin/toaster
> > index 38e71ac..d6c3175 100755
> > --- a/bin/toaster
> > +++ b/bin/toaster
> > @@ -61,10 +61,13 @@ function webserverStartAll()
> >  }
> >
> >  # Helper functions to add a special configuration file
> > +function initConfiguration()
> > +{
> > +        echo "#Created by toaster start script" > ${BUILDDIR}/conf/$1
> > +}
> >
> >  function addtoConfiguration()
> >  {
> > -        echo "#Created by toaster start script" > ${BUILDDIR}/conf/$2
> >          echo $1 >> ${BUILDDIR}/conf/$2
> >  }
> >
> > @@ -167,7 +170,9 @@ fi
> >  case $CMD in
> >      start )
> >          start_success=1
> > +        initConfiguration toaster.conf
> >          addtoConfiguration "INHERIT+=\"toaster buildhistory\""
> toaster.conf
> > +        addtoConfiguration "USER_CLASSES+=\"buildstats\"" toaster.conf
> >          if ! webserverStartAll; then
> >              echo "Failed ${CMD}."
> >              return 4
>
> Why not just add this to the INHERIT? I'm trying to figure out if
> USER_CLASSES is special in some way and when we should use one and when
> we should use the other...
>
> Cheers,
>
> Richard
>
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--001a11c30ce24ff9fe04ef10734b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Just now saw this email - sorry for the delay,<div><br></d=
iv><div>I used USER_CLASSES just because this is how it&#39;s enabled in th=
e default local.conf ...</div><div><br></div><div>Alex</div></div><div clas=
s=3D"gmail_extra">

<br><br><div class=3D"gmail_quote">On Thu, Dec 19, 2013 at 9:21 PM, Richard=
 Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundat=
ion.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span=
> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On W=
ed, 2013-12-18 at 19:26 +0000, Alex DAMIAN wrote:<br>
&gt; From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.co=
m">alexandru.damian@intel.com</a>&gt;<br>
&gt;<br>
&gt; Toaster needs buildstats to be enabled in order to<br>
&gt; be able to collect task running stats. This patch<br>
&gt; adds buildstats to the running configuration in toaster mode.<br>
&gt;<br>
&gt; Signed-off-by: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian=
@intel.com">alexandru.damian@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bin/toaster | 7 ++++++-<br>
&gt; =C2=A01 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/bin/toaster b/bin/toaster<br>
&gt; index 38e71ac..d6c3175 100755<br>
&gt; --- a/bin/toaster<br>
&gt; +++ b/bin/toaster<br>
&gt; @@ -61,10 +61,13 @@ function webserverStartAll()<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0# Helper functions to add a special configuration file<br>
&gt; +function initConfiguration()<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;#Created by toaster start scri=
pt&quot; &gt; ${BUILDDIR}/conf/$1<br>
&gt; +}<br>
&gt;<br>
&gt; =C2=A0function addtoConfiguration()<br>
&gt; =C2=A0{<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;#Created by toaster start scri=
pt&quot; &gt; ${BUILDDIR}/conf/$2<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $1 &gt;&gt; ${BUILDDIR}/conf/$2=
<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; @@ -167,7 +170,9 @@ fi<br>
&gt; =C2=A0case $CMD in<br>
&gt; =C2=A0 =C2=A0 =C2=A0start )<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_success=3D1<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0initConfiguration toaster.conf<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addtoConfiguration &quot;INHERIT+=3D=
\&quot;toaster buildhistory\&quot;&quot; toaster.conf<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0addtoConfiguration &quot;USER_CLASSES+=3D=
\&quot;buildstats\&quot;&quot; toaster.conf<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ! webserverStartAll; then<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Failed ${CM=
D}.&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 4<br>
<br>
</div></div>Why not just add this to the INHERIT? I&#39;m trying to figure =
out if<br>
USER_CLASSES is special in some way and when we should use one and when<br>
we should use the other...<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=A0</div></div=
>
</div>

--001a11c30ce24ff9fe04ef10734b--
