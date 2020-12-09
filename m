Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web08.6010.1607518790516219163
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Dec 2020 04:59:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JZpJHNpi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id 3so1575233wmg.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Dec 2020 04:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3Le/YNdNvSxZEuObHk3KOx8cS1s7/mm01QFfb2TBPWA=;
        b=JZpJHNpiXAWfenyEmzT8Y7tLVoKfL+PdNykG14j/F93HC9uEfg6tegfDtLByUh2gbL
         hH7LAmbR8VQUqHqv+rPnYQA1B1eq3ThR7NE2y5qK8L/hemL+8y5HuKXPaO+J9GJVn0r4
         SHWofWql4H75BO29/UZRApZViT5bpspGRxr5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3Le/YNdNvSxZEuObHk3KOx8cS1s7/mm01QFfb2TBPWA=;
        b=Bte0DoDqvZiUdPiDdtijY9YJxqh6ZdLjxASH/ZwK5Inc6koEF8y0Yb8FN3Wj9h8VGk
         UtqMuZsjASs2bnrOMLmg7eGtxWK5a25v6kbwXGtSEgXBXAMY7/AVA3uQpkrsedsDfGn5
         VNyxOS8CbZyoH9lN+oJqTTryf+7b1AHKVpdcy8WmIqsrPNPCxJk11yW1LQ3bdJi2fWCU
         jti17Ay5GAFIFLAjFDGS/ZOleoi3Od0Mv5fz5aalDioZEUcfmfoan3WqOQaAto7/4Bln
         cumhRBQqT4o3suWSem++dareLhbn5XPiH+BUmUdpyBq1D1cw1MHo7wm/03t9GlCPTNZO
         /Arw==
X-Gm-Message-State: AOAM530zuzkHj9ZgO9Ei+2m6f4oiusXWOhON3kj5xmdkkKPNt1n4O35m
	cMQOrNCNF2tq5XFyd/t1cDuqLQ==
X-Google-Smtp-Source: ABdhPJwGwhnJTSwyiugzz2C9EXV38qGWQdOoM7gEHVlN6Qw/khjTQSK0FNAJHyrUDv08xioXZlTu4w==
X-Received: by 2002:a1c:a9c4:: with SMTP id s187mr2692568wme.116.1607518788707;
        Wed, 09 Dec 2020 04:59:48 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 9.8.c.0.f.4.1.5.6.b.7.5.c.c.0.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (9.8.c.0.f.4.1.5.6.b.7.5.c.c.0.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c0cc:57b6:514f:c89])
        by smtp.gmail.com with ESMTPSA id p3sm3224470wrs.50.2020.12.09.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 04:59:48 -0800 (PST)
Message-ID: <87c837bcb27d2e4e761c806cec0d150462a462bf.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: use relative symlinks for anything pulled from PREMIRRORS
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Hombourger, Cedric" <Cedric_Hombourger@mentor.com>, Martin Jansa
	 <Martin.Jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, Chris Larson
	 <Chris_Larson@mentor.com>
Date: Wed, 09 Dec 2020 12:59:45 +0000
In-Reply-To: <92262695-8578-94cc-939b-fcc49af7b428@mentor.com>
References: <20201118153613.811-1-Cedric_Hombourger@mentor.com>
	 <CA+chaQez30Xyf-e+PDMOa5G-Phb9L8HiEuqhhAHSCJPgudhKdQ@mail.gmail.com>
	 <92262695-8578-94cc-939b-fcc49af7b428@mentor.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-11-27 at 15:04 +0100, Hombourger, Cedric wrote:
> 
> On 11/27/20 2:54 PM, Martin Jansa wrote:
> > Unfortunately this seems to completely break SSTATE_MIRROR handling
> > file:// at least in some setups.
>  thank you so much for the feedback. I will check what's wrong there.
> > All setscene tasks are failing, because there is a symlink in
> > sstate-cache, but when trying to use it, it points to relative path
> > into wrong directory.

I've reverted this for now until we can figure out what was wrong.

Cheers,

Richard

