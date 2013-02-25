Received: from mail-we0-f172.google.com ([74.125.82.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1U9ybx-0002xf-0U
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 15:01:06 +0100
Received: by mail-we0-f172.google.com with SMTP id x10so2522424wey.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Feb 2013 05:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:content-type;
	bh=TeFCmJaRjrUCJWSZca4yDGMzSa9EdHEOT83aJAFJx3M=;
	b=sNZWErPFTwlwdpXexlSAEnJCBf28szVReyCx7cvFzZQSwKW9rY/NoB52kLWfsTKhzt
	yz/bcC8EtdYDa4CXJ7WfDm96FljCvK4wf/t26hzp8S/pfdQTQHT15SKTJAN11HN0Q86P
	mWogUWFLHrKebpGSpwyRCvufKUMZ1mVI4zQAIrXZ120SMgu615tflykM5CDqScN7asoO
	AQAYpD/0lXOtwLljwTK5SlUeDWosyOTNL1a/uYMYQfoBT0pt063jliE7TRDnpMdhekIz
	II18MKaW3bmRRckTALfkM6X8cEXHynJ/T+J7WBAEW/YTU1PJdSd4qCoxbDDeAvirr8N5
	qaYg==
MIME-Version: 1.0
X-Received: by 10.180.75.177 with SMTP id d17mr12355290wiw.16.1361799879142;
	Mon, 25 Feb 2013 05:44:39 -0800 (PST)
Received: by 10.194.45.100 with HTTP; Mon, 25 Feb 2013 05:44:39 -0800 (PST)
In-Reply-To: <CALbNGRSZeOC0Tyv1-x6og6g+HOD148PUdCWcONYBE_YUQ7FASA@mail.gmail.com>
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
	<CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
	<CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
	<CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
	<CALbNGRSioFk7F3W9yp_VbHz6sXP-LjUtg0DqJorZmyHt_+J2sw@mail.gmail.com>
	<CABxcv=kdCzvj=Z4GDtYC4P-az9LnT5VhrspRrZq8p568uPo9QA@mail.gmail.com>
	<CALbNGRSZeOC0Tyv1-x6og6g+HOD148PUdCWcONYBE_YUQ7FASA@mail.gmail.com>
Date: Mon, 25 Feb 2013 08:44:39 -0500
Message-ID: <CAHUNapR3-Z57mPUScW6TnptFbawE3y=+bCcpnTVVfAy-2KjwjA@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [meta-ti] trouble during parsing
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
X-List-Received-Date: Mon, 25 Feb 2013 14:01:06 -0000
Content-Type: text/plain; charset=ISO-8859-1

If the purpose of the ls-remote is to match a tag with a hash,
wouldn't it be easier to just:

    cat .git/refs/tags/<tagid>

?

And if the purpose of knowing the tagid is to use that version of the
code, wouldn't it be easier to just:

    git checkout <tagid>

?


