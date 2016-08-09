Return-Path: <zzs213@126.com>
Received: from m15-111.126.com (m15-111.126.com [220.181.15.111])
	by mail.openembedded.org (Postfix) with ESMTP id 2BFE077175
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=erSCu
	mCZMz9qgJiCPx3eoN1BoMyJxafITkAA5iWHwm4=; b=PMK7N+qANkB+30aBkcTl+
	nopXGXhmKHooED9w3s+eSsPiTE0PcOJJEKQ2gZHubZiaigE7Pud/cQEkOUqtL1us
	TDTWz0RGeaaM1/R9gW36ifMTSCeLTscaFgRleJvqUGxfRyVZ5IX0ZvXmqbvtOcce
	3yvwjuaO+qnj0sOyEvDp5g=
Received: from [192.168.0.12] (unknown [171.212.168.150])
	by smtp1 (Coremail) with SMTP id C8mowAAHQohu5qlXOy8gDA--.33557S2;
	Tue, 09 Aug 2016 22:19:27 +0800 (CST)
References: <dec52a2f-ef2f-f9c1-9ca2-e8b99cea7694@126.com>
	<CAJTo0LZNQNqiTLWHcegQUXfDAMp+4eahe1jmpJgsWWDhjxfPjw@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Message-ID: <b560cd81-616c-54a4-c69c-30d0fa6b03d8@126.com>
Date: Tue, 9 Aug 2016 22:19:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAJTo0LZNQNqiTLWHcegQUXfDAMp+4eahe1jmpJgsWWDhjxfPjw@mail.gmail.com>
X-CM-TRANSID: C8mowAAHQohu5qlXOy8gDA--.33557S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryDJr1UKw18JF4fKFWruFg_yoW8Xry7pr
	s8Wr1Utr4DX348Jr1Uur4jgw13Ar95CFs8Jrn3Jr1UAr1DGFn7Jr1DJa1UXryUCr1jyryU
	tr4UJr1vvr1UtFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b87KsUUUUU=
X-Originating-IP: [171.212.168.150]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiZw-AGVWfnk8cSAAAs+
Subject: Re: howto rerun a task whenever it's content chang
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
X-List-Received-Date: Tue, 09 Aug 2016 14:19:34 -0000
X-Groupsio-MsgNum: 7830
Content-Type: multipart/mixed; boundary="------------517B4A2B8C7C517137B8C786"

--------------517B4A2B8C7C517137B8C786
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

> Can you share the task, and what release of bitbake you are using?  As
> you say, this should work fine.
>

Yes ofcourse!

the attach is my test project, just according the bitbake manual's 
printhello example.

my bitbake was cloned from 'git://git.openembedded.org/bitbake'
and using revision id was: 309f5907a3661821e041ed14645b5d165007b058

Run 'bitbake printhello' firstime the output is:

$ bitbake printhello
Parsing recipes: 100% 
|##########################################################################################################| 
Time: 00:00:00
Parsing of 1 .bb files complete (0 cached, 1 parsed). 1 targets, 0 
skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies
NOTE: Preparing RunQueue
NOTE: Executing RunQueue Tasks
NOTE: Tasks Summary: Attempted 1 tasks of which 1 didn't need to be 
rerun and all succeeded.

Then edit do_build task, run 'bitbake printhello' secondtime the output is:
$ bitbake printhello
Parsing recipes: 100% 
|##########################################################################################################| 
Time: 00:00:00
Parsing of 1 .bb files complete (0 cached, 1 parsed). 1 targets, 0 
skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies
NOTE: Preparing RunQueue
NOTE: Executing RunQueue Tasks
NOTE: Tasks Summary: Attempted 1 tasks of which 1 didn't need to be 
rerun and all succeeded.


help me please!!


--------------517B4A2B8C7C517137B8C786
Content-Type: application/x-bzip;
 name="hello.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="hello.tar.bz2"

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

--------------517B4A2B8C7C517137B8C786--
