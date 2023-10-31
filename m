Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C60C4167D
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 15:36:48 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.1977.1698766605884609900
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 08:36:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HqK/3AZ+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so3453650f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698766604; x=1699371404; darn=lists.openembedded.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mUjDjMbONB515UMRshTufl4uKQQ4kKgfFCyXF88zM4g=;
        b=HqK/3AZ+O6Xeu0avIE27BI7mRqO7Te9E0lpnzxxGztno5/wJECfUKOe26aLG13xiqs
         zmauOx70GMt3VcOdVvC8vQf0jXkXUNDiwc3TGm1RJp32VWEBoOQLSg0/a8tsfG1+LjuD
         NqAZtdURh61NQVbDglFUwBlQefQ81h5l0Ll+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766604; x=1699371404;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUjDjMbONB515UMRshTufl4uKQQ4kKgfFCyXF88zM4g=;
        b=dO8xrc0toq4bK1f/crezQL2V9laXeJhgucX4MTHKyCHMJYcZoOOA0zzLVyOxaYPGna
         ws7PBYGN7zMmPOlWYAZON4wvRHwJvPzeIP9zoBtIQ2KCl27Gu/TwG8r6eI9rv/wqZG7j
         LNjcO8XW4qrnwhJqQeHkSe3NEEEV9EzFv2qa6HCvtwGcj9RQzndz+L7drwEknPxLL46b
         2LX9+pI/IQT6ULjkpI6FU7mzlcfH8Wm+mEOmxIEHXGQXdek9/GBBWsr5KoQPkebr+xng
         qxGouQVV3AiyRYNjagCN1PTAtNhWQF6pZtiGLE6ViWsJQktjzi8YbP/FV2ZVghLHg+xh
         U+LQ==
X-Gm-Message-State: AOJu0YzkdVItsDkU8HjwkC4Pp+mYQoPpRoygarEqvlfLF7AF0WqfgNbq
	tnMQWZ9hI7d0s/Dns6uT6679mQ==
X-Google-Smtp-Source: AGHT+IE3LzP9isyUDL/C1A8T+jZ6P5+tD3XqMu/7pFXA6pq8fm33HC8JNNduGWVL2UVZSRUEUnl2jQ==
X-Received: by 2002:a05:6000:144b:b0:32f:8181:7d42 with SMTP id v11-20020a056000144b00b0032f81817d42mr3170673wrx.9.1698766604066;
        Tue, 31 Oct 2023 08:36:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9850:4974:d357:58d5? ([2001:8b0:aba:5f3c:9850:4974:d357:58d5])
        by smtp.gmail.com with ESMTPSA id q8-20020adfcd88000000b003197869bcd7sm1768258wrj.13.2023.10.31.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:36:43 -0700 (PDT)
Message-ID: <9c0799acda8eb7751d518614477246db8456dead.camel@linuxfoundation.org>
Subject: Re: [Toaster] [bitbake-devel] [PATCH 8/8] Toaster: Added
 pytest.init file
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tim Orling <ticotimo@gmail.com>, Alassane Yattara
	 <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Date: Tue, 31 Oct 2023 15:36:42 +0000
In-Reply-To: <CANx9H-ChzdqV_wyra4RFhswNYZYmjaXO-iFdJvateo7NtL5f2A@mail.gmail.com>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
	 <20231030195037.232912-8-alassane.yattara@savoirfairelinux.com>
	 <CANx9H-ChzdqV_wyra4RFhswNYZYmjaXO-iFdJvateo7NtL5f2A@mail.gmail.com>
Content-Type: multipart/alternative; boundary="=-h2BoPChcNUvi1CK9XGp9"
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 15:36:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15348

--=-h2BoPChcNUvi1CK9XGp9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-10-31 at 08:16 -0700, Tim Orling wrote:
>=20
>=20
> On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara
> <alassane.yattara@savoirfairelinux.com> wrote:
> > Added pytest init file to configure pytest and generate test
> > reports.
> >=20
>=20
>=20
> Typo: pytest.ini file?
> =C2=A0
> >=20
> > Objective
> > - We propose to integrate the plugin Pytest to generate test
> > reports for Toaster application.
> > - To keep configurations to a minimal, we propose to integrate
> > Pytest with Tox(tox.ini).
> > - Tox will automate the execution of the Pytest test cases.=C2=A0=20
> >=20
> > Pros
> > - Generate test reports
> > - Create a historical record of test results over time
> > - Track Toasters stability and quality=20
> > - Documentation and Transparency
> > - Debugging, troubleshooting=C2=A0 : identify regressions (input,
> > output,)=20
> >=20
> > Cons
> > - Limited predefined report options. Although Pytest provides
> > different report
> > formats, its default reports are rather straightforward, We might
> > have to put extra effort into crafting them ourselves.
> >=20
>=20
>=20
> One of the benefits of pytest is in fact that report plugins are
> available and fairly straightforward to implement if we need our own
> custom report format (although we should avoid=C2=A0custom plugins and us=
e
> upstream maintained ones wherever possible).=C2=A0
>=20
> We do need to ensure that plain text output is generated for
> consumption by the AutoBuilder. Fancy html output is going to clutter
> the testresults.json that will be where these test results will
> ultimately be stored:
> https://git.yoctoproject.org/poky/plain/scripts/resulttool
> https://git.yoctoproject.org/yocto-testresults/
> https://docs.yoctoproject.org/test-manual/understand-autobuilder.html?hig=
hlight=3Dresulttool#resulttool
>=20
> The reason is that the testresults.json=C2=A0is consumed by tooling to
> look for regressions. It must be machine readable and easily
> processed.

