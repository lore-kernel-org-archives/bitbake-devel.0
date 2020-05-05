Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web12.3612.1588665316896557283
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2020 00:55:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ANpmq1FE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id f13so1469144wrm.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2020 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=p8W6O+t+A0Xd+G00T+bZRkP1qLUkIB+/b7blK0DTJXU=;
        b=ANpmq1FEoMfKTNkzwNe+dbJxfwHTggiEQe//jLgvKL2bk7Z/qi/PLnfRnuU+E4e1j0
         ucJX0Cq3G0YSR4oxyvVOytlkGWQNFivAUjPqn5JrcHBfP1YH3DehbN8MOiB1l6H2Vhgg
         c0BrtjoPxNPtXg6Xio+MlqdJuY3lag19brbXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=p8W6O+t+A0Xd+G00T+bZRkP1qLUkIB+/b7blK0DTJXU=;
        b=dgpja45CA+7cZY3yc+huDnRBbypCyKtPVVixWgPtec0ia/oML3TJRq5Zyr+F7aEU8/
         amxsvhoR2lRAxlXjPWkBwJ7LimReshYGvelzRPfXjlkVR+CIYyKqgri3aJ3NR+Afi7G+
         rB5KQpUs7QIWHZY5nK7zXk/+DvUEBXZxC/PCt9jkhSRXv6JnObZDsfWctOICiF3CvQJh
         WYqsgTviJ3wzR9nzzgTgNsbqzIXIPqQeG2mbsIgtrgk9zSCkL2QCT2FhHwUgoH23BUQ/
         SGN3XpM2PsHRC9hhO43DQjSa5tc5oJzON2tUz/UELhJFVmwtJm9xYqbyNhBb4eo7sulL
         JgLg==
X-Gm-Message-State: AGi0PuYgerqSNHbDJqUZnDeFFHVXttvxmVSQXr6HsfIu6Ifr4q1gPq+0
	pvzBEHF9gzJOd4tJrZGmkZX9qAIeK88=
X-Google-Smtp-Source: APiQypIO/ugrywm9dFackZ71E0cm/18bDGxi2L8kjR09E7Lkrh6U6WWLUWCS2GVULCAMEBpYxqaPcw==
X-Received: by 2002:adf:f40b:: with SMTP id g11mr2393899wro.178.1588665315179;
        Tue, 05 May 2020 00:55:15 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id a125sm2372237wme.3.2020.05.05.00.55.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 00:55:14 -0700 (PDT)
Message-ID: <913bc1184c546164107fc8adcf7b9f76b5f2e0cd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Questions on fetcher
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 05 May 2020 08:55:13 +0100
In-Reply-To: <CALbNGRQGgPng5u33Dq_DzpfcqQkhVeWgD4sW9sWymXMHqni8Mg@mail.gmail.com>
References: 
	<CALbNGRQGgPng5u33Dq_DzpfcqQkhVeWgD4sW9sWymXMHqni8Mg@mail.gmail.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-05-04 at 23:23 +0200, Andreas M?ller wrote:
> Hope this is the right place..
> 
> Have two questions on fetcher:
> 
> 1. Feels this has changed recently: When I add/upgrade a recipe
> fetcher retries two times before giving up. Problem I have seen
> often:
> servers running two fast downloads but the third is VERY slow
> 10-20K/s. I checked docs/mailing list but did not find helpful. Is
> there a chance to abort after 1st fail and show checksums?

This sounds like there are mirrors configured and the fallback mirror
is very slow. I'd check the fetch logs and see which the slow server
is. The behaviour hasn't changed recently but some server may have.

> 2. In case of incorrect checksum the error text to copy easily into
> recipe does no more contain md5 entry any more. Does that mean md5
> checksums are not necessary any more and can be removed?

Correct, we're now only requiring one checksum and preferring sha256.
We'll just let the md5sums fade out over time.

Cheers,

Richard

