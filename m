Return-Path: <tobias.hagelborn@axis.com>
X-Greylist: delayed 381 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 03 Feb 2017 13:24:43 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 8BB7F6E5FB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Feb 2017 13:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id ABC4718484;
	Fri,  3 Feb 2017 14:18:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 68w+aQSiv54I; Fri,  3 Feb 2017 14:18:19 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id E5B4B18196;
	Fri,  3 Feb 2017 14:18:18 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE1581A067;
	Fri,  3 Feb 2017 14:18:18 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A321D1A040;
	Fri,  3 Feb 2017 14:18:18 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP;
	Fri,  3 Feb 2017 14:18:18 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by seth.se.axis.com (Postfix) with ESMTP id 96BE3208;
	Fri,  3 Feb 2017 14:18:18 +0100 (CET)
Received: from [10.94.62.1] (10.0.5.60) by XBOX02.axis.com (10.0.5.16) with
	Microsoft SMTP Server (TLS) id 15.0.1210.3;
	Fri, 3 Feb 2017 14:18:18 +0100
To: Paul Eggleton <paul.eggleton@linux.intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <16e4f38d781445449f3290f035a655ed@XBOX02.axis.com>
	<1485342777.30673.79.camel@linuxfoundation.org>
	<2926401.9a0hO52TuJ@peggleto-mobl.ger.corp.intel.com>
From: Tobias Hagelborn <tobias.hagelborn@axis.com>
Message-ID: <af9c5ef8-c95c-c414-d662-11f047db670a@axis.com>
Date: Fri, 3 Feb 2017 14:18:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <2926401.9a0hO52TuJ@peggleto-mobl.ger.corp.intel.com>
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX01.axis.com (10.0.5.15) To XBOX02.axis.com (10.0.5.16)
X-TM-AS-GCONF: 00
Cc: pkj@axis.com, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker: Drop package-depends.dot and pn-depends.dot generation
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
X-List-Received-Date: Fri, 03 Feb 2017 13:24:45 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

On 01/25/2017 08:17 PM, Paul Eggleton wrote:
> On Wednesday, 25 January 2017 11:12:57 AM NZDT Richard Purdie wrote:
>> On Wed, 2017-01-25 at 11:05 +0000, Peter Kjellerstedt wrote:
>>> pn-dependes.dot when visualizing the dependencies between packages.
>>> Even though task-depends.dot is more complete, trying to render it
>>> is near impossible given the sheer number of nodes and edges it
>>> contains. Already visualizing pn-depends.dot is hard but possible
>>> with some gvpr and tred filtering. Here are some statistics from
>>> one of my typical builds:
>>>
>>>                         Nodes  Edges
>>>                         -----  ------
>>> pn-depends.dot           1183   12087
>>> package-depends.dot      5939   55615
>>> task-depends.dot        13756  125870
>>>
>>> As can be seen, the number of nodes and edges in task-depends.dot
>>> is a magnitude greater than in pn-depends.dot.
>>
>> Its certainly simpler, but the data is just plain buggy. I'm not sure
>> I'd trust anything those files told me, even if they are easier to
>> view.
>>
>> I appreciate task-depends is hard to load graphically, it is helpful
>> even as a text file though, I do use it a lot since its a near direct
>> dump of bitbake's internal parsed task dependencies.
>
> What if we collapsed down task-depends.dot to PNs only in order to produce
> pn-depends.dot? Then at least it would be reasonably accurate.
>
> Cheers,
> Paul
>

Hi,

It is a great initiative to make the dependency graphs more correct.
I just wanted to note that I have found very good use of the 
pn-buildlist as a measure to force a certain task on, for instance, all 
recipe dependencies in an image or other recipe. It is sort of a good 
input for a "for each" cmdline scripts.

ex: xargs -a pn-buildlist bitbake -c mytask

This can of cause be done by filtering stuff out from the tasks-depends 
or pn-depends but there is a risk of parse error trying to separate task 
name from packet name if not following conventions.

So, perhaps you are aware of another preferred way to achieve this or if 
you could consider still providing the pn-buildlist (although correct 
and derived from task-depends)?

Cheers
Tobias

