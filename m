Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 4D58C731C8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 22:38:15 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 07 Mar 2016 14:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,553,1449561600"; d="scan'208";a="904327271"
Received: from bitbang.jf.intel.com (HELO [10.7.199.90]) ([10.7.199.90])
	by orsmga001.jf.intel.com with ESMTP; 07 Mar 2016 14:38:16 -0800
To: ed.bartosh@linux.intel.com,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
References: <1457079220-27980-1-git-send-email-ed.bartosh@linux.intel.com>
	<1457087406.3285.3.camel@linux.intel.com>
	<6accf51a177b4b4b9d7452f14b03b610@XBOX02.axis.com>
	<20160307192243.GB5834@linux.intel.com>
From: Randy Witt <randy.e.witt@linux.intel.com>
Message-ID: <56DE02D8.9060002@linux.intel.com>
Date: Mon, 7 Mar 2016 14:38:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160307192243.GB5834@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] xmlrpc: fix bug in setting XMLRPCServer.single_use
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
X-List-Received-Date: Mon, 07 Mar 2016 22:38:16 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2016 11:22 AM, Ed Bartosh wrote:
> On Fri, Mar 04, 2016 at 03:20:12PM +0000, Peter Kjellerstedt wrote:
>>> -----Original Message-----
>>> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>>> devel-bounces@lists.openembedded.org] On Behalf Of Joshua G Lock
>>> Sent: den 4 mars 2016 11:30
>>> To: bitbake-devel@lists.openembedded.org
>>> Subject: Re: [bitbake-devel] [PATCH] xmlrpc: fix bug in setting
>>> XMLRPCServer.single_use
>>>
>>> On Fri, 2016-03-04 at 10:13 +0200, Ed Bartosh wrote:
>>>> XMLRPCServer.single_use attribute was always set to False.
>>>> This caused xmlrpc server to keep running after build is done as
>>>> BitBakeServerCommands.removeClient only shuts down server if its
>>>> single_use attribute is set to True.
>>>>
>>>> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
>>>> ---
>>>>   bitbake/lib/bb/server/xmlrpc.py | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/bitbake/lib/bb/server/xmlrpc.py
>>>> b/bitbake/lib/bb/server/xmlrpc.py
>>>> index 1ceca51..d627550 100644
>>>> --- a/bitbake/lib/bb/server/xmlrpc.py
>>>> +++ b/bitbake/lib/bb/server/xmlrpc.py
>>>> @@ -193,6 +193,8 @@ class XMLRPCServer(SimpleXMLRPCServer,
>>>> BaseImplServer):
>>>>           BaseImplServer.__init__(self)
>>>>           if (interface[1] == 0):     # anonymous port, not getting
>>>> reused
>>>>               self.single_use = True
>>>> +        else:
>>>> +            self.singe_use = False
>>>
>>> This won't work, right? Typo.
>>>
>>> Regards,
>>>
>>> Joshua
>>
>> Or you can simplify it as:
>>
>>              self.single_use = interface[1] == 0
>
> I thought about doing this. Decided not to do as it's less readable from
> my point of view.

The pythonic way would be

self.single_use = True if (interface == 0) else False

> --
> Regards,
> Ed
>


