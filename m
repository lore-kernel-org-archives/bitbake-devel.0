Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5529.1793910432427221257
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Nov 2026 12:27:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=DC+7IyJR;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91e97d6c8b8so10804466d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 12:27:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793910431; cv=none;
        d=google.com; s=arc-20260327;
        b=I13c/dfk2hHLvfZQduuPAj0kP1bpd6v5OumcYLnUf0T+x7RVTL2LZkwYKSAHNw8gpG
         pueyR2tUWdbpcQq4BOb+Y7/qEn3N0M/1Aln1KIgzfHKaKcWSVd2s5vNNvT2xkACq229+
         0Y1WSk1anV1qUL3jMNQcW8ksfE952SAiitlVkitcYkhzk/rDS9bRwPCfwbF1g+RiFtJd
         srtyomjYAcG88MvMK9kD4vN6DcTAjhbAHPcgBi7ZWrQh23O3JUf+SGIF7hSbcSQRs5wQ
         Esc4GPcUJItXNAlokxECWvVTte4JhlDjnzrfzw167WwSuu448+Ue7uISLIXgCheqNim7
         hssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/udfPvmnNPIauocsqTCDXGp20kz4sHPRcZa5jSObO70=;
        fh=1EZLImIYOkHj7GBVtZC37LcYiworw6tBsg7e1JbUEOY=;
        b=fJNhdz8wiJI8IR7SjgZ112oa+InmdnMvsFPpc7eaLHsP115EDvD0MDYrgX9puFkotB
         VTtz8jNTvvsIqXTiXsktInT38sFvHrTTRvaggElNEPLDYGEmgGtD3ZyfRhAYr85fJz5n
         xlBwRBAI1+J0XBiPWi0SPjAAMff5oTLT7uVV1pEWMZTXRujh7rRLw71G7asmQEGqQPox
         VAVK8bssf0xt55++7RrAhFVqmuVeqiOY5gOFupOOy0dANIzemtpepeamLy80G1RmOs7W
         8oAPhQLcrhvK0LscfEiFb7JTq3gapzTcE/IlzKX5JHT7M1JPNw+wAgw3CgYvHXbXeUyW
         dlPw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910431; x=1794515231; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/udfPvmnNPIauocsqTCDXGp20kz4sHPRcZa5jSObO70=;
        b=DC+7IyJRQj4Ufyi+73042EnEtzUFt1GAh/Qk+TozZUxX9TigsFJ+2zGpW2V+FYhtQF
         qtOUrVq5A1o23VCc1wBXDtblz+u0/JXxkN5joFaSO/msKsWnT7WcsLNAH3/Lsmr9ucSU
         FOIZUJTB/mSIllo1/7uPuT/DGtdjLnU0L4H308+VWl8vYTJhTXBDcoLsT6i764O4NEej
         i/wao59civSJrrfKXgtgU/Yj5pwX2m9vArfF0uWTZSQMFjX7EJpoR0FJKE1kXwIPxF4M
         hwZctpWdSV3iAaYV+UIyLmrOEVZCMSjb6jsQ1vAGXK1z43engHfONJi+Y7188syFvINm
         V8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910431; x=1794515231;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/udfPvmnNPIauocsqTCDXGp20kz4sHPRcZa5jSObO70=;
        b=pbuleInUmrTEX93/FY2E21xUfH2QxAM1lLSAee9wrTU63tb8L91QYyoCkllpZ6uB7k
         rWZMy6Za9cf7/Z60Sw6XcC0q7jPsEa22jQBPA8GK8nqNwh1sq+6+FL4xYlN1VeraFl4P
         dmIyP3uOfAGCZneeJDrm0t5t6OAbLiQzGWsXvOg/7Wyc+pjtLUxQvGp6slRKjk6cNgd3
         LdiUPyb7W7NurjqkvcDdGcDyeFmBb1/PmTJZnS95h/Zrn5cswwam0y5mVgIZ0M9xuKGA
         XDTDUQ4N1NIsfzzApP0DeGEO3K9J2SNZPHysKyXpQYEAFzxcxwVOKwp1dN6zB+kSMeDD
         ZX6g==
