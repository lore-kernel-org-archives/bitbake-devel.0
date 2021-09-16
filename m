Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web09.1033.1631813282179865699
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 10:28:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=om2kU1qh;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: raj.khem@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id 73so3714260qki.4;
        Thu, 16 Sep 2021 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zn1/hamWdieskS/qEn6nBF+eZCdP/Su+PVQedKV4WvY=;
        b=om2kU1qhGrp2AIV7LkSnqEuZD5Lg93N9ybidCqwhgeO1L05EzOskbvyjHKM3+n5yq2
         vITSqBrp/dsmdvkkBElTDSVv8ga0tUb5PphtbBXK+AekZ5+OyfbIFSfpozw++dtIVis5
         ooXWy6hFUnCNBcE6lv85ONXtk/S3bZ3vC3oVo4Ep0NS5Gcjlb2lF5Y0N+u4SXjxeKUQJ
         DRC2OcnUTEzxKVQ6MgqQpgbRD9DTOyvERffcQ/8UFXyl6NKJLOgiYmlGh7Yhwg2AXjsZ
         +HiPfTtPYODQbqmiGdK9zUrkH0q0+MtsnvAla85Scdg9az55cuYCESYN5rx9qqdX6Tsr
         Z9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zn1/hamWdieskS/qEn6nBF+eZCdP/Su+PVQedKV4WvY=;
        b=MlGYEjrNXEUz992ck4x/CzU0aQdrIj2nqqfVk5yuFPO/tA0xKIbwD+fkk+6hFprFRp
         hdok4epx6DVUuapSX0eY3DnKiQCR/9/pkMX0+fr570qT3Lpjih5JkWQjSNqXeZwnYPSz
         K/4CpN6inwkvrA6+xhaqoZCvYUNc0l0UI+pZ+O6fhlpDNfBmr3qxB2kVdG/d6OkAyo9+
         mMekyUTFknjZDkGJYJqHy458L+LUWrx/ycPQV1vckhF8WvBvP4dBkulIpSwBnkG9XPr5
         HNzM+BFFXhVhhTEe3ZqufgS9ZpqIc/E4fA148KgT5Km0AGfSZbz6SI+sOkgtwZheOC6y
         s7/Q==
X-Gm-Message-State: AOAM530z59z0XApJ6WOYF/NCuW1xmkVswluNBihyhxQ/ARZhH8Z8ZBme
	mKSeLASYNeIId2XoTpzZ2Uigkze2O7HZVC0hmuU=
X-Google-Smtp-Source: ABdhPJym9bC0SNATaF1xGrhq2FwDLFNRwT4TCM3uM5fHtpkJO5dZZJOOWQXUVKpUp7CJZRVkKzwCOFRAX6INDY0uiYM=
X-Received: by 2002:a37:a04e:: with SMTP id j75mr6041723qke.98.1631813281159;
 Thu, 16 Sep 2021 10:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAKjpqyJZGQh0BruPiny5X=hv3iqsfzj+FJwmdzXdWm-ThzgQhA@mail.gmail.com>
In-Reply-To: <CAKjpqyJZGQh0BruPiny5X=hv3iqsfzj+FJwmdzXdWm-ThzgQhA@mail.gmail.com>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Thu, 16 Sep 2021 10:27:34 -0700
Message-ID: <CAMKF1soE_CY13wubo7mqyTUKpVqXipqOCsoXhEjeiw-AqDAcsg@mail.gmail.com>
Subject: Re: [Openembedded-architecture] Disable bbappend file from another meta layer
To: Mayank Agarwal <mayank77fromindia@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 16, 2021 at 9:45 AM Mayank Agarwal
<mayank77fromindia@gmail.com> wrote:
>
> Dear Experts,
>
> Is there any way we can disable bbappend file from another meta-layer in the current
> meta-layer or recipe file.It will be of great help.If we can use PNBLACKLIST or BBMASK
> to disable bbappend file.
>

bbappends can not be undone sadly, maybe you can try some BBMASKing it
if its in unique location perhaps.

> Regards
> Mayank
>
> 
>
