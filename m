Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web11.4867.1585861720529459421
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Apr 2020 14:08:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TnGMkh/b;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id t7so5878805wrw.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Apr 2020 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=9rEGDp4yNtx5UpgszS6Mk20bDVS7ZxLljbopLZZiGtE=;
        b=TnGMkh/byKTNhxM1eGsNJ3NuOLvzfPGgH7AwtuVckcvL2IJFZgniggwywICf0SQAdd
         iFsKOiBDGmZ+6651UwF/9Fzle9//GkcQz2F1g83NhSOmP985J3TCZL/IXInvgKNbsTae
         0lIOvLzgCjTASQ9euaj8scZCaGyXGwOBUOGAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9rEGDp4yNtx5UpgszS6Mk20bDVS7ZxLljbopLZZiGtE=;
        b=jgZZ5M7V5EHfmsUTbai54/Ir9UpbH6aOQSCLLVzaAKM6i+fq+CmgidDX0jstiqbNm7
         xAAP3woBT8T7+9TiExRRnJe8EyNd99lfKl8Kv/rX/DztgLKViJM3NGe/erj66XomXTBa
         eXpdMCnBkq8ADf2xOijmMcRX+XggdUbKZrf6D1vxzHlvJSOd691kqXzXseUmaXxiba1H
         gVtELglw8nSPXWfFv5ea71tTkJz2awKIH/u+ZWGDgnIHwyJqo5TtKZNCnviGA0+9gf7U
         1zFBngKlk7k+naXDEL6frXgOTBwNl/jeo7ZhHLKIP2T1WEr3hTZFBi0+Ej+K6vwEMm20
         hGTg==
X-Gm-Message-State: AGi0PuYtbtKtgCflxTEWYGIWYrjoeiizC3YOofiidr+P1yNTZagsb+r1
	MNKTHziA89fqv2x4B4C+fiyLqA==
X-Google-Smtp-Source: APiQypLLjxRtIB2WzjT2R8qJNQ4RuyqPXpINF0LOh7rITYHw8ieLHVdNvDp59zsOL0/UrHhiCS+y7g==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr5237997wru.131.1585861718986;
        Thu, 02 Apr 2020 14:08:38 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id 189sm8932048wme.31.2020.04.02.14.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 14:08:38 -0700 (PDT)
Message-ID: <fb960c2f15390746d24fd95368478c518748c957.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Gitsm does not use credentials when cloning submodules
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Bernd Bauer <bernd.bauer@gmx.at>, bitbake-devel@lists.openembedded.org
Date: Thu, 02 Apr 2020 22:08:37 +0100
In-Reply-To: <20200402195104.2405-1-bernd.bauer@gmx.at>
References: <20200402195104.2405-1-bernd.bauer@gmx.at>
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-04-02 at 21:51 +0200, Bernd Bauer wrote:
> If the git server needs authentication the credentials are
> encoded in the URL of the repositories.
> The credentials from the main repository are deposited in the
> recipe so main repository can still be cloned.
> 
> But the URLs from the submodules are listed in the .gitmodules
> file.
> The submodule url is encoded with an username and a password
> or a bitbucket URL token. See example.
> 
> The password is not stored in the ud.user but in the ud.pswd
> variable. So in this case the url is made up by ud.user and
> ud.pswd.
> 
> Example:
> [submodule "sub1"]
>         path = sub1
>         url = https://user:password@test.org/url/to/sub1
> 
> Signed-off-by: Bernd Bauer <bernd.bauer@gmx.at>
> ---
>  bitbake/lib/bb/fetch2/git.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

We have had requests for this before and we've said "no" since
encouraging people to put passwords in urls is bad and it leads to
people making accidental exposures. Its basically too risky.

For git submodules the line becomes blurred.

I'm open to the opinions of others but in this form the patch applies
to git and gitsm and that in itself makes it more risky.

I do understand why people want this, equally it really isn't a great
idea in general :/.

Cheers,

Richard


