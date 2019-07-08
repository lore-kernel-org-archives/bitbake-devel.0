Return-Path: <alan.kozlay@ves.solutions>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id 955517D2E5
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Jul 2019 18:28:25 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id q4so8109333pgj.8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Jul 2019 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ves-solutions-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=iym4XgNfAZGUf4mD/7sbfu72qeMuprXe510tKuWolkM=;
	b=ydkRJweuDldXoGIJea7HOkM+R2H2kDi8obEnbLrNeBzJH6hLfu0qVTcwDaVemCDmRc
	+KT0iMegYw/K9udcEmVNUyxcrhGD+K7EDpBeCsnTWXAtPZbC4e5P6nB1CWQyszMFYOH8
	8DXTZGvqdaj1UFhBW44iyvIJr4eoYDymLg4rtvL2QrKfGt5iq3MA69GAbj8sNuKGP34G
	EttcX8OHvzTsJZFK7Xs/W93s2led2sre6CyR4prbqE0KjTkHESrIhxkFzJbb08Hh0cbv
	Ns7WMjnk8V5UzAPnPDOo4V6vId6wYl0f3GhynyODFoQhiC1jJWK4rNNN4iEJMWVOydb3
	+A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=iym4XgNfAZGUf4mD/7sbfu72qeMuprXe510tKuWolkM=;
	b=ad+fDv4FA9BmIJ36U+S+0vVuj1QjzeMbOJDFJ5AO51Qq6kg5z/yBxFT7BjQ5d9mpaz
	1l6QPau59MLqRXTXxhRtVII4F5un+WbL9GWUrCSAWDTqQQyBPqKq13WKrrFN2sfnmdru
	POuBOVv/50rHlKj09hz2n5/BfhzMCFXvRGLHvucBSdoLWq3HqdTA6eXojXglxwEpzPg/
	Yw7T3ushfP4meF8xmPFuCYiEHeW873/s9C4koexDwdVf/K7o3ic5FST4ysFzwSv5P8vj
	1qnb+8vc+neVqhp+SYgpYuZoFCqGxMtqBofg8Sn+PNUuADQAu4hFKOIZVJ98sWHY0jRa
	pr1g==
X-Gm-Message-State: APjAAAWBGSbntA4oHy3ccexawD3uSyR1rJ9zDjpuyRcFljUeCxvczs+C
	ztw7ZX6QzGWDL3EFNn2jneDKI20Ir4tIEIskFhbDeCQsoAw=
X-Google-Smtp-Source: APXvYqxDcUiDNMV1WbMvjsxmt3qBa7Dpzo4VsOjQieHdAG/ls5N2DgsdXuX64ZgMPDZY1LKWMIMDRse38hqKL015P/o=
X-Received: by 2002:a17:90b:f12:: with SMTP id
	br18mr26511822pjb.127.1562610506452; 
	Mon, 08 Jul 2019 11:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
	<d12b286a3b55653e61d8d8e7672d87b374ae37d6.camel@linuxfoundation.org>
In-Reply-To: <d12b286a3b55653e61d8d8e7672d87b374ae37d6.camel@linuxfoundation.org>
From: Alan Kozlay <alan.kozlay@ves-solutions.com>
Date: Mon, 8 Jul 2019 14:27:49 -0400
Message-ID: <CAJE9sGmynaeD3uL-UBJnJt74rhv-sjSYjtQ=mNByQ69pVwaerg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: Should multiconfig save build time?
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
X-List-Received-Date: Mon, 08 Jul 2019 18:28:25 -0000
Content-Type: multipart/alternative; boundary="00000000000028e5ca058d2f9c19"

--00000000000028e5ca058d2f9c19
Content-Type: text/plain; charset="UTF-8"

All,

In regards to our original June 28th post:

We're looking for things we can do to improve the multiconfig build time.

Even on our build servers it still takes a long time.
For instance, our build servers each have 64 core, 128G RAM with 4 NVMe SSD
HDs in a striped raid (*all configured with bells and whistles to make it
super fast*).
A full fresh build on one of those servers still takes 6 hours.

