Return-Path: <anibal.limon@linaro.org>
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com
	[209.85.217.66])
	by mail.openembedded.org (Postfix) with ESMTP id 347027F986
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2019 18:07:23 +0000 (UTC)
Received: by mail-vs1-f66.google.com with SMTP id k15so4510095vsp.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2019 10:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=9ComKc5pJwziHQefEpHNqpxmOywzjuckKYhtBpOVd54=;
	b=m51CPZris+y+xskBloUawudCuWfkNEt1mHuI4Kyjo0GhEYT4PWVHitDuAODFeqA07P
	qJielFVds7Ke93XtZDIB6d7zCUfTkFWtbWguHkQG+azJ0Cc2XwR+uLqpVTeDD0v5GMq+
	fQBeZnuLd14hF652cVIxRx5Rtv/ydGSOidhQmncA2x5LCR+4Nf0XGjzardyCLdgpZc9l
	v/1oIFaKICxeDCxVyietzDO2GQKz7Pebv2TLL1SWdMQHJU/cux4Ddqg4eNpezZJRCUvQ
	81E4lI4doCjeQ+xk+DPq5qNJoqr3s65wHB7dmH6YiH6TcsvCdXvoPZTr+gkPXuuoHpNo
	JHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=9ComKc5pJwziHQefEpHNqpxmOywzjuckKYhtBpOVd54=;
	b=ogjCNhSfqPQ5nyOP+agknT1Twdr/yqJorTQQ1rHSwdu9PfAhD3xmRsBlOJMJC/LLlz
	MpfEDKJ9aFRQ1hsbJfei1z7ts8JO2I2UsnDDIIlvrQg6kyL8//EMNpgdbrpyr0FahhnD
	yoylR8+D7aUwzgA7/l9Sh99uBny+i+TFJZp3Zm9ptaOSlANJM4DY1n262WOs1Pm1pS1E
	YKyRf/HBHAEMccZsXZjLdh8yqxCFV7bm3gfM7Qf9+baIV9EQMrKlBUchmTC/ZoA8sJaq
	P4d+tnZ83zdHRPK9U1g76c6/WQbFqKy8auM/QNcB5ucRUV/SL4oSDpAAjl0Sk1wWaKOT
	D01A==
X-Gm-Message-State: APjAAAU62e0nAe6rOoA3WoNUDuGhsZTgJ7MNwhToemI3VETL1lFv1UeS
	cUCUvi1LLLknvUwvBrZqBn5AOPkN+C+QjYg82rcoWQ==
X-Google-Smtp-Source: APXvYqyCdcT8PvD/BxPUljBGSjexCdd0Q7FonoE+BI9/l8DMJfG+cb3Bkbo6ZHe1Fz0/83GtbUKXYqKi42fJ2ZchUVY=
X-Received: by 2002:a67:d802:: with SMTP id e2mr7274847vsj.221.1573754843976; 
	Thu, 14 Nov 2019 10:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20191113232303.29047-1-anibal.limon@linaro.org>
	<CAMKF1sqvx_ttxt+AhJ+1r+o4rt-z7VYNfSge5Du3N6mgjaYxJA@mail.gmail.com>
	<3ba6b1a5788f453aa1974a13342d148c@XBOX03.axis.com>
In-Reply-To: <3ba6b1a5788f453aa1974a13342d148c@XBOX03.axis.com>
From: Anibal Limon <anibal.limon@linaro.org>
Date: Thu, 14 Nov 2019 12:07:12 -0600
Message-ID: <CA+_AqistmpdU+yAShaA7ypfng2r=d7xo_5t1UUOQE5Jj=X3Y8g@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Thu, 14 Nov 2019 18:07:23 -0000
Content-Type: multipart/alternative; boundary="000000000000706a580597525a23"

--000000000000706a580597525a23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2019 at 10:54, Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> > bounces@lists.openembedded.org> On Behalf Of Khem Raj
> > Sent: den 14 november 2019 03:55
> > To: An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.org>
> > Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
> > Subject: Re: [bitbake-devel] [PATCH] lib/bb: Add
> > BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
> >
> > On Wed, Nov 13, 2019 at 3:23 PM An=C3=ADbal Lim=C3=B3n <anibal.limon@li=
naro.org>
> > wrote:
> > >
> > > The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
> > > of directories to exclude when making taskhash, our specific case
> > > is using SRC_URI that points local VCS directory.
> > >
> > > In OE-Core this variable could be set by default to:
> > >
> > > BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D ".cvs .git .svn"
>
> That should be:
>
> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D "CVS .git .svn"
>

So I will change to,

+ self.localdirsexclude =3D (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE")
or "CVS .git .svn").split()

Any other directory to add it?

Cheers,
Anibal


>
> > I like the approach.  perhaps a sane default would be nice.
>
> //Peter
>
>

--000000000000706a580597525a23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, 14 Nov 2019 at 10:54, Peter Kjell=
erstedt &lt;<a href=3D"mailto:peter.kjellerstedt@axis.com">peter.kjellerste=
dt@axis.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org" =
target=3D"_blank">bitbake-devel-bounces@lists.openembedded.org</a> &lt;bitb=
ake-devel-<br>
&gt; <a href=3D"mailto:bounces@lists.openembedded.org" target=3D"_blank">bo=
unces@lists.openembedded.org</a>&gt; On Behalf Of Khem Raj<br>
&gt; Sent: den 14 november 2019 03:55<br>
&gt; To: An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"mailto:anibal.limon@linaro.o=
rg" target=3D"_blank">anibal.limon@linaro.org</a>&gt;<br>
&gt; Cc: bitbake-devel &lt;<a href=3D"mailto:bitbake-devel@lists.openembedd=
ed.org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a>&gt;<br>
&gt; Subject: Re: [bitbake-devel] [PATCH] lib/bb: Add<br>
&gt; BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories<br=
>
&gt; <br>
&gt; On Wed, Nov 13, 2019 at 3:23 PM An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"=
mailto:anibal.limon@linaro.org" target=3D"_blank">anibal.limon@linaro.org</=
a>&gt;<br>
&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a l=
ist<br>
&gt; &gt; of directories to exclude when making taskhash, our specific case=
<br>
&gt; &gt; is using SRC_URI that points local VCS directory.<br>
&gt; &gt;<br>
&gt; &gt; In OE-Core this variable could be set by default to:<br>
&gt; &gt;<br>
&gt; &gt; BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D &quot;.cvs .git .svn&quot;<br=
>
<br>
That should be:<br>
<br>
BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D &quot;CVS .git .svn&quot;<br></blockquo=
te><div><br></div><div>So I will change to,</div><div><br></div><div>+ self=
.localdirsexclude =3D (data.getVar(&quot;BB_SIGNATURE_LOCAL_DIRS_EXCLUDE&qu=
ot;) or &quot;CVS .git .svn&quot;).split()<br></div><div><br></div><div>Any=
 other directory to add it?</div><div><br></div><div>Cheers,</div><div>Anib=
al</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; I like the approach.=C2=A0 perhaps a sane default would be nice.<br>
<br>
//Peter<br>
<br>
</blockquote></div></div>

--000000000000706a580597525a23--
