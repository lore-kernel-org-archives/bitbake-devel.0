Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B39C433EF
	for <webhook@archiver.kernel.org>; Wed, 19 Jan 2022 12:11:49 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web08.5417.1642594308953730793
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 04:11:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HyTs5nAA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id p18so5006920wmg.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 04:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=QzHCmQcfy5y3KvhrllSzdYKviya0qk0Ea5wmq8KcyN8=;
        b=HyTs5nAAYJv07FJ9hBngdUj+eNnWGute9wwoda7133s3gytiouXVpLsma9VmrTxjgL
         NgeovUlE1JRb3a/KWQWeXD/mu7oXfkUH3keHPddeFgQBA2GdcUdFwEmYnNzflxciTHrd
         gb5UH3leF+HmDN+AtA/C844TRnY6miexS1jiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QzHCmQcfy5y3KvhrllSzdYKviya0qk0Ea5wmq8KcyN8=;
        b=TasY1oY5fX8em2kZzfr6rcCAA7HEptmknBmHJ6Y6K07AMaureA7rtHbKwkpdWhU9tT
         csOGh6qoHvwesGAwTABbS6TC7Nukqk/hK2SgoHAMZePXgj11emKgB/Ev0MKEfcyRkqqH
         apLoUnmzVXLMvfF0hzYxidlbG5lD1ZEDAXdVOgKvLzcs7OGmurmGr4oPQBs/yzvjDw4o
         e6qvtfZv2ckZoQWBqsSyjIayD6Uq2gkuTNJOgxGRfc8dmOBY6nEdMuzXxKRnVN7uKU06
         zPN/xc8C3L0YUWpsogYjX9KbAQTkBfajluOT4Lq+BPwNZtOgCXdz+BPv80QyfduVUOpU
         0kcg==
X-Gm-Message-State: AOAM533je6aiByUJshqpYzf4NTIubo2/WO1MvVD54KPinMdZYWFm7QEk
	LcnVXXkYOWNv21lPMZKvfSEkURCT7vAS+A==
X-Google-Smtp-Source: 
 ABdhPJzSzhu94vEfbTSpt2CSwIeF4KFFYGxqFgImduEksjHGuIZ3DyvSScNDPaqDK9fghSCEUe41+Q==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr662829wru.462.1642594306932;
        Wed, 19 Jan 2022 04:11:46 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:4e1a:65bf:4ced:cc2d?
 ([2001:8b0:aba:5f3c:4e1a:65bf:4ced:cc2d])
        by smtp.gmail.com with ESMTPSA id
 p4sm5091282wmq.40.2022.01.19.04.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:11:46 -0800 (PST)
Message-ID: 
 <4c46161127f6a8a6a903cafefd1512348b1240ca.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-worker: Add/support network
 task flag
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jan 2022 12:11:44 +0000
In-Reply-To: <706c435f-4c16-0914-fc9a-bbc4050319a1@windriver.com>
References: <20220107231526.1517563-1-richard.purdie@linuxfoundation.org>
	 <20220107231526.1517563-2-richard.purdie@linuxfoundation.org>
	 <706c435f-4c16-0914-fc9a-bbc4050319a1@windriver.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 12:11:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13245

On Wed, 2022-01-19 at 19:49 +0800, Robert Yang wrote:
> Hi RP,
> 
> On 1/8/22 7:15 AM, Richard Purdie wrote:
> > This patch changes behaviour. After this change any task which does not
> > have the network flag set will have networking disabled on systems that
> > support that (kernel version dependent).
> > 
> > Add a "network" task specific flag which then triggers networking to
> > be enabled for this task, it is otherwise disabled.
> > 
> > This needs to happen before we enter the fakeroot environment of the task
> > due to the need for the real uid/gid which we save in the parent process.
> > 
> 
> It seems that this patch doesn't work with NIS user, since NIS user alwasy try
> to access the network to translate UID to USER, but there is no network, so we
> will get the errors like the following during the build:
> 
> do_ypcall: clnt_call: RPC: Unable to send; errno = Network is unreachable
> 
> These error messages may cause build failures such as
> 
> 1) bitbake quilt-native -cdevshell doesn't work when set OE_TERMINAL = "screen" 
> in conf/local.conf:
> ERROR: quilt-native-0.66-r0 do_devshell: Unable to spawn terminal screen: 
> Execution of /path/to/0.66-r0/temp/run.do_terminal.189055' failed with exit code 1:
> getpwuid() can't identify your account!
> 
> If no OE_TERMINAL is setting, it will go into a shell with "I have no name!":
> 
> I have no name!@host:/path/to/quilt-0.66$
> 
> 2) bitbake cmake-native failed
> This because the error string "do_ypcall: clnt_call: RPC: Unable to send; errno 
> = Network is unreachable" has been assigned to a variable, thus caused while 
> errors, for example:
> VAR=$(whomai)
> 
> It will get the string "do_ypcall: clnt_call: RPC: Unable to send; errno = 
> Network is unreachable", and cause build errors.


Thanks for the report, that is rather sad/unfortunate.

I guess we'll have to add some way to allow network access globally for such
machines, much as I'd prefer not to.

Cheers,

Richard


