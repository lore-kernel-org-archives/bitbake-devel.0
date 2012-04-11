Received: from hermes.mlbassoc.com ([64.234.241.98] helo=mail.chez-thomas.org)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gary@mlbassoc.com>) id 1SHvE1-0006hm-S4
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 12:56:34 +0200
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id 286E5F81268; Wed, 11 Apr 2012 04:47:16 -0600 (MDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from hermes.chez-thomas.org (localhost.localdomain [127.0.0.1])
	by mail.chez-thomas.org (Postfix) with ESMTP id 265D7F81204;
	Wed, 11 Apr 2012 04:47:11 -0600 (MDT)
Message-ID: <4F85612F.3040704@mlbassoc.com>
Date: Wed, 11 Apr 2012 04:47:11 -0600
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <1333645638-9195-1-git-send-email-paul.eggleton@linux.intel.com>
	<1334100324.10826.97.camel@ted> <2184436.zSGmXoSkkF@helios>
In-Reply-To: <2184436.zSGmXoSkkF@helios>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] lib/bb/fetch2: don't skip checksums when local mirror enabled
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 11 Apr 2012 10:56:34 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2012-04-11 03:11, Paul Eggleton wrote:
> On Wednesday 11 April 2012 00:25:24 Richard Purdie wrote:
>> On Thu, 2012-04-05 at 18:07 +0100, Paul Eggleton wrote:
>>> If you have PREMIRRORS set up to point to a local directory, the local
>>> download function does nothing and always succeeds and the mirror code
>>> was writing a .done stamp regardless, thus the checksum verification was
>>> being skipped even if the file wasn't actually copied from the mirror.
>>>
>>> Signed-off-by: Paul Eggleton<paul.eggleton@linux.intel.com>
>>> ---
>>>
>>>   lib/bb/fetch2/__init__.py |    7 ++++---
>>>   1 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>>> index e5c4b34..414cc2b 100644
>>> --- a/lib/bb/fetch2/__init__.py
>>> +++ b/lib/bb/fetch2/__init__.py
>>>
>>> @@ -476,9 +476,10 @@ def try_mirrors(d, origud, mirrors, check = False):
>>>               if not os.path.exists(ud.donestamp) or
> ud.method.need_update(newuri, ud, ld):
>>>                   ud.method.download(newuri, ud, ld)
>>>
>>> -                open(ud.donestamp, 'w').close()
>>> -                if hasattr(ud.method,"build_mirror_data"):
>>> -                    ud.method.build_mirror_data(newuri, ud, ld)
>>> +                if os.path.exists(ud.localpath):
>>> +                    open(ud.donestamp, 'w').close()
>>> +                    if hasattr(ud.method,"build_mirror_data"):
>>> +                        ud.method.build_mirror_data(newuri, ud, ld)
>>>
>>>               if not ud.localpath or not os.path.exists(ud.localpath):
>>>                   continue
>>
>> I messed up some commands and this ended up merged with the following
>> commit I manipulated:
>>
>> http://git.openembedded.org/bitbake/commit/?id=c9eed04c6275ef2c694f89e047f85
>> c7de76f89b6
>>
>> Since its pushed at this point I'm not sure what options I have to undo
>> it. Sorry :(
>
> No worries - but does this fix in any way help with the problem Gary was
> seeing?

No, it does not.  See https://lists.yoctoproject.org/pipermail/poky/2012-April/007752.html

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------


