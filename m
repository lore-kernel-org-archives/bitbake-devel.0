Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30794C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 23:14:26 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.6231.1708038864530590360
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Feb 2024 15:14:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JVCyzveg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41244cc3d67so7455e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 15:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708038863; x=1708643663; darn=lists.openembedded.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cCsGI8vZ9LsL3L0q+IP3BpxC7Gw+Shmj6dcwBYOR8Ao=;
        b=JVCyzvegk8hYqwWzDuzeYnfAkUwXSIWtXi7NUXqEwYEbb83ZtrLHxuQYlXtw+i8Nzg
         mu8B/TZUme3xibpGJ2mIRt3x1h94F+fDl752NI4ZvNF2kqD9WvMCUsnaQIkIIBtgdcHV
         8tt1/GEGR9Z6l/eW3qiCvvwRw4R0RmsAb4zNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708038863; x=1708643663;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCsGI8vZ9LsL3L0q+IP3BpxC7Gw+Shmj6dcwBYOR8Ao=;
        b=klu3hIity1f4sNg9SeJCUWEbBywabPRYWsZJD2b6ZwcuglNbyAJBz1nlw+RHi2DA6k
         QuSmDpDb7sUkkC1QYtbwmWYHdbkoXP27P8tBkPOP5b5znbo558KKg6qIVjHQgttSAIV+
         LaItKtayvi3yfCqqlNPjAyUrRPCujrZnaPUPW13bMU/BOk2asOe6Kr41mo7yjRAaI/KZ
         TsHgaC8vaeuAN3upSdNzkamKnEozV8FfmXaUVMyOPwZ/REdyX9ep2DESYoPK5ff36KXY
         yWa+yqvbFc7MABaKNFipsNYcDCAjis+hYf8jn4Rh89+0Gv0D0wM0lOVBlks6XEbDC9Ix
         yyiA==
X-Gm-Message-State: AOJu0YwTIo8I1lBpprvaDTf21lhcnEim+UwFH13B6IYMjE4vxHYSFvjh
	nJoS3yIiEuA8We96HhwhicCoBdmIPTBOizya2Kyf2GT42Ps5mVNEGw8oWG8ldns=
X-Google-Smtp-Source: AGHT+IE1myaxOMLtsClE6CyIS+ZlYgQwCUUNXrchZvI3yDu/zYTF08aVBv6ny7eLAesHifc7nOVZ5g==
X-Received: by 2002:a5d:414a:0:b0:33b:6d3a:acf6 with SMTP id c10-20020a5d414a000000b0033b6d3aacf6mr2249663wrq.2.1708038862803;
        Thu, 15 Feb 2024 15:14:22 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:fd13:6695:6348:c567? ([2001:8b0:aba:5f3c:fd13:6695:6348:c567])
        by smtp.gmail.com with ESMTPSA id o6-20020a056000010600b0033cf7b9db5fsm435868wrx.44.2024.02.15.15.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 15:14:22 -0800 (PST)
Message-ID: <47f538c24ddb16cd2301ee95de59459d32c05cbe.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [2.0][PATCH 1/5] runqueue: fix PSI check
 calculation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Randy MacLeod <randy.macleod@windriver.com>, Martin Jansa
	 <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, steve@sakoman.com, Chen Qi
	 <Qi.Chen@windriver.com>
Date: Thu, 15 Feb 2024 23:14:21 +0000
In-Reply-To: <018990a0-3db0-41e6-b0f9-61e4c03407c8@windriver.com>
References: <17964777D58C012A.3202@lists.openembedded.org>
	 <CA+chaQc3jWaE0Bto1MQFf45bUVdY_8UvAb9N1vFM=A1-Q_RnGA@mail.gmail.com>
	 <018990a0-3db0-41e6-b0f9-61e4c03407c8@windriver.com>
Autocrypt: addr=richard.purdie@linuxfoundation.org; prefer-encrypt=mutual; keydata=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
 YNvg==
Content-Type: multipart/alternative; boundary="=-7Gy4Np08U7uH2hkPzDjs"
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 23:14:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15905

