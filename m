Return-Path: <amikan@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E47AC433F5
	for <webhook@archiver.kernel.org>; Mon, 28 Mar 2022 18:43:46 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web11.137.1648493025027589629
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 11:43:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: amikan@ilbers.de)
Received: from [127.0.0.1] (host-80-81-17-52.static.customer.m-online.net
 [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8) with ESMTPSA id 22SIhdDp011789
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Mar 2022 20:43:41 +0200
Message-ID: <b12812ec-78a7-d6dc-2dc9-b127b5e3a3cd@ilbers.de>
Date: Mon, 28 Mar 2022 21:43:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
From: Anton Mikanovich <amikan@ilbers.de>
Subject: Dynamic pipeline execution
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Mar 2022 18:43:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13526

Hello, we are using Bitbake 1.50.4 inside custom Yocto-like build system for
Debian packages building and need to have a dynamic pipeline changing 
based on
information obtained during the execution.

Here is simple 3-stage example of what we are doing currently in POC with 3
bitbake calls from external tinfoil-based wrapper:
1) Perform fetch tasks for some set of recipes to get their sources.
2) Obtaining some kind of data from the sources and generate dependency list
based on that data (analyzing debian/control files).
3) Perform build tasks for the original set of recipes and dependency 
recipes
obtained from the previous step.

The question is how can we do the same logic within only one bitbake call?
We see two possible ways of bitbake sources modification to achieve this:
1. Add an API for dynamic injection of tasks on already started cooker.
2. Rebuild runqueue handling to enable per-task dependencies 
setting/analyzing.

What is the best way to focus on?
Or maybe there is any other more simple solution for the same logic?

Thanks for any advice.

