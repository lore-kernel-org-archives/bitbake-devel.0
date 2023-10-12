Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51803C41513
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 14:00:52 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.web11.12252.1697119249621857967
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 07:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NaDvxc4r;
 spf=pass (domain: gmail.com, ip: 209.85.128.178, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7c7262d5eso12642857b3.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697119248; x=1697724048; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iv7qcWRQ3nI4oCThnku3f4gu+eRVeSqtXf5n9dHh6/s=;
        b=NaDvxc4rE9Nkwsjws9uOXihYINGPVfbljbhscgsIBNunvt5J5KJNUyPuyt4waGL+zF
         /PhdFaH8ZwXkqzawrMyyx7dooO9o1WdFhdfzayM9qDcfX2Fhr0qPzUvml+YTX7pcyVUD
         jThLaSanSPWSFmp/Pc5q0YHZugrp/S5cvymx2Vm9sIuHvWflG/56byWGNEqnxo03mxnq
         s4cLXmk1kpWdek6LBRZXE16XtQ1gq/TrhXmIEk0npmIfJiw/aWgaojctw8C/f0pVeSA2
         e4PWBQpo8pcVviEJIdE6KuRr7S47OrRg7W+V1KNYgj1q4RT1FNLhbCSVWQtMf5buy0gi
         Yb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697119248; x=1697724048;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv7qcWRQ3nI4oCThnku3f4gu+eRVeSqtXf5n9dHh6/s=;
        b=K5DWkO0slZCWNnmbOq+8iEBwtN7WrTvRuFnsbUJ4K9J5MhICvK8ZQjOG/tG4s4lRbp
         J+tqvP8rohQBdROGiGsiR7huzvMxUvauc58G6i0XOBQVqwDbxUpqOnI5mMzZh3pE6tCH
         ndgiiVSJ9iVA7VybTtbypMFU/oEPhQMAXeJ0LAo89A/qw0joL2nhTCyYeb5WQ3NsxGEu
         iDLXfsCZt+BuebofvLDIpP5h52iiwg7B6npYd6fw0J+lUyCpKdA62fvU/Jxarh7iRCrU
         30M3CjnruI07uYY+Xd/cJPI3S/htb+kh9MZVsOlGGS+XqtF20bAcWFslscIf1L3Kbwcl
         Ma4A==
X-Gm-Message-State: AOJu0YxsI5waxRsNh4Ff7MbXDbSbv42D4ETDJYor7tRHynvc1E6HchfY
	ZFr19UAlGSg70PHyLZW5Se4cP783q1sakVoFiGdmJxLx
X-Google-Smtp-Source: AGHT+IGYCkTymMKMn/q8GeKG3yJ8vYZweyy4TBYcFsfnXFeU1xrb51qull3IGnxFqoj7rSWLhBFm7J9c9WY2CpFFEm0=
X-Received: by 2002:a81:7743:0:b0:594:f864:8507 with SMTP id
 s64-20020a817743000000b00594f8648507mr20736304ywc.51.1697119246922; Thu, 12
 Oct 2023 07:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <CANx9H-COR1vLXqM8X-r+AhgdLK6M_K=+C-pSu3KL_KaHOX7ccQ@mail.gmail.com>
 <20679.1697118372515381220@lists.yoctoproject.org>
In-Reply-To: <20679.1697118372515381220@lists.yoctoproject.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Thu, 12 Oct 2023 07:00:35 -0700
Message-ID: <CANx9H-CiJhhq9xHuXyRN0Yvh5ASkXLDWrUEc+D0FJCf4WSSEEA@mail.gmail.com>
Subject: Fwd: Private: Re: [Toaster] [PATCH 3/3] toaster:update jquery and
 functional tests waiting time
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000dabb080607855d78"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 14:00:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15213

--000000000000dabb080607855d78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding public mailing lists. Please remember to respond to all.

---------- Forwarded message ---------
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com=
>
Date: Thu, Oct 12, 2023 at 6:46=E2=80=AFAM
Subject: Private: Re: [Toaster] [PATCH 3/3] toaster:update jquery and
functional tests waiting time
To: Tim Orling <ticotimo@gmail.com>


Hello,
The timing was added because when running the test after some click events
the system takes a few seconds loading the next screen, in order to ensure
the next element in the test procedure is ready, time was added.

Bootstrap was updated to version 3.3.7 for compatibility issues with jquery=
.

Regarding to the test, there are some fails on test related to builds that
will be addressed in future patch, the fix applied in this only targeted
the test under functional folder and they are correct

From the build directory on poky you can run the following command to
validate the test outputs
*EVENTREPLAY_DIR=3D./ TOASTER_BUILDSERVER=3D1
DJANGO_SETTINGS_MODULE=3Dtoastermain.settings_test
../bitbake/lib/toaster/manage.py test tests.db tests.commands tests.browser
tests.functional tests.views *

We will continue working in test completion and success in the following
weeks until the process is completed. I will make sure to include more
details in future patchs, thanks for the suggestions

--000000000000dabb080607855d78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Adding public mailing lists. Please remember to respond t=
o all.</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">---------- Forwarded message ---------<br>From: <strong class=3D=
"gmail_sendername" dir=3D"auto">Marlon Rodriguez Garcia</strong> <span dir=
=3D"auto">&lt;<a href=3D"mailto:marlon.rodriguez-garcia@savoirfairelinux.co=
m">marlon.rodriguez-garcia@savoirfairelinux.com</a>&gt;</span><br>Date: Thu=
, Oct 12, 2023 at 6:46=E2=80=AFAM<br>Subject: Private: Re: [Toaster] [PATCH=
 3/3] toaster:update jquery and functional tests waiting time<br>To: Tim Or=
ling &lt;<a href=3D"mailto:ticotimo@gmail.com">ticotimo@gmail.com</a>&gt;<b=
r></div><br><br>Hello, <br>The timing was added because when running the te=
st after some click events the system takes a few seconds loading the next =
screen, in order to ensure the next element in the test procedure is ready,=
 time was added.<br><br>Bootstrap was updated to version 3.3.7 for compatib=
ility issues with jquery.<br><br>Regarding to the test, there are some fail=
s on test related to builds that will be addressed in future patch, the fix=
 applied in this only targeted the test under functional folder and they ar=
e correct=C2=A0<br><br>From the build directory on poky you can run the fol=
lowing command to validate the test outputs <br><strong>EVENTREPLAY_DIR=3D.=
/ TOASTER_BUILDSERVER=3D1 DJANGO_SETTINGS_MODULE=3Dtoastermain.settings_tes=
t ../bitbake/lib/toaster/manage.py test tests.db tests.commands tests.brows=
er tests.functional tests.views </strong> <br><br>We will continue working =
in test completion and success in the following weeks until the process is =
completed. I will make sure to include more details in future patchs, thank=
s for the suggestions=C2=A0
</div></div>

--000000000000dabb080607855d78--

