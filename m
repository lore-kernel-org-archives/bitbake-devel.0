Return-Path: <ross.burton@intel.com>
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com
	[209.85.220.180])
	by mail.openembedded.org (Postfix) with ESMTP id C3A38757C4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 16:56:21 +0000 (UTC)
Received: by qkoo18 with SMTP id o18so9025310qko.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 09:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=6ygld4ScZQg3XN22arLC9oTFvwBEEiVmLNpybkxOyPw=;
	b=OvUnPg+2Ku3+x8SAaVhIASn6JlYUPRjPJnODxH+gC5aVhSMmBeWlSiwKhZCufD8bum
	zFe784rutj6zEtwOvfgxHpzetOv1lvf2I76U1KYswnWYAC9e6itHQQ+UkRoXcJ/2MQW+
	vy0jPMImOZASXCf+9lnPXUVTlJAN7XMosQo8DEl84bPwCjP1C6nn35oAu8u73T/eybBV
	b1MMNVvAZOmGCJmMB9sqJUwFZhr/FSVOasKIZ4OPb0bMVlOiCwXru0VbWFpT3DIUQdkh
	VRp1Qf5x9kuGnyuGgN8kkYbvn68Ip3AqbzJvIAE2G9LW0ZfRXcOdvUJ5KNhNwno43UCe
	DeEQ==
X-Gm-Message-State: ALoCoQlEVcWrUMB3wCwFX1r+vAbRyW8W4k3C0RiOFzCrXUd5Bl0JqYtDmoilhWI2/jzk5AmR2SSp
X-Received: by 10.140.89.104 with SMTP id u95mr25615011qgd.15.1433350582961;
	Wed, 03 Jun 2015 09:56:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Wed, 3 Jun 2015 09:56:02 -0700 (PDT)
In-Reply-To: <CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 3 Jun 2015 17:56:02 +0100
Message-ID: <CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
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
X-List-Received-Date: Wed, 03 Jun 2015 16:56:23 -0000
Content-Type: multipart/alternative; boundary=001a11c135f65625d105179ff008

--001a11c135f65625d105179ff008
Content-Type: text/plain; charset=UTF-8

On 3 June 2015 at 16:37, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:

> AC_PREFIX_DEFAULT(/usr/lib/gstreamer-0.10)
> libdir='/usr/lib/gstreamer-0.10'
>

Yeah, don't do that.  Do this instead:

gstlibdir = $(libdir)/gstreamer-0.10
gstlib_LTLIBRARIES = ...

You don't need to override do_install as automake's install will do the
right thing if you inherit autotools.

Ross

--001a11c135f65625d105179ff008
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 3 June 2015 at 16:37, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mail=
to:yogesh.bit2006@gmail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>AC_PREFIX_DEFAULT=
(/usr/lib/gstreamer-0.10)</div><div>libdir=3D&#39;/usr/lib/gstreamer-0.10&#=
39;</div></blockquote></div><br>Yeah, don&#39;t do that.=C2=A0 Do this inst=
ead:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">g=
stlibdir =3D $(libdir)/gstreamer-0.10</div><div class=3D"gmail_extra">gstli=
b_LTLIBRARIES =3D ...</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">You don&#39;t need to override do_install as automake&#39;=
s install will do the right thing if you inherit autotools.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a11c135f65625d105179ff008--
