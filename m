Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
	[209.85.223.173])
	by mail.openembedded.org (Postfix) with ESMTP id 1D74370022
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Apr 2016 08:59:35 +0000 (UTC)
Received: by mail-io0-f173.google.com with SMTP id f89so9784293ioi.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Apr 2016 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=ZWwiCVv8NKRpXuamvZ/AkjlzR2+vYQY7aUSs9P6p/vQ=;
	b=aEfOtmEp7Q7s9Yyz2gbwr+kPMlZW6W5q/nGi2HQgTeHITweZowAEsjgGYSRJIQA3X9
	udWfzuhYT6vY1FXzkX2fTinx+/0bg6MS0yNHmBcgQzZNzdGZAfAgpZ+emeLrhAITTQde
	Il9/6cW+mV3dLwZAZa3qfF7Xvd7bsjq+I4S62FIydsVt9LuCpIzPxyhy7dMi1BJJCDj/
	b51zcE3mkC6Y5Iyd93RTVlqUtDTxoHaJ8anaB7m7gSh7z6qaq7pFQUK4xoA1/ao42eS7
	Il1XQapMABUhZBbJs1VQehJUckzBWIC0HokljA2SwdiEVEF/V+cfjUOz24onDOBaEuFE
	ZeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=ZWwiCVv8NKRpXuamvZ/AkjlzR2+vYQY7aUSs9P6p/vQ=;
	b=gVxE0zPXnWdGEz4HvbiIgwOvmX9s6vLHC6CZzk83kVqiDSqvRbegJSp+czT44wk8cP
	TP+/Ctrnz+Bwv+/QA7UoMVEBzqp5NGZaXSjdFdNvV/fc4tp9cUxmhZVsPtdrJjN6tTl0
	pcU/ZrH4FHKprzs826CxUn7z8Kh4luMIJCkQScfb5Jr0GgAmDPx3CHltfHEay2hE4S/k
	aiV03XhbUdpPlaDHUgiaP32M7AXorFOK4NSz2yXDJYXx5BjCrMtWwh1JTxV0c3whbd2l
	r7QQuBYZW5Ls2Ob7fC6HkHb+rhj1KwKOOOmnByfwJAnKMC9w4Zl5mgxm6k5uh2W9Vrfb
	1wDA==
X-Gm-Message-State: AOPr4FXVC9GtijCaU56zPLXf9ph4lPa2nGZIo52J2gBLq0OTWo+tL/hPCVztEtopTIXALVfvPBRqIqq1oYFSZYyM
X-Received: by 10.107.51.213 with SMTP id z204mr1914137ioz.148.1461661176563; 
	Tue, 26 Apr 2016 01:59:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.9.106 with HTTP; Tue, 26 Apr 2016 01:59:17 -0700 (PDT)
In-Reply-To: <F6CD090A69E64C4289DC608E1C5D2024253E1E0E@DE08W1305.global.ds.honeywell.com>
References: <F6CD090A69E64C4289DC608E1C5D2024253E0CBB@DE08W1305.global.ds.honeywell.com>
	<CAJTo0LZW8x_KVjOhAsp-uv3Ax5yKiKz9FxaDS-me33iF7BvcCw@mail.gmail.com>
	<F6CD090A69E64C4289DC608E1C5D2024253E1E0E@DE08W1305.global.ds.honeywell.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 26 Apr 2016 09:59:17 +0100
Message-ID: <CAJTo0LZC+tVTiw2EVdzF9DWibBPfVJPSw=y+vAGtpJPpa8fCTg@mail.gmail.com>
To: "Esponde, Joel" <Joel.Esponde@honeywell.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Fetcher issue: Error communicating with gnome-keyring-daemon
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
X-List-Received-Date: Tue, 26 Apr 2016 08:59:40 -0000
Content-Type: multipart/alternative; boundary=001a11440cd0361cbd05315f83e4

--001a11440cd0361cbd05315f83e4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22 April 2016 at 17:21, Esponde, Joel <Joel.Esponde@honeywell.com> wrote=
:

> I just tried your patch.
>
> And it works just fine!
>
>
>
> Your commit perfectly fits to our need.
>
> Just a little word on commit=E2=80=99s comment, authentication is not don=
e in this
> case over ssh it is done over https. So this fix is more generic than wha=
t
> the comment may let think.
>
>
>
> Thanks a lot for having taken time to look at my email and for having
> answered so quickly and efficiently!
>

Great, I've updated the message locally.  Thanks for testing the code.

Ross

--001a11440cd0361cbd05315f83e4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 22 April 2016 at 17:21, Esponde, Joel <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:Joel.Esponde@honeywell.com" target=3D"_blank">Joel.Esponde@honeywell.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p class=3D"Mso=
Normal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#400000">I just tried your patch.<u></u><u></u=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#400000">And it works just fine=
!<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#400000"><u></u>=C2=A0<u></u></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#400000">Your commit perfectly =
fits to our need.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#400000">Just a little word on =
commit=E2=80=99s comment, authentication is not done in this case over ssh =
it is done over https. So this
 fix is more generic than what the comment may let think.<u></u><u></u></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#400000"><u></u>=C2=A0<u></u></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#400000">Thanks a lot for havin=
g taken time to look at my email and for having answered so quickly and eff=
iciently!</span></p></blockquote></div><br>Great, I&#39;ve updated the mess=
age locally.=C2=A0 Thanks for testing the code.</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a11440cd0361cbd05315f83e4--
