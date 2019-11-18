Return-Path: <anibal.limon@linaro.org>
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
	[209.85.217.43])
	by mail.openembedded.org (Postfix) with ESMTP id 8081A7FA3B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2019 15:22:55 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id c25so11763127vsp.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2019 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=gg7fYTXKOW85m4vevlfnW9DjKB1T/3wsaBox/UH2jQ4=;
	b=bfbWrwVlwoGrYRXpemUcEG+sblL7sROi4WvojhCRcf68XtMAZYQ8Vgt/0uRS8TWBnX
	EX0nydl5FRvIy9kVRAiPVq7KCVJ5OVNnrbnTxX9v4AF2VfMdk0ySimzYHTptRYz1NQjh
	CbKmFcNyvOi/hvcOrcv6pNwIXHrnPOZ0S1MmBrrkcyZXtH+prY0eIT2y1C5TndZkPLjo
	pJ2fmUpolN5Tuwr/4yPslOnlaDeEOqpQcjlebuunvoB4xUUkIMBg7OB0dqW7WpyXrhZ8
	My1T1t52YFWoWRUxZiFsvC4lIw7v5lu+LTLVxx1Nb7AqE7vKV8U9cW32IWsnV8rtB/oY
	vIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=gg7fYTXKOW85m4vevlfnW9DjKB1T/3wsaBox/UH2jQ4=;
	b=KsP0R9SEoinfWPxzipV+XNYMz5LYKr6fnPAeHnY/dzWqYY5EOBFhnKxAI9VUypdsbh
	RzimyKqnCv5InvuRmi8GxUKrSej9MCHvze50ga6EoLM+DnFj2U1r40X+Pho6ywUeMz0h
	3ZlONcoBnusKWc6GAII+gwEkY3s7yPGW57gaTQpv81A8IIm6NMrmRatPaOtf11kiFUJQ
	iES9kBDFcltZhDxXKSjcVOqOWwEf2AbtNicR+pYnPb2WYLc8iyIY4FBUojW0jW3Y/Fkg
	Uq1TD050E9qfpULxP8Ht5y0fUIMOvU+weeTT5vnxUX0LRFts2Zr8gXXaAhpJ5w30Kjy1
	k+Jw==
X-Gm-Message-State: APjAAAWzzMfAHuqcIL9ffX+RRl7cAPjq/V69Q3mI5OyXfRrX1E/9mZKI
	R6ud6i8DxfXVDJpb9uO9UPCHHmcekWDkDZU1S5HG4SEo
X-Google-Smtp-Source: APXvYqwX2KlxIAAvCzW+4UsvrlPXDQTQf3jvB0t0y4NVpO3/wEd1+ZcVt9Lb2r94M9gvZ8+4WZLCLhSeziwMqmcpThA=
X-Received: by 2002:a67:77d4:: with SMTP id
	s203mr18513080vsc.118.1574090576130; 
	Mon, 18 Nov 2019 07:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20191115144723.7452-1-anibal.limon@linaro.org>
	<401cecf1881048e594574ca4d37c446c@XBOX03.axis.com>
	<58e2fa07-4c32-a09d-0d26-0a810b1ef0f8@kernel.crashing.org>
In-Reply-To: <58e2fa07-4c32-a09d-0d26-0a810b1ef0f8@kernel.crashing.org>
From: Anibal Limon <anibal.limon@linaro.org>
Date: Mon, 18 Nov 2019 09:22:44 -0600
Message-ID: <CA+_AqitZ_frw7Xz1n+MajpaZjiQWqRa2UPzZnm4seQO42MWRuA@mail.gmail.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCHv2] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Mon, 18 Nov 2019 15:22:55 -0000
Content-Type: multipart/alternative; boundary="000000000000a2926a0597a0852d"

--000000000000a2926a0597a0852d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Nov 2019 at 11:12, Mark Hatle <mark.hatle@kernel.crashing.org>
wrote:

