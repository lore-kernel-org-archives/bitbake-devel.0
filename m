Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1T5E1R-0006j8-3g
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Aug 2012 12:55:21 +0200
Received: by lagv3 with SMTP id v3so1557622lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 25 Aug 2012 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=S8q9v001ylLGHO4IG1KR7N6j9neCG4NoLS9orOMgW6o=;
	b=YawVzIrSrzjE8My5Tn3ms5cYbBfC/qV24YYd0XHcyXoSrENtsWLv4Solz3yX5affy5
	iqW3E91inLn6pA1ulF4hpEh9CsJgKd/MLhgwtlra2t0BjYwyugLknXLu7iOWdOqc2RMj
	m0n/075HxAqHsL/QbjUa0zwZyfw9CXRvJeDBS6oZQL0kP1KFkwvxwjIO7/CY5MDeoeeQ
	g9QJcED2qTCCcck9vJce/fu+yB5AL7zctBfVNndYdpy1a4bnAa68QUui8z8UVgRCXmbA
	7UQa1cphP1LPVNMdW7AOzIU2Rop8rFjAOb5NfCOQIIyb0/CVptz//aTXdTxccPH2LNXB
	mdHw==
MIME-Version: 1.0
Received: by 10.152.114.3 with SMTP id jc3mr8653561lab.11.1345891392191; Sat,
	25 Aug 2012 03:43:12 -0700 (PDT)
Received: by 10.112.21.9 with HTTP; Sat, 25 Aug 2012 03:43:12 -0700 (PDT)
In-Reply-To: <CABcZANm2uL7c40LQWxmvu4q6yTjrymzqth-JmTdPvbC7XAHm_w@mail.gmail.com>
References: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
	<CAK18fxFmxBPwray4tgs=LsPEs1hy9TEp7=jbw3i5LgCejmEDpw@mail.gmail.com>
	<CAHUNapQnVGUxnNeoQEj8UDZdLWKit9K0RHy5a6t8a9x5cMwxfA@mail.gmail.com>
	<CABcZANm2uL7c40LQWxmvu4q6yTjrymzqth-JmTdPvbC7XAHm_w@mail.gmail.com>
Date: Sat, 25 Aug 2012 06:43:12 -0400
Message-ID: <CAHUNapQsabEeNV7ZrpZfro8R8OKakS-862UJy1w1_5LmSZU8eQ@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: Chris Larson <clarson@kergoth.com>
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
X-List-Received-Date: Sat, 25 Aug 2012 10:55:21 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Aug 24, 2012 at 11:57 PM, Chris Larson <clarson@kergoth.com> wrote:
> No, this is wrong. When committing to the bitbake repository, there's
> no need to prefix it with 'bitbake:'.

I am new to bitbake-devel, but looking through several of the more
recent commits would indicate the majority of them do have some sort
of location identifier in the subject, some of which are just
"bitbake:". One (e0f91faf195be63803d39fb42fcd115ad558c79f) even has
"bin/bitbake:"; maybe I should use this for my patch?

> You should mention what/where
> you're clarifying, however. E.g. "clarify wording in help output for
> -s"

Okay.


