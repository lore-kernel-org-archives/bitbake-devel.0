Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.web08.10152.1612455099595787292
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Feb 2021 08:11:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=n39gM6ad;
 spf=pass (domain: gmail.com, ip: 209.85.166.182, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-il1-f182.google.com with SMTP id d6so3065934ilo.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Feb 2021 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbXWV2mVoexJFsu63w0i+o6Muvum0sWV8iN2/ES7yyg=;
        b=n39gM6adnpP8gXsry5M24DKri/YWwUIOoztuIB83glWuywCmd3IAfu1Iun1aaSpM0P
         Vg+88a52aJL7yJjAw2l1MAbfUqq8hbXGqscCU/wkxcE1nOn0T7ncgFz/W8si2sqOwV/n
         a1lAZdqzQSo3TttLh7wBOTpCqBVeRltqgjAg03NIVyzrt0jghFXLsnIR2tn0rLIOVKd5
         kkfcp+nEToNQ4SiIJv1hhJg68ozkBBXEp/s6yuKg0FuRIQ10qKPn2/mL1Btw7SKMUK/5
         id97A367JeO5NhlyHKpq/eRN0iNP3xOKTADcumwTVrMU+vTKjZnX9RKUIAgf+oBDTtC6
         mG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbXWV2mVoexJFsu63w0i+o6Muvum0sWV8iN2/ES7yyg=;
        b=gJxinl3r50kPUXkLbqRaUCD3vOfq5bQ9osIrWAwp3hQ5mIHs5AGSMa4XgmnTwVPF7V
         p9j6FJk0ZDLMhY3JaANSLVyA2hAtZVa70K70/PHNv1R2lAjKKeY8EsQGbrZUgx9vKPbF
         y7XtcpmVIKKHYntywD3uOGlk8vQxlPvb793TNs4DIPz1DK6ND+ScZd3XwjKtfnGFeoPA
         OHieuXm2cldx699FFH/ONydyYu/iRAGfAn7XBrXDbQVbfbDOb63MxET1M2mRyUwsfWqL
         FhhYi6mW311lqWQ87EeElKriRMb9hSrNRwr/aPUaXEIqV+NSKpoq1QwxoRb7B2C2HG1a
         pl6g==
X-Gm-Message-State: AOAM5306GwMZge+LHAbX2A7kivvQp5tp4fcQMBBZrfeMaIl3Dxc4ibmB
	j/lojhxzvd5oJs0BRoH1qd2ZDYdJd9qoKWLZLZE=
X-Google-Smtp-Source: ABdhPJwuuQ3/DeAu0W2t7FGtUmioK0zwyyJ+GtZRImHKlTlzLsr7aAnnL7lJnvwnudZBHybbf1Dn8oaV8DYx6e4NeU8=
X-Received: by 2002:a05:6e02:5c3:: with SMTP id l3mr7136908ils.292.1612455099037;
 Thu, 04 Feb 2021 08:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20210204010231.1380-1-tomasz.dziendzielski@gmail.com> <c4a343366f873c3b1deee2f83bdc38638b98a677.camel@linuxfoundation.org>
In-Reply-To: <c4a343366f873c3b1deee2f83bdc38638b98a677.camel@linuxfoundation.org>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Thu, 4 Feb 2021 17:14:13 +0100
Message-ID: <CAJkqNs0gA1GZDDAEoeJRjejOd_6jKNV4kbCy21NOXYKge5Mu6g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] event: Prevent bitbake from executing events that don't exist for multiconfig target
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000064fb9605ba84f581"

--00000000000064fb9605ba84f581
Content-Type: text/plain; charset="UTF-8"

> This looks interesting. It does make me wonder what happens if the
>different multiconfigs have a handler with slightly different code but
>the same name though?

Hi Richard,
I created two .bbclasses that add event handlers with the same name
printing "default" in eventdefault.bbclass and "arm" in eventarm.bbclass.
Both are triggered on BuildStarted and BuildCompleted.
If I put INHERIT += "eventdefault" to local.conf then "default" is printed
4 times (which is correct). If instead I put INHERIT += "eventarm" to
multiconfig/arm.conf then "arm" is printed 2 times (also correct). But when
I put INHERIT += "eventdefault" in local.conf and INHERIT+= "eventarm" in
multiconfig/arm.conf then "default" is printed 4 times and "arm" is not
printed at all - in this case both "default" and "arm" should be printed
twice.

Best regards,
Tomasz Dziendzielski

--00000000000064fb9605ba84f581
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt;
This looks interesting. It does make me wonder what happens if the<br>&gt;d=
ifferent multiconfigs have a handler with slightly different code but<br>
&gt;the same name though?<br><br>Hi Richard,<br>I created two .bbclasses th=
at add event handlers with the same name printing  &quot;default&quot; in e=
ventdefault.bbclass and &quot;arm&quot; in eventarm.bbclass. Both are trigg=
ered on BuildStarted and BuildCompleted.</div><div>If I put INHERIT +=3D &q=
uot;eventdefault&quot; to local.conf then &quot;default&quot; is printed 4 =
times (which is correct). If instead I put INHERIT +=3D &quot;eventarm&quot=
; to multiconfig/arm.conf then &quot;arm&quot; is printed 2 times (also cor=
rect). But when I put INHERIT +=3D &quot;eventdefault&quot; in local.conf a=
nd INHERIT+=3D &quot;eventarm&quot; in multiconfig/arm.conf then &quot;defa=
ult&quot; is printed 4 times and &quot;arm&quot; is not printed at all - in=
 this case both &quot;default&quot; and &quot;arm&quot; should be printed t=
wice.<br></div><div><br></div><div>Best regards,</div><div>Tomasz Dziendzie=
lski<br></div></div>

--00000000000064fb9605ba84f581--
