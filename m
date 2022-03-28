Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5C1C433EF
	for <webhook@archiver.kernel.org>; Mon, 28 Mar 2022 23:17:51 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.296.1648509470119579418
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 16:17:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A6jdJqvN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id u16so22439532wru.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 16:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=PQtkhQeAWRGsey5Al8C+fGZhsgvWEHfO8qdSaAuhU6k=;
        b=A6jdJqvNK0B1RzRir8gXqoY2O/6IIImxWFYWWMNbK/qCHfSJcGEhy1I+Wopc9w1uWu
         A1irEVYax20t7VbMe6EsVHR6Gvg3be+82TFyvfvB3sXzkJz8q6S5d0R9dwnqTlxTqBZq
         +cTyIutV3inPVc7TTryGKSI9RsGP5YCTuhB88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PQtkhQeAWRGsey5Al8C+fGZhsgvWEHfO8qdSaAuhU6k=;
        b=b14K1HcarJvsQqplKtI7myj1XiYItQN4PpUsqvxbx2ZbTH03WNtD907QomNt85QRhu
         UrZqWwMOWp9Aig5fb1l1oeYBBUjWo9bzPdCsvc1NHK2VZrSp0MB2AzS4zsKfYiMnLvzf
         zSIIYi8R2oUwEBoFNe8EB9R/r7b7yCl8n8Sqayo+snxqnxvV8OQ2h/2nqOy7DxB7OA4m
         qIOTveASgPq/7lHaFhUNdKw0b0tEbFhmGxOz3d37Y9yNR3T07ZB1lG2ZULGI6pCaji19
         2A82kVN7NuVc8XYpnWW+du5pvu8a2yIYnP0mjG1BwQJtUgD1t25dyuEoV9a6rIs1v4LO
         SKjA==
X-Gm-Message-State: AOAM532fsx/vFnNau2LCelwn5s4/frqfxr6+qMA5VAH1MnwzYFCm7UHY
	+7IVMgIIiBqEb2KSsp4pD/SVbw==
X-Google-Smtp-Source: 
 ABdhPJyGqpy0SmFxFLOMQO1E0jNbu/bpMzlqIQ9KcYR7KXi1s+qbVTK70lPGzkOoHsLhHF2sAfhAMg==
X-Received: by 2002:adf:ec02:0:b0:203:e0c5:ab14 with SMTP id
 x2-20020adfec02000000b00203e0c5ab14mr26731563wrn.95.1648509468593;
        Mon, 28 Mar 2022 16:17:48 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a144:3266:4a07:b254?
 ([2001:8b0:aba:5f3c:a144:3266:4a07:b254])
        by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c154e00b0038d06cc21b2sm715452wmg.35.2022.03.28.16.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:17:48 -0700 (PDT)
Message-ID: 
 <b673f5418f17d3cc420b9510c3844d7222cac83a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Dynamic pipeline execution
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Anton Mikanovich <amikan@ilbers.de>, bitbake-devel@lists.openembedded.org
Date: Tue, 29 Mar 2022 00:17:46 +0100
In-Reply-To: <b12812ec-78a7-d6dc-2dc9-b127b5e3a3cd@ilbers.de>
References: <b12812ec-78a7-d6dc-2dc9-b127b5e3a3cd@ilbers.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Mar 2022 23:17:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13527

On Mon, 2022-03-28 at 21:43 +0300, Anton Mikanovich wrote:
> Hello, we are using Bitbake 1.50.4 inside custom Yocto-like build system for
> Debian packages building and need to have a dynamic pipeline changing 
> based on
> information obtained during the execution.
> 
> Here is simple 3-stage example of what we are doing currently in POC with 3
> bitbake calls from external tinfoil-based wrapper:
> 1) Perform fetch tasks for some set of recipes to get their sources.
> 2) Obtaining some kind of data from the sources and generate dependency list
> based on that data (analyzing debian/control files).
> 3) Perform build tasks for the original set of recipes and dependency 
> recipes
> obtained from the previous step.
> 
> The question is how can we do the same logic within only one bitbake call?
> We see two possible ways of bitbake sources modification to achieve this:
> 1. Add an API for dynamic injection of tasks on already started cooker.
> 2. Rebuild runqueue handling to enable per-task dependencies 
> setting/analyzing.
> 
> What is the best way to focus on?
> Or maybe there is any other more simple solution for the same logic?

That is going to be quite hard to do generically given other constraints we've
put upon bitbake tasks. The setscene task graph is walked backwards, the main
task graph is walked forward and so bitbake has to know what the task graph
looks like in advance in order to be able to work on things from both directions
and to be able to produce the taskhashes.

Put another way, bitbake expects to be able to construct a task graph without
execution (e.g. fetching/examining sources). The places where we do allow
external inputs (e.g. querying an SCM for a revision) are fraught with race
issues already.

Where we have this challenge (e.g. crates and go modules), we're ended up with
solutions which compute our metadata, then bitbake executes it. We haven't
linked those commands into a single bitbake execution.

Why do you want to use a single bitbake invocation rather than your existing
tinfoil wrapper?

Cheers,

Richard






