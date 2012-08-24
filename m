Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1T51jT-0007Bg-DM
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Aug 2012 23:47:59 +0200
Received: by lban1 with SMTP id n1so1347274lba.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Aug 2012 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=58faZ1QJfLkvQ8DU/VuF6N33zSm4M7AikpdDUWamQ4U=;
	b=sxCXWPBTygN47WVXICdErMqmcjUIc5ImKJ/TAsPtM1oPdgfYqlvAL51d210BImxQFa
	3kL+aFIiLXT803hj7B4p5u7BMAYad+Ilt/U5iMMH6yO9D0Dl2WUKlpYLXGGQ60bymchb
	E51YU+uCl4QMh+dllAevGzykUJlS4YuKvYYSAls0KTxaxJYw8U09xtbA96VVuLphVfve
	Fr8hgTAl2UKxc7dt4r+5rMnRx5OOmAS6qLQbrlko/G9macDeJsuZycvzxqjGtqncA0f1
	o9bo2uzfUUOmgdijp2SwPUdNlTsvV2P2awNUliqTjuhhMpLY/FM6VvKDcJl5ntJ77qXA
	jgEA==
MIME-Version: 1.0
Received: by 10.112.25.4 with SMTP id y4mr3322845lbf.61.1345844151420; Fri, 24
	Aug 2012 14:35:51 -0700 (PDT)
Received: by 10.112.21.9 with HTTP; Fri, 24 Aug 2012 14:35:51 -0700 (PDT)
In-Reply-To: <CAK18fxFmxBPwray4tgs=LsPEs1hy9TEp7=jbw3i5LgCejmEDpw@mail.gmail.com>
References: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
	<CAK18fxFmxBPwray4tgs=LsPEs1hy9TEp7=jbw3i5LgCejmEDpw@mail.gmail.com>
Date: Fri, 24 Aug 2012 17:35:51 -0400
Message-ID: <CAHUNapQnVGUxnNeoQEj8UDZdLWKit9K0RHy5a6t8a9x5cMwxfA@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
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
X-List-Received-Date: Fri, 24 Aug 2012 21:47:59 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Aug 24, 2012 at 5:19 PM, Andrei Gherzan <andrei@gherzan.ro> wrote:
> Modify the commit subject. to include what you are changing. In your case
> the subject should be something like:
> "bitbake: Clarify wording"

Sorry about that, thanks for the feedback. I'll send in a new patch
for consideration.


