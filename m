Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id 390C77C3A2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 10:15:54 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 88D4E5C0086;
	Sat, 26 Jan 2019 11:15:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1548497754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=xbSkgZP7LP44oB5Iq81vUGNEDloxJhoVO4TQj1Py5C8=;
	b=KB+47fTM4zJRSJWIqNKEVzC1vywrljnSS0ZxuwuM71SlU6PxEGeyG+Wl8Yn58tfg9d8GN3
	qgnlT/omV/aLk+CeCof1IXcHbtHLWUQBSZrCt+gu4JYMlW7nfAlquTt1mgCDmpVABNVNKB
	Dg4aROZDg+ARe1z4VTVOyWB7gZCZYvA=
MIME-Version: 1.0
Date: Sat, 26 Jan 2019 11:15:54 +0100
From: Stefan Agner <stefan@agner.ch>
To: Mark Hatle <mark.hatle@windriver.com>, liu.ming50@gmail.com,
	patrickvacek@gmail.com
In-Reply-To: <832b2810-7e11-fa18-b50e-b40b07c6e265@windriver.com>
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
	<238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
	<7d80c538faadfdc9d2259bc37956835b@agner.ch>
	<fc0c4b8d-13a9-ad32-a017-27feb97fb8bd@windriver.com>
	<832b2810-7e11-fa18-b50e-b40b07c6e265@windriver.com>
Message-ID: <3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Cc: bitbake-devel@lists.openembedded.org, stefan.agner@toradex.com,
	luka.pivk@toradex.com
Subject: Re: [PATCH V2] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Sat, 26 Jan 2019 10:15:55 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[adding Patrick, he is often working on the recipe]

On 26.01.2019 00:19, Mark Hatle wrote:
> On 1/25/19 1:53 PM, Mark Hatle wrote:
>> Is the repository you are using public?  If so, give me the URL and commit ID
>> for the main repository and I'll get it added to the test suite.
> 
> I reread this and went back into the prior info from you.  It appears the
> repository you are talking about is:
> 
> gitsm://github.com/advancedtelematic/aktualizr;branch=master

Yes that is the repository.

> 
> SRCREV = d00d1a04cc2366d1a5f143b84b9f507f8bd32c44

And the hash I was using.

> 
> 
> I manually checked this out doing the following:
> 
> git clone git://github.com/advancedtelematic/aktualizr
> git checkout d00d1a04cc2366d1a5f143b84b9f507f8bd32c44
> git submodule init
> git submodule update --recursive
> 
> 
> I then ran the same thing using the gitsm fetcher.  Using:
> 
> 
> gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44
> 
> Comparing the resulting system, they are nearly identical.  All of the checked
> out sources are -exactly- the same.
> 
> There are some minor differences in the .git directory, but none of them affect
> what is actually checked out.
> 
> Output of:
> 
>    diff -urN 'gitsm version' aktualizr -x .git
> 
> is identical
> 
> comparing the git directory is slightly different, but all within the
> expectations.
> 
> So I do not see anything that the gitsm fetcher is doing incorrectly
> at this point.
> 
> You should run the same type of comparison and see if you are getting the same
> results.
> 
> 
> BTW I went back to bitbake commit c1fcc46e2498, and repeated the experiment.
> 
> This shows that a significant part of was checked out incorrectly.
> 
> For instance, the submodule partial/extern/isotp-c:
> 
> In the current version is checked out on
> 4c5904bff3ed83ec471c8586b5faed62898d0224.  (Which matches the manual
> git behavior.)
> 
> While the gitsm fetcher in the older system checkedout commit
> 614fe48fe55aeea98b49804b7e31ef2d304f62de.  Which is incorrect.
> 

Yeah this would explain the behavior I am seeing.

> 
> So it seems to be that something in the recipe was expecting semi-broken
> behavior.. and its actually a recipe problem.

Agreed, in this case we need to fix the recipe.

Thanks for looking into it and sorry for the noise!

--
Stefan

