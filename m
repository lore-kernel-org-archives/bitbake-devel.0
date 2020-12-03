Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.5879.1607036962707521070
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Dec 2020 15:09:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=X81HAACu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id r3so3550975wrt.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Dec 2020 15:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ihj4A58qF8xq080BoRfi5XDgzYbeFbmvwDsIws1fvZg=;
        b=X81HAACuy+RE/enxYUzMlYwEdGX48lsSqfQym2ScJaWqvLqWTgOxF6lz1hitpZIEJe
         CqL0MWdJx5nzHqaQDA7p08sQZb+fs03E6y06C1uXszM5iMZkJ0tU/2OiVf/bMk6zJER6
         Olr9wF1Tmarkcn7ylEDWSZOzHkcvDqXsgwkds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ihj4A58qF8xq080BoRfi5XDgzYbeFbmvwDsIws1fvZg=;
        b=aOib1Nm9D8btwnXEBzlwUAjXJ1crJK7UkcwtKbhfWh6pJuaW8hyEgXeOTxZBN90NsC
         DNlAEraLwmS8ojzIhdVg0vYSxnRvMZQ71LNbeODHXmFD/RMDicmtKu5r7vJH5bT4MQ+Z
         i2gnEaOl9u9ZCiipaFOj2vq1r2778It/3+ucfTUwg6syWQqd9CVeMaIqmwwgVMB4ZMvN
         RfXIVJ1VnDkhT46yZNbwal3man+xuI6LmWQfdZkaMmmGeU3sCbEBEXr0UHI6zVKlaOBm
         NLo/sSEdSZ3aQisd0roz+Vsx7V8b6FdbQSBvevQOO+reN/A1U6I9pMLhnTlUum7LvmbB
         mfmQ==
X-Gm-Message-State: AOAM533YYD0HjWY9bApWxH4liFTFcJlYL7pvyHztJyDuTvI/tpitrF/3
	6RcHTQ2nHzOOL7Z03GjXlXtcLw==
X-Google-Smtp-Source: ABdhPJxJtGkfsBmV4OlD0NnRiwAETTwvQiLPTiimtQXToBqzdjW1eWJwve8yjTmNYgE6IaUMuSX/hg==
X-Received: by 2002:a5d:56cb:: with SMTP id m11mr1632595wrw.346.1607036961227;
        Thu, 03 Dec 2020 15:09:21 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 9.2.d.8.e.2.1.e.1.8.2.c.7.a.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (9.2.d.8.e.2.1.e.1.8.2.c.7.a.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c4a7:c281:e12e:8d29])
        by smtp.gmail.com with ESMTPSA id f16sm1175706wrp.66.2020.12.03.15.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 15:09:20 -0800 (PST)
Message-ID: <abb376b42320bb2b3f7f2980caa060b9c09f9d3d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC][PATCH] fetch2.wget: add support for per-source download flags
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Yann Dirson <yann.dirson@blade-group.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann@blade-group.com>
Date: Thu, 03 Dec 2020 23:09:19 +0000
In-Reply-To: <CA+4=imaDYQ0XT=04cOrymvBeia=qYB2-PuWAfTYCdtRpqGKEhA@mail.gmail.com>
References: <20201202095020.1439530-1-yann@blade-group.com>
	 <CA+4=imaDYQ0XT=04cOrymvBeia=qYB2-PuWAfTYCdtRpqGKEhA@mail.gmail.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-12-02 at 11:50 +0100, Yann Dirson wrote:
> An alternative I thought about would be to:
> 
> 1. expose all the FETCHCMD_$method vars with their default values
> through setVar,
> so we can _append them, as today it is only possible to fully
> override them
> 
> 2. use something like FETCHCMD_$method_append_srcuri-$name="--foo". 
> However that
> would require to add "srcuri-$name" to overrides temporarily for each
> file fetched, and I don't
> quite see how that could fit in the current codebase

FETCHCMD was never a nice fit and we've tried to back away from using
that. That is particularly true give you want to do it on a per url
basis. The hope was we could add things to the urls as parameters if/as
needed. The strings you're trying to add are fairly complex to encode
into urls though, I'm not sure if there is a good way we could make
that work, could we encode it somehow?

Cheers,

Richard