I need to also clarify that we do indeed define different DISTRO_FEATURES
between multiconfigs, so multiconfig is necessary.

(1) We're attempting to use the ccache (via ccache.bbclass), but it's
causing some build errors that we're investigating.
(2) Can we at least set the root native work directory to be the same for
all multiconfigs?

   - Would each multiconfig honor the previously built native tools?
   - Or, would it just rebuild them, anyway?
   - Is this safe or tested or supported?

(3) We're considering a network shared sstate-cache.  But it's not entirely
clear if a multiconfig build is benefited by the sstate-cache directory.

   - Under what circumstances does a multiconfig leverage sstate-cache when
   building for another multiconfig?
   - What if the recipe would be affected by a change in DISTRO_FEATURES
   between multiconfigs?
   - Are native packages included in the sstate-cache or just target
   packages?

We welcome all thoughts and ideas.

-Alan

On Sun, Jun 30, 2019 at 5:38 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2019-06-28 at 13:31 -0400, Alan Kozlay wrote:
> > We have need to generate 6 slighly different images, with different
> > dedicated applications and use cases, but they're all destined for
> > the same hardware.
> > We have multiconfig set to build these 6 variants.  Clearly, they'll
> > all share a majority of underlying packages.
> > While the bitbake initialization takes a long time (with
> > multiconfig), we were under the impression that it could save time
> > during the actual build process because it could have the potential
> > to reuse packages already built from mc A for mc B if the inputs to
> > the recipes are unchanged (if same xxx_FEATURES, same arch, etc.).
> >
> > This was a guess on our part since we initially didn't assign
> > different tmp directories for each conf.  So, the <WORKDIR> didn't
> > change between mc builds.  That actually was causing some issues
> > until we realized that separate tmp dirs was recommended for them.
> > Since they all now have separate tmp dirs, they clearly are not going
> > to share work dirs, so, now we're questioning our original assumption
> > about any build-time speed benefit.
> >
> > So, is mc expected to be any faster than, say, 6 separate invocations
> > of non-mc bitbake whilst switching out the local.conf between them?
>
> Ultimately, yes, it would be expected to be faster.
>
> With the code as it stands today, no, it won't be. Its a known open
> issue:
>
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=10682
>
> What would be faster is to build one of the configs initially which
> will populate the sstate cache, then build the other 5 together in one
> multiconfig.
>
> We obviously want to get that issue fixed ultimately but its not an
> easy thing to do due to the way our codebase works.
>
> Cheers,
>
> Richard
>
>

-- 
Alan Kozlay
VES Solutions, LLC
Alan Kozlay <alan.kozlay@ves.solutions>
DESK 443-595-7734
CELL 443-752-0323

--00000000000028e5ca058d2f9c19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">All,<input name=3D"virtru-metadata" type=
=3D"hidden" value=3D"{&quot;email-policy&quot;:{&quot;state&quot;:&quot;clo=
sed&quot;,&quot;expirationUnit&quot;:&quot;days&quot;,&quot;disableCopyPast=
e&quot;:false,&quot;disablePrint&quot;:false,&quot;disableForwarding&quot;:=
false,&quot;enableNoauth&quot;:false,&quot;persistentProtection&quot;:false=
,&quot;expandedWatermarking&quot;:false,&quot;expires&quot;:false,&quot;isM=
anaged&quot;:false},&quot;attachments&quot;:{},&quot;compose-id&quot;:&quot=
;1&quot;,&quot;compose-window&quot;:{&quot;secure&quot;:false}}"><div><br><=
/div><div>In regards to our original June 28th post:</div><div><br></div><d=
iv>We&#39;re looking for things we can do to improve the multiconfig build =
time.</div><div><br></div><div>Even on our build servers it still takes a l=
ong time.</div><div>For instance, our build servers each have 64 core, 128G=
 RAM with 4 NVMe SSD HDs in a striped raid (<i>all configured with bells an=
d whistles to make it super fast</i>).</div><div>A full fresh build on one =
of those servers still takes 6 hours.</div><div><br></div><div>I need to al=
so clarify that we do indeed define different DISTRO_FEATURES between multi=
configs, so multiconfig is necessary.</div><div><br></div><div>(1) We&#39;r=
e attempting to use the ccache (via ccache.bbclass), but it&#39;s causing s=
ome build errors that we&#39;re investigating.</div><div>(2) Can we at leas=
t set the root native work directory to be the same for all multiconfigs?</=
div><div><ul><li>Would each multiconfig honor the previously built native t=
ools?</li><li>Or, would it just rebuild them, anyway?</li><li>Is this safe =
or tested or supported?</li></ul>(3) We&#39;re considering a network shared=
 sstate-cache.=C2=A0 But it&#39;s not entirely clear if a multiconfig build=
 is benefited by the sstate-cache directory.</div><div><ul><li>Under what c=
