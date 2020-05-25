Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.39951.1590443031299184293
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 May 2020 14:43:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gWcEcZ4s;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id q11so6258866wrp.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 May 2020 14:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=SoD5ZDnV4kL/xIoaDX+Y+eFb775QjUAA1v7lnCuvZ3U=;
        b=gWcEcZ4sq3HfyqG6NbkU9mJQUVnxOCxDC5csu7Nc6hO+tNs3O7RhxvUBS8f+V2rndP
         cFKC7iELlX10QEH4NJBRcMCLi+JwaAjKcznGPbohWD8jFdTT6MWXGE/4DsHHUXWW8VOG
         gpDTaSxMIaRWIvy3sHYo2K/3EnUDN15jgfPwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SoD5ZDnV4kL/xIoaDX+Y+eFb775QjUAA1v7lnCuvZ3U=;
        b=W/uBW8Ckk+fp6IDgKL9cDuI2DVckTguqtL9VuGOHR68Hg4E3jm4U28vAZsowexYBdn
         1CZegyeHAYi0yJqb74Z7pQV0zQ9q9ZPT4N8yfnVivoZCnfgnRSWyIzEmkpGiwKhq+LcW
         tWcRJPszQ9Dw08e82ObjweiVaIzEe0C9MmOxIKftfTi6iNMLrgrHr65RJQXA50QnI+Hi
         nV0sQD9t0BfIqCOv6iRx2UGoX1noZx1A8qHUs72okm/s7RhdexJuRWMjUPiAKrf/2tXy
         +qkGkNISFEQN9/ajm0gn0wJ/TP5vukIZLil/05l5bjliY2gZbQwlgtL6mA2rFJgQkQnw
         4lgw==
X-Gm-Message-State: AOAM532OxsfG1r+CYQNbldWF52tVVNRhN2MFb/Dmm/arL2IczQ7R6n66
	2br5mKuz/YmbZ1X7GKvPleDvkw==
X-Google-Smtp-Source: ABdhPJzzgUXZbVVVRajchXAQcG41Kf2nO+7wQdmBg8iFYL4/iKYKZ9LwWMWuQhdxdsWFNIuVQ62Oow==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr3540158wrm.93.1590443029557;
        Mon, 25 May 2020 14:43:49 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id z132sm20756104wmc.29.2020.05.25.14.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:43:48 -0700 (PDT)
Message-ID: <e1530603bcc3fab4aa0528f0bf93d5c00c9ba6cb.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Remove 'recideptask' varflag ?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 25 May 2020 22:43:47 +0100
In-Reply-To: <3e812b97-803c-87e7-0d55-6627c28f9846@gmail.com>
References: <3e812b97-803c-87e7-0d55-6627c28f9846@gmail.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-05-25 at 09:26 +0200, Jacob Kroon wrote:
> Hi,
> 
> I stumbled upon 'recideptask' varflag in the manual, but couldn't
> find 
> any use of it in OE-Core/meta-openembedded master. Judging by the
> commit 
> message in
> 
> http://git.openembedded.org/bitbake/commit/?id=f8c9b292b02ce2c28741b74901205f5e5807ca87
> 
> and seeing that its use was "cleaned" away 2018 in OE-Core judging
> by 
> "git log -p -Grecideptask", is there still a need for it ?

The use case it was created for was minimised by swapping those tasks
for commandline --runall options which are much more efficient.

I'm not sure the need for it was removed entirely and the code is
minimal so I'd prefer to keep it since it was hard to get right.

Cheers,

Richard

