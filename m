Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
 by mx.groups.io with SMTP id smtpd.web11.611.1626490516123147912
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jul 2021 19:55:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=r000imP+;
 spf=pass (domain: gmail.com, ip: 209.85.219.176, mailfrom: mayank77fromindia@gmail.com)
Received: by mail-yb1-f176.google.com with SMTP id v189so18016110ybg.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jul 2021 19:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gY6ahcIDpp/IcUTkfyXLLzWSd/qtyEQJDMvEmPP0tyc=;
        b=r000imP+q0SYOGImjbwCjAitaHJvcw1W7MfwYtrmMUsCH1QqtYCiRyuhu4Kxjl7xz7
         6lPka/Pjy+RUdM0OogafXoclAElKhAX0pD5SfbPqX0Zm6fpFHLLYPW9fAbDTsqh02e59
         r0edO93tan1sfnOga7NnLAdbMDPdi6yZkSoQCkLOPc9BKkieTATzYaTrJsqtKBWHYX+c
         DeXrMc+u5Vv95AaN9oRrJ46iZkYW+h9iaXZV3gfQbTx1MaU7fjBS5E3CL6+eqyfDtZDz
         T9rMx4NMWPz2O8n5/eZTccD5m7Qju6GGIg1OZwUKluq32A9X6tQ4y7m/h4oaEKqOgtlX
         Arng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gY6ahcIDpp/IcUTkfyXLLzWSd/qtyEQJDMvEmPP0tyc=;
        b=Bmo3gaH6zAMc0FaKgizYaoDMC///X3bzw8sm+mtxkLohHMvK2NV3pCHzeAob1OKk7m
         pwRuH/jmjUHfIYTdfiWFS2UJX3Iqz6tTjXMXL3rcWEBVNReg1HnqtSD40zycUeBMbZo5
         UxtL4+obLMWTTWFeVshintnEmX5JWqtsWbpUK68PPx1xolf+Aj38yU8ODtUsb9yVtudz
         vGbqxtIsl9SN5aXEb70ZBVcMoiTFnff9X3X5bpQsilnGIL1xRJVApJhWOk1bBYmwAyqk
         w62tj/iWb62dabfVMPDmYOGmVsjQGd8u6KbFbjP5LXeKo6IS4aV/aLPA0GjPfyS+l9Vu
         rglw==
X-Gm-Message-State: AOAM530LEWpV9N3LHdn+UX6ENR4GocytGCzpXdfeqtVUuAwe2bxxIyIk
	Gd4PACkzEddnj81odFdfwDihZQBSEoVJe142Lr0UudOAHT8=
X-Google-Smtp-Source: ABdhPJyhycQIEYdjkq4e2FrZnOimBynVbqbZTaUDJ+SOUHX8Dcdc61D2edBGaRIAu+QBhVGZj8Euwp/oQD3s7ec2qXM=
X-Received: by 2002:a5b:58e:: with SMTP id l14mr18419963ybp.143.1626490515059;
 Fri, 16 Jul 2021 19:55:15 -0700 (PDT)
MIME-Version: 1.0
From: "Mayank Agarwal" <mayank77fromindia@gmail.com>
Date: Sat, 17 Jul 2021 08:25:04 +0530
Message-ID: <CAKjpqyJ3NOLfgPQpuRqh6gwBJRZebW5sEPkEOT5bW6=Y_ZzkCA@mail.gmail.com>
Subject: how bitbake works
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000061771f05c748d526"

--00000000000061771f05c748d526
Content-Type: text/plain; charset="UTF-8"

Hi,

I am new to yocto.I have following doubts.

a) How bitbake decides the order of  compiling and executing modules.
b) Is it possible to compile 1 module before or after another one
c) Is there any file where we can see the complete list of all tasks that
bitbake executes in the order of execution.
d) How can we use logging mechanism in bitbake.Is it possible to put log
statements in recipe files and see the logs on terminal
during compilation and execution.
e) Optmization of bitbake steps.Is there any guide that tells how can we
optimize.For me 1 module takes close to 3 hrs in executing
Is there any method that i can reduce build time by pre compiling that
module.


Best Regards
Mayank

--00000000000061771f05c748d526
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am new to yocto.I have following =
doubts.</div><div><br></div><div>a) How bitbake decides the order of=C2=A0 =
compiling and executing modules.</div><div>b) Is it possible to compile 1 m=
odule before or after another=C2=A0one</div><div>c) Is there any file where=
 we can see the complete list of all tasks that bitbake executes in the ord=
er of execution.</div><div>d) How can we use logging mechanism in bitbake.I=
s it possible to put log statements in recipe files and see the logs on ter=
minal</div><div>during compilation and execution.</div><div>e) Optmization =
of bitbake steps.Is there any guide that tells how can we optimize.For me 1=
 module takes close to 3 hrs in executing</div><div>Is there any method tha=
t i can reduce build time by pre compiling that module.</div><div><br></div=
><div><br></div><div>Best Regards</div><div>Mayank</div></div>

--00000000000061771f05c748d526--
