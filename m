Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
 by mx.groups.io with SMTP id smtpd.web09.29312.1604314355265615729
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Nov 2020 02:52:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZkUC2le4;
 spf=pass (domain: konsulko.com, ip: 209.85.167.195, mailfrom: paul.barker@konsulko.com)
Received: by mail-oi1-f195.google.com with SMTP id u127so14224401oib.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Nov 2020 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECObYBtyotcr+ECg4No59hyqUKWySAaJu+0meo/mG98=;
        b=ZkUC2le46XMqiEbx6kwzR9Msm7uwDHQIkBmubQCykKAgJdmRQI94RDVNbe5df0tSP6
         CFq4hFJChd1hB6ZsDLHRhO+9wh8nHk79rDGTcQIZXwNI5AUBi/d11W+6ssdPaFStZtwN
         h3WuyC22BWkoOhHw0Mx0dXytzAEYNgMawq+Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECObYBtyotcr+ECg4No59hyqUKWySAaJu+0meo/mG98=;
        b=kKFb3aK+VM/vRXPnV1/Bp86qyD7yf8UUukw22/XXyabfyGQdWuta/eAZ8qdi2le67f
         WFGBfn9tJ9ok03iJq7Mi1G6/8r3Tfv7o9lBoq9KJEn+9s6LFXu/X3pijgQQ03WjmZyc3
         DQgqRY0LZGgtDD6tIvczkuVGrborYPLUR27F7HyuctHv8jFj0QiSSf2qZL+TO8/TaY88
         HBYGlfHCIAhOsCnFykVHty1jsGWqS4QaNRa3FXVklgot8uQ2n1KuvVzabWV3uTDIKtZw
         hPk2to7k5E3X2CcJ9aAnIPAja5BR2tPaxafHN0/l0MmyLLK1OcNugiQsYnkqugPw57WS
         3GPA==
X-Gm-Message-State: AOAM533QVwQtYTselmdfL7yoa05wb/0Kk4FSUDHz+cNOBTySFqJHH5PN
	lsqq4NRWxEv6cEmZS0Ixed27H2WXFywl9hDAXnDXcrvPBnX2xg==
X-Google-Smtp-Source: ABdhPJzc28ZzUUXXcatq5wAa+uIdJdjukSVxYoTB55wy3cvt7QYdNLwBZeIF0wsFE1U78rym1k6+AVe+99bWqek5JhU=
X-Received: by 2002:aca:ebc7:: with SMTP id j190mr8502575oih.6.1604314354635;
 Mon, 02 Nov 2020 02:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20201102102452.777-1-ds@technokrat.ch>
In-Reply-To: <20201102102452.777-1-ds@technokrat.ch>
From: "Paul Barker" <pbarker@konsulko.com>
Date: Mon, 2 Nov 2020 10:52:24 +0000
Message-ID: <CAM9ZRVsFPUgvW79gujg=sRfS_wMpq_vwJ7SW3TXb3u6sns6fvw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Append the password to the username on git URI reassembling.
To: Dominik Schmidt <ds@technokrat.ch>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2020 at 10:25, Dominik Schmidt <ds@technokrat.ch> wrote:
>
> This allows the users to specify SRC_URIs of the form
>
>         git://user:password@host.tld/path/to/repo.git
>
> which allows pulling in private repositories.

This has been discussed and rejected before multiple times, see for
example https://lists.openembedded.org/g/bitbake-devel/topic/72129859.

Thanks,

-- 
Paul Barker
Konsulko Group
