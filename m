Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id EB0996067D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jul 2017 01:57:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v6E1vqvx011058
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 13 Jul 2017 18:57:53 -0700 (PDT)
Received: from [128.224.162.246] (128.224.162.246) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.294.0;
	Thu, 13 Jul 2017 18:57:51 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1499768495.git.liezhi.yang@windriver.com>
	<868892a60e4f6888b29455b40de5b16d6cc7ec9c.1499768495.git.liezhi.yang@windriver.com>
	<1499813798.30311.101.camel@linuxfoundation.org>
	<3e7d971c-6183-487d-9a68-56b9e7212f5c@windriver.com>
	<1499974474.30311.134.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <1d8d85a1-1d6f-cd49-dc0a-d0d6bf6c3193@windriver.com>
Date: Fri, 14 Jul 2017 09:57:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1499974474.30311.134.camel@linuxfoundation.org>
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
X-List-Received-Date: Fri, 14 Jul 2017 01:57:53 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 07/14/2017 03:34 AM, Richard Purdie wrote:
> On Wed, 2017-07-12 at 17:45 +0800, Robert Yang wrote:
>> On 07/12/2017 06:56 AM, Richard Purdie wrote:
>>>
>>> Do you know why we don't either always see these or always don't
>>> see
>>> them? I'm a bit worried there may be a deeper issue lurking here.
>>> Are
>>> those events part of the event mask being set?
>> I digged this today, and find the reason, finally. It is harder than
>> I had thought. Take MonitorDiskEvent as an example, the reproducer
>> is:
>>
>> In terminal 1:
>> $ bitbake -m ; . ../poky/oe-init-build-env-memres . && bitbake world
>> -k
>>
>> In Terminal 2:
>> $ bitbake --observe-only
>>
>> Note, the time and order is very important, otherwise we can't
>> reproduce
>> the problem, we must run "bitbake target" in terminal 1 firstly, and
>> then
>> run "bitbake --observe-only" in terminal 2 after "cache loaded"
>> before runqueue is ready, in another words, run "bitbake --observe-
>> only"
>> when "Initialising tasks" is displaying in terminal 1, no early or
>> late,
>> then we will see the error in terminal 2 (And only in terminal 2):
>>
>> ERROR: Unknown event: <bb.event.MonitorDiskEvent object at
>> 0x7f5c3776f940>
>>
>> The "bitbake world" (first) does everything well, but "bitbake --
>> observe-only"
>> (second) doesn't becuase of the following code in lib/bb/main.py:
>>
>>          try:
>>              return ui_module.main(server_connection.connection,
>> server_connection.events,
>>                                    configParams)
>>
>> The second run of "ui_module.main()" sends server_connection.events
>> (bb.event.MonitorDiskEvent) which is prepared by first run, and
>> knotty.py
>> doesn't know how to handle it, and we will get the error. So we can't
>> get the error if we run second bitbake earlier (the event is not
>> ready)
>> or later (the event had been handled by first bitbake).
>>
>> I think that bb.event.RecipeTaskPreProcess is similar, add them
>> to ignore list should be fine, and I will add these explanations to
>> commit message.
>
> I'm not sure I agree here, I think you're right that there is a race
> issue however I'd rather solve any race issue than workaround it.
> Whilst you need to add these events today, there are likely other
> events which might appear tomorrow.

A rough thoughts on fixing this might be:

The original code:
try:
     return ui_module.main(server_connection.connection, 
server_connection.events, configParams)

The problem is server_connection.events contains more events than
ui_module.main() can handle, we can filter them out: (fake code)

filtered_events = []

for event in server_connection.events:
	if event in ui_module._evt_list:
		filtered_events.append(event)

And use filtered_events to call ui_module.main():
return ui_module.main(server_connection.connection, filtered_events, configParams)

Then we can totally remove the ignore list in ui like knotty.py:

             # ignore
             if isinstance(event, (bb.event.BuildBase,
                                   bb.event.MetadataEvent,
                                   bb.event.StampUpdate,
                                   bb.event.ConfigParsed,
                                   bb.event.MultiConfigParsed,
                                   bb.event.RecipeParsed,
                                   bb.event.RecipePreFinalise,
                                   bb.runqueue.runQueueEvent,
                                   bb.event.OperationStarted,
                                   bb.event.OperationCompleted,
                                   bb.event.OperationProgress,
                                   bb.event.DiskFull,
                                   bb.event.HeartbeatEvent,
                                   bb.build.TaskProgress)):
                 continue

>
>>> For reference, I've been looking at the server abstraction in
>>> bitbake and am close to rewriting a large part of bb.server.* and
>>> bb.main with a view to simplifying the code structure and making
>>> things easier to understand.
>> That's great, something var name is not easy for me to understand,
>> for example, observe_only vs observer_only. And I think that we need
>> a simple way to restart the server, something like bitbake --restart.
>>
>>>
>>>
>>> I've noticed I see some new events with my change, equally I think
>>> its
>>> an event mask issue with my new code...
>>>
>>> I pushed my changes onto http://git.yoctoproject.org/cgit.cgi/poky-
>>> cont
>>> rib/commit/?h=rpurdie/wip-
>>> rss2&id=7d970e7b9f5499f5fcdb0e73246f106844ecf09b
>>> however I am well aware things don't work properly yet and its full
>>> of
>>> debug. When finished I should be able to delete server/__init__.py
>>> and
>>> server/xmlrpc.py.
>> I will hold on my patches until you've finished the rewriting, and
>> please let me know if anything I can do.
>
> The changes are now in master-next. I plan to split the patch up and
> have been revising it a bit as I find issues. It would be great if you
> could apply this locally and see if the issues you've found are still
> present after this change and help with stressing the changes a bit,
> see what issues we have?
>
> One thing I know is probably broken at the moment is observe-only
> unfortunately. I am tempted to merge the code changes I have as this
> gives us a platform to build on which is much more understandable than
> the existing codebase even if there are issues like that.

Sure, I'd like to test them today.

// Robert

>
> Cheers,
>
> Richard
>
>
>

