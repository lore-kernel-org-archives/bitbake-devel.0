Return-Path: <kergoth@gmail.com>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
	[209.85.160.170])
	by mail.openembedded.org (Postfix) with ESMTP id EC74A601DC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 16:10:38 +0000 (UTC)
Received: by mail-yk0-f170.google.com with SMTP id q9so14042084ykb.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 08:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=76ZzUcHkhwoaepBzoYPIdLuZ4U4r6QS+F8sAocj13hI=;
	b=w2mOKSL/I7C2aVsl7zyBlyt5886VpIURynjKMpjOOrQvwQduGydfwYhJvUyG5eaSZW
	tUIfyqnox4XdDcWp4scc3yIJwsQptTSRG4SOLFxe926fRIL5nV3i5QmYfqTlVw/Iy4VW
	Bd4cc22R31KpM4rrDGr4omiTW/i9a26n24+7QCBt/M5VjxAVhhrqR+RY1wTFXFwMwfCM
	O3gRV7vY5Xlu3i1U1imfFzLhgA4Q8NdLlgTrGnYEVgUHSXnUODR5onsocPqWw5RyQ+XM
	y3jidzv02U2WQUWZsvUk6IfS8qpDFrPHYy8Vo7lZhkIsAB2VG2+3bgN1HqXZX/WnKuEK
	8Pvg==
X-Received: by 10.170.174.197 with SMTP id q188mr958107ykd.110.1422547839547; 
	Thu, 29 Jan 2015 08:10:39 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.170.205.88 with HTTP; Thu, 29 Jan 2015 08:10:18 -0800 (PST)
In-Reply-To: <1422542137.5312.6.camel@linuxfoundation.org>
References: <1422542137.5312.6.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 29 Jan 2015 09:10:18 -0700
X-Google-Sender-Auth: ZQR-WrqvxvcYBPBaVpZJxsmRUt0
Message-ID: <CABcZANkTwKvtY_HvrL8AnZOni_Z-BT6HWAbZ0TzYaSFPCQyMbQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data_smart: Don't use mutable objects as default args
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
X-List-Received-Date: Thu, 29 Jan 2015 16:10:41 -0000
Content-Type: multipart/alternative; boundary=001a113aba02a6feb7050dccba7f

--001a113aba02a6feb7050dccba7f
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 29, 2015 at 7:35 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> These only have one instance created which means your subsequent datastores
> can contain echos of previous ones. Obviously this is not the behaviour
> we want/expect. It doesn't affect bitbake too badly as we only have one
> datastore, it does massively potentially break our selftests though.
>
> Thanks to Tim Amsell for pointing out the now obvious problem!
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Wow, obvious indeed, once you look at it. Nicely spotted, Tim.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113aba02a6feb7050dccba7f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jan 29, 2015 at 7:35 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">These only have one instance created which means your subsequent da=
tastores<br>
can contain echos of previous ones. Obviously this is not the behaviour<br>
we want/expect. It doesn&#39;t affect bitbake too badly as we only have one=
<br>
datastore, it does massively potentially break our selftests though.<br>
<br>
Thanks to Tim Amsell for pointing out the now obvious problem!<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;<br></blockquote><di=
v><br></div><div>Wow, obvious indeed, once you look at it. Nicely spotted, =
Tim.</div></div>-- <br><div class=3D"gmail_signature">Christopher Larson<br=
>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<=
br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a113aba02a6feb7050dccba7f--
