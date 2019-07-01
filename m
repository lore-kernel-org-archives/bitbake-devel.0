Return-Path: <alan.kozlay@ves.solutions>
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
	[209.85.215.179])
	by mail.openembedded.org (Postfix) with ESMTP id 6F25E7E94C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Jul 2019 14:19:41 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id c13so6132378pgg.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 01 Jul 2019 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ves-solutions-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=u8BjKzzb3Y/Zbp5X/Dqq6RGZoKd2QPqP8FqZ7kdIsWI=;
	b=LSonEPFfrJJhPnG+HVe6XYSKdRK6LcFu6y/Z3+ayi2ifk73ju9+Ss/d72PbAjn5RkD
	SWgRHVIVz2/+jMZOnNnunTZhGG0EN9EEzVhhdc9VSSWOAS0R3MRlHeojSNmV4VeBHaPg
	nSYoxlh1fX9LkK/l2WiuvdCblLE70eKyScUW+HfkqOxsEUUIIqFzruzw+vWxwAgdUrwt
	T+DMzZ23VJjvtk21oD4QVNDBAUHIlHJSfFCXaIRT6sN8uLA6nox3zrzRL01B6zwxaVf+
	75YJbhm2Evd31xqRJJAs6qSv1qRAlyU77w3KIBonSFD05aRqsgFaMzZ1bx+WPp1grbd2
	6ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=u8BjKzzb3Y/Zbp5X/Dqq6RGZoKd2QPqP8FqZ7kdIsWI=;
	b=c+duAtg1n6CwGqbPQF/YJWVu/sGxxiLywdOOetzclaxBpN5UJ8erNA+K0ge9uG8XBL
	hkdORg/gcs/CbfQu/V4f+fSobDOH+UlhDCoIXhMjnS1x2IfxWrj30uONTFgQvazE7BBJ
	LY/TPE70UHCHi5xCYAxBvwf0J94FGEHnVVNIDm3NBapUf92PpHZHnYeAU3xeV6zDsaRH
	NqVr/BKMPlv+je2t3LB4tkMSkdeeW1Csz9pBbXRT/QZgTW2eX3IupW7FlAnQeY51ikBy
	MkG3vgoiQVuT7kFoL8h/RZMIauxLK5T4sB8d7CLwLXOKSrTnFNfqxVAI4eP1/ZcEVeTh
	nxGg==
X-Gm-Message-State: APjAAAV1T3sLQjvVzokwsgbMnH/baBDwTwjaHnL4TPd9LtyQno09Dv3q
	+4PtoIGeLIy2sK8zQkgb7ArxtDnV8JveYsKVB78PDA==
X-Google-Smtp-Source: APXvYqwSVZvyYT6JOBOzKqwevugOgDDii9u3c0AvHm27UvSd2WK7psF10CD1nILI7hAKtXi0r2ddC0wnP9O96q5DbJc=
X-Received: by 2002:a17:90a:7d09:: with SMTP id
	g9mr30859688pjl.38.1561990782430; 
	Mon, 01 Jul 2019 07:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
	<MW2PR12MB25406786F78B9051179B2B918BF90@MW2PR12MB2540.namprd12.prod.outlook.com>
In-Reply-To: <MW2PR12MB25406786F78B9051179B2B918BF90@MW2PR12MB2540.namprd12.prod.outlook.com>
From: Alan Kozlay <alan.kozlay@ves-solutions.com>
Date: Mon, 1 Jul 2019 10:19:06 -0400
Message-ID: <CAJE9sG=eKji+FGe4LNKMREocoOYJ7TLR8MGpw+pXx6hsSCSkeQ@mail.gmail.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 01 Jul 2019 14:19:42 -0000
Content-Type: multipart/alternative; boundary="000000000000bac4f3058c9f51e9"

--000000000000bac4f3058c9f51e9
Content-Type: text/plain; charset="UTF-8"

I wasn't completely clear in my origin post.  We actually do use the mc to
specify different DISTRO and IMAGE features.  But my point was that, for
recipies which are not affected by a change in those features, couldn't
such as recipe's workdir be leveraged by another mc conf.  But Richard's
response was clear.  That's not something which is supported, currently.

On Mon, Jul 1, 2019 at 10:13 AM chris.laplante@agilent.com <
chris.laplante@agilent.com> wrote:

