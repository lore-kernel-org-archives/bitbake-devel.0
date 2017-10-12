Return-Path: <mounesh.sutar@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id E436C71B48
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Oct 2017 10:13:30 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id m28so5406829pfi.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Oct 2017 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=ApyW9iqf+yIrtoWFC8sPwG6XV3eCuWC+5Vfn866vmSo=;
	b=a3KH4jiOyVX+8kqR8vb59SlVrQOx5Sxtpk+44r1/3VhEuLrZJB6hBmVSy4YNxjSUJ7
	L0vtBdCeuaog04p8tFv9Or24+MJtZvYveZ6t/uwxgUggDAZlgnbzln0Ie9cBPFG9HCQz
	CiR3Etz/eAj0bhzS45jdP7SSnd9Xhd9tuvV53dDGILbnyAxkdqT4sbh4vc+FOYLabUYU
	aLoUl0Csot2jYkXujfCXsWsvNGJs+lMbDOulUy3H6C8/UK2beHjC/Y+clAANIEpj1rLL
	fZyfcl+277yvVMQpAuicx7RzWZfZCdqaSj9wDFPHJG92F+x2oU2aWjVFkMn7TjavQVED
	UWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=ApyW9iqf+yIrtoWFC8sPwG6XV3eCuWC+5Vfn866vmSo=;
	b=fi8uw5jBqV/WOTgfvXA+/phjhuelfDG4nqYMOx2RQ5rDBy9YQxCiXr05FTSBojNwdI
	hkFg+RxH6vCCyqlq5pKVgHflzNqId2Eg34hvH5TWYIuM5JV/HojYXLFAWg3lpbVne5e5
	qwohYlZXrhvfJXzw7ZkXpFaa+sIy9cPJkQjky6QKTRGbQLrRGLqjWY4/ej25A5ghAeb/
	aG0/dTU4GoIPm9wat9hMckMRzQsMfsXb7hAQNV3jJcPZNFW8Zkw2GM0hNHVQKpaZZ45k
	Y+Kd0Aqq0ph8XXy0p0+0rTCzc/7yINF0zy6SjHPlYJJOyUT59hwDILpqv8QC091Yihcz
	uQzQ==
X-Gm-Message-State: AMCzsaWhoj5NWOGaz4+JUhwx7BFugslmxk15QyI0yiPQL9Kzc9BAWYrz
	Kxq0xrlAg/iBC5khMuQ+m/DX7cPLLZtfgBL3Zjs=
X-Google-Smtp-Source: AOwi7QBsU4hO8FeAwdRyxEOSg/2AVAOZZZZdK6PgskpfMZggI3PBKUEJS+hT2Kth8a0henWaHM1ahti9+Ym5a1Gyzwo=
X-Received: by 10.84.235.129 with SMTP id p1mr1740460plk.153.1507803211946;
	Thu, 12 Oct 2017 03:13:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.226.129 with HTTP; Thu, 12 Oct 2017 03:13:31 -0700 (PDT)
In-Reply-To: <1507370464.20313.65.camel@linuxfoundation.org>
References: <1474957465-27791-1-git-send-email-mounesh.sutar@gmail.com>
	<CAOtT3B52FFNZHsx+7GQwtLp0qoWvZ3C5AxU4tVYm5cPnAZC3Zg@mail.gmail.com>
	<CAJ86T=XWPVANsJmSW2aPCWKQOEB_r84E-08HTirHSjxQVPxmkQ@mail.gmail.com>
	<1507370464.20313.65.camel@linuxfoundation.org>
From: Mounesh Sutar <mounesh.sutar@gmail.com>
Date: Thu, 12 Oct 2017 15:43:31 +0530
Message-ID: <CAOtT3B5H6ekw-9kM7R3Z00bHbDjxf_7a4oucYFMaLgv=Os8ngA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Mounesh Sutar <mounesh_sutar@mentor.com>
Subject: Re: [PATCH] bitbake warning fix: No bb files matched BBFILE_PATTERN_packageName
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
X-List-Received-Date: Thu, 12 Oct 2017 10:13:31 -0000
Content-Type: multipart/alternative; boundary="089e082106a0d6de79055b56caed"

