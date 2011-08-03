Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QoR1x-0007Vu-6f
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 04:17:57 +0200
Received: by vxh2 with SMTP id 2so344473vxh.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Aug 2011 19:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=yO93Qf05g3HCeRBJs+PWb3f8lqs5gww/kEGtIEKD5Tg=;
	b=spMuxVldmWSxPqrGzJN0apFTC9y/yMqXxGDy01bK47Clert3PCxgfQiZYba+5nUiJK
	5IFuaTXs5gA4kDAZBBWBB08xQ+mtzXPm39SgYQZqyJKPR9GvMAkNRyFqDYNmHNoCKtzO
	yWxrFzS/Un6YSGLWG7rDWPSbMrlr/qloNiFYc=
Received: by 10.52.24.16 with SMTP id q16mr6698799vdf.227.1312337615053; Tue,
	02 Aug 2011 19:13:35 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.112.194 with HTTP; Tue, 2 Aug 2011 19:13:15 -0700 (PDT)
In-Reply-To: <4E38AE40.5080206@gmail.com>
References: <359B10B9B28B294BAA6405D9320312E0111E93405D@naemmail08.na.leapfrog.com>
	<CABcZANmNObv54E4yW52t1wYt6pyranwAS5Hth8S1cF61ZM5N=g@mail.gmail.com>
	<4E38AE40.5080206@gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 2 Aug 2011 19:13:15 -0700
X-Google-Sender-Auth: SYyuJgivdwxN7DkMHJ4sFBLFpQc
Message-ID: <CABcZAN=HuHuxy_9-X76dEe0j0YoTXXs=+Vj8DB9BDZuBDfwo4g@mail.gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bug with clearing SRCREV cache
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 03 Aug 2011 02:17:57 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 2, 2011 at 7:11 PM, Khem Raj <raj.khem@gmail.com> wrote:
>
> Actually in oe-core, original TMPDIR gets appended
>
> meta/conf/distro/defaultsetup.conf:TCLIBCAPPEND ?=3D "-${TCLIBC}"
> meta/conf/distro/defaultsetup.conf:TMPDIR_append =3D "${TCLIBCAPPEND}"
>
> but this probably happens late in the parse cycle. So it creates
>
> bb_codeparser.dat =C2=A0bb_persist_data.sqlite3
>
> in both TMPDIR and TMPDIR-uclibc or TMPDIR-eglibc whatever libc you are
> using.
>
> Ideally I would have thought that TMPDIR is evaluated to final value befo=
re
> its used


Good point, I'm sick of seeing two tmpdirs.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