> > We have need to generate 6 slighly different images, with different
> dedicated applications and use cases, but they're all destined for
> > the same hardware.
> > We have multiconfig set to build these 6 variants.  Clearly, they'll all
> share a majority of underlying packages.
> > While the bitbake initialization takes a long time (with multiconfig),
> we were under the impression that it could save time during the
> > actual build process because it could have the potential to reuse
> packages already built from mc A for mc B if the inputs to the recipes
> > are unchanged (if same xxx_FEATURES, same arch, etc.).
> >
> > This was a guess on our part since we initially didn't assign different
> tmp directories for each conf.  So, the <WORKDIR> didn't change
> > between mc builds.  That actually was causing some issues until we
> realized that separate tmp dirs was recommended for them.
> > Since they all now have separate tmp dirs, they clearly are not going to
> share work dirs, so, now we're questioning our original
> > assumption about any build-time speed benefit.
>
> Have you considered whether you actually need multiconfig in this case? If
> the arch and distro features don't change, you should just be able to have
> multiple image recipes.
>
> Chris
>


-- 
Alan Kozlay
VES Solutions, LLC
Alan Kozlay <alan.kozlay@ves.solutions>
DESK 443-595-7734
CELL 443-752-0323

--000000000000bac4f3058c9f51e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I wasn&#39;t completely clear in my origi=
n post.=C2=A0 We actually do use the mc to specify different DISTRO and IMA=
GE features.=C2=A0 But my point was that, for recipies which are not affect=
ed by a change in those features, couldn&#39;t such as recipe&#39;s workdir=
 be leveraged by another mc conf.=C2=A0 But Richard&#39;s response was clea=
r.=C2=A0 That&#39;s not something which is supported, currently.<input name=
=3D"virtru-metadata" type=3D"hidden" value=3D"{&quot;email-policy&quot;:{&q=
uot;state&quot;:&quot;closed&quot;,&quot;expirationUnit&quot;:&quot;days&qu=
ot;,&quot;disableCopyPaste&quot;:false,&quot;disablePrint&quot;:false,&quot=
;disableForwarding&quot;:false,&quot;enableNoauth&quot;:false,&quot;persist=
entProtection&quot;:false,&quot;expandedWatermarking&quot;:false,&quot;expi=
res&quot;:false,&quot;isManaged&quot;:false},&quot;attachments&quot;:{},&qu=
ot;compose-id&quot;:&quot;5&quot;,&quot;compose-window&quot;:{&quot;secure&=
quot;:false}}"></div><br><div class=3D"gmail_quote" style=3D""><div dir=3D"=
ltr" class=3D"gmail_attr">On Mon, Jul 1, 2019 at 10:13 AM <a href=3D"mailto=
:chris.laplante@agilent.com">chris.laplante@agilent.com</a> &lt;<a href=3D"=
mailto:chris.laplante@agilent.com">chris.laplante@agilent.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; We have n=
eed to generate 6 slighly different images, with different dedicated applic=
ations and use cases, but they&#39;re all destined for<br>
&gt; the same hardware.<br>
&gt; We have multiconfig set to build these 6 variants.=C2=A0 Clearly, they=
&#39;ll all share a majority of underlying packages.<br>
&gt; While the bitbake initialization takes a long time (with multiconfig),=
 we were under the impression that it could save time during the<br>
&gt; actual build process because it could have the potential to reuse pack=
ages already built from mc A for mc B if the inputs to the recipes<br>
&gt; are unchanged (if same xxx_FEATURES, same arch, etc.).<br>
&gt; <br>
&gt; This was a guess on our part since we initially didn&#39;t assign diff=
erent tmp directories for each conf.=C2=A0 So, the &lt;WORKDIR&gt; didn&#39=
;t change<br>
&gt; between mc builds.=C2=A0 That actually was causing some issues until w=
e realized that separate tmp dirs was recommended for them.<br>
&gt; Since they all now have separate tmp dirs, they clearly are not going =
to share work dirs, so, now we&#39;re questioning our original<br>
&gt; assumption about any build-time speed benefit.<br>
<br>
Have you considered whether you actually need multiconfig in this case? If =
the arch and distro features don&#39;t change, you should just be able to h=
ave multiple image recipes.<br>
<br>
Chris <br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span><di=
v><div dir=3D"ltr"><div><div>Alan Kozlay<br></div><div dir=3D"ltr">VES Solu=
tions, LLC<br><span>Alan Kozlay &lt;alan.kozlay@ves.solutions&gt;</span><di=
v>DESK 443-595-7734<br></div><div>CELL 443-752-0323</div></div></div></div>=
</div></span></div></div></div></div></div>

--000000000000bac4f3058c9f51e9--
