Return-Path: <liu.ming50@gmail.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id E72D17C393
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 14:23:14 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id p6so6797341wmc.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3wnD8Ekd3aZiNtdVFpf9oN5aRMze55pfLK8bnXCERSw=;
	b=IiZpVTwQSKI5Cx1ofncSXHp4YyYekcSTXvgatKYJxmI1pvhGwhaUR0eQuc6koV6ZMz
	qi79ZkIUVUNCpJchm2sLmIjE1YBHSVl7bCplVOfAOzlkHgO+VQYUFfygCaajHoRnf2NE
	hVGdQLb6DJW3U24dmi1vLdzCTrfstKIAcXaO0usuVv1x66HfCGMn+gh9AAsoo63ybqkY
	mkf/SqdL4F1mZbfRQ1iKjVGfdIpLfDfELYsIU+52tnJ1S9u4o8JnB1N1bvStZnVA5Bkd
	EXBvbxxLRIb1Adq9wPQqd/xRxnxDoHCOZteKV6ohRMYwbwIfMDz/ok4hc0xEzdJ2aQDo
	ZMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3wnD8Ekd3aZiNtdVFpf9oN5aRMze55pfLK8bnXCERSw=;
	b=Wj0BDY0MjLa3b1YOR1GbEi7FA95yn6UA9YWqSQDcBca1SBfQ4Hoq7fBEjLr7KzBZ2j
	02NP4wCiHk2jnJ+kSQH3BYQcsSaLC+X1//biNlddNzcaNfNPYPZkvegVDYUGZCSAcGlu
	S1WMGKMVaw/HxaAG0SmLAFvKSO0LQEBS69aaeUMPjnui9CwxOkkxchJavui05gxa0t31
	7bgQY/tDY84zPR/ynZdLHa0NUh1nrlocu8Q4L0QsQNk0OvdCMUZgQknbILdmqpfxERip
	xWzAf+f/g9B2A628wTmk/KeV96rfuDgnPrCMn7I+/D/y+rmpiq+dRObdOLzCtuQxOjlb
	yMyw==
X-Gm-Message-State: AJcUukdOg24/dkEBJrEJj/S1t8Ox5zpVBy/XF9uUmNcBvX/C2AJs50/v
	Z+QSP2YoenytyOCwn0mUKPBUtzl5FZPfr+a/pSM=
X-Google-Smtp-Source: ALg8bN7LPXNsEDmqNM6RScCLxCIi5hSDNWz8OfFnKoVoUDDka+OB9H/PfOP9tPbkKbDj+ZkNxSaI7HyfP06UYjq3o8k=
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr7002229wmj.147.1548426195204; 
	Fri, 25 Jan 2019 06:23:15 -0800 (PST)
MIME-Version: 1.0
References: <1548413847-32550-1-git-send-email-liu.ming50@gmail.com>
	<18561a9b63079e5dc2d4b4a8b6b12728475b0402.camel@linuxfoundation.org>
	<CALatG=7YgmkROJpk_6pfZFKGP3=RjoJC_mh3gRsKMF+e=6=aqA@mail.gmail.com>
	<1dbceb752ca54fcbb32c4c4325272b80670693f4.camel@linuxfoundation.org>
	<CALatG=5tuk+qOc3D67wFpP=bnPxxyP4r-K=5wD2ieVgMYEhD+Q@mail.gmail.com>
	<31f945c230acc44677171059ae3aaac8950e20c4.camel@linuxfoundation.org>
In-Reply-To: <31f945c230acc44677171059ae3aaac8950e20c4.camel@linuxfoundation.org>
From: Ming Liu <liu.ming50@gmail.com>
Date: Fri, 25 Jan 2019 15:23:04 +0100
Message-ID: <CALatG=4Jvs_qtO206uXFmbsP5YyE6XGOLOCX8ceFgZvoGvLHdg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
	Stefan Agner <stefan.agner@toradex.com>, Luka Pivk <luka.pivk@toradex.com>
Subject: Re: [PATCH] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Fri, 25 Jan 2019 14:23:15 -0000
Content-Type: multipart/alternative; boundary="000000000000537d8505804911cb"

--000000000000537d8505804911cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oops, you are absolutely correct, will send a V2 fixing that.

We can continue this discussion on V2.

//Ming Liu

Richard Purdie <richard.purdie@linuxfoundation.org>=E4=BA=8E2019=E5=B9=B41=
=E6=9C=8825=E6=97=A5 =E5=91=A8=E4=BA=9415:10=E5=86=99=E9=81=93=EF=BC=9A

> On Fri, 2019-01-25 at 14:44 +0100, Ming Liu wrote:
> > Hi, Richard:
> >
> > Involve in Mark.
> >
> > Please correct me if I am wrong, but according to the code, seems
> > these upper level locks could not protect this race condition,
> > because it's inside the GitSM unpack function, the call chain is:
> >
> > Inside GitSM:
> > ```
> > def unpack
> >   -> for module in submodules:
> >        -> unpack_submodules
> >             -> runfetchcmd
> >                  -> bb.process.run
> >                       -> git config submodule
> > ```
> >
> > since 'git config submodule' run concurrently and try to modify a
> > same git config file, hence the race might happen, but it's hard to
> > be reproduced since 'git config submodule' finishes quite quickly.
>
> for that git config call, workdir=3Dud.destdir so its not in any shared
> location like DL_DIR but in a recipe's workdir?
>
> Cheers,
>
> Richard
>
>

--000000000000537d8505804911cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Oops, you are absolutely correct, will send a V2 fix=
ing that.</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">We can c=
ontinue this discussion on V2.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">//Ming Liu</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
>Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">r=
ichard.purdie@linuxfoundation.org</a>&gt;=E4=BA=8E2019=E5=B9=B41=E6=9C=8825=
=E6=97=A5 =E5=91=A8=E4=BA=9415:10=E5=86=99=E9=81=93=EF=BC=9A<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On Fri, 2019-01-25 at 14:44 +0100, Ming Liu wrote=
:<br>
&gt; Hi, Richard:<br>
&gt; <br>
&gt; Involve in Mark.<br>
&gt; <br>
&gt; Please correct me if I am wrong, but according to the code, seems<br>
&gt; these upper level locks could not protect this race condition,<br>
&gt; because it&#39;s inside the GitSM unpack function, the call chain is:<=
br>
&gt; <br>
&gt; Inside GitSM:<br>
&gt; ```<br>
&gt; def unpack<br>
&gt;=C2=A0 =C2=A0-&gt; for module in submodules:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; unpack_submodules <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; runfetchcmd<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; bb=
.process.run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0-&gt; git config submodule<br>
&gt; ```<br>
&gt; <br>
&gt; since &#39;git config submodule&#39; run concurrently and try to modif=
y a<br>
&gt; same git config file, hence the race might happen, but it&#39;s hard t=
o<br>
&gt; be reproduced since &#39;git config submodule&#39; finishes quite quic=
kly.<br>
<br>
for that git config call, workdir=3Dud.destdir so its not in any shared<br>
location like DL_DIR but in a recipe&#39;s workdir?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div></div>

--000000000000537d8505804911cb--
