Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C415C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 16:33:07 +0000 (UTC)
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
 by mx.groups.io with SMTP id smtpd.web10.1180.1740069181395557612
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 08:33:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bhofmYTU;
 spf=pass (domain: gmail.com, ip: 209.85.160.194, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-471f2e1bea9so10655331cf.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740069180; x=1740673980; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=evMQtR5VXskd2KaoxSlryM1deRxkpsPzv+JZazjCKTA=;
        b=bhofmYTUg0OYzr8hNxK5doHBNpWmxTrryRp+mXVBm+hQ/RsjmNsjbeelXvGzZ/DH0n
         UYFdMdPtqY282OZoDJXf0G2AlTK3CNg0Y4yEoENuc+G9z3V/dI++NzOPIcOYucOJNyOj
         ZVkt/+Nradj4Eh0q2zNK/VJUtQoFcanx+VITvLZXlTMJGPjWPiVT5OLrQGfiKtJTqnMD
         TsDA5SIZldRuDIlmY9o5/eyR5P/MNBlFifXQomcWLXVrWxSbyg1yCIP3YFqZ/S2O+/iN
         sMkFmzPP9ee+fVrstM1ynFXfAPy7erzcanyNPKlAmCGhHV/vpRqrCKMTsg1+csT3xJP1
         9VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069180; x=1740673980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evMQtR5VXskd2KaoxSlryM1deRxkpsPzv+JZazjCKTA=;
        b=VI49KH9e2MPfctBpI3mHatJJTf90jJ4irzjcelEXHJxqrB5F1Qgry/iLWp5rxUeUwi
         dQQXlGXXYYrwdDpJuQLwImUktVXb0BPSBfUw4sK4LNLJjZvA/acFptW4tQPaDfh5u5t7
         LufZEJKvx27sQySRZyWPG6pbSgceAt//vpm42hJtpXLJ6Zyq/YdZMerRGie1Y6OrVdf0
         vGkjS/uXjrfQI1Cj6Y4DCslni0+seray0FF429QIXaWnJ7CDJOrcYtzHcs3rSni9faBK
         vYtO7G9r5jVakiMssXVnTbI1zxo+nnUJ4clb7WNWK4Ji3//xTXHWoKZioS7Yk0S4EGEg
         n61g==
X-Gm-Message-State: AOJu0Yy7jd8M4+lvlm4bwvdV5VdVp1cVg29+uPr8Pf5lds1q3SWOHMNT
	OCWwMuTWcfoSKUNkOABVWChIe+K+jRvB9t0k1sgsPRp6mmXBl3X6qd1o6E7ysu0cNAU0RdTS5ys
	3rhNcYmg3mlnK/q9a9KGBiUsDj1E=
X-Gm-Gg: ASbGncso/fbmigy7AlMduyB5bxzjryxBOLn0HPvKPBZyOrIPkqz7s0z3z55QBoKDI1b
	Cl4f4vFgMb5E4/EKLEyz0F1hsW/ldLS57fsDyPSLvmEerFQ5UCjMrNsJd4YQkUXW+iCBuxQQ+
X-Google-Smtp-Source: AGHT+IG3aMv6XDKpa96scKPn5DGa+LfNR8zaDtsfG7UeBJnKM1u470gmaLYDDlypgx36/kOoYWQqhkwMwWEhFhaJr8M=
X-Received: by 2002:a05:6214:518f:b0:6e6:6240:afb with SMTP id
 6a1803df08f44-6e69749d5c9mr123658846d6.3.1740069180325; Thu, 20 Feb 2025
 08:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20250220143030.12982-1-eric.meyers@arthrex.com>
 <20250220143030.12982-2-eric.meyers@arthrex.com> <CANNYZj_d1vuPc9M6+6WBnrQ-RRDRArngsDxSi_8ghjeK=pDO4A@mail.gmail.com>
In-Reply-To: <CANNYZj_d1vuPc9M6+6WBnrQ-RRDRArngsDxSi_8ghjeK=pDO4A@mail.gmail.com>
From: Eric Meyers <eric.meyers15310@gmail.com>
Date: Thu, 20 Feb 2025 10:32:52 -0600
X-Gm-Features: AWEUYZlxPF8EcUIFb4oHK8Kb2szwex64iBssS2BC4EK5MzNHelqmXx6-xqC1E6g
Message-ID: <CA+cKJ+Gvb8FjFwTnjT4EFDhU-c-gQYA8G34-wAEmcYMYSyBQMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Chuck Wolber <chuckwolber@gmail.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: multipart/alternative; boundary="00000000000060d031062e956dbb"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 16:33:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17261

--00000000000060d031062e956dbb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:48=E2=80=AFAM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:
>
> I'm broadly ok with this (except the question below), but it needs to
> be lgtm'd by real npm fetcher users.
>
> Does npmrc contain secrets? Would copying it to some tmpdir put the
> secrets at risk?
>
> Alex
>

It *could* have authentication credentials in plaintext, but ultimately
this is up to the user if they provide them in their .npmrc file within
their home directory. See:


https://docs.npmjs.com/cli/v9/configuring-npm/npmrc#auth-related-configurat=
ion

The way I'm using it now requires me to create a base64 encrypted string
based on the input string of "<username>:<API_KEY>" and insert this as the
"_auth" value in the .npmrc file, but there are multiple ways to provide
credentials.

The only reason I copied the .npmrc file into the tmp directory was to
avoid losing any user-provided configs passed into the environment (I could
have taken the opposite approach and modified the user's .npmrc file
instead, but didn't think that was desirable) - an example of this is
within the create_npm.py function upstream in the poky repo:


https://github.com/yoctoproject/poky/blob/ca289e5d853c5ef980ad070eab0d20f97=
3fcdb7c/scripts/lib/recipetool/create_npm.py#L98

FWIW, the wget fetcher relies on a netrc file in a user's home directory in
a similar fashion, which uses username/password in plaintext to insert a
basic auth header to a URL:


https://github.com/yoctoproject/poky/blob/ca289e5d853c5ef980ad070eab0d20f97=
3fcdb7c/bitbake/lib/bb/fetch2/wget.py#L399

--00000000000060d031062e956dbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">On Thu,=
 Feb 20, 2025 at 9:48=E2=80=AFAM Alexander Kanavin &lt;<a href=3D"mailto:al=
ex.kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt; wrote:<br>&gt;<br>&gt;=
 I&#39;m broadly ok with this (except the question below), but it needs to<=
br>&gt; be lgtm&#39;d by real npm fetcher users.<br>&gt;<br>&gt; Does npmrc=
 contain secrets? Would copying it to some tmpdir put the<br>&gt; secrets a=
t risk?<br>&gt;<br>&gt; Alex<br>&gt;<br><br>It <i>could</i>=C2=A0have authe=
ntication credentials in plaintext, but ultimately this is up to the user i=
f they provide them in their .npmrc file within their home directory. See:<=
br><br>=C2=A0 =C2=A0 <a href=3D"https://docs.npmjs.com/cli/v9/configuring-n=
pm/npmrc#auth-related-configuration">https://docs.npmjs.com/cli/v9/configur=
ing-npm/npmrc#auth-related-configuration</a><br><br>The way I&#39;m using i=
t now requires me to create a base64 encrypted string based on the input st=
ring of &quot;&lt;username&gt;:&lt;API_KEY&gt;&quot; and insert this as the=
 &quot;_auth&quot; value in the .npmrc file, but there are multiple ways to=
 provide credentials.<br><br>The only reason I copied the .npmrc file into =
the tmp directory was to avoid losing any user-provided configs passed into=
 the environment (I could have taken the opposite approach and modified the=
 user&#39;s .npmrc file instead, but didn&#39;t think that was desirable) -=
 an example of this is within the create_npm.py function upstream in the po=
ky repo:=C2=A0</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">=C2=A0 =C2=
=A0 <a href=3D"https://github.com/yoctoproject/poky/blob/ca289e5d853c5ef980=
ad070eab0d20f973fcdb7c/scripts/lib/recipetool/create_npm.py#L98">https://gi=
thub.com/yoctoproject/poky/blob/ca289e5d853c5ef980ad070eab0d20f973fcdb7c/sc=
ripts/lib/recipetool/create_npm.py#L98</a><br><br>FWIW, the wget fetcher re=
lies on a netrc file in a user&#39;s home directory in a similar fashion, w=
hich uses username/password in plaintext to insert a basic auth header to a=
 URL:<br><br>=C2=A0 =C2=A0 <a href=3D"https://github.com/yoctoproject/poky/=
blob/ca289e5d853c5ef980ad070eab0d20f973fcdb7c/bitbake/lib/bb/fetch2/wget.py=
#L399">https://github.com/yoctoproject/poky/blob/ca289e5d853c5ef980ad070eab=
0d20f973fcdb7c/bitbake/lib/bb/fetch2/wget.py#L399</a><div><br></div><div><b=
r></div></div></div></div></div>

--00000000000060d031062e956dbb--

