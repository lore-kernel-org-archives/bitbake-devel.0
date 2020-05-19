Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.9392.1589886049355092323
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 May 2020 04:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=f1cqrFVa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id e1so15397713wrt.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2020 04:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=PYZGKx5GCm0N1AxpfQy+SnD+mjkbtJPNTonziXZb5MY=;
        b=f1cqrFVauhlHA/g+sIjaC6tTR3f2nYkIUWjLRFnu6GpX1pPvIbDUFtSVRBjUVoGnBz
         SA7EmcfIPeutf9wpLQLKLXt+Pn3zFszcyTwdSNj1Y92xcdDZtbtjmdZpH3+i1FfQiRJI
         jrNNZltJGYjDM76pqPed00IYoa89JaBXrc13Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PYZGKx5GCm0N1AxpfQy+SnD+mjkbtJPNTonziXZb5MY=;
        b=OF7Xjas5NTvLBTCjUnPfFZxphjbCrpGptaaNFq4jzTmRGEk3/tXbPCpF5X5KYa9hQJ
         eDVt8AXfqHyAjOo/ouUika9x9Z1SPE10ab+JRK1u8LLUFj+Tbd2i8WL+t9RrBxM3WUd7
         CnWetfvtr6wAG8muG33UF0qgiNbwrghvrMPhX4RXoeS7BN4O6OcNRBWdgSWV/IfoGRVs
         uLWZEFhGw04A6ErzGZAcQMbXlYBb3TlXXoYzIiUQmJNeEpskuScSAhunmfQ5bhSj+CGi
         GWkNTjlouhYG1JrsFVHIXjNVo/sDYLskSMUbL9gKm/AAWoEpqkXp375573DSIsI4Vdgz
         7ueQ==
X-Gm-Message-State: AOAM53342Sa5wCorBn/6TToITOJxePJEGoCQzfvi5rB87aSS3kEPL1gL
	83bMkkpn+De5uCjig0wNtrhz/764GIA=
X-Google-Smtp-Source: ABdhPJzjiJEnt3mNOZ1/UaYVOWZ5DbFOXHY24KEnRnseTKo9nMaHWk/8eGxGmX1ee2amDBtYnBXmrA==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr572651wrl.6.1589886047422;
        Tue, 19 May 2020 04:00:47 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id u10sm3443899wmc.31.2020.05.19.04.00.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 04:00:46 -0700 (PDT)
Message-ID: <7615f5c76925fbe9edc0137c411db611a460aefa.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] BB user manual, "Variable Flags" can be applied to non-tasks, no?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 May 2020 12:00:44 +0100
In-Reply-To: <alpine.LFD.2.21.2005061136300.343666@localhost.localdomain>
References: <alpine.LFD.2.21.2005061136300.343666@localhost.localdomain>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-05-06 at 11:40 -0400, Robert P. J. Day wrote:
>   still poring over BB user manual -- Section 3.7 on variable flags
> strongly suggests that numerous flags can be applied to tasks only,
> but it seems that you can apply many of the same flags to non-task
> functions. one example from package.bbclass:
> 
>   python perform_packagecopy () {
>         ... snip ...
>   }
>   ...
>   perform_packagecopy[cleandirs] = "${PKGD}"
>   perform_packagecopy[dirs] = "${PKGD}"
> 
> pretty sure that function is not registered as a task, but still has
> a couple flags applied to it. clarification?

Some flags apply to tasks, some to functions. A task can call multiple
functions.

> rday
> 
> p.s. hang on ... it seems weird for the same routine to have both the
> [dirs] and [cleandirs] flags set.

You don't need both.

Cheers,

Richard