Tim is correct that we do need text/machine readable results for
tesresults.json but there is also a case for generating graphical/html
reports alongside the results. =C2=A0An example would be our build
performance tests:

https://autobuilder.yocto.io/pub/non-release/20231030-22/testresults/buildp=
erf-alma8/perf-alma8_master_20231030150044_28324600cb.html

where we've saved text data but also show it more visually.

Cheers,

Richard



--=-h2BoPChcNUvi1CK9XGp9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div>On Tue, 2023-10-31 at 08:16 -0700, Tim Orling wro=
te:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:=
2px #729fcf solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara &lt;<a href=3D"mai=
lto:alassane.yattara@savoirfairelinux.com">alassane.yattara@savoirfairelinu=
x.com</a>&gt; wrote:<br></div><blockquote type=3D"cite" style=3D"margin:0 0=
 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div>Added pytest =
init file to configure pytest and generate test reports.<br></div><br></blo=
ckquote><div><br></div><div>Typo: pytest.ini file?</div><div>&nbsp;</div><b=
lockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf=
 solid;padding-left:1ex"><div><br>Objective<br>- We propose to integrate th=
e plugin Pytest to generate test reports for Toaster application.<br>- To k=
eep configurations to a minimal, we propose to integrate Pytest with Tox(to=
x.ini).<br>- Tox will automate the execution of the Pytest test cases.&nbsp=
; <br></div><div><br>Pros<br>- Generate test reports<br>- Create a historic=
al record of test results over time<br>- Track Toasters stability and quali=
ty <br>- Documentation and Transparency<br>- Debugging, troubleshooting&nbs=
p; : identify regressions (input, output,) <br></div><div><br>Cons<br>- Lim=
ited predefined report options. Although Pytest provides different report<b=
r>formats, its default reports are rather straightforward, We might have to=
 put extra effort into crafting them ourselves.<br></div><br></blockquote><=
div><br></div><div>One of the benefits of pytest is in fact that report plu=
gins are available and fairly straightforward to implement if we need our o=
wn custom report format (although we should avoid&nbsp;custom plugins and u=
se upstream maintained ones wherever possible).&nbsp;</div><div><br></div><=
div>We do need to ensure that plain text output is generated for consumptio=
n by the AutoBuilder. Fancy html output is going to clutter the testresults=
.json that will be where these test results will ultimately be stored:</div=
><div><a href=3D"https://git.yoctoproject.org/poky/plain/scripts/resulttool=
">https://git.yoctoproject.org/poky/plain/scripts/resulttool</a><br></div><=
div><a href=3D"https://git.yoctoproject.org/yocto-testresults/">https://git=
.yoctoproject.org/yocto-testresults/</a><br></div><div><a href=3D"https://d=
ocs.yoctoproject.org/test-manual/understand-autobuilder.html?highlight=3Dre=
sulttool#resulttool">https://docs.yoctoproject.org/test-manual/understand-a=
utobuilder.html?highlight=3Dresulttool#resulttool</a><br></div><div><br></d=
iv><div>The reason is that the testresults.json&nbsp;is consumed by tooling=
 to look for regressions. It must be machine readable and easily processed.=
</div></div></div></blockquote><div><br></div><div>Tim is correct that we d=
o need text/machine readable results for tesresults.json but there is also =
a case for generating graphical/html reports alongside the results. &nbsp;A=
n example would be our build performance tests:</div><div><br></div><div><a=
 href=3D"https://autobuilder.yocto.io/pub/non-release/20231030-22/testresul=
ts/buildperf-alma8/perf-alma8_master_20231030150044_28324600cb.html">https:=
//autobuilder.yocto.io/pub/non-release/20231030-22/testresults/buildperf-al=
ma8/perf-alma8_master_20231030150044_28324600cb.html</a></div><div><br></di=
v><div>where we've saved text data but also show it more visually.</div><di=
v><br></div><div>Cheers,</div><div><br></div><div>Richard</div><div><br></d=
iv><div><br></div><div><span></span></div></body></html>

--=-h2BoPChcNUvi1CK9XGp9--

