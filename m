Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web09.33549.1610368704403801943
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Jan 2021 04:38:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UgYy5Q/h;
 spf=pass (domain: konsulko.com, ip: 209.85.167.178, mailfrom: paul.barker@konsulko.com)
Received: by mail-oi1-f178.google.com with SMTP id f132so19879355oib.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 Jan 2021 04:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xjJ3SVpADviELHUPI4bZboERqoN/dcAcuznDZoN1bI=;
        b=UgYy5Q/hezn1VNgfBKBgtL/vD5dBEkyrEvAFqKVeyE7oCFxgrMEYr1xqa20ltmYtVq
         4N5dgFHz9VxRZjhZ2mzJt/u1GwmpwB+MWQin+frQ6Bv3OJQqQS2OZR+vm9YuO0jOZgOD
         2hAF6/9q2833HFt7zNLaIkVYYiGK19wVWh+2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xjJ3SVpADviELHUPI4bZboERqoN/dcAcuznDZoN1bI=;
        b=S3vatK7FJd6cKyXTTm+xPyd5RtmOIkZBZifcVE0qunNbgS/CUFx8x7vC/fnurajzuL
         SYDUkolR+chCZLAHqPp8uEKOWvzoy+VlbR6VjEF5tReqLr7U00sqx+/4tLBG0DXmsd/r
         T+b355nyg7W7CyssFC2XfQMbLdiwVY4O6C9uqJRkD8VBf1DdOm9CvmBxxVTp/+X4yO5N
         xHTvLJmeCnz4L4xXmnsNs3L7J5225W3+duSZ2753UqF0JAEY5CNWi1wqlefvli8EXs8W
         ProitG7R9g38U/Czitsht5t/iF0+o+bf/Ltgl1UkmFdAh5S+3ojOyuZ9NGEDCXbqSP/L
         Ep5A==
X-Gm-Message-State: AOAM531j5nPx1/xN6/7BSR75PUFA9RPEXReO81LnE8DA2/J81r1R4WHF
	z4zCHXLOTco2a9n+c4A8DIZqN5BPTctXhnh60Kd4Hg==
X-Google-Smtp-Source: ABdhPJzfmq2UkJrWxZ+l1BVvrBAfbjkZuSPv3PG1LLxK2tlRuJbgiYd8pWrCEI1X4wqPEnEXgPqc/8iO4yOKnPBb/oc=
X-Received: by 2002:aca:fd0d:: with SMTP id b13mr9846839oii.27.1610368703748;
 Mon, 11 Jan 2021 04:38:23 -0800 (PST)
MIME-Version: 1.0
References: <1609839118-2342-1-git-send-email-mshah@mvista.com> <CA+=qD9NuCZ7KeAU3YDDnK=kLa8UVeucOMAyPi6CB+wxTf79Mbg@mail.gmail.com>
In-Reply-To: <CA+=qD9NuCZ7KeAU3YDDnK=kLa8UVeucOMAyPi6CB+wxTf79Mbg@mail.gmail.com>
From: "Paul Barker" <pbarker@konsulko.com>
Date: Mon, 11 Jan 2021 12:38:13 +0000
Message-ID: <CAM9ZRVuUY41jaHqMmpnXamQ399g5JepSGJ21_8twHhPUyFE-wQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: utils: add docstrings to functions
To: Milan Shah <mshah@mvista.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Randy MacLeod <randy.macleod@windriver.com>, brian.avery@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Jan 2021 at 12:15, Milan Shah <mshah@mvista.com> wrote:
>
> Hi All,
>
> This is a gentle reminder to review this patch.

Looks like this has already been accepted into master:
https://git.openembedded.org/bitbake/commit/?id=b61ba4a18693a9e553d2a93161feb0bcc1c82384

-- 
Paul Barker
Konsulko Group
