Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.8550.1621411420573115336
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 May 2021 01:03:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IVFIv0ec;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so2868589wmf.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 May 2021 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=wI1Fxzi8MSFdP975bD63Qz2Gnk3DIJu026Gqg2WUQb8=;
        b=IVFIv0ec4pFjgDW1C08Pqit1ZyNV2ogk21FCuWpqTuyX424TGJAWIpBDBl0yj/Xp1/
         /ccQsLSQMd57imLPda10BzCM9ZhHiprHjvxitBO86YUChv5dIOQ0QXZjQv6vW5OZPMNA
         FKkjvwwfXu0Fmt4SqIh9u3nXBE9xKoCu5D/qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wI1Fxzi8MSFdP975bD63Qz2Gnk3DIJu026Gqg2WUQb8=;
        b=M7nn7NHg2yukhwF1cRHH6vA7litfSx2zM2UY6fNKoJ3YmajtmKWiYYrsOl6+lPz3as
         GIBaTc07d5mYo4D/G3EHdHvLVLH8H0oGbxZhts7CIhBs5pReyhSyyq1aor7mvUaTWMxj
         dG/bUJ7w9vB+i+nHW8xEb0mB2q7vd2r75MCJMbXTtMeJjPkaWKnU/HDCGX4dtKvX4fHw
         j2GhuDrBT5pGZCGoA+oJ7yzR5vflDaDHpKx82bytiGFTpTN8j7t4XPaPUX9lbeC7Z9Gc
         xliTM2Y1SbF3FUcf6ynhPrJUOM8eAWBTp7se9ckb2kxj8G/IyrHrhk3Dx/eKmrO2Tq5G
         5guw==
X-Gm-Message-State: AOAM532tI39Xnp7Wfo1LzielBbRs/TiVeZ2DBY5I7rzHq7R8+VSYk4ea
	zp06unGP5pDNa5pzzyF2G5IWaA==
X-Google-Smtp-Source: ABdhPJwuY5TdY8fulqilH+iLdQ9BZWkK0/vaJ8y0ykNavYuEc5SFXSwwF08dbcrAQBpO8xGbEAa2OA==
X-Received: by 2002:a1c:df41:: with SMTP id w62mr9447367wmg.113.1621411419042;
        Wed, 19 May 2021 01:03:39 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5a03:58fe:8897:9b3? ([2001:8b0:aba:5f3c:5a03:58fe:8897:9b3])
        by smtp.gmail.com with ESMTPSA id x16sm24258344wrp.6.2021.05.19.01.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:03:38 -0700 (PDT)
Message-ID: <a5a55a51fbbd6615949f8a463e04346da4bdc029.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: make sure the uri added as expected
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Yu, Mingli" <mingli.yu@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 19 May 2021 09:03:34 +0100
In-Reply-To: <d8977b6c-c8bc-ab08-5279-42daa223b31c@windriver.com>
References: <20210514060443.33335-1-mingli.yu@windriver.com>
	 <6517f5c83f3902eb26367fa59b7d07ad1c24f106.camel@linuxfoundation.org>
	 <167EDE5E75B22E11.24280@lists.openembedded.org>
	 <d8977b6c-c8bc-ab08-5279-42daa223b31c@windriver.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-05-19 at 10:05 +0800, Yu, Mingli wrote:
> Ping.

I replied yesterday:

https://lists.openembedded.org/g/bitbake-devel/message/12322

Daily pings are not going to go down too well with me FWIW particularly
when you've not looked at the reply I took time to write and basically
ignored my previous feedback too.

Cheers,

Richard

