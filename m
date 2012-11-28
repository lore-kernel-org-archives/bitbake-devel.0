Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TdqCL-0006pw-Kk
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Nov 2012 23:33:42 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so10353197lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Nov 2012 14:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=gLOrsxAlYu0u6/RI1sRthHcmvx3S0FypHwr7xX/sCvQ=;
	b=K/fwD9NDWV1+/dzrRZwSzZRKFZWV/NP0ovg5qMx8wYeu46/dIXSQfYhNmjCA+J5fSK
	6EzmrrEVWpQXJuwpityf3OAlRK4e3jSs/NDIIhMoHiWxiFpuHM/VbPtRz8iK6DVmB3nZ
	FDPfUb+Zw0ScAPDwuVnWibOxCw6TRr3V4UPukBL34W+WkiUf78JQ//BaSDYYLImk4Czi
	CVr+44Kahkyt7+R0UM292rOzby2dAT8uxZPoPYvDhVT5VwqyFjnEW1Zw6UuEqb/NCWoT
	txEA75TdU8ZmjcG07IXIq+tFcXwneBkH+JlIBvEl2pszj12phAddiHpB2Abuh6FGnQ9n
	rnTw==
Received: by 10.112.49.202 with SMTP id w10mr8249581lbn.2.1354141166327; Wed,
	28 Nov 2012 14:19:26 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Wed, 28 Nov 2012 14:19:06 -0800 (PST)
In-Reply-To: <1354134376.15992.5.camel@ted>
References: <1354134376.15992.5.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 28 Nov 2012 15:19:06 -0700
X-Google-Sender-Auth: PUIPuP5VruL72voFbQ1ECoxYe3Y
Message-ID: <CABcZANkV1td28s-vZCXfukMHvYUAkoUH=3jScF3ZVkaBTyp9Qw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, "Eggleton,
	Paul" <paul.eggleton@intel.com>
Subject: Re: [PATCH] build.py: Preserve sigdata files in the stamps directory
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
X-List-Received-Date: Wed, 28 Nov 2012 22:33:42 -0000
Content-Type: multipart/alternative; boundary=bcaec554daa231da6704cf958f24

--bcaec554daa231da6704cf958f24
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 28, 2012 at 1:26 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> -        bb.utils.remove(mask)
> -
> +        # Preserve sigdata files in the stamps directory
> +        for name in glob.glob(mask):
> +            if name.find("sigdata") != -1:
>

if 'sigdata' not in name:
-- 
Christopher Larson

--bcaec554daa231da6704cf958f24
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra">On Wed, Nov 28, 2012 at 1:26 PM, Richard Purdie =
<span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org"=
 target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:=
<br><div class=3D"gmail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":38q">- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0bb.utils.remove(mask)<br>
-<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# Preserve sigdata files in the stamps directo=
ry<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for name in glob.glob(mask):<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if name.find(&quot;sigdata&quot;=
) !=3D -1:</div></blockquote></div><br>if &#39;sigdata&#39; not in name:<br=
>-- <br>Christopher Larson<br>
</div>

--bcaec554daa231da6704cf958f24--
