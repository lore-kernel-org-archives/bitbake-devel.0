Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC99C3ABB6
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 07:28:31 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.2913.1746602910509402063
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 May 2025 00:28:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MPikYoSo;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: setairidis@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54998f865b8so7008794e87.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 May 2025 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746602909; x=1747207709; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rqdpPTnHb/L5FIMWhn1x9y9hssuzQ10cofIJFfWGUis=;
        b=MPikYoSocVhsM1jtLUX7fJwQpq3bGMdJULKKXw0tJXzkk0Nj6D58yZ25zQqWE6ixY9
         aNc1Es+C7LoSp0UVNLK5S3A8jlpnyw3fkk+aQswBVJxhKNZzMl4vciLPfFJm0om4E0mp
         Ind5pOEMXKnc1CmQDRURG163YSmv4ad2XJ2aq+1nQU0B70xv4T6M9by+OlRDZuu4F8Ak
         cPribk27B2ABZFG8AaHUQ4ixA4jgro4KWXps0QufqG/UhI+GwUKerd1DVa0qa6j8qsTZ
         orEOEZmn/EPoX7pCw4e4+2Lz2uI4/tGg/v8G9qXD7xfSYtK1ZmlsJeVNxEFnUR/BikG0
         9EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746602909; x=1747207709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqdpPTnHb/L5FIMWhn1x9y9hssuzQ10cofIJFfWGUis=;
        b=B1O/ZUB3LtoM/HjM8XTEBz9YOslZr7kbHggrvvDesmtJRY+q//4pu9Jrsn5QSQvngS
         2tLGsmgCVcVwMXsl+QJD9zjs7qxE72d6QT2sCMIvxW4sj7NfusxCYOvR2Sk54bO/Yowv
         pZpiZghwKXdEePTM0m+mLLX/NbaZwoeGKx2S1Pb/e1aaVOlrmrACl43YLQBFBFdknrTU
         vMK2FsBfbZ9Qa+NOXkMUqdOkLjekxYjIqeseQHMUPK9q7tfqGKPFnvt6UjxjHQh+mojR
         h54X169wlK/5j8aFqYWkV3NcGWpXik2CG1H3GomrXnOd8MQaerNNUa3NcxJIIkTrykyf
         52cA==
X-Gm-Message-State: AOJu0YxkGBOnPIHBM7c8tOen/5duUJQX/9yl1U888Tr0TQmBdtCJ+wUH
	JpdjHlkhpF9HnZEVrVWFP0mjTLTkZCKMVWb+WZEvrB21WeN7CKwl7TjoQIfD1o4P13H6zjf7a1K
	WUhTCwMTUdpRJqMnaHGIUAoV1AzY=
X-Gm-Gg: ASbGncspNkWy5AcEqTqQbR8v3EJzoqA46mK9L8GRsqplmThwTTQiP4p8He570QV3jeU
	EpWlN9rzg9d8c6BZHAYGBxJGNvYQepNNGn4CsrJO/6956A7Ci11rfYtm5JJ0fuX1k1L7TotTB8G
	EswXysEgmuXtTJ4NrjIXsN8UNm
X-Google-Smtp-Source: AGHT+IFJ8V65RlTCNdxkCE3LNHhZlYjqi9hqhPM96iek+llcxnjRwZjg/MxiEgr975szYBZ2UC1zSATRAZTG5IKCnUU=
X-Received: by 2002:a05:6512:a88:b0:54e:81ec:2c83 with SMTP id
 2adb3069b0e04-54fb92936f1mr775680e87.18.1746602908395; Wed, 07 May 2025
 00:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250505185755.1952-1-falital@hotmail.com> <292ee69d270d71860a7ebada65e4f6aeeca01d13.camel@linuxfoundation.org>
In-Reply-To: <292ee69d270d71860a7ebada65e4f6aeeca01d13.camel@linuxfoundation.org>
From: Sawas Etairidis <setairidis@gmail.com>
Date: Wed, 7 May 2025 09:28:17 +0200
X-Gm-Features: ATxdqUGWa-cs9BGpCcGIBX5niNN4h7uIZxhiJ0EfYIaZ3G6hTk4azRx7YG-pTsc
Message-ID: <CAKJXz6d061e5h-_7vV6iWVj90gFvKqnKC=yRQqWaobqjvzfLgg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch: Add support for remapping URL's
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	Savvas Etairidis <falital@hotmail.com>
Content-Type: multipart/alternative; boundary="000000000000eb2c72063486ada1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 May 2025 07:28:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17597

--000000000000eb2c72063486ada1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I think it would be better to not modify how PREMIRRORS and MIRRORS work
since users already depend on them and expect them to work on specific way.
Like this you can add extra rules to rewrite the source code url and then
use  PREMIRRORS and MIRRORS if they exists.
I could instead provide an example how someone could have the same result
using PREMIRRORS if you think it is not worth having this as standalone
feature.

Regards,
Savvas

=CE=A3=CF=84=CE=B9=CF=82 =CE=A4=CF=81=CE=AF 6 =CE=9C=CE=B1=CE=90 2025 =CF=
=83=CF=84=CE=B9=CF=82 12:46=E2=80=AF=CF=80.=CE=BC., =CE=BF/=CE=B7 Richard P=
urdie <
richard.purdie@linuxfoundation.org> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:

> On Mon, 2025-05-05 at 20:57 +0200, Savvas Etairidis via
> lists.openembedded.org wrote:
> > From: Savvas Etairidis <setairidis@gmail.com>
> >
> > This commit adds support for remapping URL's in the fetcher.
> > This is useful for cases where the same server is access with
> > different protocols or different URL's. The remapping is done by
> > adding a remap entry to the global configuration or the recipe file.
> >
> > Fixed #10699
>
> I'm curious why you didn't use the PREMIRRORS and MIRRORS support that
> already exists?
>
> Cheers,
>
> Richard
>

--000000000000eb2c72063486ada1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<div><br></div><div>I think it would be better =
to not modify how PREMIRRORS and MIRRORS work since users already depend on=
 them and expect them to work on specific way.</div><div>Like this you can =
add extra rules to rewrite the source code url and then use=C2=A0 PREMIRROR=
S and MIRRORS if they exists.</div><div>I could instead provide an example =
how someone could have the same result using PREMIRRORS if you think it is =
not worth having this as standalone feature.</div><div><br></div><div>Regar=
ds,</div><div>Savvas</div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">=CE=A3=CF=84=CE=B9=CF=82 =
=CE=A4=CF=81=CE=AF 6 =CE=9C=CE=B1=CE=90 2025 =CF=83=CF=84=CE=B9=CF=82 12:46=
=E2=80=AF=CF=80.=CE=BC., =CE=BF/=CE=B7 Richard Purdie &lt;<a href=3D"mailto=
:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>=
&gt; =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On Mon, 2025-05-05 at 20:57 +0200, Savvas Etairi=
dis via <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=
=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; From: Savvas Etairidis &lt;<a href=3D"mailto:setairidis@gmail.com" tar=
get=3D"_blank">setairidis@gmail.com</a>&gt;<br>
&gt; <br>
&gt; This commit adds support for remapping URL&#39;s in the fetcher.<br>
&gt; This is useful for cases where the same server is access with<br>
&gt; different protocols or different URL&#39;s. The remapping is done by<b=
r>
&gt; adding a remap entry to the global configuration or the recipe file.<b=
r>
&gt; <br>
&gt; Fixed #10699<br>
<br>
I&#39;m curious why you didn&#39;t use the PREMIRRORS and MIRRORS support t=
hat already exists?<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--000000000000eb2c72063486ada1--

