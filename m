Return-Path: <kergoth@gmail.com>
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
	[209.85.167.193])
	by mail.openembedded.org (Postfix) with ESMTP id 858317C26B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 16:47:37 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id t204so9437362oie.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 08:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mentor-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=lu+bFBkxLrYFk6p4HssHzSEvKKLQGq5gYn5tV8Cdc0U=;
	b=MRaB8Mh9GcP5hUBEugpSTiLB0AiPJtXYGjNqxK+bO9smKCUhQzGOy+2VQTyOURB6yk
	FeQk85WLonrN7ZhxS0+CVti7unJDMRH1eReGgoH/ioe1674KW6pHQM1Nzgh5LXkJADUj
	8SvV/PTN7Tio4b8Dqh4f4x3GdJVRBff2PzXHTeK5wkOKnN0Uc8zOSCDv5xAUNSYgJKth
	pqXpUY5xrvGXC9TCv26eWHnDOItiFzJilqxr3XmjrLkv4eV1EjYg5MdU3sUlWGz8tN8b
	EAzuVB3cIcR9GubM/kyiF/r7isv+EQ5k3N4p4rr6xzFBdR+vNZkk+1gb75qs8KLU3iwH
	MNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=lu+bFBkxLrYFk6p4HssHzSEvKKLQGq5gYn5tV8Cdc0U=;
	b=KjdyDFvI7XRkg2s6JkR154uum4sCtKheKOILRgpv9NGUrue5HtfaflxVJ6IdV9uJQH
	JYqjZ7bdM/O9H4NTkddXNxpPeTfcN1SV9giOU5W3vGygK1YZUqHJOML/s/CuHF6BIVwJ
	f+r+/wGFo/Y5Kc95MuY8atTxGha5Q3LmdlpWdT0FF5M7zyCneYX3ZD0Ee8exOUE/ohmJ
	jzxdPLktYVEOhpmzlmG9iSPpZl84TKs16p98Z96mzZcSUXyCw69JaH68HDxwjj6teZJs
	0ZeqO7kJS0DM+PYUsg+pHlR93hhPx5UDbvey7RM2lPz3Ij5Zn9r4bxnSvT7RNsaBpPyJ
	ylqA==
X-Gm-Message-State: AJcUukdpISJYIKi0k9rlvq2YXEUzIrAG8zzINIITrFa7sY9s18CXaeKC
	x7xuhvW+8ay5ldlwImoEliegVLCbvzKgFvAhBFdHOv9P
X-Google-Smtp-Source: ALg8bN6YmGUb8n14GBbqUPmW8pd1Nj0FB2Cxboa50o6UFXEgdZTLjmZFYJ3rlg0wGYdSctgY/JuNcHICU05gUpS8N5g=
X-Received: by 2002:aca:d09:: with SMTP id 9mr498111oin.19.1547830058007; Fri,
	18 Jan 2019 08:47:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547829050.git.chris_larson@mentor.com>
In-Reply-To: <cover.1547829050.git.chris_larson@mentor.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 18 Jan 2019 09:47:26 -0700
Message-ID: <CABcZAN=X_fjajrhBoo7VBhdyvn1qrAmnHUrzWtgP3Vs07hRgCg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Only try to expand refs to valid variable names
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
X-List-Received-Date: Fri, 18 Jan 2019 16:47:37 -0000
Content-Type: multipart/alternative; boundary="000000000000c7be5e057fbe44ce"

--000000000000c7be5e057fbe44ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 9:46 AM Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> This aligns the behavior of expansion with the recipe parser, only
> attempting to expand references to valid variable names. This avoids
> adding references for things like `${foo#${TOPDIR}}` to our vardeps
> without imposing much additional processing overhead beyond the change
> to the expansion regexp.
>
> YOCTO #12987
>

There=E2=80=99s no statistically significant performance impact to bitbake =
-p,
bitbake-selftest, or my test image builds, only typical run-to-run
variation.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000c7be5e057fbe44ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Jan 18, 2019 at 9:46 AM Christoph=
er Larson &lt;<a href=3D"mailto:kergoth@gmail.com">kergoth@gmail.com</a>&gt=
; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">From: Christo=
pher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com" target=3D"_blank=
">chris_larson@mentor.com</a>&gt;<br>
<br>
This aligns the behavior of expansion with the recipe parser, only<br>
attempting to expand references to valid variable names. This avoids<br>
adding references for things like `${foo#${TOPDIR}}` to our vardeps<br>
without imposing much additional processing overhead beyond the change<br>
to the expansion regexp.<br>
<br>
YOCTO #12987<br></blockquote><div><br></div><div>There=E2=80=99s no statist=
ically significant performance impact to bitbake -p, bitbake-selftest, or m=
y test image builds, only typical run-to-run variation.</div></div>-- <br><=
div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D=
"ltr"><div><div dir=3D"ltr"><div>Christopher Larson<br>kergoth at gmail dot=
 com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engi=
neer, Mentor Graphics</div></div></div></div></div></div></div></div>

--000000000000c7be5e057fbe44ce--
