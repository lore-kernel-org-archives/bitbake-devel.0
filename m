Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1T57hI-0004an-EF
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Aug 2012 06:10:08 +0200
Received: by lagv3 with SMTP id v3so1456731lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Aug 2012 20:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=hVqK8Z8DO4W2v9q3epAGTK+4cv5qn13LFngHcDrWVYI=;
	b=p9gNItWQ9Cl/fNPprJKrwjzy9KF+JQSM23r+zrMAcJ2p+wAtbSaZ98tz/dkPaGsMrw
	L3bzheZhYTYqd4BMaVj1b88UlW0v2LJ/RuMIiLtGMy59WjadulDbNwdM5tgJ0byZGXF6
	puVmyFapZUJRVsXbfDHS5JoKLbZ2CjyYofkZUf7ZpJiB52zPFpSanYRltXJVtj/s5KNY
	HmH9xegY0xWzfCZXTbmdt3kOjnr4Z8Yndo6iSjNjhBzP+DuLeLP+DzBWfVvTF7F/6cTu
	akiajui4aTkIVRI3lK13XIsoJUdifXy3RuKvTP6RPeF89tDdnBorFgflN0B0y10QRiVn
	6uZA==
Received: by 10.112.100.65 with SMTP id ew1mr3562091lbb.16.1345867079865; Fri,
	24 Aug 2012 20:57:59 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.19.2 with HTTP; Fri, 24 Aug 2012 20:57:39 -0700 (PDT)
In-Reply-To: <CAHUNapQnVGUxnNeoQEj8UDZdLWKit9K0RHy5a6t8a9x5cMwxfA@mail.gmail.com>
References: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
	<CAK18fxFmxBPwray4tgs=LsPEs1hy9TEp7=jbw3i5LgCejmEDpw@mail.gmail.com>
	<CAHUNapQnVGUxnNeoQEj8UDZdLWKit9K0RHy5a6t8a9x5cMwxfA@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 24 Aug 2012 20:57:39 -0700
X-Google-Sender-Auth: qY6TpNtCSTlhfUauXuYb7ZjjHlk
Message-ID: <CABcZANm2uL7c40LQWxmvu4q6yTjrymzqth-JmTdPvbC7XAHm_w@mail.gmail.com>
To: Trevor Woerner <twoerner@gmail.com>
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
X-List-Received-Date: Sat, 25 Aug 2012 04:10:08 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 24, 2012 at 2:35 PM, Trevor Woerner <twoerner@gmail.com> wrote:
> On Fri, Aug 24, 2012 at 5:19 PM, Andrei Gherzan <andrei@gherzan.ro> wrote:
>> Modify the commit subject. to include what you are changing. In your case
>> the subject should be something like:
>> "bitbake: Clarify wording"
>
> Sorry about that, thanks for the feedback. I'll send in a new patch
> for consideration.

No, this is wrong. When committing to the bitbake repository, there's
no need to prefix it with 'bitbake:'. You should mention what/where
you're clarifying, however. E.g. "clarify wording in help output for
-s"
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


