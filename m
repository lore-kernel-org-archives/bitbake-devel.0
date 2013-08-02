Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
	[209.85.215.49])
	by mail.openembedded.org (Postfix) with ESMTP id 6BAA161AD1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2013 21:06:00 +0000 (UTC)
Received: by mail-la0-f49.google.com with SMTP id ev20so763708lab.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2013 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=sDZ/dUqv3cgfdbZgSSzfjQoguVh5ozI8tZ/kfE/Q/mk=;
	b=zRVyIoZ3s+6Z1CGafe4HQgTY9uqRqMGYx44ouwuMmpdv2o9aevwUFDolgKpeHwwkrJ
	7tG130694bPafcpemWMfXxONSKGnW26N8K5fLE2S88D7p/Rk3kkqykHpHTI/JmKUR01w
	cvX2KoolHsfeVRWOqn2vFKsFs2oIUWnBE4vnI7OSPWHDr8tLLBgL54zVOZk8D5l5VCU+
	k7GKBYDUi6kCwIGaksfjWMguyQEQho1GJFThXFQHTvlqiZT6MemUZNKaxqv+kwmLxqiL
	TlRf34MHXfx6DMPSRyI9nc6ykgNcnvFAJArssNtOuOxQxAL3vfwHkkP6AP8XrrSzX1wo
	0Qhg==
X-Received: by 10.152.37.232 with SMTP id b8mr3634527lak.80.1375477560366;
	Fri, 02 Aug 2013 14:06:00 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.17.67 with HTTP; Fri, 2 Aug 2013 14:05:40 -0700 (PDT)
In-Reply-To: <1375366786-16892-1-git-send-email-joe@deserted.net>
References: <1375366786-16892-1-git-send-email-joe@deserted.net>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 2 Aug 2013 14:05:40 -0700
X-Google-Sender-Auth: 9e72uwl3vUcmkWb-y72uPmEP60U
Message-ID: <CABcZANmaaKPj5Fno3aBiA0_DZyg6sEH4+QP8J_g=GODfAgwFag@mail.gmail.com>
To: Joe MacDonald <joe@deserted.net>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: enable pdb tracing
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
X-List-Received-Date: Fri, 02 Aug 2013 21:06:00 -0000
Content-Type: multipart/alternative; boundary=089e01493e7a61dcb004e2fd53e7

--089e01493e7a61dcb004e2fd53e7
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 1, 2013 at 7:19 AM, <joe@deserted.net> wrote:

> From: Joe MacDonald <joe@deserted.net>
>
> Based on:
>
>    http://blog.devork.be/2009/07/how-to-bring-running-python-program.html
>
> register a signal handler to dynamically start pdb tracing on receiving
> SIGUSR1.
>
> Signed-off-by: Joe MacDonald <joe@deserted.net>
>

As long as you keep in mind this will only affect the UI, not the forked
off server, this could be useful. I'd suggest adding something for the
server as well, but it'd need to listen to a socket for the input, lacking
access to the user's tty, or would need to interface with the UI to do it :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e01493e7a61dcb004e2fd53e7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
hu, Aug 1, 2013 at 7:19 AM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:joe@de=
serted.net" target=3D"_blank">joe@deserted.net</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">

<div id=3D":dz" style=3D"overflow:hidden">From: Joe MacDonald &lt;<a href=
=3D"mailto:joe@deserted.net">joe@deserted.net</a>&gt;<br>
<br>
Based on:<br>
<br>
=C2=A0 =C2=A0<a href=3D"http://blog.devork.be/2009/07/how-to-bring-running-=
python-program.html" target=3D"_blank">http://blog.devork.be/2009/07/how-to=
-bring-running-python-program.html</a><br>
<br>
register a signal handler to dynamically start pdb tracing on receiving<br>
SIGUSR1.<br>
<br>
Signed-off-by: Joe MacDonald &lt;<a href=3D"mailto:joe@deserted.net">joe@de=
serted.net</a>&gt;</div></blockquote></div><br>As long as you keep in mind =
this will only affect the UI, not the forked off server, this could be usef=
ul. I&#39;d suggest adding something for the server as well, but it&#39;d n=
eed to listen to a socket for the input, lacking access to the user&#39;s t=
ty, or would need to interface with the UI to do it :)<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--089e01493e7a61dcb004e2fd53e7--
