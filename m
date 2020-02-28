Return-Path: <aaron@assonance.org>
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
	[209.85.167.182])
	by mail.openembedded.org (Postfix) with ESMTP id 3F160618BE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2020 20:40:17 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id l12so4131432oil.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2020 12:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=assonance-org.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3GIFgA6gda/BvC/hAnbzIHuDGSIONkFC2YmbERK/Rd0=;
	b=1jBbLrfS0cvqJQEQPEMiEFcTqqqg+vje2UKJaxKefvxfjf0vf2YMJr6uXmypYY+Na7
	TJC2jsA20Qa7CRUL8ItPzttKmD9jCJQOtWuJoL+Q0u4tX7gD6Yb+8nFTSXCW4hficcFm
	QxAAsr3QquS5i5xYm/HhwQF6yuAudQAUh0iIMEFAiudk+KgzO2MzFHH9xzUKs/130bvv
	rkOogq0rhzpfDE4pzheHJWjgF8zjp9veaz072PQe7bJO5AJDL44qeycyC5gXC/s7lI9Z
	swCWPyr8syoOWVP2jiryKTIk0Epu3qeHIi9EmU9UHoZOU9pBUGZUMEtIsVOdyljvh3Am
	QquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3GIFgA6gda/BvC/hAnbzIHuDGSIONkFC2YmbERK/Rd0=;
	b=LQNGll317GWnw0ahNKvCSk7NzPE9CAFlFh3wtROdlwWMBM850vZjcCyzZUPOQSUJXu
	zKlV+OK7m7tU02yzS3E8VrU7lgD8CVRtjTXSrTb7hl05GyXxUkzZkOncQz8WFJkz4fR5
	FuD0S17L/5LWnk4lr0Y8eIH+boqqDAx1JXmHAbuSL+fOjpYJMOVeJZ6BrO99x/WCPo79
	J7KD6HBW4l1PQ8MRBenhew3Xx+dVv64LDTtziXzCvozZWhdZbE7Eic4Krl/DnX//bT14
	p+rhBVotTog9BhU7ciFeTYsZSpfPSPoCbX1d5QTq0RHWj3qmKZ8Oy2fINEbhrr3uPTW3
	8RsA==
X-Gm-Message-State: APjAAAVX4ezR3YVnHZzC+wLkDQf/2hW3Yw+Ib/mKjaYJKi0L0Xg5jeC/
	VT9csucys8IXNClLCVoT1EwudrRcPT+ZDVKPCtbMmw==
X-Google-Smtp-Source: APXvYqyjVHXyzIg1c7FRDisDlTXKS+xGTz/feVCpr3XD7YusER+6Xc17a3YeAEeidGtl5rivh2OHkT3P7UZYozXW+H4=
X-Received: by 2002:a05:6808:99c:: with SMTP id
	a28mr4221205oic.164.1582922412918; 
	Fri, 28 Feb 2020 12:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20200228083336.Horde.2i5ag6ZVWX3JF5j5y3bF1q2@crashcourse.ca>
	<20200228140919.GO104502@korppu>
	<alpine.LFD.2.21.2002281435580.6574@localhost.localdomain>
	<52d5e8b6d3c64fe0a74d098e79651f2b@XBOX03.axis.com>
In-Reply-To: <52d5e8b6d3c64fe0a74d098e79651f2b@XBOX03.axis.com>
From: Aaron Cohen <aaron@assonance.org>
Date: Fri, 28 Feb 2020 15:40:01 -0500
Message-ID: <CAFSZm+iJtq-uNr3zudmtXHq7uZAmCKuxMtCkr6xH67NUjwKioQ@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: can i get a list of only bbappend'ed recipes that were *used* in a build?
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
X-List-Received-Date: Fri, 28 Feb 2020 20:40:17 -0000
Content-Type: multipart/alternative; boundary="00000000000022b3ea059fa8d86e"