--089e082106a0d6de79055b56caed
Content-Type: text/plain; charset="UTF-8"

Hi,
The intention of this patch was to, let parse recipe files against all
PATTERNS.
So that, the correct priority of recipe file with respect to pattern is
returned.
As you agree, currently the first match is being returned, I believe this
is not expected behaviour.
As per the function name, it should check the bbfile priority and return
the corrosponding value.
I don't know much about priority assignments to layers and this patches
implications.

I have modified the patch and submitted now.
Request you to provide your feedback and suggestions for possible
improvements.


On Sat, Oct 7, 2017 at 3:31 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2017-10-06 at 13:37 -0700, Andre McCurdy wrote:
> > >
> > > On Tue, Sep 27, 2016 at 11:54 AM, Mounesh Sutar <mounesh.sutar@gmai
> > > l.com>
> > > >
> > > >
> > > > bitbake is parsing all recipe files, against layers
> > > > BBFILE_PATTERN for
> > > > warning message display.
> > > > In case of sublayer with lower/equal priority, then all
> > > > sublayer's
> > > > patterns are not being
> > > > considered for pattern match. While checking recipe file against
> > > > matching
> > > > pattern,
> > > > the first matching pattern is accepted and added to matched list,
> > > > while
> > > > remaning PATTERNs are
> > > > not being considered. With this, the recipes are being neglected
> > > > from
> > > > PATTERN match.
> > > > This fix let's parser run through all the layers PATTERNs and on
> > > > matching
> > > > added to match list.
> > > >
> > > > Upstream-Status: Submitted [bitbake-devel@lists.openembedded.org]
> > > >
> > > > Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>
> > > > ---
> > > >  bitbake/lib/bb/cooker.py |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > > > index 4df8881..5fde995 100644
> > > > --- a/bitbake/lib/bb/cooker.py
> > > > +++ b/bitbake/lib/bb/cooker.py
> > > > @@ -1705,7 +1705,7 @@ class CookerCollectFiles(object):
> > > >                  if matched != None:
> > > >                      if not regex in matched:
> > > >                          matched.add(regex)
> > > > -                return pri
> > > > +                        return pri
> > > >          return 0
> > > >
> > > >      def get_bbfiles(self):
> > > > --
> > Resurrecting an old thread as it's been pointed out to me that this
> > patch fixes the issue I raised a while ago on the oe-core list:
> >
> >   http://lists.openembedded.org/pipermail/openembedded-core/2016-July
> > /123466.html
> >
> > Are there any problems or concerns with this change?
>
> I had to go and look at this again but yes, there are problems with the
> patch:
>
> a) If matched = None, the function never returns a priority after this
>    change.
> b) Currently the first match is returned and also used in parallel for
>    the priority calculation. After the patch, the priority used would
>    be the last match found. The patch therefore reverses priority
>    assignments for layers.
>
> There is a definite problem here but the patch simply moves the
> goalposts, it doesn't actually fix it. It breaks the current behaviour
> too.
>
> Cheers,
>
> Richard
>
>

--089e082106a0d6de79055b56caed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>The intention of this patch was to, let=
 parse recipe files against all PATTERNS.</div><div>So that, the correct pr=
iority of recipe file with respect to pattern is returned.</div><div>As you=
 agree, currently the first match is being returned, I believe this is not =
expected behaviour.</div><div>As per the function name, it should check the=
 bbfile priority and return the corrosponding value.</div><div>I don&#39;t =
