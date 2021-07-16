Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web11.4863.1626434197421747134
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jul 2021 04:16:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=hT8ruErz;
 spf=pass (domain: gmail.com, ip: 209.85.219.179, mailfrom: mayank77fromindia@gmail.com)
Received: by mail-yb1-f179.google.com with SMTP id b13so14264362ybk.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jul 2021 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2NPZCc0UXMrNwyjgAqC37Zs6EvJBwbOe3IGbyoEXDLU=;
        b=hT8ruErzyVbapbD60wcFximwKhQFz4LmH0HcVnbZ07Rvzibq9Dzpv0zSF48x8A35QO
         7wK4vMLVLpe4SLnPVbZiwbnQcdZbOnwswkU5bNSVuwMdhr3gFfl1eczAU7E9SPgB57Kq
         xlBrYWd2MwlrLwHmEmWXm9R8LeFyeUAT0NN5jkPXINzjluRjsz7GJjOd9Bc1z/MTVgPR
         5UChh1ouLlwaR4qS/ZvkOH1hgSc0J/rCoUEkYb7B9ogl/+578qXOksC5AQ45kXRQ5s8g
         cVjPW1tI93l/gFxzP6INK7vYu/oAOmu6MHvsE0hUzWZ53z5TUIjggGWzMSSwuW2zUagr
         Pl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2NPZCc0UXMrNwyjgAqC37Zs6EvJBwbOe3IGbyoEXDLU=;
        b=GRXOnEWMVzLCD1h4lxnkY7of0WgWmPYZSZWBirLpWunMF/uiqU9o3Z520pEC7tnWRg
         Tc0/SEzASGxssFiZbjs6bXG26iiWLKGrNnKyMQRyk7Ve+ex5lRbYF2eHKqqetxs2siZk
         WzLJvlGakoyLhg9ODVLO4MfiXrRj/nOcpEyhsK6QqSHTicrh17DOVCXLiXb1KqTR+L8P
         i4GWkwREOcVw3s9mA5tUFqRNtLwetFL0UJkpTabjQ6dCDYnZIYFKxMlQNAQdF1bFdSyq
         GtyBnfrC3eRlN9+aNZFaPgBVqFZE2Ic37vQOOGkCWuh0F/G/Yba+mcX7X4eHtzk1H7Gd
         x/CA==
X-Gm-Message-State: AOAM532LGuQGvxqrhZyl4df8g8ZbdCRVXorMdmtsISaFtGY2qnnb0Xmm
	ObF0aUmZIbkOjQtYV9z5eQ6kjwSqLW8DYkB+jcrLk5jDUfQ=
X-Google-Smtp-Source: ABdhPJyr6SzV9IY4XJATg1ma3IqOyMPAhM1VhK1wsv64PriQL5F5/2G++MW7rd6r7MO4HuIiC0Xv+TshiQeNtH1E+yg=
X-Received: by 2002:a25:ab8b:: with SMTP id v11mr12263585ybi.375.1626434196496;
 Fri, 16 Jul 2021 04:16:36 -0700 (PDT)
MIME-Version: 1.0
From: "Mayank Agarwal" <mayank77fromindia@gmail.com>
Date: Fri, 16 Jul 2021 16:46:26 +0530
Message-ID: <CAKjpqyKztYNU8Suaq-PgC=A=VWLGGezYm3OzErSLbRVLZ7QNhQ@mail.gmail.com>
Subject: Bitbake rootfs issue
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000088652b05c73bb82e"

--00000000000088652b05c73bb82e
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am getting the issue that binaries are not installed in the final rootfs
after executing the build
using bitbake.The do_install function executes successfully but i am not
seeing the binaries
in rootfs.How can i debug this.
Also is there any sanity check or dependency  performs before putting the
binaries in rootfs
or generating the final image,if that how can we know because of which
dependency binaries are not installed in rootfs.

Best Regards
Mayank

--00000000000088652b05c73bb82e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I am getting the issue that bin=
aries are not installed in the final rootfs after executing the build</div>=
<div>using bitbake.The do_install function executes successfully but i am n=
ot seeing the binaries</div><div>in rootfs.How can i debug this.</div><div>=
Also is there any sanity=C2=A0check or dependency=C2=A0 performs before put=
ting the binaries=C2=A0in rootfs</div><div>or generating the final image,if=
 that how can we know because of which dependency=C2=A0binaries=C2=A0are no=
t installed in rootfs.</div><div><br></div><div>Best Regards</div><div>Maya=
nk</div></div>

--00000000000088652b05c73bb82e--
