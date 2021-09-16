Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web12.485.1631810720848945601
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 09:45:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=by/yZpdc;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: mayank77fromindia@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id 73so3292745qki.4;
        Thu, 16 Sep 2021 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=XBqfWzWUJL79BzGqb5sZUswc19M+jwnvdIAGZnQpc3w=;
        b=by/yZpdcFetxzKhybWa9/FJs8hl6mNlcqmaDi/eg9LHrnMGdUwq8339TjsnBPtTun1
         FvZ9gHmBF2MDEVYcGJJJQhKFoF0rZdJhh0yohWyR+pSg7LiUV4+HStoAhQUGUsPO/sm+
         5p6vUzyAPkrZdoPWxXJaW1jxndQXbzqn2ko4EOUQsJye02DTUX7lm95GHpQ2HOLFWqLT
         5MM3rSlaC2FFajpLNTx3MxJJCGF203fVH6+11x46QYvAQpKgRu6NJL7ZLwz4RBwa6IH8
         Vx9EnUgw6OOUnQ19+5IJiD77HC3oB3YoCXu9y6oVPxpldKjrjb7HlWywpYWFvsj0WSqQ
         Ft8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XBqfWzWUJL79BzGqb5sZUswc19M+jwnvdIAGZnQpc3w=;
        b=Wxwmces8sZhzXp/RmQR/OSZf4jyPFEyoU9Km9qBQiqpi+blc9mtRJdHFTjMd8ojMd/
         II4Udr5wrtvB/9ZmQhobAPdkHI07XEMnbN9JKMVEkbLg3vWeEfsC6ISplRPw6OifRv/S
         r3Oxylwihl/XhOlp2WVy/YO7C/Eu9FoeQsf3241vOlG9PIYbv7/Zf+6lFSSc1IxOOWgk
         vOLOT9geQhvHTlcJlbhRTmm3eACoKltH4YpZlMaMMR+pQIkMJU1JglUC1KqmY1+NPhco
         WgT0h1be6/LRA8C1aPD2TBTksyTRZcAajCpAXaB/C24nqU0wX+Jq+MvTjprX0/ns83tz
         U3FQ==
X-Gm-Message-State: AOAM5335qi9yOi5P7xawQh+KzNRJqtByChk+jQlr2EMsUnu5u2A7otZ8
	PtP0m4M2PDhtnIjsSPiIQp5/3k9HWF6EjY1ffbCiPax9DdU=
X-Google-Smtp-Source: ABdhPJwbuNn/2QKcqy11ALfW2v84FybQ/6kFKyZsC6zxhgnVSzcVvAisvXaYfKiGRVSJpqPdJoHRZAg/ObkHsphazMM=
X-Received: by 2002:a25:be90:: with SMTP id i16mr5841326ybk.202.1631810719034;
 Thu, 16 Sep 2021 09:45:19 -0700 (PDT)
MIME-Version: 1.0
From: "Mayank Agarwal" <mayank77fromindia@gmail.com>
Date: Thu, 16 Sep 2021 22:15:07 +0530
Message-ID: <CAKjpqyJZGQh0BruPiny5X=hv3iqsfzj+FJwmdzXdWm-ThzgQhA@mail.gmail.com>
Subject: Disable bbappend file from another meta layer
To: bitbake-devel@lists.openembedded.org, 
	openembedded-architecture@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000003fb3c405cc1f8af1"

--0000000000003fb3c405cc1f8af1
Content-Type: text/plain; charset="UTF-8"

Dear Experts,

Is there any way we can disable bbappend file from another meta-layer in
the current
meta-layer or recipe file.It will be of great help.If we can use
PNBLACKLIST or BBMASK
to disable bbappend file.

Regards
Mayank

--0000000000003fb3c405cc1f8af1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Experts,<div><br></div><div>Is there any way we can d=
isable bbappend file from another meta-layer in the current</div><div>meta-=
layer or recipe file.It will be of great help.If we can use PNBLACKLIST=C2=
=A0or BBMASK</div><div>to disable bbappend file.</div><div><br></div><div>R=
egards</div><div>Mayank</div></div>

--0000000000003fb3c405cc1f8af1--
