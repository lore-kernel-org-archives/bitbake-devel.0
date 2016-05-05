Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 8FAB8731A3;
	Thu,  5 May 2016 15:13:34 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u45FDNhL005675
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 5 May 2016 08:13:23 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Thu, 5 May 2016 08:13:22 -0700
To: Philip Balister <philip@balister.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
	<cb3d3b05-4d43-dbdb-e905-c407ce6219ec@balister.org>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <fce22d23-e66c-c692-f7d5-f1154081246a@windriver.com>
Date: Thu, 5 May 2016 10:13:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
	Gecko/20100101 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <cb3d3b05-4d43-dbdb-e905-c407ce6219ec@balister.org>
Subject: Re: [Openembedded-architecture] Python 3 for Bitbake
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
X-List-Received-Date: Thu, 05 May 2016 15:13:35 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 5/5/16 7:13 AM, Philip Balister wrote:
> On 05/04/2016 05:29 PM, Mark Hatle wrote:
>> On 5/4/16 3:56 AM, Richard Purdie wrote:
>>> My proposal is we decide to have the flag day, we queue up the patches
>>> on a python3 branch both in oe-core and bitbake, then we switch when we
>>> get successful autobuilder builds. I'd ideally like to do this quite
>>> soon and get one with it (within a few weeks), leaving plenty of time
>>> to handle issues and the other changes planned for this release cycle
>>> and give other layers time to adapt.
>>>
>>> I will likely push things so the basics in the core work, I'll then
>>> need help for things like toaster, the QA framework, the supporting
>>> tools (devtool, recipetool and so on).
>>>
>>> Does anyone object to this?
>>
>> I think this is a good plan.  Flag day, and switch.
>>
>> Question, do we need any type of identifier in layers to say they're "python3"
>> compatible or not?
> 
> Layers that are python2 will need krogoth branches. I'd expect master
> branches to follow oe-core/master and jump to python3.

I don't disagree, but my experience has been that branching is late or never in
a lot of layers.

This might be a place where we need to plan to go through the layer index and at
least see if the layer parses -- and flag things that no longer parse?  (I don't
even know if this is something reasonable to attempt.)

My fear is just we've already got a lot of "broken" (without defining that)
layers in the index, and I think it will be worse once the python3 change
happens.  I'd really like to make sure we don't confuse people with various errors.

--Mark

> Philip
> 
> 
>>
>> I'd hate for someone to bring in a layer and find it doesn't work, without
>> understanding WHY it doesn't work.
>>
>> Alternative would be to change the 'python' identifier to 'python3'..  Then if
>> 'python' is parsed, we error?
>>
>> --Mark
>>
>>> Cheers,
>>>
>>> Richard
>>>
>>>
>>>
>>> _______________________________________________
>>> Openembedded-architecture mailing list
>>> Openembedded-architecture@lists.openembedded.org
>>> http://lists.openembedded.org/mailman/listinfo/openembedded-architecture
>>>
>>
>> _______________________________________________
>> Openembedded-architecture mailing list
>> Openembedded-architecture@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/openembedded-architecture
>>


