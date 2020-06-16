Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.1605.1592341054203163278
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2020 13:57:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bkX6CFUD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id j198so3065902wmj.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2020 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=We9kmF4QoSAgqQqcynqcyEg9DH4WMnivh0wqFR9Bf7s=;
        b=bkX6CFUDsoot932B3ZZdcJyq3C14K4+cx2/s1knoXKdBkcM9JSUwhT1G2a8HZ3jEhk
         nanS3s64tkhlWFRS+hEM6jJQKdlHq7OWu1w7ZvPJERzWTaUcMP6jzroEK5rHp+YVBkEi
         nSOjq03VuqxfUyUttbLJuyykU61jZcYJ0+V9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=We9kmF4QoSAgqQqcynqcyEg9DH4WMnivh0wqFR9Bf7s=;
        b=YesfWltuci7+9Ck3V2rM+3uah5Hr/ezdyuv+8GMSpzt8rxAXCbxbUczqFYfdmnVOru
         C+FnxauhGZp0bDhQR0NZGw9vRD04vd0MrN60w3MehWNeGGo2IpnRWkxZJOVQTyL7njMj
         tfZvSGA00vYr6knaMJLaOTbYcD8hhPXz84sYThMnngNNbCmIXhWBAPZNyvWqfldIa0Cv
         GKjBP4fOOs3ZeKkAvUaIBlryfqhviLzWAWwG7CtyUA8t/ATwtprm322Eq00MnS30BYGy
         zNF6+DBf4sbtZPiS7AnNk9SeJVdFseZ/NHNOFGCS01tXHS+cMI4odM1joVjFo97oI7Lx
         +tVQ==
X-Gm-Message-State: AOAM530qV3N0qN1gBTB/yLSzIsExsq5/CorxwkWHF2EAla7eOUJXUuOZ
	II/+d1VjzBHKaM4hzOGaxX9cqw==
X-Google-Smtp-Source: ABdhPJyH8+6zUO/eRBE7M1wYGqpph+ZvXmWREZ94YBuaZe9mnxSrE6+0QmMl2HCChU0RSEW3hHtAmQ==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr4825516wmc.1.1592341052477;
        Tue, 16 Jun 2020 13:57:32 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id o20sm32205115wra.29.2020.06.16.13.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 13:57:31 -0700 (PDT)
Message-ID: <aeec131ec619b70c2d52560c90074387f5d68171.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/utils.py: Do not preserve TERM in the environment
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 16 Jun 2020 21:57:30 +0100
In-Reply-To: <4b1882bd-0811-ee77-aa99-654924fb0953@gmail.com>
References: <20200615122231.1325750-1-jacob.kroon@gmail.com>
	 <2677ce4ecd89cb99e7bd491a68be93908023c87b.camel@linuxfoundation.org>
	 <b748351a-7330-50d0-86b3-890b3ec28570@gmail.com>
	 <7f41ff1c938ef998c4e5d67ac07642b8ebb324c4.camel@linuxfoundation.org>
	 <4b1882bd-0811-ee77-aa99-654924fb0953@gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-16 at 22:38 +0200, Jacob Kroon wrote:
> On 6/16/20 8:48 PM, Richard Purdie wrote:
> > We're not seeing any issues testing this on the autobuilder which
> > is good. Its part of some very old code, created when we first
> > started to try and clean up the build environment so its possible
> > other improvements have obsoleted this need now. Its obviously just
> > had to test and be sure!
> > 
> 
> If we decide to drop it as the patch suggests, then I guess we could 
> drop it from BB_HASHBASE_WHITELIST in oe-core/meta/conf/bitbake.conf
> as  well. (There is also a reference to 'TERM' in the bitbake manual
> which should also be removed in that case)

I'm about to merge this so if you could send the follow up patches that
would be great, thanks!

Cheers,

Richard

