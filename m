Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D413C433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 23:12:14 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.3558.1639782733501282672
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Dec 2021 15:12:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I9BZ49TY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id s1so1369127wra.6
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Dec 2021 15:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9qodPEePTtu/BKvweYARCZ9jpmG+VzMF0OAOTWMwOVQ=;
        b=I9BZ49TYOExz0szK1hnFZmfiVI3NSdRAFsh6oJfdKzck0WCbyOx5aAEBqVb0WJQi97
         GfQ54Wa3wadJT+GCNGJkANPQToHdAvcfrkUTN8vzCwHEOqKf2iHQJ65wIb8bRLo+PG+E
         9AtpwRmtbFEat2fDFoCjY0hOe2tN35MhDDrRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9qodPEePTtu/BKvweYARCZ9jpmG+VzMF0OAOTWMwOVQ=;
        b=gO8Tn0zUDPLv6G9lLZn+QpEWEPiGHDGAcVM6+bGqe8oSMOs8+2CFGU/XCo1eEoaAf/
         6lvAdmdyLR+/LOO0kuGCKQdJGgvZeyOm6Rrqi3yL68U1OEWm1Xztg5+0p66+3HuKa816
         M9iWx0YyucI9wU4ZSL35e81DeOhc1MPSv42RsU5GGq9CtW8uwjn1HpkpcnjOX+LjLL0x
         SiCzaDSzAwz6LNMaupEDzKkfokFypa+owx8u2T7tCrOdFJYgcap9/RY7vz7izLOGwT0U
         IFfdT/HV8zzAb8jGyhc7TThF3ljhwhV8KgpLFW9IFaXFFSEvKwAxf+xP4JqC4McSwyzN
         UTQQ==
X-Gm-Message-State: AOAM531K930uLH9qFfk3y6ltUucnqKAMi0AEXl1Mxq6A1GWPu6W9tJun
	Zkmo5ejRtXJSupSJF5DPnkuZjA==
X-Google-Smtp-Source: 
 ABdhPJxvXGydFbRoYVw0ooPrfEcIvZzbmFGPonwYKGS5zwj1WEv5fB60Q8JmuallFXwvqrufuzMrrA==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr4114657wrs.494.1639782731807;
        Fri, 17 Dec 2021 15:12:11 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:5f8d:59ed:773f:7237?
 ([2001:8b0:aba:5f3c:5f8d:59ed:773f:7237])
        by smtp.gmail.com with ESMTPSA id
 az15sm4119079wmb.47.2021.12.17.15.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 15:12:11 -0800 (PST)
Message-ID: 
 <61600edb8f90a9e49feb95ba75a72f9663654dcf.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] process: Do not mix stderr with stdout
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, Anton Mikanovich
	 <amikan@ilbers.de>
Cc: Baurzhan Ismagulov <ibr@ilbers.de>, bitbake-devel@lists.openembedded.org
Date: Fri, 17 Dec 2021 23:12:10 +0000
In-Reply-To: 
 <CANNYZj_DT0Y+B0CABEFzpQY0u07zAs8TzjsK7YEeMFW3dPFjiA@mail.gmail.com>
References: <16BED60D9AF8ECE2.12270@lists.openembedded.org>
	 <dc689a39-6fa3-a839-32a0-653e09b8d448@ilbers.de>
	 <CANNYZj9-NcL+gjdnvZAAUWWyL3V4nkwOXefaZ=fCryo4bqoHjQ@mail.gmail.com>
	 <ef707ea2-c766-2b25-0e09-cb5fc38812c9@ilbers.de>
	 <CANNYZj_DT0Y+B0CABEFzpQY0u07zAs8TzjsK7YEeMFW3dPFjiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Dec 2021 23:12:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13195

On Fri, 2021-12-17 at 21:41 +0300, Alexander Kanavin wrote:
> Thanks, looks like the issue is real, so the patch should go in unless there are
> other concerns.
> 
> > 

It already merged:

https://git.yoctoproject.org/poky/commit/bitbake?id=f8474be059bb02dcb46a425c0a1842ff2d4d2c8d

Cheers,

Richard


