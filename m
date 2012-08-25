Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1T5NfD-00088A-W6
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Aug 2012 23:13:04 +0200
Received: by lagv3 with SMTP id v3so1735654lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 25 Aug 2012 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=jpcDcjRauPAwh6ysfD+k3I83TIepJl7FSKxfsIwWlzk=;
	b=ybSHf7QHQlUMnSZMbR+WI82X/dwb24fY1VrW0s8bZYhOu5D8PQhevBu/vlSYuzcUn7
	dxsTV5PnDuLOO2BME8n7z9Wi3khlgPd/i1uMqoPFHz9TWISC2l7sYwWbB/T8pRO0ir2Z
	8w5XeFbCl/G7KeVYsuG6qNyRcw7rFfmaYxkcTOIZbaxpW34JQMsjVNQ+xEHZF6jE02w+
	Hqvrvdt7peEk2oZDwxfZ6+E6ENB+cCBgYLU3tVTkHnUIcMn1pPEv8SELxpqRve2ENGhK
	96uvvH+MKdfY2AFb6ZrvtMz4NP5E2xVdcSsZ/flFk+yK/aFGd6zB/2mslR0ojIw6J3vV
	GzYA==
Received: by 10.112.51.195 with SMTP id m3mr4286819lbo.17.1345928452469; Sat,
	25 Aug 2012 14:00:52 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.19.2 with HTTP; Sat, 25 Aug 2012 14:00:32 -0700 (PDT)
In-Reply-To: <CAK18fxEVCYsTypt-qa88Chjhu+qj4ry2FSdU8tUEnAZyCijcCQ@mail.gmail.com>
References: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
	<CAK18fxFmxBPwray4tgs=LsPEs1hy9TEp7=jbw3i5LgCejmEDpw@mail.gmail.com>
	<CAHUNapQnVGUxnNeoQEj8UDZdLWKit9K0RHy5a6t8a9x5cMwxfA@mail.gmail.com>
	<CABcZANm2uL7c40LQWxmvu4q6yTjrymzqth-JmTdPvbC7XAHm_w@mail.gmail.com>
	<CAK18fxEVCYsTypt-qa88Chjhu+qj4ry2FSdU8tUEnAZyCijcCQ@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Sat, 25 Aug 2012 14:00:32 -0700
X-Google-Sender-Auth: -vq2xuv-dM5cVEhRt3oyNrth_tw
Message-ID: <CABcZANmumueLTHW5kHerFwqwRLkaPOYea4YRtRswwKwuBZ+OSA@mail.gmail.com>
To: Andrei Gherzan <andrei@gherzan.ro>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] clarify wording
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
X-List-Received-Date: Sat, 25 Aug 2012 21:13:05 -0000
Content-Type: text/plain; charset=UTF-8

On Sat, Aug 25, 2012 at 3:15 AM, Andrei Gherzan <andrei@gherzan.ro> wrote:
>> No, this is wrong. When committing to the bitbake repository, there's
>> no need to prefix it with 'bitbake:'. You should mention what/where
>> you're clarifying, however. E.g. "clarify wording in help output for
>> -s"
>
> Yes i'm right. When suggesting for adding "bitbake:" i wasn't refering to
> the repo. I was talking about "what is changed". And that is the bitbake
> script. The general format is "what: Short log".
>
> Here are some examples.
> bitbake: data-smart: rename the 'content' internal variable to '_content'
> bitbake: Hob wizard-like reorganization

Wrong. Inside the bitbake repository, it shouldn't and needn't be
prefixed with 'bitbake:' unless necessary due to it coming from poky.
Perhaps the only git changelog you read is inside the poky repository,
but the rest of us pay more attention.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


