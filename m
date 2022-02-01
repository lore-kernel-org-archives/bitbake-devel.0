Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70E3C433EF
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 08:00:52 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web08.45426.1643702451694805505
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Feb 2022 00:00:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PBDzXmCt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id n8so12042116wmk.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Feb 2022 00:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=Vmp9luEgd+5biSwIBokyvBqgrIVj/mUssdyjTC5ZybM=;
        b=PBDzXmCtebi/P9+WjZfN8yIT8R1hzwVSforIKZF1ks0fmbg9mYuKz64nbuAyxJOxIF
         +ehUrRVcNzs/Ug5mf2Abo1APvOBJxTeFETLaTZOwddXyzs5lYeq6EFMCkxRebKVbiYsx
         S52VgvKoFmgV6qpEd1ubm2u8uKDW88UzL0F+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Vmp9luEgd+5biSwIBokyvBqgrIVj/mUssdyjTC5ZybM=;
        b=TUK2+ekDKbziibHgZTn7T4RtbOL6KN79OjVWydG1RZIamS3tHQzyJEANtXGelxWOFl
         YZQiAb+95bVkyszStCOqE2AtdBdIK4ieiytv4PP5iyY1yuPkDuGYpHgaP5DO+oFG7gvX
         CRC+TztqIjvYaxJ8lDh0JbtqkCAXvSpOrzBH4zn271M13kNR3EzwmBSzTGbLsWAprHNd
         mwpIPJwVZUOb2JwnDonlcKVli6eCNd+5SLmWEZFZVPFM/q8oQQMcbAwy890JDUi/w+SQ
         io+nz8jmYdq+5Y5enBG017+lsgDMmjySo/Gm0sPZKoQCL8SmB5dHiCHcGH7Oz81FQS+r
         ox+g==
X-Gm-Message-State: AOAM533sbc04+GcSCn0Tg4e56AVSCbhV6wEl4SjNDM5786PDER9o0jDV
	eyTyF/mQwztNbvmBW3mOGJelFA==
X-Google-Smtp-Source: 
 ABdhPJzWMxdgX1EQZpYZLgB5CXD4ZPikWdhCf33jzV7PmCKnt+RZoa/LxqCuJnMOEmFtNeqYoUQ/sw==
X-Received: by 2002:a05:600c:27d2:: with SMTP id
 l18mr651040wmb.176.1643702450061;
        Tue, 01 Feb 2022 00:00:50 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:687d:5e4e:cf88:f9f9?
 ([2001:8b0:aba:5f3c:687d:5e4e:cf88:f9f9])
        by smtp.gmail.com with ESMTPSA id j2sm1408800wms.2.2022.02.01.00.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:00:49 -0800 (PST)
Message-ID: 
 <6dd771e81db2c09c606c298b452850c16818be5c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] knotty: improve the UI information
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Trevor Woerner <twoerner@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 01 Feb 2022 08:00:48 +0000
In-Reply-To: <20220127205138.29159-1-twoerner@gmail.com>
References: <20220127205138.29159-1-twoerner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Feb 2022 08:00:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13303

On Thu, 2022-01-27 at 15:51 -0500, Trevor Woerner wrote:
> During a build you might end up with bitbake telling you:
> 
> 	Currently 30 running tasks (2757 of 2757/3476 of 6390)
> 
> Which, to me, is really confusing. The forward slash separator and the two
> numbers immediately on each side of which are likely to be interpreted as
> being one unit (i.e. 2757/3476) but they're not. Also nothing is labeled,
> leaving the user to wonder what these numbers are.
> 
> Add labels, spaces, etc. to help clarify the information bitbake is trying to
> convey. The resulting line would appear as:
> 
> 	30 running tasks (setscene:2757/2757 tasks:3476/6390)

I agree we shouldn't have used / as a separator, my fault on that.

If we're going to change this again we need to get it right and I feel we're not
quite there yet. I was wondering about:

  30 running tasks (3476 of 6390), (Setscene: 2757 of 2757)

which moves the "tasks" closer together however my other worry is that people
don't know what setscene tasks are and that the setscene piece is then not
ordered before tasks. The "of" keyword does clearly indicate something to some
subgroup of users, I think I was once advised about that.

We could consider:

  Setscene tasks: 2757 of 2757
  30 running tasks: 3476 of 6390 

which would break the code assumptions about a single line but we can likely fix
that...

Cheers,

Richard


