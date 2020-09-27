Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web12.7667.1601186547106465808
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Sep 2020 23:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=RswfNx6/;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: raj.khem@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id w12so7266243qki.6
        for <bitbake-devel@lists.openembedded.org>; Sat, 26 Sep 2020 23:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VmSrsv1CcB1469q1TcgpXzDTfPz0C+xnrL+zcIafHVA=;
        b=RswfNx6/RNHxwikNfSjgUUK1JTSAaK31sjcJGIPwAL/QyImRchQwbQHlaTxuGXqdUR
         88agSyfHIm+sOCLT8mAerW4DlpX6l9p7LUxMK8VlNeN7uyAZJMi9XR8k9OusE5HPYW0Q
         WW52fTQlT2ymqlxvozxYjSbkCDwlf5VKTvJMekOch0n78Jp8ILoy2FZLCAqzTb/tB5tL
         zXaHApoBysWWpdjeMD38tW2td/GOV8vXBx7JwRXScvbqbYS40x+aBNXr3Mj/u6X9ni3W
         2+iBlGxIgh82GXIZvCqDHn28Jk7NvJu9eA378guGuhE/VoFTSICAAXRBbafHpa/1Lk/G
         ecGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VmSrsv1CcB1469q1TcgpXzDTfPz0C+xnrL+zcIafHVA=;
        b=TTGuIZBgx2yLJqj02SrW91ls9Xw9U6/5b/E5UZ8rtIJ3FCY/RVOvEyCWVoaNGLHMCy
         BV/D/ILdqIQZg/ipuZLamw6YxqIOTjJmaYMyEKd53UfQoxFJpzdYE4kR4zZ6H7WXpHs7
         uE/VpA+sh2Yiir4moDH4/SLTJtWAxxLvk5ViYqsWz8v63s/VE4Hp4JRCYVQdLUnwCbpi
         ItYtGynJNkGFvAsVo7aaLUoJ307jY0Ns679jc4+1a6CFMbFjwQjRgz1BiJ+whCL/gyKs
         OoJUp8METv+TtLnDWyYkj9Sb8lUGzakSrYzJuP50gh6PN7EIQkbzN8dasX3aXBofvcDq
         DLdA==
X-Gm-Message-State: AOAM532AlHdm2tMQ9UnlL2dLg/rTDHvFvb7PR61+2+6RhYXjDKA0xT7y
	v/Y1bqwS+YEKcyVwnDdOglL3fx20XAdTjGitwshKDTCyuwZAWA==
X-Google-Smtp-Source: ABdhPJztiAsMYW8yc6QuBrwkxX9JE1Zqi/jvU6wto5i5B7nUWUdP+5WD81ZGxalgYsytMKdRlhaY273xZJrJtHBsnWU=
X-Received: by 2002:a37:9046:: with SMTP id s67mr7148489qkd.212.1601186546086;
 Sat, 26 Sep 2020 23:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <kcEE.ZOfbFqNNSymtV0U67GQmfg.ALXVsTmT1gE@groupware.mz.uib.gmbh>
In-Reply-To: <kcEE.ZOfbFqNNSymtV0U67GQmfg.ALXVsTmT1gE@groupware.mz.uib.gmbh>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Sat, 26 Sep 2020 23:02:00 -0700
Message-ID: <CAMKF1srTx6as9_qQrho3ce-qbDGTb-tTe0-H1njJb-W+foRnhw@mail.gmail.com>
Subject: Re: [bitbake-devel] where to find mkfs.ntfs ?
To: Mathias Radtke <m.radtke@uib.de>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

there is meta-filesystems/recipes-filesystems/ntfs-3g-ntfsprogs/ntfs-3g-ntf=
sprogs_2017.3.23.bb
in meta-openembedded repo, which you could use
but you might need to add BBCLASSEXTEND =3D "native" to make sure it can
be built for host, if you are trying to use it during cross compiling

On Fri, Sep 25, 2020 at 5:45 AM Mathias Radtke <m.radtke@uib.de> wrote:
>
> Hi
> I am building a bootimage with yocto(poky).
>
> Currently I am trying to find a package that provides mkfs.ntfs as we ne=
ed it to partition a disk that should contain a WinPE partition.
> Any suggestion which package it is?
>
> Regards
>
> Mathias
>
>
> --
> opsi - Open PC-Server-Integration
> das Open Source Client-Management-System von uib gmbh
>
>
> Mathias Radtke
> Entwicklung
> eMail: m.radtke@uib.de
> Tel. +49 6131 / 27561-16
> Fax  +49 6131 / 27561-22
>
> uib gmbh
> Bonifaziusplatz 1B
> 55118 Mainz
>
> Internet:
> https://uib.de
> https://opsi.org
>
> Geschftsfhrer: Dr. Detlef Oertel, Erol =C3=9Cl=C3=BCkmen
> Handelsregister: Amtsgericht Mainz HRB 6942
>
>
>=20
>
