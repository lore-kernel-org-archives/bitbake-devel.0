Return-Path: <amery@apptly.co>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A6C5DF81
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 20:01:25 +0000 (UTC)
Received: from v523.v5ed9ac7d.euw1.send.eu.mailgun.net (v523.v5ed9ac7d.euw1.send.eu.mailgun.net [141.193.32.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4905.1787169677587484243
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 13:01:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@e.apptly.co header.s=mta header.b=gfenGGo2;
 spf=pass (domain: e.apptly.co, ip: 141.193.32.23, mailfrom: bounce+ec7242.b6604b-bitbake-devel=lists.openembedded.org@e.apptly.co)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=e.apptly.co; q=dns/txt; s=mta; t=1787169675; x=1787176875;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From: Cc: References: To: To: Subject: Subject: MIME-Version: Date: Message-ID: Sender: Sender;
 bh=kWhsNdrdsHcy7KFvqt6x6YL3wAI7EK3/Q+GIH8x2pdM=;
 b=gfenGGo2nPHu83NBv0Tdl1u0PEhsAZAlvJymv+/22aOSw1pZT53q+W7chhk1gKxJYuwvxnGaTa07wZDq385U6WHGd+gTTghTENlWCsaanal5bjr53yAFA8Hai5CcUDL8IpSW05aywEa03EK+fVv9MpFAYNXgX54Y76PkVQd8CVU=
X-Mailgun-Sid: WyI5YTJmMyIsImJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyIsImI2NjA0YiJd
Received: from [10.1.16.191] (unknown [51.179.224.164]) by
 ba4ca66762c64c012a62cd489d7522b5eca30b2dadf4eac50dd3b3ca7e41976f with SMTP id
 6a860b8b61b96f7ac0f42c24 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 19 Aug 2026 20:01:15 GMT
X-Mailgun-Sending-Ip: 141.193.32.23
Sender: amery=apptly.co@e.apptly.co
Message-ID: <bae58165-fd11-432b-832e-26d244415fa8@apptly.co>
Date: Wed, 19 Aug 2026 21:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] data: Return a list from exported_vars()
To: bitbake-devel@lists.openembedded.org
References: <20260727172856.2304118-1-amery@apptly.co>
 <20260730190854.2456522-1-amery@apptly.co>
Content-Language: en-US
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
From: Alejandro Mery <amery@apptly.co>
Organization: Apptly Software Ltd
In-Reply-To: <20260730190854.2456522-1-amery@apptly.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 20:01:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20004

Hi,

On 30/07/2026 20:08, Alejandro Mery wrote:
> exported_vars() was a generator, so each value expanded when the result
> was iterated rather than when it was called. bitbake-worker binds it
> before bb.utils.empty_environment() and iterates it afterwards, so any
> expansion deferred until iteration ran against the wiped environment
> rather than the one bitbake started with.
>
> The corruption is not uniform. The worker writes each variable into
> os.environ as it goes, so only the first value expands against a fully
> empty environment and the rest see it partially rebuilt, in
> exported_keys() order.
>
> Recipes whose exported variables expand a command during that loop hit
> this. A gitver-style PV such as "${@get_git_pv(d, ...)}" runs git while
> PATH is empty, so the git wrapper on PATH is bypassed and the real git
> runs directly. Under pseudo this fakes uid 0 against a repository owned
> by the real user, and git aborts with "detected dubious ownership",
> failing do_package intermittently (only on reparse, when the value is
> re-expanded rather than served from cache).
>
> Build and return the list in exported_vars() itself, so the expansion is
> complete before it returns and no caller has to know it was ever
> deferred. A value that fails to expand now warns at that point rather
> than during iteration, and a result nothing consumes is expanded anyway;
> neither is a change for the one caller, which consumes all of it. Update
> the comment at the worker's call site, which documented the generator
> that is now gone, and add tests for the expansion timing and for the
> warning that moved with it.
>
> - v3: materialise in exported_vars() itself, not at the call site; two
>    tests, using bb.utils.environment() rather than touching os.environ
>    directly.
> - v2: comment the ordering at the call site, and add the tests.
> - v1: the list() wrap alone.
>
> Signed-off-by: Alejandro Mery <amery@apptly.co>

now that this is merged (c870f5bd96ad02efc02c58133c27bdae3a300e3e), 
could it get cherry-picked into 2.18?

Thanks,
Alejandro Mery