> 
> --Mark
> 
>> (For testing what I've been doing is checking out with raw git and then with the
>> gitsm fetcher.. comparing the difference and then adding those specific things
>> as regressions checks.)
>>
>> If it's not public, then you'll likely need to do that yourself.  Compare the
>> results and try to figure out what the difference is.  Once you have that, it
>> may be more obvious what the problems.  (Comparison should include the .git
>> contents as well..)
>>
>> --Mark
>>
>> On 1/25/19 1:24 PM, Stefan Agner wrote:
>>> On 25.01.2019 16:08, Richard Purdie wrote:
>>>> On Fri, 2019-01-25 at 15:41 +0100, liu.ming50@gmail.com wrote:
>>>>> From: Ming Liu <liu.ming50@gmail.com>
>>>>>
>>>>> A following issue was observed with gitsm:
>>>>>> git -c core.fsyncobjectfiles=0 config submodule... failed with exit code 255, output:
>>>>>> error: could not lock config file config: File exists
>>>>>
>>>>> Since all git submodules share a config file and Git creates a lock
>>>>> file (.git/config.lock) to synchronize access to it, but Git only tries
>>>>> exactly once and returns a error if it's already locked. This leads to
>>>>> a race condition if there are many 'git config submodule' run in
>>>>> different processes.
>>>>>
>>>>> It could be fixed by introducing a bitbake file lock to protect config
>>>>> file from concurrent update from submodules.
>>>>>
>>>>> Reported-by: Stefan Agner <stefan.agner@toradex.com>
>>>>> Signed-off-by: Ming Liu <liu.ming50@gmail.com>
>>>>> ---
>>>>>  lib/bb/fetch2/gitsm.py | 16 ++++++++++++----
>>>>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
>>>>> index f45546b..9465acb 100644
>>>>> --- a/lib/bb/fetch2/gitsm.py
>>>>> +++ b/lib/bb/fetch2/gitsm.py
>>>>> @@ -183,11 +183,19 @@ class GitSM(Git):
>>>>>
>>>>>              local_path = newfetch.localpath(url)
>>>>>
>>>>> -            # Correct the submodule references to the local download version...
>>>>> -            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
>>>>> +            # Protects the config file from concurrent updates by submodules
>>>>> +            # e.g. 'git config submodule' run in different processes may lead
>>>>> +            # to a race condition.
>>>>> +            lf = bb.utils.lockfile(os.path.join(ud.destdir, "gitsm-config.lock"))
>>>>>
>>>>> -            if ud.shallow:
>>>>> -                runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
>>>>> +            try:
>>>>> +                # Correct the submodule references to the local download version...
>>>>> +                runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
>>>>> +
>>>>> +                if ud.shallow:
>>>>> +                    runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
>>>>> +            finally:
>>>>> +                bb.utils.unlockfile(lf)
>>>>>
>>>>>              # Ensure the submodule repository is NOT set to bare, since we're checking it out...
>>>>>              try:
>>>>
>>>> I still don't see why this is necessary after Mark's recent changes.
>>>> These files are in ud.destdir which in OE terms is WORKDIR. Only one
>>>> fetch happens against WORKDIR at a time? Therefore how is this racing?
>>>
>>> The git config race we only observed before the recent changes by Mark.
>>>
>>> If those changes have the potential to fix this issue, we should test
>>> those first and hold on with this patch.
>>>
>>>>
>>>> Have you seen this problem against the current master code?
>>>
>>> Master as of yesterday (or Wednesday) was not able to fetch the project
>>> (aktualizr).
>>>
>>> Even with the latest 2 fixes I am not able to build the (very same)
>>> recipe anymore, it ends up in an error during do_configure, presumably
>>> due to missing submodules:
>>>
>>>
>>> | -- Configuring done
>>> | CMake Error at partial/CMakeLists.txt:116 (add_library):
>>> |   Cannot find source file:
>>> |
>>>
>>> |     extern/isotp-c/deps/bitfield-c/src/bitfield/8byte.c
>>>
>>> |
>>>
>>> |   Tried extensions .c .C .c++ .cc .cpp .cxx .cu .m .M .mm .h .hh .h++
>>> .hm
>>> |   .hpp .hxx .in .txx
>>> |
>>> |
>>> | CMake Error at partial/CMakeLists.txt:116 (add_library):
>>> |   No SOURCES given to target: isotp
>>> |
>>>
>>> Using c1fcc46e2498 ("bitbake: Fix Deprecated warnings from regexs")
>>> works fine.
>>>
>>> --
>>> Stefan
>>>
>>>
>>

