Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id E07E47C3A1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 19:24:30 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id EB0B75C0258;
	Fri, 25 Jan 2019 20:24:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1548444270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=hae7uL1xbybuWPNQfN7cl2USWvy95WQbZQ11UNCinoE=;
	b=EVfmweI8et65iu/RaN5RIhAt4Qdnb0NWOpmmlrWgkG0HDvmbnsgKhVnZbfRVjo2yuUQ4Rm
	irEDwA02vUKjkr3eE09orvEIcVWwMlDWfR+pOaSpcoQv/hozPHVT7ghkjWAiej3Eshhuwc
	POuI9/8gbX3CK7TGJVUoWi0Nylv5fV0=
MIME-Version: 1.0
Date: Fri, 25 Jan 2019 20:24:30 +0100
From: Stefan Agner <stefan@agner.ch>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	mark.hatle@windriver.com
In-Reply-To: <238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
	<238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
Message-ID: <7d80c538faadfdc9d2259bc37956835b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Cc: bitbake-devel@lists.openembedded.org, luka.pivk@toradex.com,
	stefan.agner@toradex.com, liu.ming50@gmail.com
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
X-List-Received-Date: Fri, 25 Jan 2019 19:24:31 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 25.01.2019 16:08, Richard Purdie wrote:
> On Fri, 2019-01-25 at 15:41 +0100, liu.ming50@gmail.com wrote:
>> From: Ming Liu <liu.ming50@gmail.com>
>>
>> A following issue was observed with gitsm:
>> > git -c core.fsyncobjectfiles=0 config submodule... failed with exit code 255, output:
>> > error: could not lock config file config: File exists
>>
>> Since all git submodules share a config file and Git creates a lock
>> file (.git/config.lock) to synchronize access to it, but Git only tries
>> exactly once and returns a error if it's already locked. This leads to
>> a race condition if there are many 'git config submodule' run in
>> different processes.
>>
>> It could be fixed by introducing a bitbake file lock to protect config
>> file from concurrent update from submodules.
>>
>> Reported-by: Stefan Agner <stefan.agner@toradex.com>
>> Signed-off-by: Ming Liu <liu.ming50@gmail.com>
>> ---
>>  lib/bb/fetch2/gitsm.py | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
>> index f45546b..9465acb 100644
>> --- a/lib/bb/fetch2/gitsm.py
>> +++ b/lib/bb/fetch2/gitsm.py
>> @@ -183,11 +183,19 @@ class GitSM(Git):
>>
>>              local_path = newfetch.localpath(url)
>>
>> -            # Correct the submodule references to the local download version...
>> -            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
>> +            # Protects the config file from concurrent updates by submodules
>> +            # e.g. 'git config submodule' run in different processes may lead
>> +            # to a race condition.
>> +            lf = bb.utils.lockfile(os.path.join(ud.destdir, "gitsm-config.lock"))
>>
>> -            if ud.shallow:
>> -                runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
>> +            try:
>> +                # Correct the submodule references to the local download version...
>> +                runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
>> +
>> +                if ud.shallow:
>> +                    runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
>> +            finally:
>> +                bb.utils.unlockfile(lf)
>>
>>              # Ensure the submodule repository is NOT set to bare, since we're checking it out...
>>              try:
> 
> I still don't see why this is necessary after Mark's recent changes.
> These files are in ud.destdir which in OE terms is WORKDIR. Only one
> fetch happens against WORKDIR at a time? Therefore how is this racing?

The git config race we only observed before the recent changes by Mark.

If those changes have the potential to fix this issue, we should test
those first and hold on with this patch.

> 
> Have you seen this problem against the current master code?

Master as of yesterday (or Wednesday) was not able to fetch the project
(aktualizr).

Even with the latest 2 fixes I am not able to build the (very same)
recipe anymore, it ends up in an error during do_configure, presumably
due to missing submodules:

                                                              
| -- Configuring done
| CMake Error at partial/CMakeLists.txt:116 (add_library):
|   Cannot find source file:
|                                                                       
  
|     extern/isotp-c/deps/bitfield-c/src/bitfield/8byte.c               
  
|                                                                       
  
|   Tried extensions .c .C .c++ .cc .cpp .cxx .cu .m .M .mm .h .hh .h++
.hm
|   .hpp .hxx .in .txx
|
|
| CMake Error at partial/CMakeLists.txt:116 (add_library):
|   No SOURCES given to target: isotp
|

Using c1fcc46e2498 ("bitbake: Fix Deprecated warnings from regexs")
works fine.

--
Stefan



