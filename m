Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14953.1793375670269662285
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Oct 2026 08:54:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=hsFUvS4r;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E111E4E4139F;
	Fri, 30 Oct 2026 15:54:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A5B92603C2;
	Fri, 30 Oct 2026 15:54:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3FDE110329050;
	Fri, 30 Oct 2026 16:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793375663; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tULvj7FXF7HEtbCEWHBjEyhCIX5Lg9EVWT7pTOzrZUs=;
	b=hsFUvS4rwssdpDkg4IAb0TkCOD+3RXZ0uuYnAEPDscw2kYES44QCIhzT7SIUiQj/g2pa8T
	CTJk0hK2+QZ5yEoACzoC2ImKm86tKNC6qphisKE3nXYYq7FqjXE9jslZFgdd5yhu52NAS3
	mX2yUg7Bua/iHgRrGhHaAyIpN8TNmTVonngydPGzH/ACZNEQT/7gHPn5RtFFdzqKkZgJQs
	NJ3PiDVOhXLAExhKqGKJNUCkVhBJxOsuga5Lmdi99jmelkn5awpJset5yT4XJl+7kmD3UZ
	szIAePVMQoZVzY4WcZHkWzJh1fATC6gOjn1cmPZPnNZVOlKVsZs5MI4IfnCwVA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 16:54:21 +0100
Message-Id: <DMIAM5878KKF.2UFLZ25JCPACZ@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Richard Purdie" <rpurdie@rpsys.net>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH RFC 3/3] runqueue: Hand each covered
 task's log to a single setscene task
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
 <20261024-mathieu-debug-replay-v4-v1-3-3f7f52a3b8e6@bootlin.com>
 <dbd7b348c19f311707890f325bf643d3b9b33cee.camel@rpsys.net>
In-Reply-To: <dbd7b348c19f311707890f325bf643d3b9b33cee.camel@rpsys.net>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 30 Oct 2026 15:54:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20386

On Sun Oct 25, 2026 at 3:20 PM CET, Richard Purdie wrote:
> On Sat, 2026-10-24 at 14:33 +0200, Mathieu Dubois-Briand via lists.openem=
bedded.org wrote:
>> When a setscene task starts, hand it the covered tasks of the same recip=
e
>> which were not yet handed to another setscene task, and pass their names
>> to the task through BB_SETSCENE_REPLAY_TASKS. Several setscene tasks can
>> cover the same task (e.g. do_populate_sysroot and do_package both cover
>> do_compile), so this lets metadata replay the log of each covered task
>> exactly once when restoring it from the sstate cache.
>>=20
>> AI-Generated: Uses opencode (DeepSeek V4 Flash)
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>> =C2=A0bin/bitbake-worker | 1 +
>> =C2=A0lib/bb/runqueue.py | 9 +++++++++
>> =C2=A02 files changed, 10 insertions(+)
>
> This is a very specific piece of API, specifically tailored to what
> this particular task entails.
>

Just to make sure I fully understand this: I should rather try to rely
more on existing API or introduce something a bit more generic. Is that
right?

> I'm a bit worried that it still doesn't cover everything it should, for
> example a warning from another recipe that is only covered by a given
> sstate task and nothing else.

Indeed. Knowing we have to replay these logs should be easy, but
accessing these logs in the first place might be a bit tricky. I will
have to experiment a bit and understand what is possible.

>
> You can pobably calculate it from BB_TASKDEPDATA already too, if you
> know which tasks are sstate, which I think we know.
>
> There is also the potential for multiple log output from these covered
> tasks, e.g. do_package and do_populate_sysroot both 'cover' on
> do_install so a warning from do_install will be shown by both tasks at
> setscene time.
>

This should not happen with the current code. But I will have to be
careful when covering tasks from another recipe.

In your example, only one of the two tasks should be assigned with the
logs of do_install, either do_package or do_populate_sysroot, but not
both. This is the point of the sq_replay_assigned set here.

Also, it should be covered by my tests on the oe-core side.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

