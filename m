Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gopikrishnans@pec.edu>) id 1SUhLV-0007bT-Sr
	for bitbake-devel@lists.openembedded.org;
	Wed, 16 May 2012 18:45:06 +0200
Received: by dalh21 with SMTP id h21so1069318dal.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 May 2012 09:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding
	:x-gm-message-state;
	bh=R/Cm7dy7yOLQp9IQxH7L5LiVZnCRPMmSAGzMX7PtJ64=;
	b=HKXVtD4FIcJ/b9LHLhYdVtiVPIntfjc8dLeL01WmlmOvNdRS5rCAayfd33Q/9yf6Ar
	4YiPf5yZghWfbQbrkfqp+CJHbm0s9CFy8pYWJdujXTvUKY3caJ4Cn8jsBvrwbLF1qjhj
	4P8oiq+kOE86uAcSxJAGGkeQssjrFxKd+UnDKCQLiZpTYXcVQpTDVivYUdokrHb6HbKr
	H2iRRRngAvwmzNrSZSeM6sHELVEGWak1IUDlgrySs2FzS+NZhiDUqoLSolCyB0BzCj8y
	7xXQfMsV6g/AUiaxF57tcIFVbhzSr2KER5Br0lSmS7mkpT8Dmhvf+h7mnC3CISaX/CrC
	5X1g==
Received: by 10.68.204.227 with SMTP id lb3mr17569029pbc.92.1337186103221;
	Wed, 16 May 2012 09:35:03 -0700 (PDT)
Received: from [117.230.161.214] ([117.230.161.214])
	by mx.google.com with ESMTPS id wd10sm5932906pbc.70.2012.05.16.09.34.58
	(version=SSLv3 cipher=OTHER); Wed, 16 May 2012 09:35:01 -0700 (PDT)
Message-ID: <4FB3D73A.6050708@pec.edu>
Date: Wed, 16 May 2012 22:05:06 +0530
From: Gopi - College <gopikrishnans@pec.edu>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <CAOkC3RaOcShZzeUNU9UNwMjt+LHgOVw=FgosdqwZXh8F0s0A_Q@mail.gmail.com>
	<1336935419.2711.20.camel@ted>
In-Reply-To: <1336935419.2711.20.camel@ted>
X-Gm-Message-State: ALoCoQmixlTjKvkA6lLuFWT4K1nEnH/hbopaETkgzgsQe6qDEefGD6B1EMyBJyNiolYvhz842QCa
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
X-List-Received-Date: Wed, 16 May 2012 16:45:06 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Where could I get better guide for writing bitbake METADATA


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



