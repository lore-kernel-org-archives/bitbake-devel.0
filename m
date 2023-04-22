Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A3EC6FD18
	for <webhook@archiver.kernel.org>; Sat, 22 Apr 2023 09:33:18 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.4377.1682155994332226101
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Apr 2023 02:33:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=E1tc3Y9J;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-2f7db354092so1573819f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 22 Apr 2023 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682155992; x=1684747992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K1TPpRJsfQi6DWZH7jx0SrUA3kgPKAkz0anpAK70ktY=;
        b=E1tc3Y9J40lS/xoOIBZLiBcXX4JDFoyVYiLGCP+V4a+yriK2U+SXxrbdwJNQjptshU
         arg0YKcuQ8A+z57C0K+ezjPX89Ef6eVhf7nNnxiEBUlI/KL2CD/lyBe5jdzuxOIyNf+N
         inTfjhR0G9NlxkRhu9mVG4S8/K0Yxdrjaz0aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682155992; x=1684747992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1TPpRJsfQi6DWZH7jx0SrUA3kgPKAkz0anpAK70ktY=;
        b=c8YzQNnVC1Ld0Zy9UdHCBY6CNtEgGRpadLB3nV8BS16FSOmWs0su5D0ty5/WcyBWr7
         NmfAiEj7I6qsgwYbSirPu9fXtPti2kP9W2ySE4EN7soN5GVbfa7Y3JqsmzPEaoG3g2Wb
         9PXphy34B1UO6zUoBd29h/+TYF746VurbtHN9VCv0WtdkHOYTUBfavDUxCf3JpJehmP+
         7jOp24rVxvJsUdV+cRBWjN8KLFapQbk0EWUIvBDbZ1BHqR0v84vKGd293ocLfic/+mw8
         COCKOn1L3if2nZRry60zb5WHyHYc6YucRaAvIRQ9/G/NLkOkxl2pQerFRmpPLcJG3oIC
         xaPw==
X-Gm-Message-State: AAQBX9fpOwbN4Vu8dQRV0qksZzeDbRkc5nfrKdKFfDwkGfSe0kEXwqEx
	5I7LLcjUNUVVjRMMBOqo51xbuQ==
X-Google-Smtp-Source: AKy350Y5xkTNJfQPGxBYEYYBfnyMxJJB2Nf8fFk7HYF8Z7ZT3RMxjUx8b7o9U8e886iv+3bZrVoaOg==
X-Received: by 2002:adf:cd85:0:b0:2fb:283a:1754 with SMTP id q5-20020adfcd85000000b002fb283a1754mr6734920wrj.32.1682155992537;
        Sat, 22 Apr 2023 02:33:12 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5f22:3f4c:8346:a897? ([2001:8b0:aba:5f3c:5f22:3f4c:8346:a897])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bca41000000b003f179fc6d8esm6826313wml.44.2023.04.22.02.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 02:33:12 -0700 (PDT)
Message-ID: <bbade087cbe4d4a4a8c66c34f74db1223a0781d4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/3] BitBake user manual updates for 2.4
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <bluelightning@bluelightning.org>, 
	bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com
Date: Sat, 22 Apr 2023 10:33:11 +0100
In-Reply-To: <cover.1682131637.git.bluelightning@bluelightning.org>
References: <cover.1682131637.git.bluelightning@bluelightning.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Apr 2023 09:33:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14739

On Sat, 2023-04-22 at 15:05 +1200, Paul Eggleton wrote:
> Documentation updates for the 2.4 branch / master (to correspond with
> the Yocto Project 4.2 release).

Thanks for catching these. I wish we could do a better job as we go
along but it is hard with the resources we have. Sadly I'm probably
guilty of not adding some of these.

> Note: I am electing to add BB_GLOBAL_PYMODULES and BB_HASH_CODEPARSER_VAL=
S
> here without pointers from the Yocto reference manual currently, since th=
ey
> are highly specialized.

I agree that makes sense as those are only really meant to be used by
the core.

Cheers,

Richard

