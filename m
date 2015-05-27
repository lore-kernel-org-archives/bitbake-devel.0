Return-Path: <kergoth@gmail.com>
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
	[209.85.216.181])
	by mail.openembedded.org (Postfix) with ESMTP id 38EC375618
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 16:52:53 +0000 (UTC)
Received: by qcbhb1 with SMTP id hb1so6465350qcb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=M0i/nS4nS73CBgmM/rKCj6aXcBXeqbeXf2EH+8Bs+Bw=;
	b=hDuGOn0WXObDccpZl13VgD2ru9QAGOYhZWYQiMvvcmxzOBhNWt49Cpfsa1A5y1HAqz
	oCeyt/J5Xrc5moervsw0aDyjp8gIJPWZKTn98xqHGXjAyx/h2Hgmx1WnkPqe2t0LqrSX
	AZ9sgL/KOcu60Huj9CiO0XaQxG1EqtHUj8vlZV2vUnTI0Y68LsLJsrPdKYu7GHvsvke6
	FeAIgLLg4V/wQ6IP6z9s2Fgb1iXJm27yrnOxwBgEKaJHMDsJh0RFolNqe8Jo7Pmgb6Wv
	uRG+ePvIK5LFG0O+Q9ha286EJOTXUpgmcGkODgbG78IefJhRg/NxfTDdgwq6UTk5rS0B
	jvQg==
X-Received: by 10.229.84.198 with SMTP id k6mr43456040qcl.16.1432745574463;
	Wed, 27 May 2015 09:52:54 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.117 with HTTP; Wed, 27 May 2015 09:52:33 -0700 (PDT)
In-Reply-To: <1432653462.404.12.camel@linuxfoundation.org>
References: <1432653462.404.12.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 27 May 2015 09:52:33 -0700
X-Google-Sender-Auth: dw99BvaFj92kPVjVFUPZFNIlL-4
Message-ID: <CABcZAN=r+2UB52Y4ya=rr2tgHPvF2sfF0O88v=2PWV_XzFyXHg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] tests/data: Add log parsing test code
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
X-List-Received-Date: Wed, 27 May 2015 16:52:57 -0000
Content-Type: multipart/alternative; boundary=001a1134541a050245051713138f

--001a1134541a050245051713138f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 8:17 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> +def LogContains(item, logs):
> +    for l in logs:
> +        m =3D l.getMessage()
> +        if item in m:
> +            return True
> +    return False
>

I didn=E2=80=99t notice at first, but this doesn=E2=80=99t comply with PEP8=
 =E2=80=94 camelcase is
for use with class names, not function names. Minor, obviously :)
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1134541a050245051713138f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On Tue, May 26, 2015 at 8:17 AM=
, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&=
gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div id=3D":ya" class=3D"a3s" style=3D"overflow:hidden">+def LogContain=
s(item, logs):<br>
+=C2=A0 =C2=A0 for l in logs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 m =3D l.getMessage()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if item in m:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 return False</div></blockquote></div><br>I didn=E2=80=99t no=
tice at first, but this doesn=E2=80=99t comply with PEP8 =E2=80=94 camelcas=
e is for use with class names, not function names. Minor, obviously :)<br>-=
- <br><div class=3D"gmail_signature">Christopher Larson<br>clarson at kergo=
th dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - T=
slib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1134541a050245051713138f--
