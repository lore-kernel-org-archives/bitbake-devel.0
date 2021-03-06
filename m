Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web12.6902.1615034887249821420
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Mar 2021 04:48:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=DwcFmX9j;
 spf=pass (domain: gmail.com, ip: 209.85.166.170, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-il1-f170.google.com with SMTP id h18so4601149ils.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Mar 2021 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39JkXIoN1x/79202q0Hffxx8UFNBUCoYSPEi+fuf7B8=;
        b=DwcFmX9jupQKM6u9ahPOpBAJYgdKv1V4M+o7bEDJ4PfGWXuMbnz9XJLSi2Dw70iEPS
         LWGXjFS4+RCX3/ebjCBg9W5FzrSm3X7qmn/NVi2BRbfslmacEGDTz098nnq9d1SgG5zk
         ZrlFor9Xy9IZEJE65UWuuzi6hSwpf+14Iiwg6RV7Y160f86nSNphOLYbX3qN7Xt1J6+b
         MZJZobpg0BaeSzOXNS0cPOyDnJpDhokGxn2EbLYTKO8FJNucAmMG+6Zpuicu1iQ+viFd
         22za5Jk3kcvLjIJT5q5HWAs5bmclo5gxmqwcwqtjMleT4j7QiGabmzQ0KhooGYTe+TRU
         EpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39JkXIoN1x/79202q0Hffxx8UFNBUCoYSPEi+fuf7B8=;
        b=hvChmt5gCsA5luiN/nuE93TPkxvk/T1FrD4KD8qsHx/8w1hK1Lvcjy8AEGm5B/SjWi
         wqEJ8xmJuD/EJWq1g0oDDvxoOy8rP8cYM1LYQ5dnzOJlkNIB0pMxrxDqSiAZgefzdo85
         w5rObWqOcGqweRQT4KEXH2YskJYE458JpC8EZkJCpoLZC76rwxYrM3foGazg7meQHdm1
         pZDJtRW1QQTd4L1NWUgyrJlFTnrwIEUz6LCUTM21aEMD3Om0DUpuGLRWm1WoloC1M/DD
         KSxXC5pPimnCikuP9D3SmKdjaPGBCc/GfThEZjXQ8BFFldDb94vrDBiQOrqsLizFDcdH
         YDmQ==
X-Gm-Message-State: AOAM532CXVlkqqFqRUu5+5zSRdXjpxXcJL5IG73gsYi7BIjvc8mCLAGI
	ghnJQW20FwJtIuPAp9jDEFmtWD0J3TohpxdK4Vg=
X-Google-Smtp-Source: ABdhPJz9m5sOpo6G3lxoUL4OXT3A0DDUgxSg4J0BfL6dw+HNUfKOdpK5Inc3385Wapz84SKeUkLJnr8Vd9pyS7Z4Y2s=
X-Received: by 2002:a92:b08:: with SMTP id b8mr13032875ilf.13.1615034886572;
 Sat, 06 Mar 2021 04:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20210210111515.1189896-1-tomasz.dziendzielski@gmail.com> <ede980db00b9924e73ce83cfcdfa0a734f426dd4.camel@linuxfoundation.org>
In-Reply-To: <ede980db00b9924e73ce83cfcdfa0a734f426dd4.camel@linuxfoundation.org>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Sat, 6 Mar 2021 13:50:50 +0100
Message-ID: <CAJkqNs1_oXuRtGNXH5meVY+Lw-O5bjEq1TivksnkXE4SmR5-1A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v5] event: Prevent bitbake from executing event handler for wrong multiconfig target
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Content-Type: multipart/alternative; boundary="000000000000b6ce3605bcdd9cd6"

--000000000000b6ce3605bcdd9cd6
Content-Type: text/plain; charset="UTF-8"

>Somehow I suspect this patch is causing a parsing speed regression:
>
>
https://autobuilder.yocto.io/pub/non-release/20210305-7/testresults/buildperf-ubuntu1604/perf-ubuntu1604_master_20210305150036_c8075ed8f1.html
>
>See the "test3: Bitbake parsing (bitbake -p)" where you see bitbake -p
>goes from 19s to 22-23s. With more layers the issue becomes more
>pronounced.
>
>I haven't 100% confirmed this yet or looked into it but we need to find
>out what cause the parsing speed regression from around this time...

It's possible this patch is causing the regression, since in
fire_class_handlers we iterate over the _BBHANDLERS_MC list multiple times
to check if it contains an event name.

def fire_class_handlers(event, d):
...
+ if d and not name in (d.getVar("__BBHANDLERS_MC") or []):
+ continue

I've sent a patch changing this structure into a set that is faster than
list in checking if an item is present in the structure. Anyway, I can't
confirm if it is the case, since the difference in parsing time is not
significant in my environment. If not, then it's still good to merge it.
https://lists.openembedded.org/g/bitbake-devel/message/12072

Please note that this patch might conflict with:
https://lists.openembedded.org/g/bitbake-devel/message/12053
so one of them will require adaptation depending on the order of merging.

Best regards,
Tomasz Dziendzielski

--000000000000b6ce3605bcdd9cd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr">&gt;Somehow I suspect this patch is =
causing a parsing speed regression:<br>&gt;<br>&gt;<a href=3D"https://autob=
uilder.yocto.io/pub/non-release/20210305-7/testresults/buildperf-ubuntu1604=
/perf-ubuntu1604_master_20210305150036_c8075ed8f1.html">https://autobuilder=
.yocto.io/pub/non-release/20210305-7/testresults/buildperf-ubuntu1604/perf-=
ubuntu1604_master_20210305150036_c8075ed8f1.html</a><br>&gt;<br>&gt;See the=
 &quot;test3: Bitbake parsing (bitbake -p)&quot; where you see bitbake -p<b=
r>&gt;goes from 19s to 22-23s. With more layers the issue becomes more<br>&=
gt;pronounced.<br>&gt;<br>&gt;I haven&#39;t 100% confirmed this yet or look=
ed into it but we need to find<br>&gt;out what cause the parsing speed regr=
ession from around this time...</div><br></div><div>It&#39;s possible this =
patch is causing the regression, since in fire_class_handlers we iterate  o=
ver the _BBHANDLERS_MC list multiple times to check if it contains an event=
 name.<br></div><div><br></div><div> def fire_class_handlers(event, d):</di=
v>...<br>+            if d and not name in (d.getVar(&quot;__BBHANDLERS_MC&=
quot;) or []):<br><div>+                continue</div><div><br></div><div>I=
&#39;ve sent a patch changing this structure into a set that is faster than=
 list in checking if an item is present in the structure. Anyway, I can&#39=
;t confirm if it is the case, since the difference in parsing time is not s=
ignificant in my environment. If not, then it&#39;s still good to merge it.=
</div><div><a href=3D"https://lists.openembedded.org/g/bitbake-devel/messag=
e/12072">https://lists.openembedded.org/g/bitbake-devel/message/12072</a></=
div><div><br></div><div>Please note that this patch might conflict with:<br=
><a href=3D"https://lists.openembedded.org/g/bitbake-devel/message/12053">h=
ttps://lists.openembedded.org/g/bitbake-devel/message/12053</a></div><div>s=
o one of them will require adaptation depending on the order of merging.</d=
iv><div><br></div><div>Best regards,</div><div>Tomasz Dziendzielski<br></di=
v></div>

--000000000000b6ce3605bcdd9cd6--
