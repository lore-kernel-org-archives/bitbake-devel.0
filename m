Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.8968.1619533237753916730
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Apr 2021 07:20:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DeJfzbH8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id n2so6502339wrm.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Apr 2021 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=z+G+IopedqP0ggbNVDDrhVD9P5dBymAgeeZ9H1wtNzE=;
        b=DeJfzbH87K13+WUvGhzj1mXbzKjXnzJIxV2MBXlwljaoXFbxT8upu/BwRPnzPCyt3I
         KrNODx93VLohDFbSzkP4gH8FH5ifGlwc7fe+jbSwTxjM76gBmB2HJaOjLu85/Fe1Bvn7
         oxwyPMwY6fS23yhqv85NS7OMs2z048qVcmCVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=z+G+IopedqP0ggbNVDDrhVD9P5dBymAgeeZ9H1wtNzE=;
        b=TPlG2M4W+UZCmN5hJPF0HdR8TRkEPehAUldhbG9MK260IrVl3/wCb8e1S9Nef534cB
         cQ2uWBmluGvtnqy6eayiE1n5nuhrKOF4gFMsHYZOh6XQpYTZztBcDtu9AnYMcesayfX3
         Xxn8TYcd/KqQ0zp6Rb17BYhQvBKpXd3h2UcVA1IHkIWtsvv7ZCx5zEKTSv8C7f9lTQD+
         XD7oYPjSJo5H2H0zojiF2JyFSTyZjhI01hzqTHpeul/cSWQYKml64FjUTN2SaQLIfoZv
         ZFu0jqJM4EWVr6toHml7EjuqX4xltkWZ7QRqKWQ+qXG5oPAQvMZLUyvf/WAY+TJnQt3y
         PSJg==
X-Gm-Message-State: AOAM531piHi0k17azN/mMMCbbxZBVuHcNtB593lTfYdr1PIW/9skPxMn
	kBtjkVO5hq6NguUZ7hAFAftBCA==
X-Google-Smtp-Source: ABdhPJz4D88xJ6tgZEzdXrbXjuHuFd9EwI/FGa+dvcnlZ3pyJXRYd8ncSds0F1nHA9L4W/K1qVyQLg==
X-Received: by 2002:adf:eb92:: with SMTP id t18mr30434678wrn.409.1619533236184;
        Tue, 27 Apr 2021 07:20:36 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:dc22:3d8d:56cd:9dcb? ([2001:8b0:aba:5f3c:dc22:3d8d:56cd:9dcb])
        by smtp.gmail.com with ESMTPSA id 2sm2637725wmi.19.2021.04.27.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 07:20:35 -0700 (PDT)
Message-ID: <fcbceb5b62675b9a4ca21b080acdd7ac07b010b4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] S3 fetcher: add progress handler for S3 cp command
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Przemyslaw Gorszkowski <pgorszkowski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 27 Apr 2021 15:20:22 +0100
In-Reply-To: <CAExyXVSe-0nJL3XTTXzG2DQ65KVBzOOyMvpFzB357P7ykU7HdA@mail.gmail.com>
References: 
	<CAExyXVSe-0nJL3XTTXzG2DQ65KVBzOOyMvpFzB357P7ykU7HdA@mail.gmail.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-04-27 at 09:02 +0200, Przemyslaw Gorszkowski wrote:
> Hi,
> 
> This is my first patch here so forgive me if I am doing it wrong.
> 
> Regarding to my patch:
> In case of fetching source from the AWS there is no progress available. This change provides a progress by
> extracting the needed values from logs of the aws-cli cp command.

Thanks for the patches. Ideally the patches should be in the main message
rather than as attachments and the subject lines (short log) needs tweaking
to match our patch formatting guidelines.

Also, the full log messages for the changes is missing and the patches
do not have Signed-off-by: entries.

I have tweaked the patches a little to fix the above (I can't add a 
Signed-off-by line for you though) and added to master-next for testing.
The content of patches themselves look ok, it is just a question of the
commit message logs/formatting/signed off by.

Cheers,

Richard




