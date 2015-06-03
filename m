Return-Path: <ross.burton@intel.com>
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com
	[209.85.192.46])
	by mail.openembedded.org (Postfix) with ESMTP id 8C53865C9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 21:47:32 +0000 (UTC)
Received: by qgep100 with SMTP id p100so10037047qge.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 14:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=CQGUwe9eQYzV6qvWmtOo3uAfqzzd5fVbEq+MDRH92kw=;
	b=Fy4rsuX0ybN+0G63Mcc0zMxD6ujSWDxomjKT3gJIiL5zrT32CHQ7MyyVY0/+C2QEOy
	7MppgOIrLtg2yaH2xVKxjaxzz3gCJ3lgunq0369L5WjP5gTmsKas0rS2SBhjkFBZdEgR
	9a32sOCDR2699LGNFT5lKR0f6fNRyqA9SCMP38u5gm3fpI4tT05A4fO/qh06JLz31JCF
	5xJcQxd1p5bwGgHSUSq95QXXd3mK3562J0AZpQQ1uMXSnknn/2vhlzrYzwOwichE+s6T
	blB2uAoX9+xLc/oTv2L3BcLYwCFbyBbCygybNvW5RieYbXo0rblopLLJd/7RKKq4SGUw
	WKFw==
X-Gm-Message-State: ALoCoQkeMza4TxCNonOBSpTHaNNjhfw75EcnUpLlATdFsVC1V9EQRPESg8Ph3fv+zHVp4oeytb5+
X-Received: by 10.55.43.130 with SMTP id r2mr45541724qkr.14.1433368053966;
	Wed, 03 Jun 2015 14:47:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Wed, 3 Jun 2015 14:47:13 -0700 (PDT)
In-Reply-To: <CADL-HDiPMeR7zdiW99j10TEAhjzUzaqzQkMLnvOWiqdSfPRMHA@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
	<CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
	<CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
	<CAJTo0LYHok7aqeq5VG-bBq6L=tge_k40i2urOPp9=KWvLf894w@mail.gmail.com>
	<CADL-HDiPMeR7zdiW99j10TEAhjzUzaqzQkMLnvOWiqdSfPRMHA@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 3 Jun 2015 22:47:13 +0100
Message-ID: <CAJTo0LYwFRrNT9xnjd43c4+_dMTJvMhAsbJTOdW4e6YXKJP3yg@mail.gmail.com>
To: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Library not getting installed to intended path
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
X-List-Received-Date: Wed, 03 Jun 2015 21:47:34 -0000
Content-Type: multipart/alternative; boundary=001a1147afb0b07f340517a4016b

--001a1147afb0b07f340517a4016b
Content-Type: text/plain; charset=UTF-8

On 3 June 2015 at 20:24, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:

> ERROR: QA Issue: non -dev/-dbg/-nativesdk package contains symlink .so:
> gst-plugin-linux-user path
> '/work/core2-32-poky-linux/gst-plugin-linux-user/git+master-r0/packages-split/gst-plugin-linux-user/lib/gstreamer-0.10/libgstfl.so'
> ERROR: QA run found fatal errors. Please consider fixing them.
>

That QA test is over-keen and that's a false-positive, but the real fix is
in your makefile.  Pass -module -avoid-version to libtool as you're
building modules, not libraries.

Ross

--001a1147afb0b07f340517a4016b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 3 June 2015 at 20:24, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mail=
to:yogesh.bit2006@gmail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>ERROR: QA Issue: =
non -dev/-dbg/-nativesdk package contains symlink .so: gst-plugin-linux-use=
r path &#39;/work/core2-32-poky-linux/gst-plugin-linux-user/git+master-r0/p=
ackages-split/gst-plugin-linux-user/lib/gstreamer-0.10/libgstfl.so&#39;</di=
v><div>ERROR: QA run found fatal errors. Please consider fixing them.</div>=
</blockquote><div><br></div><div>That QA test is over-keen and that&#39;s a=
 false-positive, but the real fix is in your makefile.=C2=A0 Pass -module -=
avoid-version to libtool as you&#39;re building modules, not libraries.</di=
v><div><br></div><div>Ross=C2=A0<br></div></div></div></div>

--001a1147afb0b07f340517a4016b--
