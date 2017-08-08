Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 0E0196FF69
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 14:22:06 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v78EM7QZ029548
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 8 Aug 2017 07:22:07 -0700 (PDT)
Received: from [128.224.162.246] (128.224.162.246) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.361.1;
	Tue, 8 Aug 2017 07:22:06 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1502183410.git.liezhi.yang@windriver.com>
	<53074458ae150fc7544b02f5c3e37ff49257cb27.1502183410.git.liezhi.yang@windriver.com>
	<1502196622.18633.246.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <e6634bbb-5d26-7b24-18b9-42b356f5ffd9@windriver.com>
Date: Tue, 8 Aug 2017 22:21:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1502196622.18633.246.camel@linuxfoundation.org>
Subject: Re: [WIP][RFC PATCH 5/5] bitbake: main: make observe-only work without --bind
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
X-List-Received-Date: Tue, 08 Aug 2017 14:22:07 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 08/08/2017 08:50 PM, Richard Purdie wrote:
> On Tue, 2017-08-08 at 02:12 -0700, Robert Yang wrote:
>> The bitbake --server-only can work without --bind, so --observe-only
>> should also
>> can work without --bind or --remote-server.
>>
>> And also allow the connection all the time, otherwise --observe-only
>> doesn't
>> work.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>  bitbake/lib/bb/main.py           | 4 ----
>>  bitbake/lib/bb/server/process.py | 8 ++------
>>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> The other patches look ok but I worry a bit about this one since the
> code isn't really set up to handle multiple potentially competing
> connections right now. If something is an observer, we need to ensure
> its marked as such and can't send control commands...

Yes, that's a problem, I will fix it.

// Robert

>
> Cheers,
>
> Richard
>

