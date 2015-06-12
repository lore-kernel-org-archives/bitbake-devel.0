Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f181.google.com (mail-qk0-f181.google.com
	[209.85.220.181])
	by mail.openembedded.org (Postfix) with ESMTP id CBDF474051
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jun 2015 13:04:36 +0000 (UTC)
Received: by qkhq76 with SMTP id q76so16894711qkh.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jun 2015 06:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=+lNGhi62kcyMktEa9EI2qO0GiL7W1/XHGEew7Qc62Js=;
	b=tgrkVJ6CjuOuZEdDq1l8BLzrOFlTsjXF0eNXtGUT4iDvrGwdyfUxnIpfMyr8wCDlZM
	xrK2uhnuXj4DBTcRCxoG3ZdU6ZGEMrRWqDAZ2NDgs8HdmZNxhLP0LKjsJYExilXgtWIT
	4F5SyBnbRiW8DiMy2HjfaIRlhiILZCGOOlNOUAfEzSxVMsN+fq/nzTgbz2GHQ7ZGuAp3
	FK/y0IJJJ6RounLLdUaKlEazrTzOATCo2Hg9en+sy1vhVwCC/7VQPLyEj+wTaTgTQhf/
	AfEIT0pG2XgCJLWaEK6AQDMzyEn/vrQQ/4vNj3n5lMxNmi6NuQROt7q5XhvMARzlhogi
	0gGw==
X-Received: by 10.140.165.150 with SMTP id l144mr18550011qhl.99.1434114277994; 
	Fri, 12 Jun 2015 06:04:37 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.73 with HTTP; Fri, 12 Jun 2015 06:04:17 -0700 (PDT)
In-Reply-To: <355BE46A91031048906B695426A8D8E616BEA6C0@DEFTHW99EH4MSX.ww902.siemens.net>
References: <355BE46A91031048906B695426A8D8E616BEA6C0@DEFTHW99EH4MSX.ww902.siemens.net>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 12 Jun 2015 08:04:17 -0500
X-Google-Sender-Auth: Hnk36Aog6SHvHHS0wQeInWN-F4U
Message-ID: <CABcZANnmPX=wU8BNt+y3UnCLOkbB9LWR-Lwgw6zVxa-_+PF6kQ@mail.gmail.com>
To: "Bach, Pascal" <pascal.bach@siemens.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Allow access to specific git server while BB_FETCH_PREMIRRORONLY ="1"
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
X-List-Received-Date: Fri, 12 Jun 2015 13:04:40 -0000
Content-Type: multipart/alternative; boundary=001a1134effa1b9177051851c075

--001a1134effa1b9177051851c075
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 12, 2015 at 7:47 AM, Bach, Pascal <pascal.bach@siemens.com>
wrote:

> I was wondering if there is a way to allow access to specific urls even if
> BB_NO_NETWORK or BB_FETCH_PREMIRRORONLY is set.
>
> The use case I have at hand it that we want to fetch all 3rd party sources
> from a HTTP premirror we have internally. Except for some packages that
> are hosted on a git server where we would like bitbake to always fetch from
> there (no tarball on the pre mirror).
>
> I tried:
> PREMIRROR_prepend = "git@local/foo.git git@local/foo.git \n"
>
>
> But this doesn't seem to work.
>
> Is there way to achieve this with the current PREMIRROR variable? Or is
> this functionality currently missing?
>

See the recently added BB_TRUSTED_NETWORK variable.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1134effa1b9177051851c075
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 12, 2015 at 7:47 AM, Bach, Pascal <span dir=3D"ltr">&lt;<a href=
=3D"mailto:pascal.bach@siemens.com" target=3D"_blank">pascal.bach@siemens.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,20=
4);border-left-style:solid;padding-left:1ex"><div id=3D":2gn" class=3D"" st=
yle=3D"overflow:hidden">I was wondering if there is a way to allow access t=
o specific urls even if BB_NO_NETWORK or BB_FETCH_PREMIRRORONLY is set.<br>
<br>
The use case I have at hand it that we want to fetch all 3rd party sources =
from a HTTP <span class=3D"">premirror</span> we have internally. Except fo=
r some packages that are hosted on a git server where we would like bitbake=
 to always fetch from there (no tarball on the <span class=3D"">pre</span> =
mirror).<br>
<br>
I tried:<br>
PREMIRROR_prepend =3D &quot;git@local/foo.git git@local/foo.git \n&quot;<br=
>
<br>
<br>
But this doesn&#39;t seem to work.<br>
<br>
Is there way to achieve this with the current <span class=3D"">PREMIRROR</s=
pan> variable? Or is this functionality currently missing?</div></blockquot=
e></div><br>See the recently added=C2=A0<span style=3D"font-size:13px">BB_T=
RUSTED_NETWORK variable.</span><br>-- <br><div class=3D"gmail_signature">Ch=
ristopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEm=
bedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mento=
r Graphics</div>
</div></div>

--001a1134effa1b9177051851c075--
