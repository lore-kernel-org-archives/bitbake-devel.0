Return-Path: <alan.kozlay@ves.solutions>
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
	[209.85.210.178])
	by mail.openembedded.org (Postfix) with ESMTP id A72CB6C108
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 13:42:28 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id 3so1683022pfb.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ves-solutions-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=P2zlv5OGHrmP6qmspNbOEEeZ3wxo11czuigqHfNAq8I=;
	b=R/pQVP/kMvaA5WIP5HY3IB47PKOz4lqCtnJExApD7raOU0RpSkizWYSXO/r/4SfqGY
	pKfh2rbK3PFcpxRHFQTlBZ5sioF8RI0dK3LoAXLy5o0OGujGrllVDshiLA/AwXraxZYi
	FL7r4VWgYJwh4asMplQJvrfz7OWiOCgcO+dV/e1ZwTlZyHMnM+Ds7ivDcdFfpARmFgYA
	Y2waegei3m+APAmyLd0/fqb3/qewhK18RXOELTlPMwT5cfa1tepWkcQXkudlNVTBOTPz
	cEobW1GdykMRZSUI4Em+DPYkc46y75BXsq17WRjsiQpN7hO+OMe2On57aF13BewZtUpn
	tQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=P2zlv5OGHrmP6qmspNbOEEeZ3wxo11czuigqHfNAq8I=;
	b=YabwNQ0xmZCFOzV+BmSP9vqjnWvYfqrTaFXmoflv4CQYSKzqndmOlD7iDKl3GlakvT
	XL8P1Kl7XOcXHL8YllQN4LjdML/xkjUZmguRZhL3fR29RCxxNyu/7p3lzje9XYWDtAQX
	7hZIOXAt4mizr5x5pJvQe8ZdjYdTjCn7p1v+syLi2lenVJQ2f+uhz1EoURRacoEi0yJu
	7iJtFa4xFnpbuTqUumFptLkNvDeKGkYp/Ad0zgAF/rqk36jZF6hR67KOFy/i2uL3E/GB
	r5zmTtU3TDnCO/oSkb98EDsSlpetQxyMJnhUQ1AjrJXVTQjmG+brgJT2yj8/TXLzVSEO
	t1PA==
X-Gm-Message-State: APjAAAVMyJF9NvYR5r1mLec/YtgERNxLFmIJFJEHRM7L+zddklBkXLjd
	kjsHBgPDEdXS+sqzlgJq1Adjw8OgOZqNNzwFI8G9c6v0
X-Google-Smtp-Source: APXvYqwTEy8CR5U6it8dfm/wSjHHyAniQz1sIjgkhjwo6INs1qGKfRSLh47NIhZOaEN+K4SaJAgxx1wQoIRDDNQ64Qs=
X-Received: by 2002:a17:90a:610:: with SMTP id
	j16mr5037401pjj.85.1573652549143; 
	Wed, 13 Nov 2019 05:42:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJE9sG=reXLA4GZQjBMsHc8eis=W7ejHTSmvNTAfNJ7gDBsQXw@mail.gmail.com>
	<685e3541-d3fe-4ca4-bb66-7e0c0ff79eca@Spark>
In-Reply-To: <685e3541-d3fe-4ca4-bb66-7e0c0ff79eca@Spark>
From: Alan Kozlay <alan.kozlay@ves-solutions.com>
Date: Wed, 13 Nov 2019 08:41:53 -0500
Message-ID: <CAJE9sGnsyY26PUB71QZdZjELfskoJPm10RyRTmZxcmVZqGXWGA@mail.gmail.com>
To: Christopher Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: MACHINE_ARCH not in pkgarch (sstatesig.py)
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
X-List-Received-Date: Wed, 13 Nov 2019 13:42:28 -0000
Content-Type: multipart/alternative; boundary="0000000000003129cf05973a89ac"

--0000000000003129cf05973a89ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chris,

Thanks for the explanation.  I understand now.

-Alan

On Tue, Nov 12, 2019 at 10:01 PM Christopher Larson <kergoth@gmail.com>
wrote:

> On Nov 12, 2019, 1:50 PM -0700, Alan Kozlay <alan.kozlay@ves-solutions.co=
m>,
> wrote:
>
> In:
> oe-core/meta/lib/oe/sstatesig.py
>
> The find_sstate_manifest function will search for a manifest assuming a
> number of potential paths based on various package architecture names.
> However, a few of the choices appear to have needed to be queried from th=
e
> bitbake database but their bb database variable *names* are used,
> instead.  That yields search paths which could never be correct:
>
>         pkgarchs =3D ['${MACHINE_ARCH}']
>         pkgarchs =3D pkgarchs +
> list(reversed(d2.getVar("PACKAGE_EXTRA_ARCHS").split()))
>         pkgarchs.append('allarch')
>         pkgarchs.append('${SDK_ARCH}_${SDK_ARCH}-${SDKPKGSUFFIX}')
>
>         for pkgarch in pkgarchs:
>                 manifest =3D
> d2.expand("${SSTATE_MANIFESTS}/manifest-%s-%s.%s" % (pkgarch, taskdata,
> taskname))
>
>
> d2.expand() expands all the variable references from pkgarch, so unless
> it=E2=80=99s also used later on and *isn=E2=80=99t* passed to expand(), t=
his isn=E2=80=99t an issue.
>
> -Chris
>


