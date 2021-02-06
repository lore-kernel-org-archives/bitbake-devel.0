Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.13674.1612653004343976488
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:10:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=jf2WUHp9;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id bl23so18864155ejb.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXoFi9ty8m2fhOo4tY6IZsGZ/4hQL1BOE9gcWzz0XVE=;
        b=jf2WUHp9t/mh4OZGuk7r8eQMxFcZm09Zc/36HRF9dG6pW+TJs0xjxrolUrfMTl2CWV
         +etvKrj2fop9NmlQgg1wsL5hB0r2cGmu2HtDmazzrhOZj8WqW4HtDDoBEAaW5mkmNd3e
         7V5gHApVlD+1YBGjf9KXVJDNfCTja/elqkUzmqj+xVJ2aa6a90xHggis/OGexOq4Gx+J
         3vPEYZt3i0XE3KjBHSWjn7poe8UCoRmIkP81tar3OJYT9yasnDbsZ8mHdQ8gcVuq7fTT
         Eet338j4DBtfvWqGK5IxqSq5QSAn4PR41XAFA+wNxLBjbDVfWUfC5vCaow+8W/bbTqV7
         9rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXoFi9ty8m2fhOo4tY6IZsGZ/4hQL1BOE9gcWzz0XVE=;
        b=lKQ82BNlujfwC2ge79+stCQM/3EyetkifajQJsK2ZfX4MmDg7ba2cBubex+ULAx0W2
         y4QGD9gknOBnTv9gMsnpWeKGXsKtpww6lDh400Xf+W5rnocCyw24PLESE0vknvK/iu6D
         mSGiQeZNgINMDtfGBQkdOmhPbzQuC7yRGZ+93dov9T7pG+NUlF9rL+j2WCvtbfLewTGe
         NKq4jlXhtXGKAtToEgUmnlUfNVes3rWfG4pR9yCildqG8O9LcbBLcQ6caToz1cGFDBX1
         ig+PoB6s89nPWqOgj4PEsTtuqJ2HQeX2s0UFLKuWbImE6Wk/4+m7yW9eeoA9hnkVqPsW
         JezQ==
X-Gm-Message-State: AOAM533wfLEKyFyHmW6ztTLtXnCUjzGhcdnI/1n/OrZBS2bFmV8D2ak9
	qh3rb+oEdc68Rr77EqL+fJfqWK22c7o8TacCu4I=
X-Google-Smtp-Source: ABdhPJwbhRUyOmBDaMs16NfzoOr11V7zvOBnUdsSI/y6WY8CLR701ENpcAD4OkVOpmum2W92EglRTdSyrr9Cbw3GO90=
X-Received: by 2002:a17:906:da0b:: with SMTP id fi11mr10687259ejb.392.1612653002819;
 Sat, 06 Feb 2021 15:10:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612652802.git.akuster808@gmail.com>
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Sun, 7 Feb 2021 00:09:51 +0100
Message-ID: <CA+chaQca+j4btP3UNS=B+Zv=th3qWFJbPjC_k9Hf86UoiTpsxQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [gatesgargh 00/10] patch review Feb 06
To: akuster <akuster808@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000610cc705bab309e4"

--000000000000610cc705bab309e4
Content-Type: text/plain; charset="UTF-8"

On Sun, Feb 7, 2021 at 12:08 AM akuster <akuster808@gmail.com> wrote:

> Next Gatesgarth patch review.
> Please have comments back by Monday.
>

wrong ML :).

--000000000000610cc705bab309e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sun, Feb 7, 2021 at 12:08 AM akuster &=
lt;<a href=3D"mailto:akuster808@gmail.com">akuster808@gmail.com</a>&gt; wro=
te:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Next Gatesgarth patch review.<br>
Please have comments back by Monday.<br></blockquote><div><br></div><div>wr=
ong ML :).=C2=A0</div></div></div>

--000000000000610cc705bab309e4--
