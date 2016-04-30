Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
	[209.85.213.171])
	by mail.openembedded.org (Postfix) with ESMTP id 2508B76F8C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 20:07:09 +0000 (UTC)
Received: by mail-ig0-f171.google.com with SMTP id bi2so53121743igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=N5nLG0P5mnkbnav7F4xqWPXVX8UUrYeKhzg0lJlLYgg=;
	b=PUVVjlyDUM9PY3DNF4IS2gvn3Jyq1o+y2vQ11KHnmjfXrBQWZuTlYg16DEh+H1fnQh
	UKfAVnN6jwALC7nInmw/YTEeSCbkJT5cbSaiOitRgZ/MQXcgMB0suJKKs3v9FNy0e0tl
	0vjzUtOo+rRpU0SlkTF+0JL9AcSW+lSfyUX9suKFQZngaI+grvrYK+TrEkosR5Zx4oBh
	Yyl4AcNpL48q916sjm7efQufqGtZkgADugMij/v8MdjL5mTSXsw96rMlm21F/3yLlCo6
	fnig2LWsb4FmkrYYY5EqNgwMUY0Foh5mhDrAGOw68vGhL7hdj7IBdB6KRbN6DdlwWDKB
	dfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=N5nLG0P5mnkbnav7F4xqWPXVX8UUrYeKhzg0lJlLYgg=;
	b=HD1PT/e9jKTAlbENcDQVnuZZo0tp1irGp85tszjNsDN84ZUIctP44rqnx67PaJGDTW
	4LoI2+Z6rhQRhLWvGsLnbCAySS1XguQeH1npkWmsqD+rPwKznDGB1V+oRliyn47LV0vv
	EmfU78kt4wmo9XQ8aeqVsr7EhQQawFYs2v3kogF8WidZcLSvSq0rQgnboDEWPIsbbnXR
	94SJ9PRbAsXsd+/0+2AqdIRwVBnKE0nNhLWIYUiWmT6wjXS1WCMQIomR9ryOI2y6TFew
	dMGmHqlqoDE5hEbh6oUP6TtPUQyxSQmAYqIZn8OLDWQU0QWe1NbaaraTDy29Vbg+G1dG
	NbAw==
X-Gm-Message-State: AOPr4FW0rOICaIdkPCfYd4CaDFno745F0g0g8vatLRKRIX6vXY36k1EmJrgpYKlnluDqMNjsvXdUMeXlUfgmng==
X-Received: by 10.50.160.3 with SMTP id xg3mr12160907igb.87.1462046830247;
	Sat, 30 Apr 2016 13:07:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.70 with HTTP; Sat, 30 Apr 2016 13:06:50 -0700 (PDT)
In-Reply-To: <1462045969-14538-3-git-send-email-kergoth@gmail.com>
References: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
	<1462045969-14538-3-git-send-email-kergoth@gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Sat, 30 Apr 2016 13:06:50 -0700
Message-ID: <CABcZAN=DWHSWgOi-HBcShqH9t7tWQ603hPXJgGLFd8RZzwinvA@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [master][PATCH] bb.cooker: only emit a var as python if 'func' is set
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
X-List-Received-Date: Sat, 30 Apr 2016 20:07:10 -0000
Content-Type: multipart/alternative; boundary=001a11348a7af64a2e0531b94d10

--001a11348a7af64a2e0531b94d10
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 30, 2016 at 12:52 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> This avoids a common issue where PACKAGECONFIG is emitted as a function in
> bitbake -e when the 'python' flag exists. It isn't a python function unless
> both 'func' and 'python' are set. This aligns with the behavior of
> emit_func_python.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>


Don't apply this yet, v2 forthcoming.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11348a7af64a2e0531b94d10
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">On Sat, Apr 30, 2016 at 12:=
52 PM, Christopher Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:kergoth@g=
mail.com" target=3D"_blank">kergoth@gmail.com</a>&gt;</span> wrote:<br><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Christopher Lar=
son &lt;<a href=3D"mailto:chris_larson@mentor.com">chris_larson@mentor.com<=
/a>&gt;<br>
<br>
This avoids a common issue where PACKAGECONFIG is emitted as a function in<=
br>
bitbake -e when the &#39;python&#39; flag exists. It isn&#39;t a python fun=
ction unless<br>
both &#39;func&#39; and &#39;python&#39; are set. This aligns with the beha=
vior of<br>
emit_func_python.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;</blockquote><div><br></div><div>Don&#=
39;t apply this yet, v2 forthcoming.<br>-- <br><div class=3D"gmail_signatur=
e"><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Found=
er - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Soft=
ware Engineer, Mentor Graphics</div></div>
</div></div>
</div></div>

--001a11348a7af64a2e0531b94d10--
