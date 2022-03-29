Return-Path: <amikan@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A11C433FE
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 13:08:14 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web09.6351.1648559293338481401
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 06:08:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: amikan@ilbers.de)
Received: from [127.0.0.1] (host-80-81-17-52.static.customer.m-online.net
 [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 22TD88NK015328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Mar 2022 15:08:09 +0200
Message-ID: <35332832-30ee-625a-a543-1ed29620fb7a@ilbers.de>
Date: Tue, 29 Mar 2022 16:08:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] Dynamic pipeline execution
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <b12812ec-78a7-d6dc-2dc9-b127b5e3a3cd@ilbers.de>
 <b673f5418f17d3cc420b9510c3844d7222cac83a.camel@linuxfoundation.org>
Cc: Baurzhan Ismagulov <ibr@ilbers.de>
From: Anton Mikanovich <amikan@ilbers.de>
In-Reply-To: 
 <b673f5418f17d3cc420b9510c3844d7222cac83a.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 13:08:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13537

29.03.2022 02:17, Richard Purdie wrote:
> On Mon, 2022-03-28 at 21:43 +0300, Anton Mikanovich wrote:
>> Hello, we are using Bitbake 1.50.4 inside custom Yocto-like build system for
>> Debian packages building and need to have a dynamic pipeline changing
>> based on
>> information obtained during the execution.
>>
>> Here is simple 3-stage example of what we are doing currently in POC with 3
>> bitbake calls from external tinfoil-based wrapper:
>> 1) Perform fetch tasks for some set of recipes to get their sources.
>> 2) Obtaining some kind of data from the sources and generate dependency list
>> based on that data (analyzing debian/control files).
>> 3) Perform build tasks for the original set of recipes and dependency
>> recipes
>> obtained from the previous step.
>>
>> The question is how can we do the same logic within only one bitbake call?
>> We see two possible ways of bitbake sources modification to achieve this:
>> 1. Add an API for dynamic injection of tasks on already started cooker.
>> 2. Rebuild runqueue handling to enable per-task dependencies
>> setting/analyzing.
>>
>> What is the best way to focus on?
>> Or maybe there is any other more simple solution for the same logic?
> That is going to be quite hard to do generically given other constraints we've
> put upon bitbake tasks. The setscene task graph is walked backwards, the main
> task graph is walked forward and so bitbake has to know what the task graph
> looks like in advance in order to be able to work on things from both directions
> and to be able to produce the taskhashes.
>
> Put another way, bitbake expects to be able to construct a task graph without
> execution (e.g. fetching/examining sources). The places where we do allow
> external inputs (e.g. querying an SCM for a revision) are fraught with race
> issues already.
>
> Where we have this challenge (e.g. crates and go modules), we're ended up with
> solutions which compute our metadata, then bitbake executes it. We haven't
> linked those commands into a single bitbake execution.
>
> Why do you want to use a single bitbake invocation rather than your existing
> tinfoil wrapper?
>
> Cheers,
>
> Richard

Hello Richard, thanks for quick reply.
Using single bitbake invocation can reduce overhead for recipes parsing and
task graph creation. We already have ~50 multiconfigs, so it takes some 
time.
It will also allow to save task parallelization during processing.
And it is more convenient to retain bitbake as entry point for the user.