X-Forwarded-Encrypted: i=1; AKwUvBwQY6V2m5jIJlH7sgB//TsEGm/iaWPeDA58ZjWzxtBOeUxLxWKU1RjhHXJZ/K8xUlTsHw2f/kvL09zskvWS@lists.openembedded.org
X-Gm-Message-State: APuU4Z+uFk11/J+iVk/Da/c84mTe5oAKaDC+FKItdfSMKlpUpDacjwrB
	XgUyguXbh2jFaX/EPAWPpAQWpYtDlO9c9dzc8Si9tY5pMnhAoNk+LoFtmG+yFBqU346GGAe44yc
	cbi5GZZfx2VKhX6LYaBDoLNkk7D2xyAw=
X-Gm-Gg: AYBFou3zg5IkOxyoXnsDpLMeyvwJLuQdIJrkyYs2drVzjI0bzCPjfxGXwFtVgRLo6T3
	CMgMq4McTuI5D3k9IgP7ZFkSl9LEU3OOgfxLDFOwy0CdvoPyHr4tygI46k+WibhWZwkyx1aPeob
	d25bRPeJZpzvrsY0iAc1xnCWApG7akWPr9XT1FqDtFsxUEp8hwqO7LsUpSNrtzSLB9TY4q1yDpt
	+aD1JLRwowMtOzCh/Phx0iEf/hcEIBXQsjgDUKwpnXvmYuPTl3UP6cqezBf8vApr+G8H4QWEIC7
	o9HYOguwC+vCqeuy8fZXu+8HGHymVVUFfnDE1g48T56VLv/mwUhEWG3KGixSv9zGx9sXo6JFMY8
	QHAF4La8EZDPkkscJNkwmv4eBvpkLc41OQ/62eq7/9SJK/jszQ6/MltJ+P/o3vxz7O0Mwqlg=
X-Received: by 2002:a05:6214:3911:b0:91e:7939:dda5 with SMTP id
 6a1803df08f44-91ea98b3b9fmr1328666d6.23.1793910431205; Thu, 05 Nov 2026
 12:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20261105122145.543282-1-stondo@gmail.com>
In-Reply-To: <20261105122145.543282-1-stondo@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 5 Nov 2026 21:26:57 +0100
X-Gm-Features: AclHuK8nfJ_E6mjxH8Y68i3P9IZUWgLAgfGyu6JvkM0w0rRJCjg1DVl8K8hEEsY
Message-ID: <CANNYZj9=G4+jmRx7UJMYbsp2xwDxwSmm+Gv2HxcPJtOen_9LUA@mail.gmail.com>
Subject: Re: [RFC] spdx30: name, version and purl for dependency downloads
To: Stefano Tondo <stondo@gmail.com>
Cc: openembedded-core@lists.openembedded.org, stefano.tondo.ext@siemens.com, 
	bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	Peter Marko <peter.marko@siemens.com>, Adrian Freihofer <adrian.freihofer@siemens.com>, 
	Patrick Wicki <patrick.wicki@siemens.com>
Content-Type: multipart/alternative; boundary="00000000000002ce0a065f8d5276"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 20:27:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20399

--00000000000002ce0a065f8d5276
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 13:21, Stefano Tondo <stondo@gmail.com> wrote:

> I would like your opinion on a direction for the SPDX output of
> recipes with language dependencies. I have working patches for it,
> described below, but I would rather agree on the approach before
> sending them.
>

I'm afraid I am missing context, which is hardly surprising because I did
no spdx work until now. What are the language dependencies? Does something
require or recommend them? Is there a normative document that defines them?
The email talks about how the implementation works, but says nothing about
what the problem is.

Alex

--00000000000002ce0a065f8d5276
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, 5 Nov 2026 at 13:21, Stefano Tondo &l=
t;<a href=3D"mailto:stondo@gmail.com">stondo@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">I would like your opi=
nion on a direction for the SPDX output of<br>
recipes with language dependencies. I have working patches for it,<br>
described below, but I would rather agree on the approach before<br>
sending them.<br></blockquote><div><br></div><div>I&#39;m afraid I am missi=
ng context, which is hardly surprising because I did no spdx work until now=
. What are the language dependencies? Does something require or recommend t=
hem? Is there a normative document that defines them? The email talks about=
 how the implementation works, but says nothing about what the problem is.<=
/div><div><br></div><div>Alex</div><br></div></div>

--00000000000002ce0a065f8d5276--
