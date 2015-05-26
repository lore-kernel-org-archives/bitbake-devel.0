Return-Path: <ross.burton@intel.com>
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com
	[209.85.220.180])
	by mail.openembedded.org (Postfix) with ESMTP id 5BF556AC12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 14:22:22 +0000 (UTC)
Received: by qkx62 with SMTP id 62so89864616qkx.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 07:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=OgCas2IggtP3B06az/hCIcTJM4m33PFhiw0dREsrSTI=;
	b=SJBRYQLsveZQ6PDdpmiAzVUYxLAkgFkDi6Vw2ZJ2eMJjbufPrgjUuP230zCjbNXslu
	/2uk5kLu7ihHqgx2M0tofP6upyaBljgiPprZQ1wWhpGPFQWkDd/2tXOW90tYiCYlfPro
	+21epb/o18g2ITp1HG6Uz9wDAH0jCVgxI2H63lViz55Nr6W/BhZDGSTkD1khgGsP28kP
	MmVz9DMx4leB4EXjS7Fiyx+Iyw/yGsf8Tjww6uC4QVENjTeL6NA4wO/qdcOpiO4CSqpS
	fw1FiNld/AbYgHlC9FI3ssvkic+oR5T7hGu/EHsaJZQuc/28jcAk3fxY8ozQLyZxabTg
	gR7g==
X-Gm-Message-State: ALoCoQlsPWrLNEhDTYzAYdacWidpyvXRj7MBqYUq0atVuL+wlp6pHg9VrkgQ3jM0ETE+Qv1dktSg
X-Received: by 10.140.235.19 with SMTP id g19mr12755679qhc.52.1432650143489;
	Tue, 26 May 2015 07:22:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Tue, 26 May 2015 07:22:03 -0700 (PDT)
In-Reply-To: <CADL-HDgAGgapu7xNC9N0zMutZ8qOytSZv4+zNNUp04j5Bx8dSA@mail.gmail.com>
References: <CADL-HDgAGgapu7xNC9N0zMutZ8qOytSZv4+zNNUp04j5Bx8dSA@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 26 May 2015 15:22:03 +0100
Message-ID: <CAJTo0LbbmGMuDXKJcqg+QPnzT-EcPQoTRViYRVxnTEHXvs+rXA@mail.gmail.com>
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
X-List-Received-Date: Tue, 26 May 2015 14:22:23 -0000
Content-Type: multipart/alternative; boundary=001a11376dace3f74e0516fcdac2

--001a11376dace3f74e0516fcdac2
Content-Type: text/plain; charset=UTF-8

On 26 May 2015 at 14:10, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:

> and I have also added "gst-plugin-base" to packagegroup bb file of my
> project but still gst-plugins-base libs are not going to rootfs. Please
> help.
>

gst-plugins-base is an empty package.  If you want all plugins. install
gst-plugins-base-meta.

Ross

--001a11376dace3f74e0516fcdac2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 26 May 2015 at 14:10, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mail=
to:yogesh.bit2006@gmail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>and I have also a=
dded &quot;gst-plugin-base&quot; to=C2=A0packagegroup bb file of my project=
 but still gst-plugins-base libs are not going to rootfs. Please help.</div=
><div></div></blockquote></div><br>gst-plugins-base is an empty package.=C2=
=A0 If you want all plugins. install gst-plugins-base-meta.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a11376dace3f74e0516fcdac2--
