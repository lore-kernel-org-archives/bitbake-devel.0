Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
 by mx.groups.io with SMTP id smtpd.web12.7655.1612858542893158822
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 00:15:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=uVJAZVR+;
 spf=pass (domain: gmail.com, ip: 209.85.166.176, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-il1-f176.google.com with SMTP id q5so15308426ilc.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Feb 2021 00:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FE9rLamP/aBgKnW1LRHtj/EmYsYMmsBwq/IoJkJ69Cs=;
        b=uVJAZVR+3jQTBup+LIuHn3BkpWO2LwN0ISou8hidM9fgU354CIxs5j1hgH5S73QhHM
         R9fbK6VwqFoVpS1744hBtZmuniSQQDanPHi3JoSYzWrAvXk7OecL6hfrxcWlLeKYt/MI
         hptCl3RvedgjqinAHyehawDy/lbP5wcu2LuHAFSq1S1+9JT/smsAmz6IyV4xU2f9mTU2
         v5afH1ayPJ9Fn6faCTJg4VdylK2xM48/1XZup6oj2umKexltkEzQgOFi0RZl7Hx3PHtO
         CxzRl+yO8IKBhv2Fd46ecwJdOCi7lWb6y+f3zxQgGVmShGiJI1HwlTnr6H2aV32u8yTE
         fc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FE9rLamP/aBgKnW1LRHtj/EmYsYMmsBwq/IoJkJ69Cs=;
        b=QcSJptCAp3BrG9wO1KhNH4VvhFzWuXhxQpa9G1vWlYA6LoCjI092GZHkaf5kYHKtuM
         Aa8AhPXktFsMpDShGLrBUWMQ4N+KfoHcfznoOweDjp3cbHb1yaTRgI7P0hRwyoK2cDIW
         NZwTNW/IR4H79rBvknpsxZKtfjx72WoOzNGUW4ZRawF7Oil8EyWs0ZXP5caHn+ggHIyK
         FVxq0xfLhws/UjyeyEzNlWquHUhil18JONGTjw2vz9Yhbpv27t0wix6kgfU1mtu08dHN
         cpltAsPODkMBcJYMNxb1xgf3Qui9FSCgVwtwyJCdnEvXtAXIsRBfZYuhF6ZeMxmyqox0
         /czg==
X-Gm-Message-State: AOAM533bRaQ3o8G1SxYd33SJYYh8OsoxsTtdnueqGE2i1bqSZdId2I4c
	0Iuqtmg+DFKuxvNKQjU7UUoY86E2ImLJp+M0Tno=
X-Google-Smtp-Source: ABdhPJwSHdW/ny7OBKDS/DTRdw3e2Xuk6Je+98MiPELiNneBrWShYFlFCSKx2t2C+RYyEOZ1UCeosRYrCWkll+AqUgA=
X-Received: by 2002:a05:6e02:1d02:: with SMTP id i2mr19646888ila.30.1612858542359;
 Tue, 09 Feb 2021 00:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20210206214034.295239-1-tomasz.dziendzielski@gmail.com> <28ad5643e356d5a2278f6d1aae24b6278f5ec5b6.camel@linuxfoundation.org>
In-Reply-To: <28ad5643e356d5a2278f6d1aae24b6278f5ec5b6.camel@linuxfoundation.org>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Tue, 9 Feb 2021 09:17:07 +0100
Message-ID: <CAJkqNs2M37iAe9K=0DrAzYXvzQ4W90-uNcjJd0X3_aDo6+TXnA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] event: Prevent bitbake from executing event handler for wrong multiconfig target
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000007d86c005bae2e425"

--0000000000007d86c005bae2e425
Content-Type: text/plain; charset="UTF-8"

>This seemed to trigger a different problem, seen in a few different
>builds/tests:
>
>https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1831

The error here is:
>ERROR: Undefined event handler function 'kmonitor_139920531531424'
which means I did not add the multiconfig prefix to _bb_diskmonitor_
handler and next step wanted to remove that prefix and wrongly cut the
name. I submitted another patch where correctly I added the prefix to
handler name:
https://lists.openembedded.org/g/bitbake-devel/message/12002

Best regards,
Tomasz Dziendzielski

--0000000000007d86c005bae2e425
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;This seemed to trigger a different problem, seen in a =
few different<br>
&gt;builds/tests:<br>
&gt;<br>&gt;<a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/build=
ers/83/builds/1831" rel=3D"noreferrer" target=3D"_blank">https://autobuilde=
r.yoctoproject.org/typhoon/#/builders/83/builds/1831</a><br><div><br></div>=
<div>The error here is:<br></div>&gt;ERROR: Undefined event handler functio=
n &#39;kmonitor_139920531531424&#39;<br><div>which means I did not add the =
multiconfig prefix to _bb_diskmonitor_ handler and next step wanted to remo=
ve that prefix and wrongly cut the name. I submitted another patch where co=
rrectly I added the prefix to handler name:<br></div><div><a href=3D"https:=
//lists.openembedded.org/g/bitbake-devel/message/12002">https://lists.opene=
mbedded.org/g/bitbake-devel/message/12002</a></div><div><br></div><div>Best=
 regards,</div><div>Tomasz Dziendzielski<br></div></div>

--0000000000007d86c005bae2e425--
