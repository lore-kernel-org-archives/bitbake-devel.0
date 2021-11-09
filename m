Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD7C4332F
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 12:21:50 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.11091.1636460509342970826
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:21:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MBH2EWBs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id
 f7-20020a1c1f07000000b0032ee11917ceso2142311wmf.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0r6djCxhPMyGAaUqiTrcP6p6fl3fmgEestGie0jzzv8=;
        b=MBH2EWBsG1Co9x7xiJQU7mWeHOAx+wzfrkc1GL2XSDq1YRzbAKKa3x9huOIJDskVwg
         SHEjohf4PWMe/Fsm+0Ru01ZJHc2dz8W258l+K1MUEOD03J6mUS64Bx/6kiQJkN5mlL0v
         YjRG+NkNfagWq+3FdN0pHr2b5JI3B5K3ptuCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0r6djCxhPMyGAaUqiTrcP6p6fl3fmgEestGie0jzzv8=;
        b=YuUfQgosNDwBkJkXnQI4K87eZwZU6nQqgXq0te2APSx4JG8pszoC3VHDTX3+fLwJhx
         Ywu/BNB8Ij1VKawowOlH+C3XvMEQVbkY+a4cHdISrJVIubkxs2EC0/yhw87ulR306hqX
         8Y2Rv+o+bwfW+i3NYVIF6GJ3tDbPy7UI5tpE1H5qcGwZMGsnnX2PZxVy2riYFm1QdFky
         nIjDKwOLJFOJCobI54Myy8hI3YppiPih3u7HU8THzRSzxIz6OUMMTOnpwIphHyoOFTQK
         kw47USbKnA1cBTuV8yPD7W38XBc2jQILAEnBQ7rYh+vmc4XkT8CFFyf/z/vQ/TWUBme3
         +VeQ==
X-Gm-Message-State: AOAM530424RDZk1Afey5axreCpeqlOqGb9OmA/QtGDpgjQZCy4sEHUy4
	OW/Su1Icn5QXvjApx3wSAqU/wQ==
X-Google-Smtp-Source: 
 ABdhPJyEK1vO7MDf0tXHb7EeCW9Oj9aYTmVyv+IZn1PI9yx0Pp4FEZUujduZD0jRNifiPagLYByBDQ==
X-Received: by 2002:a1c:8093:: with SMTP id
 b141mr6740223wmd.129.1636460507865;
        Tue, 09 Nov 2021 04:21:47 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:10b7:e9c6:d1a:6f7c?
 ([2001:8b0:aba:5f3c:10b7:e9c6:d1a:6f7c])
        by smtp.gmail.com with ESMTPSA id
 p12sm23632994wrr.10.2021.11.09.04.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 04:21:47 -0800 (PST)
Message-ID: 
 <e5b2f8439e5aab93a2841728e00650185ff60573.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] bitbake style/workflow
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Mikko.Rapeli@bmw.de, Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 09 Nov 2021 12:21:46 +0000
In-Reply-To: 
 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
References: 
	<CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
	 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
	 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
	 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
	 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
	 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
	 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
	 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
	 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
	 <YYo2KsoUeMTZ6y5C@korppu> <16B5D5AA827DA237.27841@lists.openembedded.org>
	 <16B5D6BAD1F7C3E6.27841@lists.openembedded.org>
	 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 12:21:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12966

On Tue, 2021-11-09 at 12:56 +0100, Marius Kriegerowski wrote:
> I'm sure there is a readon not to hit the merge button but instead doing that
> manually which I don't understand.

No, you don't understand and it is actually a *really* important difference.

We are a community project with wide peer review. *Nobody* gets to merge changes
without that peer review. I may be the maintainer for some of it but even my own
patches get peer review. This means there is no single "this patch can merge"
point without it having been on the mailing list for potential discussion.

If a patch gets sent via the github MR, someone needs to take that, put it on
the mailing list and ensure the community gets to review it. Khem has kindly
taken on that role for some patches which is his choice. If there is review
feedback, it puts him in a tricky position since he then has to merge that back
to the github discussion somehow. We do not encourage this and in the case of
the repositories I maintain, I simply do not have the bandwidth to try and do
this for multiple github MRs.

I understand it is easier for people to submit but our processes simply don't
scale to that and people would get *very* upset if changes through github MRs
were bypassing normal peer review. This is why Khem cannot simply hit the merge
button and why our other repos don't support that workflow.

Cheers,

Richard






