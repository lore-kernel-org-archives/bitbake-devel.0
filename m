Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web12.3628.1612477008779889655
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Feb 2021 14:16:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qt9Pa94s;
 spf=pass (domain: gmail.com, ip: 209.85.166.169, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-il1-f169.google.com with SMTP id g9so4123241ilc.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Feb 2021 14:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmesEy+f5+dMtLFl8UC6C1mNsha0eCRda9XguOecx6g=;
        b=Qt9Pa94sXC2rHhglLVO0lZYIylq3GC1rGSM3DwwzkQ0nsrVIxp0DJxiTb7LtkWX+D5
         Bs9todLJ8V+4lhLvTqq99XSQU3je68Y9BEkVp7Gpiv2ZoHP2wOpuS4imiR7kXgdU8jGW
         lmrg5S9vFSLJDtpPUEVGhH7ZAllzIEOwN/61wRnq9PeQ7BT0+VkAl8jn5Q5gLkzuPEvg
         GKfhuTqbedPQbTSA/KpS1LFwBMAK2u6eE86zCW3SUP8YEtnTcIu6iCSeNHhgiafe0hjX
         1abjyf4a1HRQ7oXIhMFVjHpZ3mpJE5x6FDSE33tqaGPpWZzbbxmotD61Rhu6qmSTGtBf
         +c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmesEy+f5+dMtLFl8UC6C1mNsha0eCRda9XguOecx6g=;
        b=eoQpU2JQhIQXCp+eB63H1uMzPU2Z5/7mzshOjJNX9In4VLyRaDO6uXeoTa4moK392s
         pt7t2yaSetKTUnfB/gMIwWAE9R7qCBGQY3EX2ZPaULO7n84zWRXUdJpPPFQbqXOpkopz
         sRJIONi+oDEz+qi3vbbcP2ELvLG9fbDkbS4tOc8lXEVv7X/qMJ2r4NtwIUZ/1/NJYjRQ
         xTR2WMEhfVVQP9TxTVO+vPY3YqQUZu5RPRYC7z5jRn5SWs3wegSIPX2OwOq5JWv1FF9C
         /yPThjop7DhI45NTVTTxGOKfqUeaHh1rugxKKyduxsMxSnIDZvHzs6Qhpt3JQ61Hi+u9
         srMg==
X-Gm-Message-State: AOAM530B5kprM8KPssuPMEq4ykodqxrLP5BkEyODQzq+gNR9Cs6GBvd9
	lelHoLbCekOvHw/uajSvw6EW3LIYr5jzeFgzKDQ=
X-Google-Smtp-Source: ABdhPJxNZdBGae7g02jwEKWp2aMJcFmRwKu8+Jz5pFcZUjIrhVjr8Dxs5DEkUycDuap/K6KdY7gA0g7tU7+jF/vf6zk=
X-Received: by 2002:a92:6f12:: with SMTP id k18mr1188804ilc.66.1612477008228;
 Thu, 04 Feb 2021 14:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20210204010231.1380-1-tomasz.dziendzielski@gmail.com>
 <c4a343366f873c3b1deee2f83bdc38638b98a677.camel@linuxfoundation.org> <1660975EC3653C7D.8308@lists.openembedded.org>
In-Reply-To: <1660975EC3653C7D.8308@lists.openembedded.org>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Thu, 4 Feb 2021 23:18:08 +0100
Message-ID: <CAJkqNs36Fp47DM4GpgcBtj=yObjOxjF77Xt3j4v70VAHrsuhow@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] event: Prevent bitbake from executing events that don't exist for multiconfig target
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000048b58405ba8a0f7d"

--00000000000048b58405ba8a0f7d
Content-Type: text/plain; charset="UTF-8"

I submitted a new patch with different subject (because it's content is
different). Please check:
https://lists.openembedded.org/g/bitbake-devel/message/11965

Best regards,
Tomasz Dziendzielski

--00000000000048b58405ba8a0f7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I submitted a new patch with different su=
bject (because it&#39;s content is different). Please check:<br><a href=3D"=
https://lists.openembedded.org/g/bitbake-devel/message/11965">https://lists=
.openembedded.org/g/bitbake-devel/message/11965</a></div><div><br></div><di=
v>Best regards,</div><div>Tomasz Dziendzielski</div></div>

--00000000000048b58405ba8a0f7d--
