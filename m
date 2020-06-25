Received: from mail.cvg.de (mail.cvg.de [193.158.56.148])
 by mx.groups.io with SMTP id smtpd.web10.12503.1593097091015190207
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2020 07:58:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=EAF/se0m;
 spf=pass (domain: sigma-chemnitz.de, ip: 193.158.56.148, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-0.intern.sigma-chemnitz.de (mail-mta-0.intern.sigma-chemnitz.de [192.168.12.76])
	by mailout-1.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id 05PEw7lA030244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2020 16:58:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1593097088;
	bh=Pbuc8ReL/jqISfd2C5l5soiAiZy/ijyP8ZnyHiW+v+4=; l=888;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=EAF/se0mPEdY0xFcvj7o8oGqrr3rrec5iXUY8+uHhXxGTYRUCZrh1MJ+O5xv8hgun
	 pyp7eMDsU0CoLVXUM1WplwCXycL4g4pLfC6Wcr/+WNVAzAFR4D3L1gbEuBytQKChcF
	 tfp/TQUyspmyZXbw+fpNORpFx1HOTTKVufufQoCg=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.intern.sigma-chemnitz.de [192.168.0.193])
	by mail-mta-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id 05PEw3aO023894
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Thu, 25 Jun 2020 16:58:04 +0200
Received: from mail-msa-0.intern.sigma-chemnitz.de ( [192.168.12.77]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 18AD05BFFBA; Thu, 25 Jun 2020 16:58:03 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id 05PEw3GY023891
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 25 Jun 2020 16:58:03 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.93)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1joTKE-00Asjg-L8; Thu, 25 Jun 2020 16:58:02 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: Paul Barker <pbarker@konsulko.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Support for git+https://foo.example.com like URIs
References: <lyh7uzxnvx.fsf@ensc-virt.intern.sigma-chemnitz.de>
	<CAM9ZRVuqYrSW5-WLsUnZG4ok=qSc82BkrZgSC=ToGgDoBLXpBg@mail.gmail.com>
Date: Thu, 25 Jun 2020 16:58:02 +0200
In-Reply-To: <CAM9ZRVuqYrSW5-WLsUnZG4ok=qSc82BkrZgSC=ToGgDoBLXpBg@mail.gmail.com>
	(Paul Barker's message of "Thu, 25 Jun 2020 15:44:05 +0100")
Message-ID: <lyd05nxked.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

Paul Barker <pbarker@konsulko.com> writes:

> I'd implement this in an inverse way, add a new class for your
> projects, eg. my-project.bbclass:
>
>     MY_REPO_NAME ?= "${BPN}"
>     SRC_URI =
>     "git://foo.example.com/project/${MY_REPO_NAME};protocol=https"

yes; we did such a thing a other projects too and it is difficulty to
handle:

- beside name, you have to add ';branch=...' information somewhere too
  -> either add yet another variable, or add this to MY_REPO_NAME

- it breaks common SRC_URI usage; now you have to do the inherit thing
  and then 'SRC_URI += "..."'

- it is not universal; for every repository source you have to write
  such a class and/or add yet another variable.

A 'git+ssh://' like syntax is common and allows a usual workflow (just
add it to $SRC_URI) and does require introduction of dozens of extra
variables and/or classes.


Enrico
