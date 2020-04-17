Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
 by mx.groups.io with SMTP id smtpd.web10.3319.1587153666842059880
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Apr 2020 13:01:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=dgvmBepz;
 spf=pass (domain: gmail.com, ip: 209.85.221.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vk1-f169.google.com with SMTP id 10so891427vkr.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Apr 2020 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LtA2iHV4UGP6iz/67LYHtRzh89vRGUlpVkvnz5EVF2U=;
        b=dgvmBepz8dv4sx5Z0XEVDJoa9X0H2iz8IVPF1h6owddt6ZRQiyVF2uyQWQ6Ep+6LIX
         2RUe/HbQPPaz9C2zr69BagfAs5KowCp49qI6fFz+O3j0wunCJQLR/tmNG4qUb6i5bey/
         H6zhXCwIu6Xg+FvLnpd4HpaJ/qulItQqROgU37JJdn7/1l1l2wJ21KZ9PRJcz4yDZcww
         SXC7as+Hf9/9Momw9N2eeZ7eWC0aAPO33urnXNBIO6nuSWrRMTlq26GskzAM+w6TE8Gz
         niTTmqK6S0lNVLcmunmPWQhvS/u1F5PfdHWXzLJoU4Ajzvz3GEdH3S1OIvzHGQI9jdRt
         phQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtA2iHV4UGP6iz/67LYHtRzh89vRGUlpVkvnz5EVF2U=;
        b=Go0IraE5TRQZf1wRXTkLDo6o3988D3A/A2oSIDSkJHyw05zYgDNB/IIsYUUyB871nE
         V6zzSFuPHaC3ErCb7gjl3FKa1wpH00PhNGAaw6oFwaYm+Vy6/NOq9deJddKEe+mRjghb
         6bhN+30bCkw0SDBbeNNeVwXRkz+t0GSaH6h/GjQZ61R5aerGXfQVRQSizncUW5zxBuoe
         I8vyuqUzEilED/TXHYA/Qv2scEX3mpFQw14OeS5LnsFAkj9ekG6sP7QdBv03Txwl7VlT
         YMu5wYydVtJYARWivNxsrv65uSuxrRl2UDrNGk+ehEZHEATveJLhVy0uRkKqHPjTlJL6
         oKNg==
X-Gm-Message-State: AGi0PuaHq1A973ET4WZw+Bv0617i/bxkUUQcYeF/7JLvNP3q1WAHyI5l
	Xb/MrtHCYYlCf8Qacr91iSDPtXEqA3OFlRr9raIjixd8
X-Google-Smtp-Source: APiQypKwwOQ3oHDl/Sl3kIQhlUoO4vyrZDqZEFiUdTrD338am7/7CxvF8i21I3PPG0lVuc6bNbu44DHM4JQ0J81ITnE=
X-Received: by 2002:a1f:9745:: with SMTP id z66mr3891603vkd.49.1587153665931;
 Fri, 17 Apr 2020 13:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj8fXnTRGk9fT3K8tGOPwxLO6iWJ+ZD2QtWpVPqcAYeNKg@mail.gmail.com>
 <4582.1587153072272638092@lists.openembedded.org>
In-Reply-To: <4582.1587153072272638092@lists.openembedded.org>
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
Date: Fri, 17 Apr 2020 22:00:54 +0200
Message-ID: <CANNYZj8E3O9D1m6nVoizgmWp_szadiSRGnjTfCXFxWJ9j2TZxg@mail.gmail.com>
Subject: Re: [bitbake-devel] Significance of "SRCREV_FORMAT" variable for multiple sources fetch
To: abhishek.shah@broadcom.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000763d6205a3820205"

--000000000000763d6205a3820205
Content-Type: text/plain; charset="UTF-8"

Nowadays it's enough, but there used to be a bug where none of the SRCREV
named overrides were factored into the task hash:
http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/?h=master-next&id=74331a426ff263cd7b74a7578d6f49eb72d7f3c2

Alex

On Fri, 17 Apr 2020 at 21:51, Abhishek Shah via lists.openembedded.org
<abhishek.shah=broadcom.com@lists.openembedded.org> wrote:

> We are using dunfell (3.1) yocto.
>
> How does SRCREV_FORMAT get used to check rebuild is needed or not?
> Shouldn't SRCREV_name be enough to check if "name" needs to be fectched
> again? 
>

--000000000000763d6205a3820205
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Nowadays it&#39;s enough, but there used to be a bug =
where none of the SRCREV named overrides were factored into the task hash:<=
/div><div><a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/=
?h=3Dmaster-next&amp;id=3D74331a426ff263cd7b74a7578d6f49eb72d7f3c2">http://=
git.yoctoproject.org/cgit/cgit.cgi/poky/commit/?h=3Dmaster-next&amp;id=3D74=
331a426ff263cd7b74a7578d6f49eb72d7f3c2</a></div><div><br></div><div>Alex<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, 17 Apr 2020 at 21:51, Abhishek Shah via <a href=3D"http://li=
sts.openembedded.org">lists.openembedded.org</a> &lt;abhishek.shah=3D<a hre=
f=3D"mailto:broadcom.com@lists.openembedded.org">broadcom.com@lists.openemb=
edded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">We are using dunfell (3.1) yocto.<br><br>How does=C2=A0SRCREV_F=
ORMAT get used to check rebuild is needed or not?<br>Shouldn&#39;t SRCREV_n=
ame be enough to check if &quot;name&quot; needs to be fectched again?
<br>
</blockquote></div>

--000000000000763d6205a3820205--
