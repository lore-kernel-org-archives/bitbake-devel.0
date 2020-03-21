Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
 by mx.groups.io with SMTP id smtpd.web12.20742.1584835147324453701
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Mar 2020 16:59:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=DEb7aXQs;
 spf=pass (domain: gmail.com, ip: 209.85.160.195, mailfrom: raj.khem@gmail.com)
Received: by mail-qt1-f195.google.com with SMTP id v15so8592308qto.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Mar 2020 16:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nmFSxyLnKYIKmXVjrSp/mJkgGUeQYqg4gDSpdirdwoA=;
        b=DEb7aXQsawnohbVwSbsEVIPFyeabFYJWkbY049pRcNopGsPS7HqLsvKDGaVVipF++S
         JHMpBfoj/PaAzhQbBLWhFumP7pUBwZCuFbyOeA5VeVVJ1F9jBZPq4/BaHE/+YF9ELqOq
         xoFo64Ah6uXsqAdguCgl8NzGCHJxHcEV4JzeGiVtl1jgmoxxDEnA2+wzWv5aCxbV1fFQ
         TX8onClexDlgKMyg3120aq9uRD6MmW1qQLs321q5arFBx6Ukf8xga1uQ7yumlOc//kWg
         QHddJMEsM6eecZDzXxo+P4gWEjJEuNiOLdNnbxx0Jp4NYCB16k3vSQ9aszuAIBgwrEZ4
         sakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nmFSxyLnKYIKmXVjrSp/mJkgGUeQYqg4gDSpdirdwoA=;
        b=cHCt09usOL1+HScumKylsnT+aDVI+CB70bS1rcuJqFlxZZqebWkVtliauNYK+fy95c
         LLRPPUfLy6uegW4cq77hUU58ERc871dop3VfUj1zIZ0JMZFVC5XcGSSsvGLndufBNmsJ
         RingnvpEc4hS+m6V3laaTQlnEqvsyfGKQ/xmfNY5SR6W774HRR1fjK/U6MhxH0JNjz8k
         iciFP5MN9KUhCS8Yh6jh18sng/50Pda6TjsfMa7+osDXENNk/JmnfgaOMiIRlAU1JDG+
         0T1os+azHJcD8g0x/CL9nf8hujWMpompfIqR0A2fphaLspgbIFEJtKsb+rKvbcsicHLl
         xcgg==
X-Gm-Message-State: ANhLgQ1rA/cGixcZH8ZsD/EhpZqKVhJZ89KivoqiTwVX62sixLgt/EZT
	vEqGKjT9JWM9HJET5dFdLVh64tfvAytYw5bySrk=
X-Google-Smtp-Source: ADFU+vuDi4NI523RcgE/k1Ch1elr82yQvs2GUD58V/Ula1HpZXrmOalNAjqb2JcJPuMswS6MkW8cb84pasZDCGBgzkI=
X-Received: by 2002:ac8:a09:: with SMTP id b9mr15272698qti.190.1584835146133;
 Sat, 21 Mar 2020 16:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200215032955.3958-3-pkj@axis.com> <5532.1584827063458682607@lists.openembedded.org>
 <1cdd50184c1f4af488baee9ee691b495@XBOX03.axis.com>
In-Reply-To: <1cdd50184c1f4af488baee9ee691b495@XBOX03.axis.com>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Sat, 21 Mar 2020 16:58:38 -0700
Message-ID: <CAMKF1srOQVRW8n9bzr9GXiA3NBOX=cE5EV-W9S_dq+JFRqNjMQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2020 at 4:50 PM Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
>
> Rather than blindly reverting, can=E2=80=99t we update the documentation =
instead? If you use ${AUTOREV} you obviously do it because you always want =
the latest revision.
>

Autorev + clear srcrev policy if you want that

>
>
> Before this change, using ${AUTOREV} in combination with BB_SRCREV_POLICY=
 =3D =E2=80=9Ccache=E2=80=9D didn=E2=80=99t work, which also wasn=E2=80=99t=
 documented.
>
It could be interpreted also that cache also caches AUTOREVs
this will break downstream projects. Its equivalent of ABI change,
that perhaps will do more harm then what it fixes.

>
>
> //Peter
>
>
>
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Khem Raj
> Sent: den 21 mars 2020 22:44
> To: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow ${AU=
TOREV} to be used when BB_SRCREV_POLICY is "cache"
>
>
>
> removing
>
> if d.getVar('BB_SRCREV_POLICY') !=3D "cache":
>
> Will cause autorevs to be excluded from policy and its not documented
>
> https://www.yoctoproject.org/docs/2.1/bitbake-user-manual/bitbake-user-ma=
nual.html#var-BB_SRCREV_POLICY
>
> did not state that AUTOREVs plus BB_SRCREV_POLICY behavior, this patch is=
 regressing the case
> where we rely on this behavior to use externalsrc on AUTOREVed recipes.
