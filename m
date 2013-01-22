Received: from mail-wg0-f49.google.com ([74.125.82.49])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1TxhzK-0007P6-NZ
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 18:50:28 +0100
Received: by mail-wg0-f49.google.com with SMTP id 15so1467465wgd.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jan 2013 09:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=voibbtT+DvaZfLL2ixiRHAZfNxyKGO+VFie/YsLY6qo=;
	b=MogTF3vzEr7u4cTv0FUY/PrbLowMNc2DOAi8bbFH8sdCIAY4v/mtuNJq+apJDtIHPP
	2odkqetINiV+1hNFcIZk/t+hImMZClajahOYzbtV0khN68qTvo/0qN9WcNhsWGb4Q3ND
	Lot2fJBCCAZGyuajTf55AD6e+RkZLg+o+npzQqF9HtfO5OdOR9bMtmvTlxEaVIHMG9z9
	pF4fhTn72mUfIJb9Qk+9UOPAeAbXnrfFKoyQMW+v8I4K2KxQAa1EPYCkQ169TG9xtPrE
	tb2F2Pi9XFRFP0vOGafhFA7ouyXet6vRPjvE58TL7lbljby0KPOy9S/o25ddPwr9JbO2
	2afg==
MIME-Version: 1.0
X-Received: by 10.180.93.40 with SMTP id cr8mr22945951wib.15.1358876092583;
	Tue, 22 Jan 2013 09:34:52 -0800 (PST)
Received: by 10.227.132.205 with HTTP; Tue, 22 Jan 2013 09:34:52 -0800 (PST)
In-Reply-To: <CABcZANnyXfaJiX7xqitTUZp9FLoY3yBy_Y7WbrTXtufYmUxUQw@mail.gmail.com>
References: <6811518C-5E13-40A7-8B8B-57C2810DEA8B@gmail.com>
	<CAHUNapSSaOqnkOZq3_BaMthqY6hG+JTxvi9XpgD_38yT6+wDhA@mail.gmail.com>
	<CABcZANnyXfaJiX7xqitTUZp9FLoY3yBy_Y7WbrTXtufYmUxUQw@mail.gmail.com>
Date: Tue, 22 Jan 2013 12:34:52 -0500
Message-ID: <CAHUNapR_vdtwaiBVB9oMFM1=+fxVZGEcUkpqxG4G1C+ts=sApQ@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Display mode
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
X-List-Received-Date: Tue, 22 Jan 2013 17:50:28 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 22, 2013 at 11:41 AM, Chris Larson <clarson@kergoth.com> wrote:
> On Tue, Jan 22, 2013 at 9:37 AM, Trevor Woerner <twoerner@gmail.com> wrote:
>> This feature is called "knotty".
>
> No, the knotty UI is the default bitbake UI, and has been for years, even
> before this feature was added to it. The new display was initially checked
> in as 'knotty2' rather than the default knotty, and eventually knotty2 was
> merged back into the default knotty UI.


Ah yes I see. It was wrong of me to call it knotty because the feature
to which Trung was referring is now currently known as... knotty? ;-)

Haha, I'm just teasing. Thanks for the clarification :-)


