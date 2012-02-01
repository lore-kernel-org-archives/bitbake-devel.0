Received: from mail-lpp01m020-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1RscnX-0007D7-Hy
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 17:12:39 +0100
Received: by lbol12 with SMTP id l12so197555lbo.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Feb 2012 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=mXFyzDTq/iwF1jEfuSD1zkz4OsDDoO/Y0nA0Hj05x2Q=;
	b=HOZhAYMMQdtSiFrTHordt+4prMmmqfxV/A/VrY9S8Ae3HPn66mLr4DVSqm87KbnYrx
	4mFI4JbDC+AaQAX20HskySaEdZ7ipWCb852K7f6P3c+QSTsKI40TOHLtt1k4oZWQ6Vo/
	vgZUA0B6Q92Qm3c01pTE51JZ+TpQJ0nwonISI=
Received: by 10.112.32.1 with SMTP id e1mr7034043lbi.3.1328112284299; Wed, 01
	Feb 2012 08:04:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.152.5.201 with HTTP; Wed, 1 Feb 2012 08:04:14 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 1 Feb 2012 08:04:14 -0800
Message-ID: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.linuxtogo.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: should we switch off patchwork for oe-core and bitbake projects
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
X-List-Received-Date: Wed, 01 Feb 2012 16:12:39 -0000
Content-Type: text/plain; charset=UTF-8

Hi

patchwork instance that we have currently handles patches for
oe-devel, oe-core and bitbake
layers which use oe-devel maintain and use the patch queues ok so it
makes sense to have it
there. But patch flow for oe-core and bitbake is handled differently
via pull requests. Would it
make sense to turn it off for these two projects. Is someone using
patchwork and/or finds
it useful to have the patchwork catch those patches please let me know

-Khem


