Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
	[209.85.215.44])
	by mail.openembedded.org (Postfix) with ESMTP id 487B26F573
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 21:30:28 +0000 (UTC)
Received: by mail-la0-f44.google.com with SMTP id hr13so6404161lab.17
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=BBIA3qXYAjRdZyPqdJKNLqpe1UV+56/42FUzWBUZiGk=;
	b=E23a4p8hQXFBqK/j+ql46nIqHA59Yz03hLFk3nIU00fBEMPD6Y4D7wRKcruk2WYMDK
	hggxPzN6OIqLzDxIc/gL18YprGTY+IcXOyS7Vy4MbiBMjSfMm/tfx7oAEfl3W7ty5Ew8
	HJZ5zuutR6seqzgV1u3QqukofMiDi3L5kPdvoaRaUt1oywQ2z1bu6U3njFjycgVCMJ6y
	+6/6/b0/LrwCXxDsi8+wxbBZirlva37Q+02LMS5QXF0LSBdxNzq10txI3IXAybmwywU3
	w4Md2laxwKqYv2r7xTegnmPxhODHUJSaMYyRMglVtIk6JOQdjTYOhKlLO8sl6U4Dx670
	kqhQ==
X-Received: by 10.112.163.69 with SMTP id yg5mr6547477lbb.14.1395264628966;
	Wed, 19 Mar 2014 14:30:28 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.35.200 with HTTP; Wed, 19 Mar 2014 14:30:08 -0700 (PDT)
In-Reply-To: <1395183532.3808.99.camel@ted>
References: <1395183532.3808.99.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 19 Mar 2014 14:30:08 -0700
X-Google-Sender-Auth: NWzrjdZfysVff6T_XX4wOui0TP0
Message-ID: <CABcZANmHKR0EFDaKVq4nFQUUxb=NWeSCT=O6QKPSaPkHKcKc-A@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Really fix sigchld handling
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
X-List-Received-Date: Wed, 19 Mar 2014 21:30:41 -0000
Content-Type: multipart/alternative; boundary=089e0118294e93cb7404f4fc5c78

--089e0118294e93cb7404f4fc5c78
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 18, 2014 at 3:58 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> +                        bb.warn("Unknown process (%s) exited unexpectedly
> (%s), shutting down..." % (pid, str(status)))
>

This says it's shutting down, but the commit message and code imply that it
isn't for these. I'm guessing this message needs adjustment from a
copy/paste? :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e0118294e93cb7404f4fc5c78
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Mar 18, 2014 at 3:58 PM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":nl" class=3D"a3s" style=3D"overf=
low:hidden">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Unknown process (%s) exited unexpecte=
dly (%s), shutting down...&quot; % (pid, str(status)))<br>

</div></blockquote><div><br></div><div>This says it&#39;s shutting down, bu=
t the commit message and code imply that it isn&#39;t for these. I&#39;m gu=
essing this message needs adjustment from a copy/paste? :)<br></div></div>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--089e0118294e93cb7404f4fc5c78--
