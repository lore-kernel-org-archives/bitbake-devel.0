Return-Path: <trevor.woerner@linaro.org>
Received: from mail-ee0-f46.google.com (mail-ee0-f46.google.com [74.125.83.46])
	by mail.openembedded.org (Postfix) with ESMTP id BD9716CE3F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Oct 2013 15:22:04 +0000 (UTC)
Received: by mail-ee0-f46.google.com with SMTP id c13so3497089eek.33
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Oct 2013 08:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:content-type;
	bh=Lfr4nsR8TNbjie27mqDdPEVDE4F7AnUq+5WLidBB15s=;
	b=J5yL2yyyVhCrXIt1fIZb9eqsvHinfqI0aFmC0dpQJnDWNlseXfV88nsREOF2cJBpXR
	wlrEe9Seido+So6fGSUoUohXzvwzUNw0trAuum/fEXfQdjN4lemDI8eXzesTzpMxeBj2
	zGYAoAzlX0PQIS5+qXsphw+Wpfcb9PAd/7WRXr9vL/G/zLKpKdpzBEm31OvacOI5pi0u
	w5fgGgAcgMYyWpHISsEsdOoxQ06UVZRy9SaNj0LFX4ZpWR76TSO1Q/VErAeJk0GyTqmJ
	stYBC6KWPmZePeTGONAUQGAJfzm9AQuGwysgRiqLQ50i/9Zhk1CkscbVvdEBvdJJxRyc
	FCQg==
X-Gm-Message-State: ALoCoQlnkm4/gkaVp57B9qkRV+dpv4Kwnz7JIt7pFKBqx+W+SWUxqdgH7B7j5SDiuwKNozH4e0oQ
MIME-Version: 1.0
X-Received: by 10.14.180.73 with SMTP id i49mr4271227eem.55.1381764125138;
	Mon, 14 Oct 2013 08:22:05 -0700 (PDT)
Received: by 10.14.117.67 with HTTP; Mon, 14 Oct 2013 08:22:05 -0700 (PDT)
In-Reply-To: <CAAPegz04fh+NP+ZEduiPo+Cbvh-bbzyqGNEsMaWJoOH0t_v23w@mail.gmail.com>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
	<1381683215.29912.233.camel@ted>
	<CAAPegz12Mnrbipi0w4zMdcje1R4SUwhMiUKsOAOfKHpzukea2Q@mail.gmail.com>
	<1381761637.29912.326.camel@ted>
	<CAAPegz04fh+NP+ZEduiPo+Cbvh-bbzyqGNEsMaWJoOH0t_v23w@mail.gmail.com>
Date: Mon, 14 Oct 2013 11:22:05 -0400
Message-ID: <CALmOhg=r3oU4GkUk=ozidcg9=4gNKTTeFeJFVPwt+ofgvHLnEQ@mail.gmail.com>
From: Trevor Woerner <trevor.woerner@linaro.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Bitbake for native x86 project?
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
X-List-Received-Date: Mon, 14 Oct 2013 15:22:05 -0000
Content-Type: text/plain; charset=ISO-8859-1

Chris,

Are all of your developers working on creating the target's kernel,
rootfs, and/or bootloader? If most of the developers are only doing
target, user-space, application development then all they need is an
appropriate SDK (which only needs to be generated whenever any target
packages change). This means a huge build only needs to be done once,
and then everyone can use the results. In this scenario a
network-shared sstate can still be employed for further build-time
savings.

