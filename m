Received: from mail-lb0-f174.google.com ([209.85.217.174])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TyrpS-0006cR-3j
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 23:32:58 +0100
Received: by mail-lb0-f174.google.com with SMTP id l12so1494604lbo.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 14:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=881ShKjiIfRp5fSwmu9JHndHzX+Q2wQ3//dIe9sqcVI=;
	b=InSU/Z5qYUQMdomCvcEzNoST3eq9cbf/cBEDJaXertDDhrA6dFYKtlV2lY7QzbpC7z
	st5HtkiIET6lAgl0beKWy/ZXXI1GAlTsQAxOqMB5IfVEKQoU36JWWoEqSeSqTNyNeCnP
	QQcjJZVAjEkc+7X7I2CA4C5q0oKSNGO5G1TDYU44MYUig7wH2I/+NQ3+Tt9YX1B4OlY9
	up56iWEGzF43jyRTpRqMT+OWhppfOU6IK1uU6deW1xM8+g6iC6GaFw2dKgjGeoRbV74T
	G2kxwHf6xdcM1UbmE7yKhjfdHj08SFTI/GUb3aGBi/4pAZvQzHAzN/rsQyj7mvpt8wl2
	8CMA==
X-Received: by 10.112.40.71 with SMTP id v7mr2777122lbk.32.1359152243296; Fri,
	25 Jan 2013 14:17:23 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Fri, 25 Jan 2013 14:17:03 -0800 (PST)
In-Reply-To: <CA+chaQdCwSfEm0V4WtAg1KhVaDjxquE6WDFUfgvmwChCBgyVug@mail.gmail.com>
References: <1359142708-24667-1-git-send-email-Martin.Jansa@gmail.com>
	<CABcZANmTSLLfC=AvKjocVAN+Fj6n3Q3ZRQ=vON0EBw=5ahEiMw@mail.gmail.com>
	<CA+chaQdCwSfEm0V4WtAg1KhVaDjxquE6WDFUfgvmwChCBgyVug@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 25 Jan 2013 15:17:03 -0700
X-Google-Sender-Auth: 0sHVpovszO3Qe4MB-3XBoEkDZtg
Message-ID: <CABcZANk1SdS8v9=7N6Lg_3Li7TQzaVjqMXENpdzviSbUE3kKTA@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] world-image: add extra target
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
X-List-Received-Date: Fri, 25 Jan 2013 22:32:58 -0000
Content-Type: multipart/alternative; boundary=e0cb4efe3188a84b2404d4244a90

--e0cb4efe3188a84b2404d4244a90
Content-Type: text/plain; charset=UTF-8

On Fri, Jan 25, 2013 at 3:13 PM, Martin Jansa <martin.jansa@gmail.com>wrote:

> Agreed, I've tried with handler added in world-image.bbclass (cumulating
> all PACKAGES on RecipeParsed event) and failed, that's why this ended in
> bitbake code, but I'm open to ideas how to hook it properly.


RecipeParsed isn't ideal, better to let bitbake collate the world recipe
list, pass that along via a config level event (not ConfigParsed, but after
the cooker and taskdata preparation), and map that to packages with pkgdata
from the RecipeParsed.
-- 
Christopher Larson

--e0cb4efe3188a84b2404d4244a90
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jan 25, 2013 at 3:13 PM, Martin Jansa <span dir=3D"ltr">&lt;<a href=
=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.com=
</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Agreed, I&#39;ve tried with handler added in=
 world-image.bbclass (cumulating all PACKAGES on RecipeParsed event) and fa=
iled, that&#39;s why this ended in bitbake code, but I&#39;m open to ideas =
how to hook it properly.</blockquote>

</div><br>RecipeParsed isn&#39;t ideal, better to let bitbake collate the w=
orld recipe list, pass that along via a config level event (not ConfigParse=
d, but after the cooker and taskdata preparation), and map that to packages=
 with pkgdata from the RecipeParsed.<br>

-- <br>Christopher Larson</div></div>

--e0cb4efe3188a84b2404d4244a90--
