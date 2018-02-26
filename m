Return-Path: <pbarker@toganlabs.com>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail.openembedded.org (Postfix) with ESMTP id F0AFB78699
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Feb 2018 22:20:34 +0000 (UTC)
Received: by mail-wr0-f195.google.com with SMTP id o76so22870583wrb.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Feb 2018 14:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=toganlabs-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=vTjAtEJtKRiLiyPuGtfsQsVLrGZ7alI4j5rwkIQRUu4=;
	b=e4NJoXZ/fBoKMgf11EPcOK2Punztko6U/6AdLdpoos7y/pJ9Q2JiTQWAG6UaYPrBHU
	F5SUNx6N0nV+SEXv3DYmDw9CO69k2Ad7+XhV1b6S86NBvMjpMql1jsWaQxQGufqr+2tR
	x7kTEIT4pPxFzTWfD7xZK4R+4k15CFzwSx9imHQ+OkUR1V70Fq812+2Eu3LkYosDjVZr
	uDa8d6/21FO9VOKXVtJDPzPXxc/3150HJ2J+ylXMMu+5vO9ODENrhE5r7nd3bt27NdQx
	j8yl0vUw/AEKu/Eu+BWor14SQ/xONt6M7P0g7ejAnWZoEQY4W5W5EQj7bMx+owMKrUhg
	syrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=vTjAtEJtKRiLiyPuGtfsQsVLrGZ7alI4j5rwkIQRUu4=;
	b=ePa1iUd1MQ6q4R3TZL+tf5LtHQ2WTjUiiykWR0s9fXWqDgWuZyhHRwEnVp1XEhdWVX
	YcgjXFJyBTpQoDjIAySMhGcNQzGaxf9nnnHYp07vKEvA76eC8qoIM3Na392/KI/jYOey
	0UvkH+6sUA1Aq82NZyq6ZMUjXv4zxixO5XN4i5Gkn7nQh5gwMMrIegXo/jB9FDxqADEm
	6YJdlG2nnULJrO+uFFG9OPERFzhfWmkvzRVCCWYnug809ocEESsSZt7ezaILsz97QxKy
	mpo1b2ZxAJdwgjjOyvqWTNAJTYuN1pz9d3Negfzt5Fzl2FELNhY+43mOUB2A7qj6U5S2
	wN8Q==
X-Gm-Message-State: APf1xPCYWTjTfIlBcF98uvycVqhjlx5HV3caTBbo2vRDzmJKO8eTHcj4
	dGoJ61WSvp9B+a9832/1qdS5ewMjLXI0rF5r2+dMsg==
X-Google-Smtp-Source: AH8x225kF4VoIfZrL88Svz8Wspf4F73KupR16f4xaf5M1/Y7RlhJChEe77Ktg0Kob0tmTngP2HVAdIaQkRZhpV9LTO8=
X-Received: by 10.223.192.76 with SMTP id c12mr10291801wrf.177.1519683635529; 
	Mon, 26 Feb 2018 14:20:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.153.48 with HTTP; Mon, 26 Feb 2018 14:20:35 -0800 (PST)
In-Reply-To: <CAPyrkgxbBhVotXYVdnXBby4xCN2O_YjeJTpPU33DmhnnW+Mmsg@mail.gmail.com>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
	<1517314210-25684-4-git-send-email-richard.purdie@linuxfoundation.org>
	<CAPyrkgwKMnb7OchXGr8OE3f_NK90ehxphS1HzGpOYjuyaKemhQ@mail.gmail.com>
	<1519596717.24236.384.camel@linuxfoundation.org>
	<CAPyrkgxDenV61oP1CZLFSFueqM3NXo2BOptNgSFTDnRHpm62iQ@mail.gmail.com>
	<CAPyrkgzzasujqZ1D5pABM+vudjjaM=4wdVuseFNB8u0OHVdMCA@mail.gmail.com>
	<1519663996.24236.387.camel@linuxfoundation.org>
	<CAPyrkgxbBhVotXYVdnXBby4xCN2O_YjeJTpPU33DmhnnW+Mmsg@mail.gmail.com>
From: Paul Barker <pbarker@toganlabs.com>
Date: Mon, 26 Feb 2018 22:20:35 +0000
Message-ID: <CAPyrkgxV5cVA8SjdXBGdYnbLWsoq_S4AYM2_Ej6kKQG7Mhq3MQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] runqueue: Rewrite and optimize recrdepends handling
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
X-List-Received-Date: Mon, 26 Feb 2018 22:20:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 4:55 PM, Paul Barker <pbarker@toganlabs.com> wrote:
> On Mon, Feb 26, 2018 at 4:53 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>>
>> Thanks, more information helped. I think you have found a bug. I'm
>> wondering about:
>>
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index 48df0131556..f2e52cf758c 100644
>> --- a/bitbake/lib/bb/runqueue.py
>> +++ b/bitbake/lib/bb/runqueue.py
>> @@ -765,7 +765,7 @@ class RunQueueData:
>>              bb.debug(1, "Added %s recursive dependencies in this loop" =
% extradeps)
>>
>>          # Remove recrdeptask circular references so that do_a[recrdepta=
sk] =3D "do_a do_b" can work
>> -        for tid in self.runtaskentries:
>> +        for tid in recursivetasksselfref:
>>              self.runtaskentries[tid].depends.difference_update(recursiv=
etasksselfref)
>>
>>          self.init_progress_reporter.next_stage()
>>
>> as a fix for it...
>>
>
> That makes sense. I'll apply that change and see if it works.
>

That's working for me. Dependencies are all resolved correctly and I'm
not seeing any errors.

--=20
Paul Barker
Tog=C3=A1n Labs Ltd