--=-7Gy4Np08U7uH2hkPzDjs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-02-15 at 18:06 -0500, Randy MacLeod wrote:
> =20
> On 2023-11-10 9:06 a.m., Martin Jansa wrote:
> =20
> > =20
> > I forgot to include [RFC] tag in the subject, because these changes
> > might be a bit controversial.=20
> >=20
> >=20
> >=20
> > From my testing:
> >=20
> > https://github.com/shr-project/test-oe-build-time/commit/d5111f4472ac39=
7c0f1197eb6366ac7d2e56453f
> >=20
> > the reasonable pressure values for 2.0 (in kirkstone) and 2.6 (in
> > nanbield) are significantly different due to these changes in PSI
> > calculation and logic so while 1000 was reasonable value for my
> > system in 2.0, I need 100000 with 2.6.
> >=20
> >=20
> >=20
> >=20
> > I've backported these changes long time ago for my local builds to
> > use the same PSI values for all builds.
> >=20
> >=20
> >=20
> >=20
> > And the controversy is that backporting these will change the
> > expected values (so kind of change in behavior which might not be
> > suitable for stable release). But the commits make it sound as a
> > bug in the logic, so we can also consider them as bug fixes.
> >=20
> >=20
> >=20
> >=20
> > The change in expected pressure values was reported in:
> >=20
> > https://lists.openembedded.org/g/bitbake-devel/message/14942
> >=20
> >=20
> >=20
> >=20
> > If it's not a bug to be fixed in 2.0 then maybe we should mention
> > different PSI values in release notes for nanbield (I know I'm too
> > late for that).
> >=20
> >=20
> >=20
> >=20
> > Regards,
> > =20
> =20
> So people were suggesting that the slow YP AB times might be due to
> PSI regulation.
>=20
> On a 24 core system, I built core-image-minimal with the original
> code=20
> from before Chen's commit in August 2023=20
> =20
> poky.git
> $ git log --oneline -2 653ff4d85cbaf53627f7978b06c1f025ac4694e2
> 653ff4d85c bitbake: runqueue.py: fix PSI check logic=20
> ac5512b0ac bitbake: fetch2: add Google Cloud Platform (GCP)
> fetcher=C2=A0=C2=A0=C2=A0 <---- Old
> =20
>=20
> =20
> =20
> and with current master ~ Feb 2024 :
> =20
> $ git log --oneline -2=20
> 9382d731bd bash: nativesdk-bash does not provide /bin/bash so don't
> claim to <----- New
> 0fe85ce0c6 busybox: Explicitly specify tty device for serial consoles
> =20
> Note that the source being build is different and it would have been
> better to just change the
> pressure regulaiton code but this was a weekend 'fun' project. Also,
> yes I fetched the code before
> building with the set of BB_PRESSURE_MAX_CPU values.
> =20
> There wasn't much of a difference as shown in the graph and data
> below.
> =20
> I could try the same thing for world builds but I'm not sure that's
> worthwhile.
> I still plan to construct a test of PSI regulation using some -native
> recipes that invoke stress-ng
> enough to cause sustained (CPU or IO) pressure and then test if a new
> task will ALWAYS be prevented
> from running until the pressure subsides.=20

Thanks for checking that, it is helpful to rule things out. I think the
bigger question was whether we needed to adjust the pressure values and
whether the autobuilder is under-utilising. I'm surprised and slightly
suspicious when the graphs have correlation that good btw :)

Cheers,

Richard

> =20


--=-7Gy4Np08U7uH2hkPzDjs
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head>

  <style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head>
  <body><div>On Thu, 2024-02-15 at 18:06 -0500, Randy MacLeod wrote:</div><=
blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fc=
f solid;padding-left:1ex"><div> </div><div class=3D"moz-cite-prefix">On 202=
3-11-10 9:06 a.m., Martin Jansa wrote:<br> </div><div> <br></div><blockquot=
e type=3D"cite" cite=3D"mid:CA+chaQc3jWaE0Bto1MQFf45bUVdY_8UvAb9N1vFM=3DA1-=
Q_RnGA@mail.gmail.com" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf =
solid;padding-left:1ex"><div> </div><div dir=3D"ltr">I forgot to include [R=
FC] tag in the subject, because these changes might be a bit controversial.=
 <div><br> </div> <div>From my testing:</div> <div><a href=3D"https://urlde=
