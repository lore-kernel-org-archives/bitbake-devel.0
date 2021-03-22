Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web11.836.1616448878713996137
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Mar 2021 14:34:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=MnG/8UZy;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: paulswirhun@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id c6so13529067qtc.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Mar 2021 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WT0byxElzqovRQJhU5V2IrXOsFztCIDOObaNOdTN5d4=;
        b=MnG/8UZyygWv/5H4HyBB6ph4uNcIaZnZ4f5OHS2E1L9230GdFVg31d2DpZzdv/bFLT
         atqkO3UqUDA92fmfPb1BTG27Sk+zm79siFDt8r5RDegItlW9jcQRhQfXbH2/Q8TFiwgU
         eLXcWrn3W7NaXzuhz41/UOITdOLekrFoo0p11Jds9EFcqGItab/uQqAqJcOUNjycl1XA
         /fBiFhcWonxdsZ30nE8yx8OaFVIO11EsYjEhec3NwP+RDdfF4h8AcwHVDg4QUGn9kUXl
         pvairE/DpwY7+5HXyUgemWLDlbrGc+JbxcFTKcpLW0pdsM3sxmIgcmF/tjrPHvHy1pnq
         qJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WT0byxElzqovRQJhU5V2IrXOsFztCIDOObaNOdTN5d4=;
        b=onjzsIcL8nHSnOv+nW5lQNDFoYi3Mpr5AjtfH6NK8WWyb8f470F8vQ97WtgHwWh+0n
         UiKM7DOU7WjQ/JkX8NaT+Uqk5MoWGtV1vWuuvWiF2YmR812aoZU1Xxcz1EMnY/2iATjc
         XtB049SJjlDuiuNHWuCZhiPodeXhO4Vj3/rjIezxKWTMgJnFm7WOezuzSIXTHKr0rc/+
         ha/xNLPhpkYZb8CTmGNJaryxpmhG5WobSV28zWsKAjAdUgXM+n0dfeIqAfPFJbxQd89S
         YchuZmqCTQv4Pk0+8hxGCzahY4B+MOoog6dOwbaL71zsYH4yv84DGJu6bhxuDczHou8Q
         xqxA==
X-Gm-Message-State: AOAM532fiuzgDEZtzd4/+hvFQolQzKKXZSVAIM02YmAGjJx4W9D0mXP9
	JyzJ3dpegxmOmd+xUvfrBp8EFzh2vpYBT3kkZRLL014YweE=
X-Google-Smtp-Source: ABdhPJwmHytcvR8eASOuYZfqcZR7Ale2oxcQx5J96Z5gLmDjbT0FnqhN2tdjF1QYo5WFYvO+G4RJj5jRwpgYZi2MMSw=
X-Received: by 2002:a05:622a:9:: with SMTP id x9mr1807639qtw.189.1616448877569;
 Mon, 22 Mar 2021 14:34:37 -0700 (PDT)
MIME-Version: 1.0
From: paulswirhun@gmail.com
Date: Mon, 22 Mar 2021 14:34:27 -0700
Message-ID: <CADOqROysGx1rYW3fccwLM8yf11kknp1kXSriwayY6XChE2Jf+g@mail.gmail.com>
Subject: Patching recipe from pypi
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000252b7f05be26d5be"

--000000000000252b7f05be26d5be
Content-Type: text/plain; charset="UTF-8"

Hello,

This is my first visit to this group, so my apologies if this is not the
appropriate way to ask a question.

I would like to patch or overwrite a .py file from a pypi library which had
a bug. The problem has been fixed at its source but I need the fixed
version integrated into our version of Yocto (Zeus). Can someone point me
to an example .bbappend recipe to replace a file populated by pip / pypi?
Specifically, devtools/python/python-periphery/mmio.py has a bug which has
been fixed in its top of tree but the old version remains and probably will
remain in Zeus for some time.

Thanks,
Paul

--000000000000252b7f05be26d5be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>This is my first visit to this g=
roup, so my apologies=C2=A0if this is not the appropriate way to ask a ques=
tion.</div><div><br></div><div>I would like to patch or overwrite a .py fil=
e from a pypi library which had a bug. The problem has been fixed at its so=
urce but I need the fixed version integrated into our version of Yocto (Zeu=
s). Can someone point me to an example .bbappend recipe to replace a file p=
opulated by pip / pypi? Specifically, devtools/python/python-periphery/mmio=
.py has a bug which has been fixed in its top of tree but the old version r=
emains and probably will remain in Zeus for some time.</div><div><br></div>=
<div>Thanks,</div><div>Paul</div></div>

--000000000000252b7f05be26d5be--
