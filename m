Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5D1FB780F3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Jul 2017 09:45:38 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v6C9ja2G021610
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Wed, 12 Jul 2017 02:45:36 -0700
Received: from [128.224.162.246] (128.224.162.246) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 12 Jul 2017 02:45:36 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1499768495.git.liezhi.yang@windriver.com>
	<868892a60e4f6888b29455b40de5b16d6cc7ec9c.1499768495.git.liezhi.yang@windriver.com>
	<1499813798.30311.101.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <3e7d971c-6183-487d-9a68-56b9e7212f5c@windriver.com>
Date: Wed, 12 Jul 2017 17:45:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1499813798.30311.101.camel@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/3] bitbake: knotty.py: add MonitorDiskEvent and RecipeTaskPreProcess
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
X-List-Received-Date: Wed, 12 Jul 2017 09:45:39 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi RP,

On 07/12/2017 06:56 AM, Richard Purdie wrote:
> On Tue, 2017-07-11 at 03:27 -0700, Robert Yang wrote:
>> Sometimes, we may see the errors:
>> $ bitbake --observe-only
>> ERROR: Unknown event: <bb.event.MonitorDiskEvent object at
>> 0x7fbd2e0a8438>
>> ERROR: Unknown event: <bb.event.RecipeTaskPreProcess object at
>> 0x7fdc6b7e7b00>
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>  bitbake/lib/bb/ui/knotty.py | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/bitbake/lib/bb/ui/knotty.py
>> b/bitbake/lib/bb/ui/knotty.py
>> index 11afb3e7441..71ec168fa6c 100644
>> --- a/bitbake/lib/bb/ui/knotty.py
>> +++ b/bitbake/lib/bb/ui/knotty.py
>> @@ -667,11 +667,13 @@ def main(server, eventHandler, params, tf =
>> TerminalFilter):
>>                                    bb.event.MultiConfigParsed,
>>                                    bb.event.RecipeParsed,
>>                                    bb.event.RecipePreFinalise,
>> +                                  bb.event.RecipeTaskPreProcess,
>>                                    bb.runqueue.runQueueEvent,
>>                                    bb.event.OperationStarted,
>>                                    bb.event.OperationCompleted,
>>                                    bb.event.OperationProgress,
>>                                    bb.event.DiskFull,
>> +                                  bb.event.MonitorDiskEvent,
>>                                    bb.event.HeartbeatEvent,
>>                                    bb.build.TaskProgress)):
>>                  continue
>
> Do you know why we don't either always see these or always don't see
> them? I'm a bit worried there may be a deeper issue lurking here. Are
> those events part of the event mask being set?

I digged this today, and find the reason, finally. It is harder than I
had thought. Take MonitorDiskEvent as an example, the reproducer is:

In terminal 1:
$ bitbake -m ; . ../poky/oe-init-build-env-memres . && bitbake world -k

In Terminal 2:
$ bitbake --observe-only

Note, the time and order is very important, otherwise we can't reproduce
the problem, we must run "bitbake target" in terminal 1 firstly, and then
run "bitbake --observe-only" in terminal 2 after "cache loaded"
before runqueue is ready, in another words, run "bitbake --observe-only"
when "Initialising tasks" is displaying in terminal 1, no early or late,
then we will see the error in terminal 2 (And only in terminal 2):

ERROR: Unknown event: <bb.event.MonitorDiskEvent object at 0x7f5c3776f940>

The "bitbake world" (first) does everything well, but "bitbake --observe-only"
(second) doesn't becuase of the following code in lib/bb/main.py:

         try:
             return ui_module.main(server_connection.connection, 
server_connection.events,
                                   configParams)

The second run of "ui_module.main()" sends server_connection.events 
(bb.event.MonitorDiskEvent) which is prepared by first run, and knotty.py
doesn't know how to handle it, and we will get the error. So we can't
get the error if we run second bitbake earlier (the event is not ready)
or later (the event had been handled by first bitbake).

I think that bb.event.RecipeTaskPreProcess is similar, add them
to ignore list should be fine, and I will add these explanations to
commit message.

>
> For reference, I've been looking at the server abstraction in bitbake
> and am close to rewriting a large part of bb.server.* and bb.main with
> a view to simplifying the code structure and making things easier to
> understand.

That's great, something var name is not easy for me to understand, for example,
observe_only vs observer_only. And I think that we need a simple way to
restart the server, something like bitbake --restart.

>
> I've noticed I see some new events with my change, equally I think its
> an event mask issue with my new code...
>
> I pushed my changes onto http://git.yoctoproject.org/cgit.cgi/poky-cont
> rib/commit/?h=rpurdie/wip-
> rss2&id=7d970e7b9f5499f5fcdb0e73246f106844ecf09b
> however I am well aware things don't work properly yet and its full of
> debug. When finished I should be able to delete server/__init__.py and
> server/xmlrpc.py.

I will hold on my patches until you've finished the rewriting, and please
let me know if anything I can do.

// Robert

>
> Cheers,
>
> Richard
>
>
>

