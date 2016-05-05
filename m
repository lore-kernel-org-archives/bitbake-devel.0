Return-Path: <philip@balister.org>
X-Greylist: delayed 400 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 05 May 2016 12:20:00 UTC
Received: from sanddollar.geekisp.com (sanddollar.geekisp.com
	[216.168.135.167])
	by mail.openembedded.org (Postfix) with SMTP id B241E73181
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 May 2016 12:20:00 +0000 (UTC)
Received: (qmail 20408 invoked by uid 1003); 5 May 2016 12:13:20 -0000
Received: from unknown (HELO ?192.168.11.140?)
	(philip@opensdr.com@108.44.118.32)
	by mail.geekisp.com with (DHE-RSA-AES128-SHA encrypted) SMTP;
	5 May 2016 12:13:20 -0000
To: Mark Hatle <mark.hatle@windriver.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
From: Philip Balister <philip@balister.org>
Message-ID: <cb3d3b05-4d43-dbdb-e905-c407ce6219ec@balister.org>
Date: Thu, 5 May 2016 08:13:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
X-Mailman-Approved-At: Fri, 06 May 2016 09:12:57 +0000
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
X-List-Received-Date: Thu, 05 May 2016 12:20:01 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 05/04/2016 05:29 PM, Mark Hatle wrote:
> On 5/4/16 3:56 AM, Richard Purdie wrote:
>> My proposal is we decide to have the flag day, we queue up the patches
>> on a python3 branch both in oe-core and bitbake, then we switch when we
>> get successful autobuilder builds. I'd ideally like to do this quite
>> soon and get one with it (within a few weeks), leaving plenty of time
>> to handle issues and the other changes planned for this release cycle
>> and give other layers time to adapt.
>>
>> I will likely push things so the basics in the core work, I'll then
>> need help for things like toaster, the QA framework, the supporting
>> tools (devtool, recipetool and so on).
>>
>> Does anyone object to this?
> 
> I think this is a good plan.  Flag day, and switch.
> 
> Question, do we need any type of identifier in layers to say they're "python3"
> compatible or not?

Layers that are python2 will need krogoth branches. I'd expect master
branches to follow oe-core/master and jump to python3.

Philip


> 
> I'd hate for someone to bring in a layer and find it doesn't work, without
> understanding WHY it doesn't work.
> 
> Alternative would be to change the 'python' identifier to 'python3'..  Then if
> 'python' is parsed, we error?
> 
> --Mark
> 
>> Cheers,
>>
>> Richard
>>
>>
>>
>> _______________________________________________
>> Openembedded-architecture mailing list
>> Openembedded-architecture@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/openembedded-architecture
>>
> 
> _______________________________________________
> Openembedded-architecture mailing list
> Openembedded-architecture@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/openembedded-architecture
> 