fense.com/v3/__https://github.com/shr-project/test-oe-build-time/commit/d51=
11f4472ac397c0f1197eb6366ac7d2e56453f__;!!AjveYdw8EvQ!f35PVorsjRHzPeCdLVCit=
tHJcXcQTibeF0q5nqa0CcWnxVr6Zdu3-DT7IpTT6Q1miq7Pyxk8DDBJq1Nij5jI1m3znH8$" mo=
z-do-not-send=3D"true">https://github.com/shr-project/test-oe-build-time/co=
mmit/d5111f4472ac397c0f1197eb6366ac7d2e56453f</a></div> <div>the reasonable=
 pressure values for 2.0 (in kirkstone) and 2.6 (in nanbield) are significa=
ntly different due to these changes in PSI calculation and logic so while 1=
000 was reasonable value for my system in 2.0, I need 100000 with 2.6.</div=
> <div><br> </div> <div>I've backported these changes long time ago for my =
local builds to use the same PSI values for all builds.</div> <div><br> </d=
iv> <div>And the controversy is that backporting these will change the expe=
cted values (so kind of change in behavior which might not be suitable for =
stable release). But the commits make it sound as a bug in the logic, so we=
 can also consider them as bug fixes.</div> <div><br> </div> <div>The chang=
e in expected pressure values was reported in:</div> <div><a href=3D"https:=
//urldefense.com/v3/__https://lists.openembedded.org/g/bitbake-devel/messag=
e/14942__;!!AjveYdw8EvQ!f35PVorsjRHzPeCdLVCittHJcXcQTibeF0q5nqa0CcWnxVr6Zdu=
3-DT7IpTT6Q1miq7Pyxk8DDBJq1Nij5jICLP93rQ$" moz-do-not-send=3D"true">https:/=
/lists.openembedded.org/g/bitbake-devel/message/14942</a><br> </div> <div><=
br> </div> <div>If it's not a bug to be fixed in 2.0 then maybe we should m=
ention different PSI values in release notes for nanbield (I know I'm too l=
ate for that).</div> <div><br> </div> <div>Regards,</div> </div><div> </div=
></blockquote><div> </div><p>So people were suggesting that the slow YP AB =
times might be due to PSI regulation.<br> <br> On a 24 core system, I built=
 core-image-minimal with the original code <br> from before Chen's commit i=
n August 2023 <br> </p><div> </div><p>poky.git<br> $ git log --oneline -2 6=
53ff4d85cbaf53627f7978b06c1f025ac4694e2<br> 653ff4d85c bitbake: runqueue.py=
: fix PSI check logic <br> ac5512b0ac bitbake: fetch2: add Google Cloud Pla=
tform (GCP) fetcher&nbsp;&nbsp;&nbsp; &lt;---- Old<br> </p><div> </div><p><=
br> </p><div> </div><p>and with current master ~ Feb 2024 :</p><div> </div>=
<p>$ git log --oneline -2 <br> 9382d731bd bash: nativesdk-bash does not pro=
vide /bin/bash so don't claim to &lt;----- New<br> 0fe85ce0c6 busybox: Expl=
icitly specify tty device for serial consoles <br> </p><div> </div><p>Note =
that the source being build is different and it would have been better to j=
ust change the<br> pressure regulaiton code but this was a weekend 'fun' pr=
oject. Also, yes I fetched the code before<br> building with the set of BB_=
PRESSURE_MAX_CPU values.<br> </p><div> </div><p>There wasn't much of a diff=
erence as shown in the graph and data below.</p><div> </div><p>I could try =
the same thing for world builds but I'm not sure that's worthwhile.<br> I s=
till plan to construct a test of PSI regulation using some -native recipes =
that invoke stress-ng<br> enough to cause sustained (CPU or IO) pressure an=
d then test if a new task will ALWAYS be prevented<br> from running until t=
he pressure subsides. <br> </p></blockquote><div><br></div><div>Thanks for =
checking that, it is helpful to rule things out. I think the bigger questio=
n was whether we needed to adjust the pressure values and whether the autob=
uilder is under-utilising. I'm surprised and slightly suspicious when the g=
raphs have correlation that good btw :)</div><div><br></div><div>Cheers,</d=
iv><div><br></div><div>Richard</div><div><br></div><blockquote type=3D"cite=
" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1e=
x"><div> </div></blockquote><div><br></div><div><span></span></div></body><=
/html>

--=-7Gy4Np08U7uH2hkPzDjs--

