Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.253.1614966645453423407
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Mar 2021 09:50:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XtRqDcfX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id n22so2192876wmc.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Mar 2021 09:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VCD/T1e5/9rgPBpxm2/lBfQJQ1RPST2SoJSJTo/yhiM=;
        b=XtRqDcfXprtTYHIc9VC5BoTWsqBmocEfWiQm5NONK7OsK+ry0bBmfI3s9MK3ZK9QhC
         6q/u755c18lDt5NF3nb+lrQnsJbqSTQVJjEDExZ7vQ10NoNCbBemlYt0RlMF7r9u+1jZ
         d80g48rCpH7aEWtIeReDsotk5poNoGzrAXVk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VCD/T1e5/9rgPBpxm2/lBfQJQ1RPST2SoJSJTo/yhiM=;
        b=Sow08BvwZ/Po0pJJl+9VrCfkA5dD8Wn0tKR+vjBxpTZPWnK97LtShgoEHhZk7Alkwu
         4ewcf+BjqiOzwgb8BEJRS3uk1YXMX1gaIrhJvyO5Vl3W/1a8KTNWzJ+FMmsC4UAcxcD4
         gxBuvNx2FjHnPvWUD8W5DQo+YRyxb2NocaieIOQKC/Fvh5r4cDo4VlW+u0nmzsKYwdtW
         s2UdS/H9B2w9HUg2e1Ii3hUwhqaS3zBgPPHH+hIV9J7yDk5FbPkyhzAtPWHVwB73O/Ib
         sxGS2a3NKTtxjoE2WcL95ZQFs8EsPlwShmaAUVJVDXKWfez7CJdtvznOU218SP6o27GQ
         PZAw==
X-Gm-Message-State: AOAM533RKXNTKX4wpZGGESXJkhcAEf0GsUbTYCr0Kv10v6vm5hls3uar
	m3EKCfEbSDeiUmITrc7rUnDWMg==
X-Google-Smtp-Source: ABdhPJyOu0MWHSua/8gsPKVqLmXLo1ebs5w9EQ7s/YBHqPC+mJSpQIRy/znmF/NIzi6TN/TSQEGhHQ==
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr9790004wmq.183.1614966643799;
        Fri, 05 Mar 2021 09:50:43 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:a6be:e9e5:bd97:feaa? ([2001:8b0:aba:5f3c:a6be:e9e5:bd97:feaa])
        by smtp.gmail.com with ESMTPSA id f5sm5099032wrx.39.2021.03.05.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:50:43 -0800 (PST)
Message-ID: <7133548d7c805c051099c599553027689c2351ce.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v4] runqueue: Print pseudo.log if fakeroot task failed
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Jan Brzezanski <jan.brzezanski@gmail.com>, Paulo Neves
 <ptsneves@gmail.com>,  Mikolaj Lasota <mikolaj.lasota@protonmail.com>,
 Wiktor Baura <wbaura@gmail.com>, Kamil Kwiek <kamil.kwiek@gmail.com>
Date: Fri, 05 Mar 2021 17:50:40 +0000
In-Reply-To: <20210305114424.10665-1-tomasz.dziendzielski@gmail.com>
References: <20210305114424.10665-1-tomasz.dziendzielski@gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-03-05 at 12:44 +0100, Tomasz Dziendzielski wrote:
> Currently if pseudo fails we can only see the path to pseudo.log. If we
> have no access to server and can only rely on bitbake log then debugging
> becomes impossible. This printing needs to be added in runqueue level,
> not inside task execution, because in some cases task fails with pseudo
> abort really early and we don't even see any log.
> 
> In this change I'm adding pseudo log printing in every fakeroot task
> failure that logged `mismatch`, `error` or `fatal` to logfile, because
> we have no other way to communicate with pseudo if it failed or not.
> Only lines from last pseudo server execution will be printed.

I don't think this is going to work as it has the same issue as with taskfn.

There are only two bitbake-worker processes started and these fork off
individual processes. The fakeroot enrvionment is adjusted in those
workers as the tasks are started and pseudo will reread from the 
environment. The log analysis code will need to update to the current 
process' environment too...

Cheers,

Richard

