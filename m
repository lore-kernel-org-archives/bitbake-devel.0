Return-Path: <ross.burton@intel.com>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
	[209.85.220.175])
	by mail.openembedded.org (Postfix) with ESMTP id 019C8728CB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 21:24:35 +0000 (UTC)
Received: by qkhg32 with SMTP id g32so17007350qkh.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 14:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=MCHuurC2g5F0Eb+e++o0v7og1P8vB6lwaPxMru16xPo=;
	b=fapqrbo4EhLPz7If2WL75NNLaySPC2mHDtYY+YqkN12smm6yUdlu0sG3c1zJ3hksDb
	SfKZb9h8yQHtT7OtWAS34v7X6p36jNyHR17Vbuel49W4zQ0/K4l9OybLau0Gxr3f31/l
	bY5RLiSF4w1qusGWAmPEBnLPY6/9jMh7MYYVszt3CxxXAWSRWk47MvuS1PMdqfOA8+Ah
	maB8rXzxcme2dj9AuHlT9OzAhlDEJT1h48yXGW+FOGnTFG6KVSNtDmQoUPooHGLABngk
	rr52jqBY1Vv1d4p3BtuYrkCK1sTmMtTIpzbuRK7JZUzuabz9Mx63+3wl8ORKWZ16Zq6r
	34/g==
X-Gm-Message-State: ALoCoQn1lt6a8TR/RoLYziKws5qnoNzJ6zK334O2O6onS3xi0FnXNyPkYDIwbRs+Ph5/MhHq1qJN
X-Received: by 10.140.43.228 with SMTP id e91mr35606819qga.80.1432675476579;
	Tue, 26 May 2015 14:24:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Tue, 26 May 2015 14:24:16 -0700 (PDT)
In-Reply-To: <556493d8.2687440a.0ded.66ab@mx.google.com>
References: <CADL-HDgAGgapu7xNC9N0zMutZ8qOytSZv4+zNNUp04j5Bx8dSA@mail.gmail.com>
	<CAJTo0LbbmGMuDXKJcqg+QPnzT-EcPQoTRViYRVxnTEHXvs+rXA@mail.gmail.com>
	<556493d8.2687440a.0ded.66ab@mx.google.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 26 May 2015 22:24:16 +0100
Message-ID: <CAJTo0LbQk5EeDTPZ3m_WVYvJQy-jE8DviM1_zcc_94axGnZNfA@mail.gmail.com>
To: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: gst-plugin-base libs not going to rootfs
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
X-List-Received-Date: Tue, 26 May 2015 21:24:38 -0000
Content-Type: multipart/alternative; boundary=001a113a34bcdc3b9e051702c0df

--001a113a34bcdc3b9e051702c0df
Content-Type: text/plain; charset=UTF-8

On 26 May 2015 at 16:40, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:

> Thanks for replying. I have checked that when gst-plugins-base is build,
> it contains complete source and all the libraries are also getting created.
> How come this is an empty package?
> How do I know it's an empty package? I am a novice in bitbake/yocto.
>

The *recipe* builds correctly, but that recipe generates many packages.
You can see what packages have been created by looking in tmp/deploy, and
use rpm/dpkg to inspect the contents.

Ross

--001a113a34bcdc3b9e051702c0df
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 26 May 2015 at 16:40, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mail=
to:yogesh.bit2006@gmail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div style=3D"font-fam=
ily:Calibri,sans-serif;font-size:11pt">Thanks for replying. I have checked =
that when gst-plugins-base is build, it contains complete source and all th=
e libraries are also getting created. How come this is an empty package?=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>How do I know it&#39;s an empty=
 package? I am a novice in bitbake/yocto.</div></blockquote></div><br>The *=
recipe* builds correctly, but that recipe generates many packages.=C2=A0 Yo=
u can see what packages have been created by looking in tmp/deploy, and use=
 rpm/dpkg to inspect the contents.</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">Ross</div></div>

--001a113a34bcdc3b9e051702c0df--