know much about priority assignments to layers and this patches implication=
s.</div><div><br></div><div>I have modified the patch and submitted now.</d=
iv><div>Request you to provide your feedback and suggestions for possible i=
mprovements.</div><div><br></div></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Sat, Oct 7, 2017 at 3:31 PM, Richard Purdie <span =
dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" targe=
t=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Fri=
, 2017-10-06 at 13:37 -0700, Andre McCurdy wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Sep 27, 2016 at 11:54 AM, Mounesh Sutar &lt;mounesh.sutar=
@gmai<br>
&gt; &gt; <a href=3D"http://l.com" rel=3D"noreferrer" target=3D"_blank">l.c=
om</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; bitbake is parsing all recipe files, against layers<br>
&gt; &gt; &gt; BBFILE_PATTERN for<br>
&gt; &gt; &gt; warning message display.<br>
&gt; &gt; &gt; In case of sublayer with lower/equal priority, then all<br>
&gt; &gt; &gt; sublayer&#39;s<br>
&gt; &gt; &gt; patterns are not being<br>
&gt; &gt; &gt; considered for pattern match. While checking recipe file aga=
inst<br>
&gt; &gt; &gt; matching<br>
&gt; &gt; &gt; pattern,<br>
&gt; &gt; &gt; the first matching pattern is accepted and added to matched =
list,<br>
&gt; &gt; &gt; while<br>
&gt; &gt; &gt; remaning PATTERNs are<br>
&gt; &gt; &gt; not being considered. With this, the recipes are being negle=
cted<br>
&gt; &gt; &gt; from<br>
&gt; &gt; &gt; PATTERN match.<br>
&gt; &gt; &gt; This fix let&#39;s parser run through all the layers PATTERN=
s and on<br>
&gt; &gt; &gt; matching<br>
&gt; &gt; &gt; added to match list.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Upstream-Status: Submitted [<a href=3D"mailto:bitbake-devel@=
lists.openembedded.org">bitbake-devel@lists.<wbr>openembedded.org</a>]<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Mounesh Sutar &lt;<a href=3D"mailto:mounesh_s=
utar@mentor.com">mounesh_sutar@mentor.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; =C2=A0bitbake/lib/bb/cooker.py |=C2=A0=C2=A0=C2=A0=C2=A02 +-=
<br>
&gt; &gt; &gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooke=
r.py<br>
&gt; &gt; &gt; index 4df8881..5fde995 100644<br>
&gt; &gt; &gt; --- a/bitbake/lib/bb/cooker.py<br>
&gt; &gt; &gt; +++ b/bitbake/lib/bb/cooker.py<br>
&gt; &gt; &gt; @@ -1705,7 +1705,7 @@ class CookerCollectFiles(object):<br>
&gt; &gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if matched !=3D None:<br>
&gt; &gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if not re=
gex in matched:<br>
&gt; &gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0<wbr>matched.add(regex)<br>
&gt; &gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return pri<br>
&gt; &gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<wbr>return pri<br>
&gt; &gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 0<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0def get_bbfiles(self):<br>
&gt; &gt; &gt; --<br>
&gt; Resurrecting an old thread as it&#39;s been pointed out to me that thi=
s<br>
&gt; patch fixes the issue I raised a while ago on the oe-core list:<br>
&gt;<br>
&gt; =C2=A0 <a href=3D"http://lists.openembedded.org/pipermail/openembedded=
-core/2016-July" rel=3D"noreferrer" target=3D"_blank">http://lists.openembe=
dded.org/<wbr>pipermail/openembedded-core/<wbr>2016-July</a><br>
&gt; /123466.html<br>
&gt;<br>
&gt; Are there any problems or concerns with this change?<br>
<br>
</div></div>I had to go and look at this again but yes, there are problems =
with the<br>
patch:<br>
<br>
a) If matched =3D None, the function never returns a priority after this=C2=
=A0<br>
=C2=A0 =C2=A0change.<br>
b) Currently the first match is returned and also used in parallel for=C2=
=A0<br>
=C2=A0 =C2=A0the priority calculation. After the patch, the priority used w=
ould=C2=A0<br>
=C2=A0 =C2=A0be the last match found. The patch therefore reverses priority=
=C2=A0<br>
=C2=A0 =C2=A0assignments for layers.<br>
<br>
There is a definite problem here but the patch simply moves the<br>
goalposts, it doesn&#39;t actually fix it. It breaks the current behaviour<=
br>
too.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br></div>

--089e082106a0d6de79055b56caed--
