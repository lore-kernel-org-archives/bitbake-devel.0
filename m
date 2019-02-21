Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id A6C456BE2A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Feb 2019 21:16:53 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id v13so59218wrw.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Feb 2019 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=NEyBgNlSmV7gQxWU79sLz5bmSifJaeeRRGcFnKjeC74=;
	b=cnQjM5tt664fczekyP8YZLqwHyhnU7bVQHPnkwKC4weT4kzfpzp+tErZM29UwlvD6E
	QJf3/5cFc9ncb00i8xcuK8yCdZF6Gwhva7vrhmP8WlQX49Ozw8FdwbmI7uQ308TYHML+
	Y+SmIqc2mQhMAmOJg2RH+198Cza+Y9JqfhUMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=NEyBgNlSmV7gQxWU79sLz5bmSifJaeeRRGcFnKjeC74=;
	b=ZMsyZkoXd6miHaOuQcIkbcshGr+kjakQmv55ksAYcSbNyLVoriAbHMt8a5iNUEN+DY
	+rfXrIvnWor0Ycm4bFIWTaqq1jCiDel+BlOZyqn6FZwW7DMCjlnCbHkeXbKk7iM8k6vM
	Aaae7Z5t92e6kyZNSKrcIExhKHwwdsbbT4tzznw3DDKqvazvCJuVmQQPQphVs6kTaSQ6
	4RmSjxjOzVEnGvBK6GfhQXmRLcA1x3SP5MdeaMBD2KxVu7IDjUXR9/Brx+XsmVL+n30N
	fTfktlmSTQi2peUKlRfThcxBXCjD716k7C/UMf8sJo51OdNBEJwtHucqE5omDqZcrU/T
	ylyg==
X-Gm-Message-State: AHQUAuaVFk47vRFewU2i6RO2vvpyk3wbhCTlVrvh76J2UNkCVChDiwo+
	5KkzAIz0sMJTKg2NEIW++p/+310rgsI=
X-Google-Smtp-Source: AHgI3IbTyOzB+Vo2hDlD5DH73QDSnmO1eefxjr+tkwpl/hvvCqs10lsRIpGUfWnQz4AnAkrV/yHnig==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr398294wrm.72.1550783814246;
	Thu, 21 Feb 2019 13:16:54 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	m16sm19068666wro.78.2019.02.21.13.16.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 21 Feb 2019 13:16:53 -0800 (PST)
