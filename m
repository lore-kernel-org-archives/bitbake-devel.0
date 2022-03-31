Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514F3C433F5
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 15:34:37 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web08.8770.1648740876445535618
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 08:34:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=hcYs8vBQ;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: kergoth@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id bh17so99102ejb.8
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5DvfvoYB1LWfd4TTFjr5zIYOWit7APGX5XvFgAt0kU=;
        b=hcYs8vBQZVdQKvfLLQKD0nqUec7y0YU6wGdGImrGsA1frok91Lgxaer/cchodnGW3N
         BLxXOn7ItgneYZ2Mko5LPugHu3amgOQs5i2H+taw/fAL4pF5g5wqvAZU+tzTsn3+75eu
         uN1nb94t0L3HNfO0+f8HW0OKtO/SmeoUglUcEL5uXoL3399F3PcG4au1OFKCngAVPD3A
         1x2hn++s+Q6MpXqE1xMsy2bKy8tnGfuNnHsxQaqKBO/ZoBc41jFE2jVIi860GAIoJd2M
         zFtMtpefCUL9Eolhf0Vx+KksQITMUpeqGjF4eyKEw9SEQMje9keE8Ae9EDZ1MYKREBq3
         BrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5DvfvoYB1LWfd4TTFjr5zIYOWit7APGX5XvFgAt0kU=;
        b=ZnHV+jNcxRkQh8beP38vpxvWnV0rPqoseh4o1+2QsSSh9qfCfUubF3jBFS3viK4jTl
         BJdC6bgMyu/fMPUv9LFkmmzK5rqxC4dKda52LZJuPyRlDL9cpfeHV53d2x4sB1dyUEXl
         Ay6t92ai3HKlWAdGR9k0hoVFbEoYGsjqtjwBDCKiefGvQXQXWzxcsAy0U3taknISfLOA
         t/ObYf6LGZvb/K8XQdYGdTWh7EuqYwFhaGVOAfr3MUHCDvswlKBpcvn8wj3vVFI9TKeN
         nZkH/+KU95cqtcs2UrS946hn48mDqSAeUwcKgNOlR4ki7s17M6SpkC1HTpgUG8WP/UQK
         mPcA==
X-Gm-Message-State: AOAM5301dtbLGIUGxRKKM3t4DF+ITy6au/FEfNtVwXvPAhhUgABBh8Oq
	5HsXlNfywrIGIbEQpZthz7tOmRSaIiSs45MaVAU=
X-Google-Smtp-Source: 
 ABdhPJyQsxpjnhqfIM8sWXYw7AX0BI/iBf68XTFQ5whQ0R3EY9JPSqUpDVbCHceq3EbA4X6NQT9/tOy6Df77Cvwp4MA=
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id
 mp9-20020a1709071b0900b006d8faa84a06mr5481877ejc.701.1648740874662; Thu, 31
 Mar 2022 08:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220331110437.1562951-1-richard.purdie@linuxfoundation.org>
 <20220331110437.1562951-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20220331110437.1562951-2-richard.purdie@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 31 Mar 2022 08:34:23 -0700
Message-ID: 
 <CABcZANkKWnVs8uT4d4c1KN9duL7LqPFtBWXxmV=MnA4C358c0g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] cooker: Restore sys.path and
 sys.modules between parses
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000002940d605db85663a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Mar 2022 15:34:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13559

--0000000000002940d605db85663a
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 31, 2022 at 4:04 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> When memory resident bitbake is active and we re-parse, the old module
> configuration is present which can lead to strange errors. Reset this
> when reparsing so the state is consistent. This fixes memory resident
> bitbake errors.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Looks good!

Acked-by: Christopher Larson <chris_larson@mentor.com>
-- 
Christopher Larson
chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
Principal Software Engineer, Embedded Linux Solutions, Siemens Digital
Industries Software

--0000000000002940d605db85663a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 31, 2022 at 4:04 AM Richa=
rd Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard=
.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">When m=
emory resident bitbake is active and we re-parse, the old module<br>
configuration is present which can lead to strange errors. Reset this<br>
when reparsing so the state is consistent. This fixes memory resident<br>
bitbake errors.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank" rel=3D"noopener">richard.purdie@linuxfoundat=
ion.org</a>&gt;<br></blockquote><div><br></div><div>Looks good!</div><div><=
br></div><div>Acked-by: Christopher Larson &lt;<a href=3D"mailto:chris_lars=
on@mentor.com">chris_larson@mentor.com</a>&gt;</div></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><font =
color=3D"#333333">Christopher Larson<br><a>chris_larson@mentor.com</a>,=C2=
=A0<a>chris.larson@siemens.com</a>,=C2=A0<a>kergoth@gmail.com</a><br>Princi=
pal Software Engineer,=C2=A0Embedded Linux Solutions,=C2=A0Siemens Digital =
Industries Software</font><br></div></div></div></div>

--0000000000002940d605db85663a--