--00000000000022b3ea059fa8d86e
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 28, 2020 at 3:32 PM Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> > bounces@lists.openembedded.org> On Behalf Of Robert P. J. Day
> > Sent: den 28 februari 2020 20:38
> > To: Mikko.Rapeli@bmw.de
> > Cc: bitbake-devel@lists.openembedded.org
> > Subject: Re: [bitbake-devel] can i get a list of only bbappend'ed recipes
> > that were *used* in a build?
> >
> > On Fri, 28 Feb 2020, Mikko.Rapeli@bmw.de wrote:
> >
> > > Hi,
> > >
> > > On Fri, Feb 28, 2020 at 08:33:36AM -0500, rpjday@crashcourse.ca wrote:
> > > > looked around and i don't see an immediately obvious way to do
> > > > this ... is there a way to generate a list of *only* those recipes
> > > > that were used in the current build that had associated .bbappend
> > > > files?
> > > >
> > > > "bitbake-layers show-appends" will show all recipes with .bbappend
> > > > files, including those that are not included and processed for the
> > > > current build/image. here's the rationale, in case i'm missing
> > > > something.
> > >
> > > I'm doing "find meta* -name \*recipe\*bb\*" and reviewing every one
> > > of them. More visibility to this including parsing order would be
> > > nice to store in e.g. buildhistory.
> >
> >   thanks for clarifying that there wasn't a massively trivial way to
> > do this that i just didn't see.
>
> For each image you build, you should find a manifest in
> "tmp/deploy/image/<machine>/<image>-<machine>.manifest". It contains the
> names, architectures and versions of all packages that were installed in
> the image.
>
> To convert the package names from the manifest to recipes, you can use
> oe-pkgdata-util:
>
>   oe-pkgdata-util -p tmp/pkgdata/<machine> package-info -f <path to the
> manifest file>
>
> (the -p tmp/pkgdata/<machine> option isn't necessary, but you avoid
> starting tinfoil if you use it). This will give you one line per package
> that also includes the recipe name. Pass the output to `cut -f3 -d' ' |
> sort -u' and you should have the list of recipes that were used to build
> the packages in your image.
>
> Then all you have to do is take the intersection of recipes from that
> list and from `bitbake-layers show-appends` and you should have the
> list of recipes that have bbappends applied and are used to build your
> image.
>
>
pipe the package list through 'xargs bitbake-layers show-appends' and it
seems exactly what's asked for.

oe-pkgdata-util -p tmp/pkgdata/<machine> package-info -f
tmp/deploy/images/<machine>/<image>.manifest | cut -f3 -d' ' | sort -u |
xargs bitbake-layers show-appends

--00000000000022b3ea059fa8d86e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28, 2020 at 3:32 PM Peter Kje=
llerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@axis.com">peter.kjellers=
tedt@axis.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org" =
target=3D"_blank">bitbake-devel-bounces@lists.openembedded.org</a> &lt;bitb=
ake-devel-<br>
&gt; <a href=3D"mailto:bounces@lists.openembedded.org" target=3D"_blank">bo=
unces@lists.openembedded.org</a>&gt; On Behalf Of Robert P. J. Day<br>
&gt; Sent: den 28 februari 2020 20:38<br>
&gt; To: <a href=3D"mailto:Mikko.Rapeli@bmw.de" target=3D"_blank">Mikko.Rap=
eli@bmw.de</a><br>
&gt; Cc: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"=
_blank">bitbake-devel@lists.openembedded.org</a><br>
&gt; Subject: Re: [bitbake-devel] can i get a list of only bbappend&#39;ed =
recipes<br>
&gt; that were *used* in a build?<br>
&gt; <br>
&gt; On Fri, 28 Feb 2020, <a href=3D"mailto:Mikko.Rapeli@bmw.de" target=3D"=
_blank">Mikko.Rapeli@bmw.de</a> wrote:<br>
&gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Feb 28, 2020 at 08:33:36AM -0500, <a href=3D"mailto:rpjda=
y@crashcourse.ca" target=3D"_blank">rpjday@crashcourse.ca</a> wrote:<br>
&gt; &gt; &gt; looked around and i don&#39;t see an immediately obvious way=
 to do<br>
&gt; &gt; &gt; this ... is there a way to generate a list of *only* those r=
ecipes<br>
&gt; &gt; &gt; that were used in the current build that had associated .bba=
ppend<br>
&gt; &gt; &gt; files?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &quot;bitbake-layers show-appends&quot; will show all recipe=
s with .bbappend<br>
&gt; &gt; &gt; files, including those that are not included and processed f=
or the<br>
&gt; &gt; &gt; current build/image. here&#39;s the rationale, in case i&#39=
;m missing<br>
&gt; &gt; &gt; something.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m doing &quot;find meta* -name \*recipe\*bb\*&quot; and rev=
iewing every one<br>
&gt; &gt; of them. More visibility to this including parsing order would be=
<br>
&gt; &gt; nice to store in e.g. buildhistory.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0thanks for clarifying that there wasn&#39;t a massively tr=
ivial way to<br>
&gt; do this that i just didn&#39;t see.<br>
<br>
For each image you build, you should find a manifest in <br>
&quot;tmp/deploy/image/&lt;machine&gt;/&lt;image&gt;-&lt;machine&gt;.manife=
st&quot;. It contains the <br>
names, architectures and versions of all packages that were installed in <b=
r>
the image. <br>
<br>
To convert the package names from the manifest to recipes, you can use <br>
oe-pkgdata-util:<br>
<br>
=C2=A0 oe-pkgdata-util -p tmp/pkgdata/&lt;machine&gt; package-info -f &lt;p=
ath to the manifest file&gt;<br>
<br>
(the -p tmp/pkgdata/&lt;machine&gt; option isn&#39;t necessary, but you avo=
id <br>
starting tinfoil if you use it). This will give you one line per package <b=
r>
that also includes the recipe name. Pass the output to `cut -f3 -d&#39; &#3=
9; | <br>
sort -u&#39; and you should have the list of recipes that were used to buil=
d <br>
the packages in your image.<br>
<br>
Then all you have to do is take the intersection of recipes from that <br>
list and from `bitbake-layers show-appends` and you should have the <br>
list of recipes that have bbappends applied and are used to build your <br>
image.<br><br></blockquote><div><br></div><div>pipe the package list throug=
h &#39;xargs bitbake-layers show-appends&#39; and it seems exactly what&#39=
;s asked for.</div><div><br></div><div>oe-pkgdata-util -p tmp/pkgdata/&lt;m=
achine&gt; package-info -f tmp/deploy/images/&lt;machine&gt;/&lt;image&gt;.=
manifest | cut -f3 -d&#39; &#39; | sort -u | xargs bitbake-layers show-appe=
nds<br></div><div><br></div><div>=C2=A0</div></div></div>

--00000000000022b3ea059fa8d86e--
