Return-Path: <ashcharles@gmail.com>
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com
	[209.85.213.181])
	by mail.openembedded.org (Postfix) with ESMTP id 6C64075669;
	Fri, 29 May 2015 05:46:17 +0000 (UTC)
Received: by igbyr2 with SMTP id yr2so6364480igb.0;
	Thu, 28 May 2015 22:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=0o6iGJ+0LL/kfBoYVYP+xBJt7DBVfvKE78APNDdG/+g=;
	b=K3kc/YqbJD9te3VqFr8XWEthGyM4U8MhdrZYvD3Y23iZMNI1SXVTkwiJyLBd+g5tGU
	V3N6oJrdP+ch93MQAcsqOy2WZe62uZdROoJ+ziryd/mjRI805yjiu5SkZuidlkYv7h1r
	y3bcidN1XByS17GNT0QhJWwFjyukS1BPqgbDnG4jpeLLSH4aNPsDUEYU1UrLotnlxQ8z
	GGhzzBk/FRbGXoUtvHKg6ok8SkCz4e5c72PhF+ePnDFhYDyPB+Y9gmp8UShkAzN2Tg8i
	cSZD+AR2804lG8qVsBFwu95xhiCKd6plQEDeD0tRYLUKkGiMQOonXRafg7QnQfkDMnaV
	rCRA==
MIME-Version: 1.0
X-Received: by 10.107.31.134 with SMTP id f128mr8058135iof.19.1432878378965;
	Thu, 28 May 2015 22:46:18 -0700 (PDT)
Received: by 10.107.138.134 with HTTP; Thu, 28 May 2015 22:46:18 -0700 (PDT)
Received: by 10.107.138.134 with HTTP; Thu, 28 May 2015 22:46:18 -0700 (PDT)
In-Reply-To: <5567C5B1.7010901@windriver.com>
References: <20150427105100.GB2379@jama>
	<1432309170-5575-1-git-send-email-ashcharles@gmail.com>
	<5567C5B1.7010901@windriver.com>
Date: Thu, 28 May 2015 22:46:18 -0700
Message-ID: <CAK8F28mc2C=r4n42xFmNaxNveectuB8esrkt4M2BkSknH-mFxw@mail.gmail.com>
From: Ash Charles <ashcharles@gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-devel@lists.openembedded.org
Subject: Re: [oe] [PATCH] fetch/hg: Disable checksums for archived downloads
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
X-List-Received-Date: Fri, 29 May 2015 05:46:20 -0000
Content-Type: multipart/alternative; boundary=001a11403efac8e2fd051731fe09

--001a11403efac8e2fd051731fe09
Content-Type: text/plain; charset=UTF-8

> I wonder how did you test the patch, please ? Did you revert the patch:
>  fetch/hg: support submodules ?
Hi Robert,
I tested the patch in a Yocto environment which had a prepopulated
downloads directory. In particular, I had seen the failure described [1]
for vim.
My version of bitbake was slightly older so the submodule patch that was
breaking the mirroring hadn't yet been applied.

[1]
https://www.mail-archive.com/openembedded-devel@lists.openembedded.org/msg41328.html

--Ash

--001a11403efac8e2fd051731fe09
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p>&gt; I wonder how did you test the patch, please ? Did you revert the pa=
tch:<br>
&gt; =C2=A0fetch/hg: support submodules ?<br>
Hi Robert,<br>
I tested the patch in a Yocto environment which had a prepopulated download=
s directory. In particular, I had seen the failure described [1] for vim.<b=
r>
My version of bitbake was slightly older so the submodule patch that was br=
eaking the mirroring hadn&#39;t yet been applied.</p>
<p>[1] <a href=3D"https://www.mail-archive.com/openembedded-devel@lists.ope=
nembedded.org/msg41328.html">https://www.mail-archive.com/openembedded-deve=
l@lists.openembedded.org/msg41328.html</a></p>
<p>--Ash</p>

--001a11403efac8e2fd051731fe09--
