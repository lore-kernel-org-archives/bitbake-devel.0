Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.9786.1614937249585806370
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Mar 2021 01:40:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hRVLocKe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id 7so1356079wrz.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Mar 2021 01:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PZQ+mR1jaiwDlc1Lh3mvpDGD/iGi0YSnU6t9+nsLKV0=;
        b=hRVLocKeZ9z3zlvNsHG8G6LUf7hzO3kMOwGBUVriWlEb2Ghl/QIE0QzGOnsofISlKk
         PR21qr9BrzQqKQGBhYSoaAyt4Tf8zoOdBtgqIWSgl4JiC6OquI3ws/OdXIjdPzwH/WXv
         fQXRa0rGpD2PBZyMuoTbjbEEnbXjDKZ+Dh8/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PZQ+mR1jaiwDlc1Lh3mvpDGD/iGi0YSnU6t9+nsLKV0=;
        b=bIDCdkTdyzSmRB/6GAFe/9T92NC/SCAjooIGeAQLKUSixZ8tk8a7p6cfJw5ly6gmrz
         veUhW3LIMbN6AasrGPxRVE00PfdnJfD0D8JQ47rZc6mNbl/WW5WUurlwLu/agVFOE5T/
         sIxLZgZwnZBJ7a2fNIVxhmPr/PxYMMIc1mcp4sZBYf1bTHodv9dlh1ekuDmoxpsll+fq
         /f05KeEcXep+8BYrTKn7+rcMngy6xWmD8adqSsRN5aVxFbI42Rq4tOIIScqPvk+6zltL
         tGd3J+RGzeVM3FN8y29EtLGJKag590EHXruzNs2zvA16lv6yZe14USgO0g4F+z2Bi7+9
         6odA==
X-Gm-Message-State: AOAM533m1IeThbF2LPqOAIlKpkFt5CWlajRP0ASHqGgOty3+D6RWQRdG
	JLI9+gX3wxo73itXEbp2dfmQXw==
X-Google-Smtp-Source: ABdhPJzh1CZKwx814TB59Gy0/nq4JzQ+ZEpUzo9M/Svmqypc4YnXoxEqi/HuaiOTwahgb9RUXrztNg==
X-Received: by 2002:a5d:42cb:: with SMTP id t11mr8386931wrr.280.1614937247953;
        Fri, 05 Mar 2021 01:40:47 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:a6be:e9e5:bd97:feaa? ([2001:8b0:aba:5f3c:a6be:e9e5:bd97:feaa])
        by smtp.gmail.com with ESMTPSA id 75sm4037353wma.23.2021.03.05.01.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:40:47 -0800 (PST)
Message-ID: <eb67b43dfc87005748f21eaf052c2fa3fc82ca8c.camel@linuxfoundation.org>
Subject: Re: [PATCH v3] runqueue: Print pseudo.log if fakeroot task failed
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: kergoth@gmail.com, Jan Brzezanski <jan.brzezanski@gmail.com>, Paulo
 Neves <ptsneves@gmail.com>, Mikolaj Lasota <mikolaj.lasota@protonmail.com>,
 Wiktor Baura <wbaura@gmail.com>, Kamil Kwiek <kamil.kwiek@gmail.com>
Date: Fri, 05 Mar 2021 09:40:45 +0000
In-Reply-To: <CAJkqNs3JqXTh9R3BEqz3AV2cSi5L93OD+pk_byiu-K8AqUykng@mail.gmail.com>
References: <20210222203630.9686-1-tomasz.dziendzielski@gmail.com>
	 <CAJkqNs3JqXTh9R3BEqz3AV2cSi5L93OD+pk_byiu-K8AqUykng@mail.gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-03-05 at 10:03 +0100, Tomasz Dziendzielski wrote:
> Hello,
> I found a worrying issue in runqueue.py exposed by this patch. Lately I encountered a few cases where
> pseudo.log was not printed on pseudo abort. I added some debug prints and it seems in some cases (where we
> build the whole image, not single recipe) taskfn is set incorrectly.
> The recipe X failed with task log:
> |  Check logfile: X_WORKDIR/pseudo//pseudo.log
> | ...
> | ERROR: Logfile of failure stored in: X_WORKDIR/temp/log.do_install.34470
> but the debug line printing taskfn value and pseudo.log path taken from dictionary (based on taskfn) showed:
> | WARNING: taskfn: PATH/Y.bb pseudo_log: Y_WORKDIR/pseudo/pseudo.log
> And since there were no pseudo abort in Y recipe the log was not printed. (Please note that this warning
> comes from the failed task from X recipe)
> 
> The important note is that I don't change the value of taskfn with a patch sent
> under this subject, so it's unlikely that my patch introduced this behaviour. In
> this patch I just pass current taskfn value to start_fakeworker(), so in fact 
> it's value is already wrong in the execute() method. It means something else 
> might also be broken and not yet detected. Please correct me if I made some 
> wrong assumption. Maybe taskfn is expected to have some different value and I 
> just shouldn't depend on it? I can't be 100% sure it's not related to my 
> changes, that's why I'm writing in this thread, instead of submitting a bug.

I'm afraid it is your patch. There is only one fake worker started per multiconfig
and therefore the taskfn is being set to the value of the first task run on that
worker, it doesn't get updated as other tasks start. This is the wrong place to
be passing in that value.

Cheers,

Richard