>
>
> On 11/15/19 10:29 AM, Peter Kjellerstedt wrote:
> >> -----Original Message-----
> >> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> >> bounces@lists.openembedded.org> On Behalf Of An=C3=ADbal Lim=C3=B3n
> >> Sent: den 15 november 2019 15:47
> >> To: bitbake-devel@lists.openembedded.org
> >> Subject: [bitbake-devel] [PATCHv2] lib/bb: Add
> >> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
> >>
> >> The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
> >> of directories to exclude when making taskhash, our specific case
> >> is using SRC_URI that points local VCS directory.
> >>
> >> Use bb.fetch.module to set default to: "CVS .bzr .git .hg .osc .p4 .re=
po
> >> .svn"
> >>
> >> Signed-off-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.org>
> >> ---
> >>  lib/bb/checksum.py        | 5 +++--
> >>  lib/bb/fetch2/__init__.py | 4 ++--
> >>  lib/bb/siggen.py          | 5 +++--
> >>  3 files changed, 8 insertions(+), 6 deletions(-)
> >
> > [cut]
> >
> >> --- a/lib/bb/siggen.py
> >> +++ b/lib/bb/siggen.py
> >> @@ -123,6 +123,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
> >>
> >>          self.unihash_cache =3D bb.cache.SimpleCache("1")
> >>          self.unitaskhashes =3D self.unihash_cache.init_cache(data,
> "bb_unihashes.dat", {})
> >> +        self.localdirsexclude =3D
> (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE") or "CVS .bzr .git .hg .os=
c
> .p4 .repo .svn").split()
> >
> > I don't like this construct, because if I do:
> >
> > BB_SIGNATURE_LOCAL_DIRS_EXCLUDE_append =3D " some_dir"
> >
> > it means that all of a sudden the SCM directories listed above will no
> > longer be excluded since BB_SIGNATURE_LOCAL_DIRS_EXCLUDE will now be
> > defined, but only contain " some_dir". Isn't it better to add:
> >
> > BB_SIGNATURE_LOCAL_DIRS_EXCLUDE ??=3D "CVS .bzr .git .hg .osc .p4 .repo
> .svn"
>
> I agree.. this really should be put into the bitbake.conf file in
> OE-core.  (I'd
> also suggest adding it to the bitbake.conf file in bitbake itself, as an
> example.)
>
> --Mark
>
> > somewhere in OE-Core (and it can then also have a suitable
> > BB_SIGNATURE_LOCAL_DIRS_EXCLUDE[doc], though it seems BB_-variables
> > are only documented in meta/conf/documentation.conf)?
> >
> > Alternatively, to keep the list above within bitbake, make it two
> > variables, one for the list of directories above that is not really
> > intended to be modified, and one for additional directories (which
> > should still be documented in meta/conf/documentation.conf).
>

For me it is fine if we set this variable in OE-Core with a default value
to VCS directories this is covered by v1 PATCH, after merge I will send
a patch to OE-Core adding the default value.

Regards,
Anibal


> >
> > //Peter
> >
>

--000000000000a2926a0597a0852d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, 15 Nov 2019 at 11:12, Mark Ha=
tle &lt;<a href=3D"mailto:mark.hatle@kernel.crashing.org">mark.hatle@kernel=
.crashing.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><br>
<br>
On 11/15/19 10:29 AM, Peter Kjellerstedt wrote:<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.o=
rg" target=3D"_blank">bitbake-devel-bounces@lists.openembedded.org</a> &lt;=
bitbake-devel-<br>
&gt;&gt; <a href=3D"mailto:bounces@lists.openembedded.org" target=3D"_blank=
">bounces@lists.openembedded.org</a>&gt; On Behalf Of An=C3=ADbal Lim=C3=B3=
n<br>
&gt;&gt; Sent: den 15 november 2019 15:47<br>
&gt;&gt; To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=
=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
&gt;&gt; Subject: [bitbake-devel] [PATCHv2] lib/bb: Add<br>
&gt;&gt; BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directorie=
s<br>
&gt;&gt;<br>
&gt;&gt; The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a li=
st<br>
&gt;&gt; of directories to exclude when making taskhash, our specific case<=
br>
&gt;&gt; is using SRC_URI that points local VCS directory.<br>
&gt;&gt;<br>
&gt;&gt; Use bb.fetch.module to set default to: &quot;CVS .bzr .git .hg .os=
c .p4 .repo<br>
&gt;&gt; .svn&quot;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"mailto:anibal=
.limon@linaro.org" target=3D"_blank">anibal.limon@linaro.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 lib/bb/checksum.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 5 +++--<br>
&gt;&gt;=C2=A0 lib/bb/fetch2/__init__.py | 4 ++--<br>
&gt;&gt;=C2=A0 lib/bb/siggen.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 5 +++--=
<br>
&gt;&gt;=C2=A0 3 files changed, 8 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; [cut]<br>
&gt; <br>
&gt;&gt; --- a/lib/bb/siggen.py<br>
&gt;&gt; +++ b/lib/bb/siggen.py<br>
&gt;&gt; @@ -123,6 +123,7 @@ class SignatureGeneratorBasic(SignatureGenerat=
or):<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.unihash_cache =3D bb.cache.=
SimpleCache(&quot;1&quot;)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.unitaskhashes =3D self.unih=
ash_cache.init_cache(data, &quot;bb_unihashes.dat&quot;, {})<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.localdirsexclude =3D (data.getVa=
r(&quot;BB_SIGNATURE_LOCAL_DIRS_EXCLUDE&quot;) or &quot;CVS .bzr .git .hg .=
osc .p4 .repo .svn&quot;).split()<br>
&gt; <br>
&gt; I don&#39;t like this construct, because if I do:<br>
&gt; <br>
&gt; BB_SIGNATURE_LOCAL_DIRS_EXCLUDE_append =3D &quot; some_dir&quot;<br>
&gt; <br>
&gt; it means that all of a sudden the SCM directories listed above will no=
 <br>
&gt; longer be excluded since BB_SIGNATURE_LOCAL_DIRS_EXCLUDE will now be <=
br>
&gt; defined, but only contain &quot; some_dir&quot;. Isn&#39;t it better t=
o add:<br>
&gt; <br>
&gt; BB_SIGNATURE_LOCAL_DIRS_EXCLUDE ??=3D &quot;CVS .bzr .git .hg .osc .p4=
 .repo .svn&quot;<br>
<br>
I agree.. this really should be put into the bitbake.conf file in OE-core.=
=C2=A0 (I&#39;d<br>
also suggest adding it to the bitbake.conf file in bitbake itself, as an ex=
ample.)<br>
<br>
--Mark<br>
<br>
&gt; somewhere in OE-Core (and it can then also have a suitable <br>
&gt; BB_SIGNATURE_LOCAL_DIRS_EXCLUDE[doc], though it seems BB_-variables <b=
r>
&gt; are only documented in meta/conf/documentation.conf)?<br>
&gt; <br>
&gt; Alternatively, to keep the list above within bitbake, make it two <br>
&gt; variables, one for the list of directories above that is not really <b=
r>
&gt; intended to be modified, and one for additional directories (which <br=
>
&gt; should still be documented in meta/conf/documentation.conf).<br></bloc=
kquote><div><br></div><div>For me it is fine if we set this variable in OE-=
Core with a default value to VCS directories this is covered by v1 PATCH, a=
fter merge I will send=C2=A0</div><div>a patch to OE-Core adding the defaul=
t value.</div><div><br></div><div>Regards,</div><div>Anibal</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; //Peter<br>
&gt; <br>
</blockquote></div></div>

--000000000000a2926a0597a0852d--
