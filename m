Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gopikrishnans@pec.edu>) id 1SUhax-0008EK-0u
	for bitbake-devel@lists.openembedded.org;
	Wed, 16 May 2012 19:01:03 +0200
Received: by dalh21 with SMTP id h21so1086441dal.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 May 2012 09:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding
	:x-gm-message-state;
	bh=7TvyIpD34/x8IFJ3LCgNkad27bePTbizQp1qf/NjAp8=;
	b=Zz0S6fFDNEuU8dptgcP6vUzl09u4RKRLZr6bJZrh/+v9pOZspar80plh6AgomCQW1M
	m3qTleIxFxEbFnDbyJnQbpiiFE0tUvdmOztQnGI3yw44TOqvAZMwr10Tsq1oF6f/bkho
	SKwU9JECjl9Xmxz4LuYdFdZU5SQpKlAUfS8FJMByI+afU7cYVyYQwZwkAYFGT7znFmdX
	29sQd8sFY3WEogK2+9wNzSeDSPgogUeD7JaCrfkKDdw8bORyvuxw74ZW1G6XqQQwgwMJ
	NicNKDgWQq3ZcDd7JPYts6jBospHIpC3h6fCzrXzcPKJzfJj/UzzDrsuUm3bVToUGl3S
	OIeA==
Received: by 10.68.242.226 with SMTP id wt2mr376495pbc.89.1337187060746;
	Wed, 16 May 2012 09:51:00 -0700 (PDT)
Received: from [117.230.161.214] ([117.230.161.214])
	by mx.google.com with ESMTPS id pd9sm6001420pbc.26.2012.05.16.09.50.54
	(version=SSLv3 cipher=OTHER); Wed, 16 May 2012 09:50:57 -0700 (PDT)
Message-ID: <4FB3DAF5.6020403@pec.edu>
Date: Wed, 16 May 2012 22:21:01 +0530
From: Gopi - College <gopikrishnans@pec.edu>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <CAOkC3RaOcShZzeUNU9UNwMjt+LHgOVw=FgosdqwZXh8F0s0A_Q@mail.gmail.com>
	<1336935419.2711.20.camel@ted>
In-Reply-To: <1336935419.2711.20.camel@ted>
X-Gm-Message-State: ALoCoQnMT2Y81hsSELwkCm9PdEgLE6P6DZKwEXKzV9D7HozDY1JOPCxvNNUFmCLHtcrTZL4FDoAT
Cc: bitbake-devel@lists.openembedded.org
Subject: =?UTF-8?B?UmU6IEw0IEZpYXNjby5PQyDCtS1rZXJuZWwh?=
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
X-List-Received-Date: Wed, 16 May 2012 17:01:03 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

If it is possible to compile any kernel; But, the system builder @ 
mentor-graphics currently have only patch freescale p2020 for linux 
2.6.35, Not available for any other higher version of linux kernel, If 
this is the case how it is possible to freeze a kernel, where p2020 
patch that doesn't exist.

Reg,
Gopi

On 5/14/2012 12:26 AM, Richard Purdie wrote:
> On Sat, 2012-05-12 at 16:11 +0530, GOPIKRISHNAN S wrote:
>>       Using bitbake is it possible to compile and generate uImage for
>> "L4 Fiasco.OC µ-kernel!"; Anybody Tried it? Please guide,
>>
> Most things are possible. You'd need the right metadata and I've not
> tried that, nor do I know anyone who has. This mailing list is about the
> tool itself, not the metadata it reads so you might have more success on
> one of the OpenEmbedded lists.
>
> Cheers,
>
> Richard
>
>