--=20
Alan Kozlay
VES Solutions, LLC
Alan Kozlay <alan.kozlay@ves.solutions>
DESK 443-595-7734
CELL 443-752-0323

--0000000000003129cf05973a89ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Chris,<input name=3D"virtru-metadata" typ=
e=3D"hidden" value=3D"{&quot;email-policy&quot;:{&quot;state&quot;:&quot;cl=
osed&quot;,&quot;expirationUnit&quot;:&quot;days&quot;,&quot;disableCopyPas=
te&quot;:false,&quot;disablePrint&quot;:false,&quot;disableForwarding&quot;=
:false,&quot;enableNoauth&quot;:false,&quot;persistentProtection&quot;:fals=
e,&quot;expandedWatermarking&quot;:false,&quot;expires&quot;:false,&quot;is=
Managed&quot;:false},&quot;attachments&quot;:{},&quot;compose-id&quot;:&quo=
t;3&quot;,&quot;compose-window&quot;:{&quot;secure&quot;:false}}"><div><br>=
</div><div>Thanks for the explanation.=C2=A0 I understand now.</div><div><b=
r></div><div>-Alan</div></div><br><div class=3D"gmail_quote" style=3D""><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 12, 2019 at 10:01 PM Christo=
pher Larson &lt;<a href=3D"mailto:kergoth@gmail.com">kergoth@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">



<div>
<div name=3D"messageReplySection">On Nov 12, 2019, 1:50 PM -0700, Alan Kozl=
ay &lt;<a href=3D"mailto:alan.kozlay@ves-solutions.com" target=3D"_blank">a=
lan.kozlay@ves-solutions.com</a>&gt;, wrote:<br>
<blockquote type=3D"cite" style=3D"margin:5px;padding-left:10px;border-left=
:thin solid rgb(26,188,156)">
<div dir=3D"ltr">
<div>In:</div>
<div><font face=3D"monospace">oe-core/meta/lib/oe/sstatesig.py</font></div>
<div><font face=3D"monospace"><br></font></div>
<div>The <font face=3D"monospace">find_sstate_manifest</font> function will=
 search for a manifest assuming a number of potential paths based on variou=
s package architecture names.=C2=A0 However, a few of the choices appear to=
 have needed to be queried from the bitbake database but their bb database =
variable <i>names</i> are used, instead.=C2=A0 That yields search paths whi=
ch could never be correct:</div>
<div><br></div>
<div><font face=3D"monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs =3D [<fo=
nt color=3D"#FF0000">&#39;${MACHINE_ARCH}&#39;</font>]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs =3D pkgarchs + list(reversed(d2.getVar=
(&quot;PACKAGE_EXTRA_ARCHS&quot;).split()))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs.append(&#39;allarch&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs.append(<font color=3D"#FF0000">&#39;${=
SDK_ARCH}_${SDK_ARCH}-${SDKPKGSUFFIX}&#39;</font>)<br></font></div>
<div><font face=3D"monospace"><br></font></div>
<div><font face=3D"monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 for pkgarch in pk=
garchs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 manifest =3D d2.exp=
and(&quot;${SSTATE_MANIFESTS}/manifest-%s-%s.%s&quot; % (pkgarch, taskdata,=
 taskname))=C2=A0<br></font></div>
</div>
</blockquote>
<div><br></div>
<div dir=3D"auto">d2.expand() expands all the variable references from pkga=
rch, so unless it=E2=80=99s also used later on and *isn=E2=80=99t* passed t=
o expand(), this isn=E2=80=99t an issue.</div>
<div dir=3D"auto"><br></div>
<div dir=3D"auto">-Chris</div>
</div>
</div>

</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><di=
v><div dir=3D"ltr"><div><div>Alan Kozlay<br></div><div dir=3D"ltr">VES Solu=
tions, LLC<br><span>Alan Kozlay &lt;alan.kozlay@ves.solutions&gt;</span><di=
v>DESK 443-595-7734<br></div><div>CELL 443-752-0323</div></div></div></div>=
</div></span></div></div></div></div></div>

--0000000000003129cf05973a89ac--
