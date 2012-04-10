Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1SHeUc-0000fM-0m
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Apr 2012 19:04:34 +0200
Received: by lagw12 with SMTP id w12so17129lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2012 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=wVB7nrCLO9tiOyCis5GhmAT3SlFLNY7MrKY7PmOKKa0=;
	b=p4A3lVVNhSVCLC8W+C5HVPvV0UFSFJnnNmbPczqfcTW0iAOKc1nz1jlV26lNPcnkwC
	iOZXKt2a0VHrCxj9GVOFM4YlkbP/JuSQuh7eMOO/P6hrtyZKbEyPelt+YjUaWcfEf1u3
	a9a4ud5kAHG1hPsjBKlHa4tc6SHNc24oz/vrxHWJxVHlEFvwUbjomtGjBXb7Nz8TQITO
	hMVByKA/Th27d/0PAk/bqGxpNeHJi0qXXy3uq3JMItKih63Hn206LNYq5RCkpkLLA1jA
	uRf5eYZVEJDaK2iay0+1RX9Fy5L/pmy85HfsmUt8cqulfwfPSF5yhRCcOvND2OBeDdVW
	uzcw==
Received: by 10.112.83.105 with SMTP id p9mr1543438lby.43.1334076915942; Tue,
	10 Apr 2012 09:55:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.129.134 with HTTP; Tue, 10 Apr 2012 09:54:45 -0700 (PDT)
In-Reply-To: <CABcZAN=4SzW-7b75_ydFfT67uQhb_xq643v6o4AbvVbGxatJVA@mail.gmail.com>
References: <4F82DE2E.30208@mlbassoc.com>
	<CAMKF1sr5t8DptrHBO6NdA0mh2URs6QVXgpfLSXMcFHW9ybX3jg@mail.gmail.com>
	<4F845B40.2040302@mvista.com>
	<CABcZAN=4SzW-7b75_ydFfT67uQhb_xq643v6o4AbvVbGxatJVA@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 10 Apr 2012 09:54:45 -0700
Message-ID: <CAMKF1soNohu5iM9j3Sro+MeKPObUsObwzCyFFEsO30cZQ2qJyw@mail.gmail.com>
To: Chris Larson <clarson@kergoth.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bblayers.conf is required?
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
X-List-Received-Date: Tue, 10 Apr 2012 17:04:34 -0000
Content-Type: text/plain; charset=UTF-8

> Yeah, bitbake itself doesn't require bblayers.conf.

right. I forgot about bitbake's life without OE :)


