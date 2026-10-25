Received: from tim.rpsys.net (tim.rpsys.net [217.169.23.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23656.1792938051259156902
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Oct 2026 07:20:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rpsys.net header.s=2021 header.b=MD3iNUwy;
 spf=pass (domain: rpsys.net, ip: 217.169.23.60, mailfrom: rpurdie@rpsys.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rpsys.net; s=2021;
	t=1792938042; bh=DFyee73NRVn9hQKYJOfZtD5IGdpmdZgwtNA1wTmJYKg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MD3iNUwyexq2sA1MhopWXDH/81NGPBdEJifBeNL/PK5mSyTwVFlRpHFSh8gRXe43L
	 XOprlO7rFhLhjYbhIDqAmoq8ozx49ZN6bwUOMZki9GWe5QfhlOC9ym8ceJN/jBU70b
	 h3SvRu+ck1To1wM3aqox0QZixIeNSL95znz1nJ6V5WocR3ag2P3LL9mTP+GxATYfv6
	 PqdhpwybJvU+SoXeNCSi5qe04rQQTzkc9r/qhelCgp5Yag7rPP/Kc6efY33nnjpU4M
	 5M0hDhiUlUiL3dpL0KVJ6yFpT+j3k5gep49O5bUkcH91foe25Na2munD4FlRTv4dSP
	 W1VNyF3KuUBsw==
Received: from [192.168.1.8] (tim.rpsys.net [217.169.23.61] (may be forged))
	(authenticated bits=0)
	by tim.rpsys.net (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id 69PEKfAP108550
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 14:20:42 GMT
Message-ID: <dbd7b348c19f311707890f325bf643d3b9b33cee.camel@rpsys.net>
Subject: Re: [bitbake-devel] [PATCH RFC 3/3] runqueue: Hand each covered
 task's log to a single setscene task
From: Richard Purdie <rpurdie@rpsys.net>
To: mathieu.dubois-briand@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Sun, 25 Oct 2026 14:20:36 +0000
In-Reply-To: <20261024-mathieu-debug-replay-v4-v1-3-3f7f52a3b8e6@bootlin.com>
References: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
	 <20261024-mathieu-debug-replay-v4-v1-3-3f7f52a3b8e6@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.4.3 at tim
X-Virus-Status: Clean
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sun, 25 Oct 2026 14:20:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20378

On Sat, 2026-10-24 at 14:33 +0200, Mathieu Dubois-Briand via lists.openembe=
dded.org wrote:
> When a setscene task starts, hand it the covered tasks of the same recipe
> which were not yet handed to another setscene task, and pass their names
> to the task through BB_SETSCENE_REPLAY_TASKS. Several setscene tasks can
> cover the same task (e.g. do_populate_sysroot and do_package both cover
> do_compile), so this lets metadata replay the log of each covered task
> exactly once when restoring it from the sstate cache.
>=20
> AI-Generated: Uses opencode (DeepSeek V4 Flash)
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
> =C2=A0bin/bitbake-worker | 1 +
> =C2=A0lib/bb/runqueue.py | 9 +++++++++
> =C2=A02 files changed, 10 insertions(+)

This is a very specific piece of API, specifically tailored to what
this particular task entails.

I'm a bit worried that it still doesn't cover everything it should, for
example a warning from another recipe that is only covered by a given
sstate task and nothing else.

You can pobably calculate it from BB_TASKDEPDATA already too, if you
know which tasks are sstate, which I think we know.

There is also the potential for multiple log output from these covered
tasks, e.g. do_package and do_populate_sysroot both 'cover' on
do_install so a warning from do_install will be shown by both tasks at
setscene time.

So we should probably handle wider tasks than just the current
recipe...

Cheers,

Richard



