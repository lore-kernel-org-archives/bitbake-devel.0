Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TXgdn-00012Z-L3
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Nov 2012 00:08:41 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so1996709lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Nov 2012 14:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=GuBwKoc9XqvMXgV9p48g/mFHvXInWPV4d8LLhheEbwk=;
	b=u9fTRtiEjQ0KbvQAtHpUa3AxHYAqBV6UfY9P9J8tkOwqgSL8hbBOM9CrFeTvPNag0P
	dTdkoojZD0TFGn/8+9+J9vKPx5hPll0lEmDpzmLRrMGc1uGQZc4Vyy3MHPdQtwJZaYXe
	rcoKzq4fKZhfZ1zmlgr9C7ji+k/DO2xtnwAIZ2DVr4E15OMhucgizYMFf5Rj5Qj6FiwY
	9tf822V57NL4nx7hdLUPBr6rpOVSH1h6eApUq5KH5rPCqUjcTczXhUQCfGv2Fg5rR4VE
	UxlG8/YV0xJTRxmBkWQrTnTAAuwvoEHavArzj9tnWieyLKoBegP0iLFBWT8+JmbxL8x0
	m/Ng==
Received: by 10.112.26.233 with SMTP id o9mr7329505lbg.101.1352674483374; Sun,
	11 Nov 2012 14:54:43 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.18.239 with HTTP; Sun, 11 Nov 2012 14:54:23 -0800 (PST)
In-Reply-To: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Sun, 11 Nov 2012 15:54:23 -0700
X-Google-Sender-Auth: WPt5jgR9ib4FOLozQir7w2PE-5I
Message-ID: <CABcZANkEh-RvPBDRcGAbu3R=SBMrkqxFThjuvBwgj8Y2WuhLuQ@mail.gmail.com>
To: Seth Bollinger <seth.boll@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake: Colorize knotty interactive console output
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
X-List-Received-Date: Sun, 11 Nov 2012 23:08:42 -0000
Content-Type: multipart/alternative; boundary=bcaec554dbca140b6804ce4012ba

--bcaec554dbca140b6804ce4012ba
Content-Type: text/plain; charset=UTF-8

On Sun, Nov 11, 2012 at 8:17 AM, Seth Bollinger <seth.boll@gmail.com> wrote:

> @@ -67,6 +86,8 @@ class BBLogFormatter(logging.Formatter):
>          if record.levelno == self.PLAIN:
>              msg = record.getMessage()
>          else:
> +            if self.color_enabled:
> +                self.colorize(record)
>


I'm not seeing your definition of color_enabled in the constructor.
Wouldn't this attribute not exist when it's first created, before
enable_color() is called? Have you tested this with a non-interactive
terminal? I'd think you'd want a self.color_enabled = False in the
constructor for the formatter.
-- 
Christopher Larson

--bcaec554dbca140b6804ce4012ba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Sun, Nov 1=
1, 2012 at 8:17 AM, Seth Bollinger <span dir=3D"ltr">&lt;<a href=3D"mailto:=
seth.boll@gmail.com" target=3D"_blank">seth.boll@gmail.com</a>&gt;</span> w=
rote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><font face=3D"arial, sans-serif">@@ -67=
,6 +86,8 @@ class BBLogFormatter(logging.Formatter):</font></div>
<div><font face=3D"arial, sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
record.levelno =3D=3D self.PLAIN:</font></div><div><font face=3D"arial, san=
s-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D record.get=
Message()</font></div><div><font face=3D"arial, sans-serif">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0else:</font></div>


<div><font face=3D"arial, sans-serif">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if self.color_enabled:</font></div><div><font face=3D"arial, sans-ser=
if">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.colorize(=
record)</font></div></blockquote></div><br><br>I&#39;m not seeing your defi=
nition of color_enabled in the constructor. Wouldn&#39;t this attribute not=
 exist when it&#39;s first created, before enable_color() is called? Have y=
ou tested this with a non-interactive terminal? I&#39;d think you&#39;d wan=
t a self.color_enabled =3D False in the constructor for the formatter.<br>

-- <br>Christopher Larson<br>
</div>

--bcaec554dbca140b6804ce4012ba--
