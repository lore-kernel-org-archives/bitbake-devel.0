Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RmSeo-0000BA-PE
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 17:10:11 +0100
Received: by qap15 with SMTP id 15so1747552qap.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Jan 2012 08:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=YL3EuVNxtuq6jiCgI9c2+ofdAuX8Wu/AzzaYYcjjQm4=;
	b=THe3MkUc9A2MJMfSXBkglFGCPckwo4lyQwhUu8dOmBDI4TzGpMGhWzr2n3t5GqH73c
	E92zof6+lo0dg9AX8dkTOKdXA+xh4g+hRxRBsRBi5HMRgrQup2t0sbwbRRRSTYo07AAf
	S9rgsUMLKzHyvgW69dQicoxunUEbGq9cuLq8k=
Received: by 10.224.175.2 with SMTP id v2mr10410026qaz.69.1326643355343; Sun,
	15 Jan 2012 08:02:35 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.186.149 with HTTP; Sun, 15 Jan 2012 08:02:13 -0800 (PST)
In-Reply-To: <20120115101510.A4BD610337@opal>
References: <20120115101510.A4BD610337@opal>
From: Chris Larson <clarson@kergoth.com>
Date: Sun, 15 Jan 2012 09:02:13 -0700
X-Google-Sender-Auth: BgR-WxA5ia04zkbmVhhh6nDAqyE
Message-ID: <CABcZANm7mK5DHM5cc7AjWU3vOG=9wcnghmWRwe-NKyCdDTsR5g@mail.gmail.com>
To: git@git.openembedded.org
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Paul Eggleton : bitbake/knotty: don't count errors as warnings in summary
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
X-List-Received-Date: Sun, 15 Jan 2012 16:10:11 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 15, 2012 at 3:15 AM,  <git@git.openembedded.org> wrote:
> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
> index 0340619..5366386 100644
> --- a/lib/bb/ui/knotty.py
> +++ b/lib/bb/ui/knotty.py
> @@ -127,7 +127,7 @@ def main(server, eventHandler):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if event.levelno =
>=3D format.ERROR:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err=
ors =3D errors + 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn_value =3D 1
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if event.levelno=
 >=3D format.WARNING:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif event.level=
no =3D=3D format.WARNING:

Just as an FYI, this could have remained as >=3D, given the elif fixes
the error matching issue. It doesn't matter for us, as I don't think
we have any message levels higher than warning but lower than error,
but wanted to note it for future reference.
--=20
Christopher Larson