Message-ID: <e50122b91a10676d4a3e561a8610e6b9128b283c.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Feb 2019 21:16:52 +0000
In-Reply-To: <MW2PR12MB25406C73DC67507911E948168BEA0@MW2PR12MB2540.namprd12.prod.outlook.com>
References: <MW2PR12MB25406C73DC67507911E948168BEA0@MW2PR12MB2540.namprd12.prod.outlook.com>
User-Agent: Evolution 3.31.90-1 
MIME-Version: 1.0
Subject: Re: Fixing bitbake --revisions-changed
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 21 Feb 2019 21:16:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-10-04 at 15:10 +0000, chris.laplante--- via bitbake-devel
wrote:
> Hi all,
> 
> A while back I wanted to use the --revisions-changed flag of bitbake
> but found that it was unfortunately broken. In the next week or so I
> hope to submit a patchset to fix it. There are 3 issues preventing it
> from working, which I'll detail below. I am not sure how to fix the
> third issue, so that's why I'm starting this conversation.
> 
> Please note that to reproduce these results, vanilla Poky isn't
> enough - none of its recipes use SRCREV = "${AUTOREV}". So you'll
> either need to add a recipe (or layer with a recipe) that uses it.
> 
> 
> 1. Bad call to bb.fetch.fetcher_compare_revisions
> 
> The first issue you'll encounter if you try the flag is this
> exception:
> 
>     ERROR: Command execution failed: Traceback (most recent call
> last):
>       File "/home/laplante/poky-
> master/poky/bitbake/lib/bb/command.py", line 116, in runAsyncCommand
>         commandmethod(self.cmds_async, self, options)
>       File "/home/laplante/poky-
> master/poky/bitbake/lib/bb/command.py", line 723, in compareRevisions
>         if bb.fetch.fetcher_compare_revisions(command.cooker.data):
>     TypeError: fetcher_compare_revisions() takes 0 positional
> arguments but 1 was given
> 
> BitBake rev 81bc1f20662c39ee8db1da45b1e8c7eb64abacf3 (2016)
> mistakenly dropped the 'd' parameter of fetcher_compare_revisions.
> The sole usage of the method (in command.py) still correctly passes
> it. So the fix here is easy - just add back the 'd' to
> fetcher_compare_revisions.
> 
> 
> 2. Incorrect handling of bb.command.CommandExit in knotty.py
> 
> After you've fixed (1), and if upstream changes are "detected", then
> compareRevisions (command.py) will call
> command.finishAsyncCommand(code=1). That method will fire
> bb.command.CommandExit. Assuming you are using knotty, your bitbake
> command will hang forever. This is because the knotty CommandExit
> handler does not set "main.shutdown" (unlike the CommandFinish and
> CommandCompleted handlers). 
> 
> The fix here is simple - the CommandExit handler should set
> "main.shutdown = 2" to break out of the loop and return its return
> code. This is in line with how the ncurses UI works (it exits the
> loop for all three flavors of events).
> 
> 
> 3. bb.fetch2.saved_headrevs is always empty inside
> fetcher_compare_revisions, because fetcher_init is called twice.
> 
> Now we get to the part we're I'm unsure of how to proceed. In (2),
> "detected" is quoted because as we shall see,
> fetcher_compare_revisions will always think it detects changes.
> 
> I will assume BB_SRCREV_POLICY is set to its default "clear".
> fetcher_compare_revisions boils down to comparing these two sets of
> revisions:
> 
>     data = bb.persist_data.persist('BB_URI_HEADREVS', d).items()
>     data2 = bb.fetch2.saved_headrevs
> 
> If you instrument the code with some extra logging, you'll find that
> data2 (and therefore bb.fetch2.saved_headrevs) is always empty. The
> problem is that fetcher_init gets called twice. I'll reproduce just
> the first part of the method:
> 
>     def fetcher_init(d):
>         # ...
>         srcrev_policy = d.getVar('BB_SRCREV_POLICY') or "clear"
>         if srcrev_policy == "cache":
>             logger.debug(1, "Keeping SRCREV cache due to cache policy
> of: %s", srcrev_policy)
>         elif srcrev_policy == "clear":
>             logger.debug(1, "Clearing SRCREV cache due to cache
> policy of: %s", srcrev_policy)
>             revs = bb.persist_data.persist('BB_URI_HEADREVS', d)
>             try: 
>                 bb.fetch2.saved_headrevs = revs.items()
>             except:
>                 pass 
>             revs.clear()
> 
> Again, let's assume BB_SRCREV_POLICY is "clear". The first time the
> method is called (during server startup), bb.fetch2.saved_headrevs is
> correctly set and BB_URI_HEADREVS is rightfully cleared.
> 
> Unfortunately, fetcher_init gets called again later by runCommand
> (command.py). The sequence of method calls is command.py:runCommand
> => command.py:updateConfig => cooker.py:updateConfigOpts =>
> cooker.py:reset => cooker.py:initConfigurationData =>
> cookerdata.py:parseBaseConfiguration => bb.fetch.fetcher_init. 
> 
> In this second invocation, bb.fetch2.saved_headrevs is again set
> based on BB_URI_HEADREVS. But the first call to fetcher_init cleared
> BB_URI_HEADREVS... thus bb.fetch2.saved_headrevs ends up empty.
> 
> ----
> 
> I'd like to hear some feedback on how to fix (3). The "easy"
> solution, I think, is to do something like this to ensure
> saved_headrevs doesn't get overwritten:
> 
>     if not bb.fetch2.saved_headrevs:
>         bb.fetch2.saved_headrevs = revs.items()
> 
> fetcher_compare_revisions is the only thing that uses saved_headrevs,
> so this shouldn't break anything. Alternatively, is it better to
> change it so fetcher_init doesn't get called multiple times? Perhaps
> it should be split into a fetcher_init and fetcher_reset? 
> 
> (Another side question I have is whether we should/could modify
> fetcher_compare_revisions to work even when BB_SRCREV_POLICY is set
> to 'cache'. That functionality would seem very useful to me. That's
> probably a topic for another discussion thread though.)
> 
> Looking forward to feedback.

I'm slightly worried this has been broken for as long and not used. It
kind of suggests we might not need the functionality.

Poking global state into the fetch2 module is fairly horrible and the
only concern with your fix is that memory resident bitbake wouldn't
like it and there would be future bugs lurking there for us.

I can't help feel this code could do with quite an overhaul so rather
than fixing it, it may be worth reworking it somehow. Unfortunately
I've lacked time to look into this more, the email is flagged as
needing attention though...

Cheers,

Richard


