Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15002.1793375785040847202
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Oct 2026 08:56:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=HZu1cFew;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1B6821A13CA
	for <bitbake-devel@lists.openembedded.org>; Fri, 30 Oct 2026 15:56:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D383B603C2;
	Fri, 30 Oct 2026 15:56:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D325103290DC;
	Fri, 30 Oct 2026 16:56:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793375782; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0C84hgy4848vMf83OUY1L7Yc+QnX0Gd8+5+4kxKzc/k=;
	b=HZu1cFewuzu52Ad7OHGTMVsZPR5p5AMe7ZrFGsEtJsMoimcRGOJfYGHjRtyp1R9+Y436wX
	wjC3pF6CLenrwxl97+Eo0veoIRuav4oFoSp87A8h/3lkpSWlS/Pv4x4IellyUHfTz1cd4p
	ANUBvkrPi833WNaniXnVNyI2y0xIR1opixpy/cSwO5csxHEtBlUg+jww5eiYnMSWMh4iJT
	3y4FHr2Rm0y8GaWgs8Mo7ngDJMbNxyNulWQ6sxlXtiAyOJF7dYSgpiUY6eQXdram7fcISS
	aMr0cJkTha9wDMh25y4XZTw404Yti7Du0Uo5Mx/emXhiA4O07lYJTZfZlCF88A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 16:56:21 +0100
Message-Id: <DMIANO837A8R.PC0CY8WUO45E@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH RFC 2/3] build: Attach a log catcher to
 tasks and save their records
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
 <20261024-mathieu-debug-replay-v4-v1-2-3f7f52a3b8e6@bootlin.com>
 <1f4c6cf178dd2b78c6e970c5f46817da8838e13b.camel@linuxfoundation.org>
In-Reply-To: <1f4c6cf178dd2b78c6e970c5f46817da8838e13b.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 30 Oct 2026 15:56:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20387

On Sun Oct 25, 2026 at 3:15 PM CET, Richard Purdie wrote:
> On Sat, 2026-10-24 at 14:33 +0200, Mathieu Dubois-Briand via lists.openem=
bedded.org wrote:
>> Every task gets a LogCatcher which records its warnings and errors durin=
g
>> execution. Right after the task body, and before the postfuncs, the
>> records are written to ${T}/logrecords.<task>.json. The sstate packaging
>> postfunc reads the current task's file to bundle the messages for replay
>> when the task is later restored from the sstate cache.
>>=20
>> Writing the file before the postfuncs makes both the current task's own
>> record and the files of already finished dependency tasks readable from
>> the same place.
>>=20
>> AI-Generated: Uses opencode (DeepSeek V4 Flash)
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---

...

>> @@ -711,6 +720,9 @@ def _exec_task(fn, task, d, quieterr):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 for func in (prefuncs or '').split():
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exec_func(func, localdata)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 exec_func(task, localdata)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if t=
asklogcatcher.records:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 with open(logrecords, 'w') as f:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 json.dump(tasklogcatcher.reco=
rds, f)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 for func in (postfuncs or '').split():
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exec_func(func, localdata)
>
> I was going to ask if this should unconditionally rewrite the file even
> if there are no records, else messages might persist if you fix
> warnings output for example? I then see you delete the file above.
>
> If there is no log output, I guess the question is whether we should
> write an empty file or not...
>

I had no strong opinion here, but based on your comment, I feel like we
should indeed write an empty file when there is no log.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

