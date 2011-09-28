Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dbaryshkov@gmail.com>)
	id 1R8tiN-0004vi-Lt; Wed, 28 Sep 2011 14:58:19 +0200
Received: by eya25 with SMTP id 25so6124696eya.6
	for <multiple recipients>; Wed, 28 Sep 2011 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=ta7np6ctF9UxwzKEEU7og6IsmbKBxSpZ1qA6JAJIWek=;
	b=bQdILGrAzkchae3dC2Pa2eX6kMVjDL0upGpBhlQmKiVVSujQPiBO91q9sy530KjIwE
	njqVvZf4Cwp3ISIt9FmGUF5sRMcX52VsYvmJ762LjMe5DsEz28ipkuIDXoWkj8hFFBR8
	JJqcPqmgel870BodmP+9cUe5EIsxc/n9HKr4c=
Received: by 10.216.88.140 with SMTP id a12mr9896100wef.82.1317214372665;
	Wed, 28 Sep 2011 05:52:52 -0700 (PDT)
Received: from [137.202.140.192] (nat-rup.mentorg.com. [139.181.168.34])
	by mx.google.com with ESMTPS id f26sm40500170wbp.7.2011.09.28.05.52.50
	(version=SSLv3 cipher=OTHER); Wed, 28 Sep 2011 05:52:51 -0700 (PDT)
Message-ID: <4E831868.4090603@gmail.com>
Date: Wed, 28 Sep 2011 16:51:52 +0400
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <CALT56yN5hXMLBhHVLKyHbNb=7WDb3pZUB0Q+HNKc-2t+g6M58A@mail.gmail.com>
	<201109281116.00890.paul.eggleton@linux.intel.com>
In-Reply-To: <201109281116.00890.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] meta-micro problems
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
X-List-Received-Date: Wed, 28 Sep 2011 12:58:19 -0000
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/28/2011 02:16 PM, Paul Eggleton wrote:
> Hi Dmitry,
>
> On Friday 16 September 2011 19:17:17 Dmitry Eremin-Solenikov wrote:
>> While trying to use a meta-micro, I've stumbled upon a problem.
>> Each run, bitbake keeps running all tasks over and over. Sometimes
>> this leads to failures (http://bugs.lumag.spb.ru/show_bug.cgi?id=33).
>> Sometimes it doesn't. I've narrowed a simple test case. Attached
>> the log of one of the executions of bitbake quilt-native. stamps dir
>> has all necessary stamps, but tasks keep being executed over and over.
>>
>> Layers enabled:
>> meta-micro
>> meta-handhelds
>> meta-opie
>> openembedded-core/meta
>
> Did you manage to figure out the cause of this? Does it still happen when meta-
> opie is removed? It would be useful to try to narrow down what causes the
> problem as I'd be surprised if all of these layers need to be present to
> trigger the bug.

No, I did another few attempts and then stopped caring about this bug. 
Just switched to distro-less oe-core.

If you wish, I can retry this with smaller layer set. But if the bug 
will still arise, I simply have no knowledge/time to look deeper into bb 
without additional input/pointers from bb gurus.

>
> Also, did you not have the meta-oe layer enabled? Both meta-opie and meta-
> handheld normally require it...

No, I didn't have meta-oe enabled. No errors during parsing and start of 
task execution.

-- 
With best wishes
Dmitry


