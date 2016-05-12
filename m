Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
	[209.85.223.194])
	by mail.openembedded.org (Postfix) with ESMTP id A90DB6FF4E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 15:58:41 +0000 (UTC)
Received: by mail-io0-f194.google.com with SMTP id k129so11092294iof.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=B1IKMr+gPWISjb7HhOCbtrZDQ8kOSviPotC0Vz9UeOs=;
	b=ZCTKeCnxKp6BlTqamcHG4YLbW0yKZDq4fOmgkev4Wr2GIEf1TYxT6quJK7a4LYhCQm
	7auHpC/pqbOYXQTOq3vji7hbuOmpkdvsfUnzZIWjAgP7IJaRoMF4amRGhTQZZcBYK2b9
	hg3PyC4MaBI1IAM/bHQKgf3BO/SLcKEF7jnsOQnXnsXxqFcpGJvcQyaOTjmoXkgcIwbY
	gQnwsSr9B2fnuq0xjm+V1luarQ9kPN4TIsevh1PpeLQQZVhASVezRSwopukg6ZHoQnGQ
	p/YwacKRxYaotQ8RS6u4jNdeU+hvPr3oXCis99aw9e856OTDelNSJzWj8ccOSV3M+BTS
	X3Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=B1IKMr+gPWISjb7HhOCbtrZDQ8kOSviPotC0Vz9UeOs=;
	b=UW7u5fz90YjPcLaYcPx9gV9UlR6kA5Zn35VfzNqbXVsKXV1rLVrgf6huxCzlh8LBJn
	7NYDnjKjTtaHQBmd5U4OIWrofQG44tguVGFroIIk3hefi4tuEzUEYwmShtfTAblTsQTQ
	OHnGKIDhepATDsUcIH94sqCEdTWfkTZXdSuBJAzKAde0Nxh/tPNgd9rfczN+eOzf+6Q0
	U9GLFHt/wuZPRjUiiF8z/3O7qSSiC7TEOoiTRBOZcaT3aegWjwqir7Zvw86+j2mVHyCT
	06FYAVucrYtc65OznZ+KRbRRS9VC8yZGTaaqmws+cUuE27UMB+4QsuH2h4P6UiV9HtPZ
	x4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=B1IKMr+gPWISjb7HhOCbtrZDQ8kOSviPotC0Vz9UeOs=;
	b=dzmJ+1kzkiU4WqVzWSzJc0plglyApxjRPeGwH080yevBdd75tzCeStrmC4Ed6ivS3L
	vjmdp31/fZS2Z0yzzN15kMzFD+C82LkpkJh+4d5LViXixznJaUUoT+asgfW4jU2QXZZZ
	1QgnZZKnekaccowbnQsP6g3jhFkLj0c3QcEA803Llf1NI+72SVCjgSWOpq7SA4Jb1Yl8
	mlRTWTz25YTJB+rkq/CtS4r8xCaP9QZAyGOxSLcldQVoChBWRPghvjAjmuvtx00yKmZz
	S4WzOYtciuiafV8zBZET0EFn/+jucTYJ6cc1RnE55ZDttQ6b7XS5aYKIuYYSvLDDtBLP
	9uFw==
X-Gm-Message-State: AOPr4FUGVIYHamqAE83mZj7EuHqb7siuT8gho3BQQEVrFwK3rYWNl+75A6YudlBhNV4KmBxLmn/vDp11uAxoCA==
X-Received: by 10.107.147.7 with SMTP id v7mr8000107iod.3.1463064966935; Thu,
	12 May 2016 07:56:06 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Thu, 12 May 2016 07:55:47 -0700 (PDT)
In-Reply-To: <1463047019.9746.7.camel@linuxfoundation.org>
References: <1463047019.9746.7.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 12 May 2016 07:55:47 -0700
X-Google-Sender-Auth: vslTvmkJAx2OLQ15P-8EFwkbgyU
Message-ID: <CABcZAN=v9YiLHPQugxLXpOKbznSjek30Xbk72+9-BF6bPiyLOQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cookerdata: Fix log messages and ensure we exit
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
X-List-Received-Date: Thu, 12 May 2016 15:58:44 -0000
Content-Type: multipart/alternative; boundary=94eb2c055f68a33a850532a65b85

--94eb2c055f68a33a850532a65b85
Content-Type: text/plain; charset=UTF-8

On Thu, May 12, 2016 at 2:56 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> The string formatting wasn't correct and we should exit if we hit
> errors here similar to the other exception handlers.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 50259a9..fba95af 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -192,7 +192,8 @@ def catch_parse_error(func):
>                  fn, _, _, _ = traceback.extract_tb(tb, 1)[0]
>                  if not fn.startswith(bbdir):
>                      break
> -            parselog.critical("Unable to parse %s", fn,
> exc_info=(exc_class, exc, tb))
> +            parselog.critical("Unable to parse %s" % fn,
> exc_info=(exc_class, exc, tb))
> +            sys.exit(1)
>

The python logging module supports passing the % format values as
arguments, you don't have to format the string at call time. What was the
error here?
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c055f68a33a850532a65b85
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, May 12, 2016 at 2:56 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":z3" class=3D"a3s aXjCH">The string formatting wasn&#39;=
t correct and we should exit if we hit<br>
errors here similar to the other exception handlers.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;<br>
<br>
diff --git a/lib/<span class=3D"il">bb</span>/cookerdata.py b/lib/<span cla=
ss=3D"il">bb</span>/cookerdata.py<br>
index 50259a9..fba95af 100644<br>
--- a/lib/<span class=3D"il">bb</span>/cookerdata.py<br>
+++ b/lib/<span class=3D"il">bb</span>/cookerdata.py<br>
@@ -192,7 +192,8 @@ def catch_parse_error(func):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fn, _, _, _ =
=3D traceback.extract_tb(tb, 1)[0]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not fn.sta=
rtswith(bbdir):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parselog.critical(&quot;Unable t=
o parse %s&quot;, fn, exc_info=3D(exc_class, exc, tb))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parselog.critical(&quot;Unable t=
o parse %s&quot; % fn, exc_info=3D(exc_class, exc, tb))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(1)</div></blockquote></=
div><br>The python logging module supports passing the % format values as a=
rguments, you don&#39;t have to format the string at call time. What was th=
e error here?<br>-- <br><div class=3D"gmail_signature">Christopher Larson<b=
r>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus=
<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--94eb2c055f68a33a850532a65b85--
