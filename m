Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.13118.1612888116588912549
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 08:28:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=rXBsaAhk;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id q2so24568832edi.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Feb 2021 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meGwGn9QaBPzXuZjNjtAfC5ZWf6FF9BWYih7pA4dgQ8=;
        b=rXBsaAhkoZBIAa4mM9Hu7E759fwPmbaqkTDQ4BR/oU9klaDrc9kAXdd9GOBF6F0kLK
         x3qBHhWWAPxHKmRVuzb+K27Ek8zBxN6g2Pmv/k3Z5SnO3lYIDffE6+l8fP4FF5v+fx5S
         Yb9EeECHXZOreEcIOAw45cy8wZ51lVtts7xyOmKMWt12ic43E0koeacagFBkIiuUYUj2
         gGbXUfBFJFI6ynuMxeQ6RQUiGb5xEdndcRZI71d3i4im32jo9RUvmuCmKfvJvkWFNM7W
         173x/ZBuFAiXf4nVzCwnxWqaoO36PpeHmyiGg/cnCXWmVBFLQy/IVKf/qIzTeQdsyVBd
         ktNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meGwGn9QaBPzXuZjNjtAfC5ZWf6FF9BWYih7pA4dgQ8=;
        b=tPkLcOTRQjDSvGubgRC0N3y821053z0pkl+zQ1pnDS6WMkkG2TBVZoDvBcPbA7lJZY
         FTL4AL2rG7Os25iX3XgvApzsLbl0oHjQCb0gH+2eRIZsjS84xpq+IimssmyaPXM57ilZ
         4MoacBJwYU+Z5l1FK+zYBe9eVatPx+ahu6arbQfWLtURCo+9XNLGE9pPNfuXuZ+flOzM
         m1hkx/gJBjrjp13xIiN6M0kosyhBhuxecyI7Fyz+36Nh0MWve7l9qZBKcnOeJWJn/Eui
         ny5dQZoXTXBM4dM7TGdGyR5NN70bSzKeVr5afbAIA1sk8QSRrHzz2TxLowkrA0h7+8xp
         MLNA==
X-Gm-Message-State: AOAM530Nv2C0/Oav/ksTAI6qFQpS39X4NNteBvfQ4iVqGEwRctTxY1Th
	w8FmG7X/FcKZwoHGI1jJ94UdKDQWR6gPRME1hO4=
X-Google-Smtp-Source: ABdhPJxpnYXDr+NF+RM4FtwQGdhpZeVZJucPiR9pnwAEQoOTQT1o8zL8uWQVQpfGoy+Ycvm1RL95+KF4QVP4Z7MTWzU=
X-Received: by 2002:aa7:d754:: with SMTP id a20mr23967979eds.265.1612888115069;
 Tue, 09 Feb 2021 08:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20210209155021.21709-1-JPEWhacker@gmail.com>
In-Reply-To: <20210209155021.21709-1-JPEWhacker@gmail.com>
From: "Christopher Larson" <kergoth@gmail.com>
Date: Tue, 9 Feb 2021 09:28:23 -0700
Message-ID: <CABcZANn_RqcBbzt4RppvG8PxeqALoPNYp7yzsq08fyJNhmp-1Q@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] logging: Make bitbake logger compatible with python logger
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000029447a05bae9c79e"

--00000000000029447a05bae9c79e
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 9, 2021 at 8:50 AM Joshua Watt <JPEWhacker@gmail.com> wrote:

> The bitbake logger overrode the definition of the debug() logging call
> to include a debug level, but this causes problems with code that may
> be using standard python logging, since the extra argument is
> interpreted differently.
>
> Instead, change the bitbake loggers debug() call to match the python
> logger call and add a debug2() and debug3() API to replace calls that
> were logging to a different debug level.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>


Very nice.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Siemens Digital Industries Software

--00000000000029447a05bae9c79e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Feb 9, 2021 at 8:50 AM Joshua Wat=
t &lt;<a href=3D"mailto:JPEWhacker@gmail.com">JPEWhacker@gmail.com</a>&gt; =
wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">The bitbake logger overrode the definition of the debug()=
 logging call<br>
to include a debug level, but this causes problems with code that may<br>
be using standard python logging, since the extra argument is<br>
interpreted differently.<br>
<br>
Instead, change the bitbake loggers debug() call to match the python<br>
logger call and add a debug2() and debug3() API to replace calls that<br>
were logging to a different debug level.<br>
<br>
Signed-off-by: Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com" targ=
et=3D"_blank">JPEWhacker@gmail.com</a>&gt;</blockquote></div><div><br></div=
><div>Very nice.</div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><di=
v dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail =
dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software E=
ngineer, Siemens Digital Industries Software</div></div></div></div></div>

--00000000000029447a05bae9c79e--