ircumstances does a multiconfig leverage sstate-cache when building for ano=
ther multiconfig?<br></li><li>What if the recipe would be affected by a cha=
nge in DISTRO_FEATURES between multiconfigs?<br></li><li>Are native package=
s included in the sstate-cache or just target packages?<br></li></ul></div>=
<div>We welcome all thoughts and ideas.</div><div><br></div><div>-Alan</div=
></div><br><div class=3D"gmail_quote" style=3D""><div dir=3D"ltr" class=3D"=
gmail_attr">On Sun, Jun 30, 2019 at 5:38 PM Richard Purdie &lt;<a href=3D"m=
ailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On Fri, 2019-06-28 at 13:31 -0400, Alan Kozlay wrote:<br>
&gt; We have need to generate 6 slighly different images, with different<br=
>
&gt; dedicated applications and use cases, but they&#39;re all destined for=
<br>
&gt; the same hardware.<br>
&gt; We have multiconfig set to build these 6 variants.=C2=A0 Clearly, they=
&#39;ll<br>
&gt; all share a majority of underlying packages.<br>
&gt; While the bitbake initialization takes a long time (with<br>
&gt; multiconfig), we were under the impression that it could save time<br>
&gt; during the actual build process because it could have the potential<br=
>
&gt; to reuse packages already built from mc A for mc B if the inputs to<br=
>
&gt; the recipes are unchanged (if same xxx_FEATURES, same arch, etc.).<br>
&gt; <br>
&gt; This was a guess on our part since we initially didn&#39;t assign<br>
&gt; different tmp directories for each conf.=C2=A0 So, the &lt;WORKDIR&gt;=
 didn&#39;t<br>
&gt; change between mc builds.=C2=A0 That actually was causing some issues<=
br>
&gt; until we realized that separate tmp dirs was recommended for them.<br>
&gt; Since they all now have separate tmp dirs, they clearly are not going<=
br>
&gt; to share work dirs, so, now we&#39;re questioning our original assumpt=
ion<br>
&gt; about any build-time speed benefit.<br>
&gt; <br>
&gt; So, is mc expected to be any faster than, say, 6 separate invocations<=
br>
&gt; of non-mc bitbake whilst switching out the local.conf between them? <b=
r>
<br>
Ultimately, yes, it would be expected to be faster.<br>
<br>
With the code as it stands today, no, it won&#39;t be. Its a known open<br>
issue:<br>
<br>
<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10682" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.org/show_bu=
g.cgi?id=3D10682</a><br>
<br>
What would be faster is to build one of the configs initially which<br>
will populate the sstate cache, then build the other 5 together in one<br>
multiconfig.<br>
<br>
We obviously want to get that issue fixed ultimately but its not an<br>
easy thing to do due to the way our codebase works.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><di=
v><div dir=3D"ltr"><div><div>Alan Kozlay<br></div><div dir=3D"ltr">VES Solu=
tions, LLC<br><span>Alan Kozlay &lt;alan.kozlay@ves.solutions&gt;</span><di=
v>DESK 443-595-7734<br></div><div>CELL 443-752-0323</div></div></div></div>=
</div></span></div></div></div></div></div>

--00000000000028e5ca058d2f9c19--
