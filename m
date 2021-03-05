Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web12.9461.1614934926417899872
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Mar 2021 01:02:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Pzv3cGgN;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id a7so1179041iok.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Mar 2021 01:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uwl8Tgbd18UyFFdBfGMjXJcNR7j1sbTsz1W3X2EuK8=;
        b=Pzv3cGgNGov/j2Gpo/yATrKTVYDHC/4RjbEd2UWbiEbDIFG8g/SbKkDidyVsoNHXXL
         rnn0ERfE64HCOIa4leT7CuabOKp7xhiPO27L8jeRRPRCA7E57F0Kq7yTIqF7NnLeLk/K
         oSEyQmZeRuS9pAGfc32/uprFpfG+Hz9L4L1qrgRTb9T3fWf34Wd/GPWJpp20kJUSHn40
         OwfmsHBHwx8yPDHkzs1jQbBx/dYY+vIHG/o9ptwQKNAFffB6l1D7u/yuDqq9PBUukl5q
         tHQUjwMBOdXTgr2Nzr+9wv/5C4QSfqCg8RGVRkeSTKKxoz96EozByRIo7NM7W1bcVlEg
         p0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uwl8Tgbd18UyFFdBfGMjXJcNR7j1sbTsz1W3X2EuK8=;
        b=YALg9giBAF69+wqGeikC/XAwnYPgoN3GnCGnSvL+vhEj5Q4LtxFvHP14epJkTiu5Dk
         p60+K1QTBQtP8ZnOxGee1qNLIxnM9W0M34VVJaikVQHNHDm/xJ0ca5Jp7OGdg33qq811
         wkrLiUizFNKZW4pVNreHPB/T49ya4+OsAz/H6YqTcMl6EOADLQowWvqgHcXZZSjOqX6n
         GbndbTNfwvo44YWE2fysxCuo3+gdl2J2r4HeRK/PdX2Fm8G3MJlmKM3mLkkhadc9qIkL
         DPjcPSFsBkANBTPDNoBrj9NupuTXEDLdWaiIVZGTuQ7sHhSmj3+SVK2w9H2NK4dPyhWm
         rwWw==
X-Gm-Message-State: AOAM5322WIGaX2U5q/9DsNj3p+SFMbtd7igsMkW4n52va0iRBQp1C134
	/X64EE9dZWse5o40g7ErlYNawfOf0TmOF42Z+zNQ0M2M3zI=
X-Google-Smtp-Source: ABdhPJzYJgr8A1FBd7dk+zDjy7jDw9k+GrQsEKOu0eh1mnUeZv76c66EfMIIUZ+P6PseXgPX4CJWkK4ECGhVEt/PzX8=
X-Received: by 2002:a5d:9418:: with SMTP id v24mr7310968ion.61.1614934925559;
 Fri, 05 Mar 2021 01:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20210222203630.9686-1-tomasz.dziendzielski@gmail.com>
In-Reply-To: <20210222203630.9686-1-tomasz.dziendzielski@gmail.com>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Fri, 5 Mar 2021 10:03:49 +0100
Message-ID: <CAJkqNs3JqXTh9R3BEqz3AV2cSi5L93OD+pk_byiu-K8AqUykng@mail.gmail.com>
Subject: Re: [PATCH v3] runqueue: Print pseudo.log if fakeroot task failed
To: bitbake-devel@lists.openembedded.org
Cc: kergoth@gmail.com, Jan Brzezanski <jan.brzezanski@gmail.com>, 
	Paulo Neves <ptsneves@gmail.com>, Mikolaj Lasota <mikolaj.lasota@protonmail.com>, 
	Wiktor Baura <wbaura@gmail.com>, Kamil Kwiek <kamil.kwiek@gmail.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="00000000000092ce1805bcc6561e"

--00000000000092ce1805bcc6561e
Content-Type: text/plain; charset="UTF-8"

Hello,
I found a worrying issue in runqueue.py exposed by this patch. Lately I
encountered a few cases where pseudo.log was not printed on pseudo abort. I
added some debug prints and it seems in some cases (where we build the
whole image, not single recipe) taskfn is set incorrectly.
The recipe X failed with task log:
|  Check logfile: X_WORKDIR/pseudo//pseudo.log
| ...
| ERROR: Logfile of failure stored in: X_WORKDIR/temp/log.do_install.34470
but the debug line printing taskfn value and pseudo.log path taken from
dictionary (based on taskfn) showed:
| WARNING: taskfn: PATH/Y.bb pseudo_log: Y_WORKDIR/pseudo/pseudo.log
And since there were no pseudo abort in Y recipe the log was not printed.
(Please note that this warning comes from the failed task from X recipe)

The important note is that I don't change the value of taskfn with a patch
sent under this subject, so it's unlikely that my patch introduced this
behaviour. In this patch I just pass current taskfn value to
start_fakeworker(), so in fact it's value is already wrong in the execute()
method. It means something else might also be broken and not yet detected.
Please correct me if I made some wrong assumption. Maybe taskfn is expected
to have some different value and I just shouldn't depend on it? I can't be
100% sure it's not related to my changes, that's why I'm writing in this
thread, instead of submitting a bug.

Best regards,
Tomasz Dziendzielski

--00000000000092ce1805bcc6561e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,<br></div><div>I found a worrying issue in runq=
ueue.py exposed by this patch. Lately I encountered a few cases where pseud=
o.log was not printed on pseudo abort. I added some debug prints and it see=
ms in some cases (where we build the whole image, not single recipe) taskfn=
 is set incorrectly.<br></div><div></div><div>The recipe X failed with task=
 log:<br></div><div>|=C2=A0 Check logfile: X_WORKDIR/pseudo//pseudo.log<br>=
| ...<br>| ERROR: Logfile of failure stored in: X_WORKDIR/temp/log.do_insta=
ll.34470<br>but the debug line printing taskfn value and pseudo.log path ta=
ken from dictionary (based on taskfn) showed:<br>| WARNING: taskfn: PATH/Y.=
bb pseudo_log: Y_WORKDIR/pseudo/pseudo.log<br></div><div>And since there we=
re no pseudo abort in Y recipe the log was not printed. (Please note that t=
his warning comes from the failed task from X recipe)<br></div><div><br></d=
iv><div>The important note is that I don&#39;t change the value of taskfn w=
ith a patch sent under this subject, so it&#39;s unlikely that my patch int=
roduced this behaviour. In this patch I just pass current taskfn value to s=
tart_fakeworker(), so in fact it&#39;s value is already wrong in the execut=
e() method. It means something else might also be broken and not yet detect=
ed.  Please correct me if I made some wrong assumption. Maybe taskfn is exp=
ected to have some different value and I just shouldn&#39;t depend on it? I=
 can&#39;t be 100% sure it&#39;s not related to my changes, that&#39;s why =
I&#39;m writing in this thread, instead of submitting a bug.<br></div><div>=
<br></div><div>Best regards,</div><div>Tomasz Dziendzielski<br></div><div><=
br></div></div>

--00000000000092ce1805bcc6561e--
