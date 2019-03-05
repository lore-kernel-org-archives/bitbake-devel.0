Return-Path: <ross.burton@intel.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id 76C8D7C8D4
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Mar 2019 11:06:52 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id 188so3861330itb.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 Mar 2019 03:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ybdLbS3PnFA7R+a7bUbI0mpG4O2UW3jLxIRCw9jFY5Q=;
	b=lAFBpKPl6ojkpuIxZwAmKerF3INlNcxqZUS7tsL0I7NOpvA7su8Ry7Swhv+WE9e4Vu
	Dtn+wZABrLpl/yiaUPO7g1KiYMfH1sgAKbP5cpxjkFbQgMxB5bzshDqNgyQ21Ie+CWzf
	Wi3CwZ6odYyXmZFbLXLrB/fJAW90usdam41ZRpUJzyIlN/EOeT+ZkhAH/GqsrufjReIz
	6wSAdp5bJIUcLw2fjXvNPX9yWHvaNeI4LTxdN+99ZuQ5e11G7eY+2gvE0cw+Vsk/UF0Y
	0DbuIcSZhC2Id27ZzSLZes3DIKq0LGhAgmc2+gvFmGJcedkHmVgq0+65lqOBMNZtK1Op
	HpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ybdLbS3PnFA7R+a7bUbI0mpG4O2UW3jLxIRCw9jFY5Q=;
	b=MSn+XJRFOl8uJdnKHSflUZHiz2R8m0T5x9iEmY8G7+iKdQNcU8HUCHTJGgeoPOcMvd
	d1A2d2tUL7h0T2y9O4udncNOn46FmGK51oiQuV55F+T4+cA28Q9aP4zkgnC2SP92fzTo
	MeUDk34U5yH1nfQSZLdKji6gMaO0kWK2osvkdmM2KN1r8Z8JWJ5Wc+Iq+gYQNDzBlJZT
	1EOh9Um6PiTmL6Myksaq/fEZKL33D2inY82hRQ/z0G5GAY2btWsLRr7fBznprpysoD1M
	3uqkB3l6WCjgHMwBxBNbKUoyfgY79WJeFdCnLAwiO+VrZVdH0s3jvYo/ovl4UWjNupNc
	FeCg==
X-Gm-Message-State: APjAAAW0bDAx0UGPiKqGx3lyqN79g+c5HXPiAj2jlXaicUkQbzk/6q2A
	xLNE2LDmpwjN85eWgKytylY6U2C0cUQULt7P5zjHlQ==
X-Google-Smtp-Source: APXvYqyDRXbTRexENEOor67zqq5u4J+3Ak5QsSkr63Sfq3KEn1fyAd3+agVG05oG7wau9mgYdrhvB+9tceONuICZ6eI=
X-Received: by 2002:a05:6638:348:: with SMTP id x8mr793481jap.79.1551784013233;
	Tue, 05 Mar 2019 03:06:53 -0800 (PST)
MIME-Version: 1.0
References: <CAPybu_1GLgMMBysaCD0GDiPSmJr6jEqVptzX6+DQmU7ZBOigMA@mail.gmail.com>
	<CAJTo0LYEFB4GyiyP=JK3vj2vFqzT1tzJiERKqezb9BO3N_K25g@mail.gmail.com>
	<CAPybu_2fbDkuM_kpX4ZbyPw8B8QfS2FEoCXSg1z7gFvfF=gyBg@mail.gmail.com>
In-Reply-To: <CAPybu_2fbDkuM_kpX4ZbyPw8B8QfS2FEoCXSg1z7gFvfF=gyBg@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 5 Mar 2019 11:06:41 +0000
Message-ID: <CAJTo0LbXz_d+oNrHxrE2M3nOKeZh0C7-bz76OqHS0_zgkTHk6w@mail.gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Daniel Gomez <daniel@qtec.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Two recipes providing the same .so... How it should not be done :)
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
X-List-Received-Date: Tue, 05 Mar 2019 11:06:52 -0000
Content-Type: text/plain; charset="UTF-8"

That is horrible and they should be ashamed.  Can you share the
complete recipe, as this *should* be a fairly trivial switcharoony.

Ross

On Tue, 5 Mar 2019 at 11:00, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
>
> HI Ross
> On Tue, Mar 5, 2019 at 11:58 AM Burton, Ross <ross.burton@intel.com> wrote:
> >
> > Does they literally just provide a libgl.so and no headers, etc?
>
> It provides:
>
> /usr/lib/libGL.so.1.2.0
> /usr/lib/libGL.so.1
>
>
> >
> > Ross
> >
> > On Fri, 1 Mar 2019 at 11:29, Ricardo Ribalda Delgado
> > <ricardo.ribalda@gmail.com> wrote:
> > >
> > > Hello
> > >
> > > I have a build system that supports some aarch64 machines. For most of
> > > the them, the only difference is the kernel configuration, kernel
> > > version.
> > >
> > > I am using multiconfig on my build server and the build goes really
> > > fast thanks to all the shared binaries/artifacts.
> > >
> > > But I have a problem adding a new machine. This machine is also
> > > aarch64, with a special kernel (nothing new here), but in this case
> > > the vendor provides a binary .so for libgl that is required to get
> > > hardware acceleation.
> > >
> > > I could .bbappend mesa and on the installation part replace libgl with
> > > the new .so. But then everything that depends on mesa needs to be
> > > rebuilt for that machine and I could not use multiconfig.
> > >
> > > Instead I have created a new recipe: mesa-gl-replace.bb that has the
> > > file. This breakes completely the design of OE, but works.
> > >
> > > Some snipsets of the "magic" to make it work:
> > >
> > > #Force that the version is allways higher than the one from mesa:
> > > PE = "5"
> > >
> > > #Rprovide the same as mesa
> > > RPROVIDES_libgl-mesa += "libgl"
> > >
> > > #Do not overwrite pkgdata of mesa
> > > PACKAGEFUNCS_append = " rm_pkgdata_runtime"
> > > rm_pkgdata_runtime() {
> > > rm -rf ${WORKDIR}/pkgdata/runtime/*
> > > rm -rf ${WORKDIR}/pkgdata/shlibs2/*
> > > }
> > >
> > > #Keep this on machine
> > > PACKAGE_ARCH = "${MACHINE_ARCH}"
> > >
> > > #Make sure we are not saved as providers for libgl
> > > PRIVATE_LIBS = "libGL.so.1"
> > >
> > > #Avoid sanity checks
> > > read_subpackage_metadata () {
> > > }
> > >
> > >
> > > If your eyes have not fallen as this point, this means you have a lot
> > > of tolerance for crappy code, congrats :)
> > >
> > > Now the question. Is there a better way to do this?
> > >
> > > PS: I already tried and failed with update_alternatives
> > >
> > >
> > > Best regards!
> > >
> > >
> > > --
> > > Ricardo Ribalda
> > > --
> > > _______________________________________________
> > > Openembedded-core mailing list
> > > Openembedded-core@lists.openembedded.org
> > > http://lists.openembedded.org/mailman/listinfo/openembedded-core
>
>
>
> --
> Ricardo Ribalda

