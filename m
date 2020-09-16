Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.318.1600286744055204364
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Sep 2020 13:05:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=c6sB25qc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id w5so8154188wrp.8
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Sep 2020 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QiNeuNzcfFk5u15zqH3ch0cdiHa5s9oE6IK79bD81g4=;
        b=c6sB25qcbI9on2ooF7NApAWNpkgGoVkE2sERVm/H+ty9ucgBzAWQqHD6BXQ3ndqDMR
         g8tUHFn2v4i3oNKMZQmwAmkcs2q9CAgyx2NffHifJ1p7vpgVfH9bvftEZQRB6JI/zdKY
         Xc2Ro6Ec/zgexIEmfB4ZZCLiAsjFqrbLaRFWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QiNeuNzcfFk5u15zqH3ch0cdiHa5s9oE6IK79bD81g4=;
        b=bKA/W6xLITzB2Su7De28txymD8MSyObZrzziDUjFuOwsVvMz/9DJM12eA3UIvUa7FY
         Y759glAyWGPSVaPKWZcqZUxZAISXDOOTA679urUkUhzDgPuRzfZ4PK4yqLtTaHDa9kmw
         Fr0dI0pxV4G673T96xOvYS5JGe0RaoeGdgqwZTli9lb3yYjiAfdV5AziYgm4mHkIjVw5
         U9Wue53+0Ctpk+/bgcW0c8NYJabsGefantMrYOL8wwnnUTFNj3WwhTeVxHa3/SlysXZ0
         Wq7QwcX4prLwlvhjrHHr/1L/qsjuTXD+UmL3CMHC54s7jMexxA/SlXK+LE5H5ltBUioT
         w7UQ==
X-Gm-Message-State: AOAM533jhHcqZNk8jQ8/A+UH2FFzHVj7ZmWzqTXX9dje1917svBJStF/
	cLlq9uFQ/x35WvImFRtQ3blxoNrpaJD8tQ==
X-Google-Smtp-Source: ABdhPJzQqu8nbZ441NeqNZEohPoEUmqsiz3ewq/luc8v0bQzgOA7P3AMowe2527vCYP/MnLPFhnzLw==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr28180233wrq.408.1600286742058;
        Wed, 16 Sep 2020 13:05:42 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from c.6.3.c.1.5.9.4.8.7.9.7.2.3.5.0.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (c.6.3.c.1.5.9.4.8.7.9.7.2.3.5.0.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:532:7978:4951:c36c])
        by smtp.gmail.com with ESMTPSA id k6sm6613427wmf.30.2020.09.16.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 13:05:40 -0700 (PDT)
Message-ID: <8519545833ac58a1221fa9d34d509217c775e3af.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] SyncThread exit issues
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 16 Sep 2020 21:05:37 +0100
In-Reply-To: <16341DF9BC4EF512.16354@lists.openembedded.org>
References: <16341DF9BC4EF512.16354@lists.openembedded.org>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2020-09-12 at 19:52 +0100, Richard Purdie via lists.openembedded.org wrote:
> Hi All,
> 
> Its taken quite a bit of debugging and going around in circles but I'm
> now 99% sure the remaining "hung" bitbake issues are related to the
> SyncThread. It is exiting correctly but taking far too long to do so.
> The bitbake-cookerdaemon log for a recent failure is shown below but
> the key section is this:
> 
> 622524 16:21:48.768140 Exiting
> 622524 16:23:22.923871 Original lockfile
> contents: ['622524\n']
> 
> i.e. at exit bitbake went AWOL for 94s. This is longer than the 60s 
> connection timeout so this is why other tests failed. Earlier lines in the log clearly show the SyncThread had not finished.
> 
> I'm not really sure what to do about this, presumably its due to high 
> IO load on on the autobuilders.
> 
> I wanted to mention it to show that we are at least able to clearly 
> identify the cause of the rare test failures and the logs are doing a 
> better job of capturing what is going on.
> 
> (https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/1352 was the build that failed this corresponds to)

For the purposes of the archives, I think the problem is happening
particularly on the Fedora workers which are using ext4 partitions with
normal journals. On some other machines we use ext4 partitions with
writeback journals.

The journal runs in its own process which has be/3 priority, so even if
we have file deletion running at idle or compiles at be/7, they will
end up writing to the journal which can stall out be/4 process I/O.

The solution here may be to mount these ext4 partitions as writeback
journals. This will mean fewer writes through the journal, letting the
I/O scheduler do the right thing.

Hopefully :)

This also explains an observation I've had where a build with an
"ionice -c 3 rm" runs much more slowly than a build without
'background' deletion.

Cheers,

Richard

