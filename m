Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.4009.1618349874955406761
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 14:37:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T3hoiCmd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id y124-20020a1c32820000b029010c93864955so11489633wmy.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Apr 2021 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Me+hdoyrhO9OOj70UHoQENKDhYA28/Vp9GjqRWHt2gc=;
        b=T3hoiCmdFdfog1hQoUT3V9JlGGl/tOdCJRQ4MLXon/jrUbO2UqVJ9JfacSPj0gZGRw
         K9Cnal50GJ3Wbj+lTwHwRNC6JMZ005BCyfW0W2utYAgSxXA0DFc69ePRtXakD1eKcJdn
         hDfMtN1QJ5cc+Xm4i0xGiGqUXyWdciC9EyUeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Me+hdoyrhO9OOj70UHoQENKDhYA28/Vp9GjqRWHt2gc=;
        b=sSItZv0UMAzlDk0nK+CbAv3klLmKbcZ5KEuQb5/qm0GxmVLHMSLjiSUqQDjqwPhBNw
         U0n46S2yWp7E9isOQGN+6af7Q2UdulQhcVirxBNn68xnLhN8D1uuVISCKFDitV+2dofq
         ECNbSGW/1oYCLAFsUjnk0qQvQ3SIjRhehZlUYxrc+9BYdiOjRO2+CtLK1hDb9HOIr79i
         J4FpjDaFuxCZqP/FCFnVPXGtIKE7OMZQpxYTLnkcwRswA1RAX+7I+A9j931QJi9eVxNY
         l2EgnJ4UEdhU/gxdoZD2iVMTTrrmXy6VTXuIQtcKYKmB0UG6vYRzHk1S8kY8TSN7bM2p
         cYBA==
X-Gm-Message-State: AOAM533tfC1kxPHV0svh1Wyi295CJ/hQYbnEj6j51ErsRb0xYXrSWIhP
	2Ibr8qyIDBWPNG4VrpM1+YgByA==
X-Google-Smtp-Source: ABdhPJzYFD4emQydHL/z0zSmZOflLjvAhEHs3reRZivCc+oNBTydHG6qFJ+YaJM4z6II0tW9agxNAg==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr1853943wmk.104.1618349873327;
        Tue, 13 Apr 2021 14:37:53 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:92c8:89c8:3615:b078? ([2001:8b0:aba:5f3c:92c8:89c8:3615:b078])
        by smtp.gmail.com with ESMTPSA id n9sm3376712wmo.27.2021.04.13.14.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:37:53 -0700 (PDT)
Message-ID: <979af729ffac904b287ca62d533ac45e430bdc91.camel@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] tests/fetch: deduplicate local git testing code
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Henning Schild <henning.schild@siemens.com>, 
	bitbake-devel@lists.openembedded.org
Cc: isar-users@googlegroups.com, Cedric Hombourger
	 <Cedric_Hombourger@mentor.com>, Chris Larson <Chris_Larson@mentor.com>
Date: Tue, 13 Apr 2021 22:37:52 +0100
In-Reply-To: <20210413150251.1969-2-henning.schild@siemens.com>
References: <20210413150251.1969-1-henning.schild@siemens.com>
	 <20210413150251.1969-2-henning.schild@siemens.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-04-13 at 17:02 +0200, Henning Schild wrote:
> Purely cosmetic change that probably improves the code.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  lib/bb/tests/fetch.py | 33 +++++++--------------------------
>  1 file changed, 7 insertions(+), 26 deletions(-)

The patches look good but could you rebase+resend against master-next 
please? We're just sorting the current release out so there is a small 
queue and yours conflicts with another in the queue there.

Cheers,

Richard

