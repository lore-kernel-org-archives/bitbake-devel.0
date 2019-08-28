Return-Path: <alex.kanavin@gmail.com>
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
	[209.85.217.67])
	by mail.openembedded.org (Postfix) with ESMTP id 38F147EFD3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Aug 2019 15:19:39 +0000 (UTC)
Received: by mail-vs1-f67.google.com with SMTP id c7so190054vse.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Aug 2019 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=n3680UTemsfI5c2RtM+j+cbbArWbrTpe54WvF4wopMY=;
	b=W9APTic+p5jZUryfnvNaXNx9RqsawpZyGQZk8jeXeG850jnEdI9153okDCvlrzHPlM
	AYd/GefAvL2orsLv/TPuMS5ykSjdhqZLIGoLhOjgzmpG3dkwu99D0sChQuyJana3alBB
	zTM6Z3HfrpVojSHnSKGb7nE0ed79N2JoyDF9/A+maGsC3qeyh2BDB6f9AqZf1O0JLm1O
	w1CMH8zsI9k7YIhSOmkkPgCv49ZSKwNTC/0oDn0y3EF3iZqMsaHWCpeEKG0gy+QoQlgc
	7BCldWasDy6dH8JupUUIX1xlKCbgjmGrMYlH1XRnTzXAWdMTL0z6jYlfWORDBhzgpnxS
	yY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=n3680UTemsfI5c2RtM+j+cbbArWbrTpe54WvF4wopMY=;
	b=YMgWFED7GHmoAlVovzd8lgtWnEjfc5WQLSfYYyvsXKjobDK6akBYBXH+uz2Ef3cP30
	aQsGscgx3PcEmCxCBmeFIcLV85Ub4Hj4qx6kRY+MeRQFFAE8ahykCyaiw/FjxIicNvaQ
	17GpJAa86uNTRs+LiftVACdC0b3SzOTiJTH5w2+lWppYyGJDtbBVhRk1BAjl+4BWDeIJ
	6h4p/eWccv8oroJjGHkNr640U19xCBXX2r7ENPscQ6QVfJoVCwhjxHXshCVqtehPRbRg
	qILSJZ6BFXK3JdSdc+IjXP2PQlL9gtgVSxtb5cSqZ/TSZgQceB+B/qwf2n2vl8OBmyxX
	vE0w==
X-Gm-Message-State: APjAAAXu13AK3H9EctF2dhTDwMagDqFTYcKJfBNc9BEJSgLRFaaQW2gA
	TpWAtqFkZIhJvArUzZD445Y28hsCIMguaRL3xso=
X-Google-Smtp-Source: APXvYqwKJI1ZDLZH+2mEUVH0vFQvyKRN9uH/k1N92IO9O8xoKG8UCJ56K13GXUQJzYVne5XRhQT0s1uPiCVDH5Rxcx4=
X-Received: by 2002:a67:347:: with SMTP id 68mr2675663vsd.35.1567005580113;
	Wed, 28 Aug 2019 08:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190827000358.25777-1-andrew@aj.id.au>
	<a0279d01-3d06-3648-f63c-9392be141397@windriver.com>
	<2e4b0f4a-8288-490a-8bc2-7d49f460487e@www.fastmail.com>
In-Reply-To: <2e4b0f4a-8288-490a-8bc2-7d49f460487e@www.fastmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Aug 2019 17:19:29 +0200
Message-ID: <CANNYZj-mt-djAF2xnhLduA8O9Zzgc7VsiPFjXXZKzNHkR8uM0A@mail.gmail.com>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: Brad Bishop <bradleyb@fuzziesquirrel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>, ojayanth@in.ibm.com
Subject: Re: [RESEND RFC PATCH] gitsm: Control submodule recursion
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
X-List-Received-Date: Wed, 28 Aug 2019 15:19:39 -0000
Content-Type: multipart/alternative; boundary="000000000000f6bd4505912eea7d"

--000000000000f6bd4505912eea7d
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2019 at 16:38, Andrew Jeffery <andrew@aj.id.au> wrote:

> Can you expand a bit more on how I'd do this (examples?), or point me in
> the right direction with documentation? There don't appear to be any
> pointers in the git:// fetcher section of the mega manual.
>

I believe you simply need to specify several git:// entries for the
submodules you want like for example vulkan-demos does:

SRCREV_glm = "01f9ab5b6d21e5062ac0f6e0f205c7fa2ca9d769"
SRCREV_gli = "8e43030b3e12bb58a4663d85adc5c752f89099c0"
SRCREV = "ae0b59c6e2e8630a2ae26f4a0b7a72cbe7547948"

SRC_URI = "git://github.com/SaschaWillems/Vulkan.git \
           git://github.com/g-truc/glm;destsuffix=git/external/glm;name=glm
\
           git://github.com/g-truc/gli;destsuffix=git/external/gli;name=gli
\

 file://0001-Don-t-build-demos-with-questionably-licensed-data.patch \
"

In our internal project we ended up converting all gitsm:// recipes to
plain 'unfolded' git:// as gitsm:// has a number of issues in the thud
release that we tripped over
(I made sure warrior/master does address them).

Alex

--000000000000f6bd4505912eea7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, 28 Aug 2019 at 16:38, Andrew Jeffery &lt;<a href=3D"mailto:a=
ndrew@aj.id.au">andrew@aj.id.au</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Can you expand a bit more on how I&#39;d d=
o this (examples?), or point me in<br>
the right direction with documentation? There don&#39;t appear to be any<br=
>
pointers in the git:// fetcher section of the mega manual.<br></blockquote>=
<div><br></div><div>I believe you simply need to specify several git:// ent=
ries for the submodules you want like for example vulkan-demos does:</div><=
div><br></div><div>SRCREV_glm =3D &quot;01f9ab5b6d21e5062ac0f6e0f205c7fa2ca=
9d769&quot;<br>SRCREV_gli =3D &quot;8e43030b3e12bb58a4663d85adc5c752f89099c=
0&quot;<br><div>SRCREV =3D &quot;ae0b59c6e2e8630a2ae26f4a0b7a72cbe7547948&q=
uot;<br></div><br>SRC_URI =3D &quot;git://<a href=3D"http://github.com/Sasc=
haWillems/Vulkan.git">github.com/SaschaWillems/Vulkan.git</a> \<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git://<a href=3D"http://github.com/g-truc=
/glm;destsuffix=3Dgit/external/glm;name=3Dglm">github.com/g-truc/glm;destsu=
ffix=3Dgit/external/glm;name=3Dglm</a> \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0git://<a href=3D"http://github.com/g-truc/gli;destsuffix=3Dgit/ex=
ternal/gli;name=3Dgli">github.com/g-truc/gli;destsuffix=3Dgit/external/gli;=
name=3Dgli</a> \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://0001-Do=
n-t-build-demos-with-questionably-licensed-data.patch \<br>&quot;</div><div=
><br></div><div>In our internal project we ended up converting all gitsm://=
 recipes to plain &#39;unfolded&#39; git:// as gitsm:// has a number of iss=
ues in the thud release that we tripped over</div><div>(I made sure warrior=
/master does address them).</div><div><br></div><div>Alex<br></div></div></=
div>

--000000000000f6bd4505912eea7d--
