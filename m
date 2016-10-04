Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
	[209.85.218.66])
	by mail.openembedded.org (Postfix) with ESMTP id 4145D719D7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Oct 2016 15:00:32 +0000 (UTC)
Received: by mail-oi0-f66.google.com with SMTP id r132so10360659oig.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Oct 2016 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=YPrMkFWZk7IG9kRgtrq3y6/tr7+g95zGbcW0Wenr0SI=;
	b=Uvbbvhb+I0OFoW0v7p7lZSGpLOwIb31bZx9lBO+kgg5l2RdUpKQiLjZjgS5RrDEaoC
	tmR/2RFi/6v41CY4XjKExU1Hmog2P2E7Wadl1/ITGIRZqCVFDQFESPDx/eB89Csr4rMo
	QW/DBlVMQqvFV0RYS1s24/M1xWqPqyJz0/uQDTvuMZUQxjHQe3KwR/BmQMgiuKcy1CGp
	eyA2fit+1ilQ5JY291hX56xBnmJdazvFxSQqO138AVIc/2WTyerxOxwXLY6x2GmhLMKp
	56qiMuFUG9E0PMFtMPL5yjUjQ3wlXncLrQn3Dsl+6yRNHqMK9NaEzDQ3kIJ6vx6MynS9
	WU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=YPrMkFWZk7IG9kRgtrq3y6/tr7+g95zGbcW0Wenr0SI=;
	b=Zk8hgPB9Fl5fabofbRxSLOSCeOw67QREP8/Qy3/s1W1DJ+11o7ZCRPsWoBG90/OgB5
	XZoAE7jS46P0zwuLyydCbqltEUV2qhUoirMPi1i8Ict41LMtnpPVi1vmtdnc3a0+kVXg
	UyTLLjjzWZUEc3eghUZO/ZYkIlkmGGL9aKNjMqpYxSFq2WGIOeUI9C5NMQv22Hg1DDv2
	3QY/j9XSllrRtLJzXjsbLwhWNptH8vNUj2fsoKdHnn2dG6utB5DeyeUzS4V0wf3K/N2m
	7HEo6W9SCMYTn3rXdkCNDcfJ9oasDKFYmjQqpy+JhLJhoPWe1OALxjOOUu4iPuVPeVgV
	/xYg==
X-Gm-Message-State: AA6/9Rl1HgkOx0XTYOSHHmUWcGt0gGZK5QXAwOzWybv5kOqf8YB+F0Lm7msKFlzA7Gw1EwPzFvGxbzIhHgDV+A==
X-Received: by 10.157.31.48 with SMTP id x45mr1930443otd.29.1475593234195;
	Tue, 04 Oct 2016 08:00:34 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Tue, 4 Oct 2016 08:00:13 -0700 (PDT)
In-Reply-To: <1475575435-11098-1-git-send-email-joshua.g.lock@intel.com>
References: <1475575435-11098-1-git-send-email-joshua.g.lock@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 4 Oct 2016 08:00:13 -0700
X-Google-Sender-Auth: -wlTCCcPAu1MuN6HUzLh6vf_u7A
Message-ID: <CABcZAN=-xrXnC+CGhBeAto07sN1tuQ9YTFLpQ-gTjOEtDkGQgg@mail.gmail.com>
To: Joshua Lock <joshua.g.lock@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] event: prevent unclosed file warning in print_ui_queue
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
X-List-Received-Date: Tue, 04 Oct 2016 15:00:33 -0000
Content-Type: multipart/alternative; boundary=001a113e391c8eeb37053e0b5245

--001a113e391c8eeb37053e0b5245
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 4, 2016 at 3:03 AM, Joshua Lock <joshua.g.lock@intel.com> wrote=
:

> Use logger.addHandler(), rather than assigning an array of Handlers
> to the loggers handlers property directly, to avoid a warning from
> Python 3 about unclosed files:
>
> $ bitbake
> Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake
> --help' for usage information.
> WARNING: /home/joshuagl/Projects/poky/bitbake/lib/bb/event.py:143:
> ResourceWarning: unclosed file <_io.TextIOWrapper
> name=3D'/home/joshuagl/Projects/poky/build/tmp/log/cooker/qemux86/2016100=
4094928.log'
> mode=3D'a' encoding=3D'UTF-8'>
>   logger.handlers =3D [stdout]
>
> Signed-off-by: Joshua Lock <joshua.g.lock@intel.com>
>

There are valid cases to do an assignment, or at least clear out the
existing handlers via another means. We probably assigned there to ensure
it didn=E2=80=99t try to do anything else with the events other than dump t=
hem to
the output stream. Probably not an issue most of the time, in this case,
but worth noting. Good catch on this.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113e391c8eeb37053e0b5245
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Oct 4, 2016 at 3:03 AM, Joshua Lock <span dir=3D"ltr">&lt;<a href=
=3D"mailto:joshua.g.lock@intel.com" target=3D"_blank">joshua.g.lock@intel.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":zu" =
class=3D"a3s aXjCH m1578f273d2d565b2">Use logger.addHandler(), rather than =
assigning an array of Handlers<br>
to the loggers handlers property directly, to avoid a warning from<br>
Python 3 about unclosed files:<br>
<br>
$ <span class=3D"il">bitbake</span><br>
Nothing to do.=C2=A0 Use &#39;<span class=3D"il">bitbake</span> world&#39; =
to build everything, or run &#39;<span class=3D"il">bitbake</span> --help&#=
39; for usage information.<br>
WARNING: /home/joshuagl/Projects/poky/<wbr><span class=3D"il">bitbake</span=
>/lib/<span class=3D"il">bb</span>/event.py:143: ResourceWarning: unclosed =
file &lt;_io.TextIOWrapper name=3D&#39;/home/joshuagl/Projects/<wbr>poky/bu=
ild/tmp/log/cooker/<wbr>qemux86/20161004094928.log&#39; mode=3D&#39;a&#39; =
encoding=3D&#39;UTF-8&#39;&gt;<br>
=C2=A0 logger.handlers =3D [stdout]<br>
<br>
Signed-off-by: Joshua Lock &lt;<a href=3D"mailto:joshua.g.lock@intel.com">j=
oshua.g.lock@intel.com</a>&gt;</div></blockquote></div><br>There are valid =
cases to do an assignment, or at least clear out the existing handlers via =
another means. We probably assigned there to ensure it didn=E2=80=99t try t=
o do anything else with the events other than dump them to the output strea=
m. Probably not an issue most of the time, in this case, but worth noting. =
Good catch on this.<br>-- <br><div class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com<br>Fo=
under - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior S=
oftware Engineer, Mentor Graphics</div>
</div></div>

--001a113e391c8eeb37053e0b5245--
