Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23841.1792937762620791648
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Oct 2026 07:16:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LQN8YO0S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a214af2076so14886395e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 25 Oct 2026 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792937761; x=1793542561; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XmeqQ0M978UthdmXNFnDSz6hU2VB8biA2GccqCmj8S8=;
        b=LQN8YO0SsAvopnI0rPiO4m4Y/JYpWKD+rT/LMJiEKDT3+QqKC6SQ4x4exL/iWRcN9c
         CojUeUJdLoWlyxHHC5XmHcvLAwjTHyaRGvLAMas4BBH9AZFclJDtBYVpJofHBm82HbD7
         zwj3mXZnDgA1vIpJuEWd/kz2EKDOtNsS7lSyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792937761; x=1793542561;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XmeqQ0M978UthdmXNFnDSz6hU2VB8biA2GccqCmj8S8=;
        b=KrEVROJ52Z3jZdI9/yuvaXGxxiZ2a6UW+/txk8nBRSpzvyvkG8R2CM0bOYjfxZZiKX
         EYsoMSK12dXwcT5QhUKc4+yZkIDJ3gLnKfIKp4xgPfFCp/VvOcBPk6h8fdOE3GE1rOI9
         bZsdzOgH1YlRaQpTNn1FNZl/qxXCw/saKf4D/2SwCR5+XHSfc1GwgrT+rMy2nye3o4nO
         HOyBmBukH34/dBc0j08027oaUaqJW2F1QCjwtQ7KCN/3BDIAXQx+vmEJr05CZwPfz4vP
         fbL9vKDt+IS/GNPbDY7CsRbCEQ7AHooY7uy2x6xmvNlfhMtawDc1lFax7ZZIq8pPYS10
         cwng==
X-Forwarded-Encrypted: i=1; AKwUvByyBM5ijjHZ4pvpwHMsW62xko234gcVsM2xvd3vnTDqw/MkuPteT/vEWF0b4rFWVTpZpoNQ1/9hd3DYe3E8@lists.openembedded.org
X-Gm-Message-State: AFq9FYKfgOZ9JzI7/lhe11SPGaZ5FzEXUOPPjvt2TrF1vmxLQOJtOSsF
	GqAAjqYEoeIy8aLtPd2Lurd3TGWTe+SZBmdWGfjopLub8lDHvVkj0rO2BTnbpr4j1uc=
X-Gm-Gg: AYBFou3/lAGBO8+BYB+Z+Qqz3KGpcrlUnGd0fEUF42cDj/9WSKWYF1ev+mYlIA3uwjz
	vodUvkoczA0IitoX5STPuiFQJtLjPoAGw9DNkNvTydJi7oH6c3uRS/nTJiiOKTmnl34/14cRDHB
	i1g80OIYlCg8kMDvr5wJa4qMoQh8k9ulb217etsiHUFQVgLbxXxGh4KsDamYXbY4y4LoTYBLbZ1
	k22fM4F0730XuWTaudRKyGc95jUBuz9UlA4vOn6PaxHlglPuv1CZXfUXDXSOEPGEhlRhxlueiST
	SEmgZ4LCrLhszKEmMnVFdA4bjBGFXfEH6BJvfcaF7w5yGsRMx3efTpB59SZooNpBtywK25uYj6l
	H842g72JLApeiUOn4Z21qpqTIzjmuHD+Pr1/1diqxwv4Hh3ZXeX40W6pkvhJGqqY5bE1hXJqN/w
	mYI0bFSISKdVT3LNrlxg7kzzIjK5dYR9rtEjXgyW8GKly+NZyzdeTfytTSlI1mGJWIKU+R6Y10n
	KWJtOuoroDS4l0sDS0l7s1bMQ5DLd9Kp+xh9Nv1xBlHXOau3mu392Z6KMnzn+VLW2ukBenxa7eK
	YZ/JfUuufkNdlQMOa5kzfhPR9uKs+cY8zHR7f9Pkfc2mHUe20zx+OlrsNjS48bQfcI8=
X-Received: by 2002:a05:600c:6219:b0:4a1:f03f:f1f8 with SMTP id 5b1f17b1804b1-4a35ac3b0edmr63133245e9.3.1792937760705;
        Sun, 25 Oct 2026 07:16:00 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:9150:7788:2374:b5de? ([2001:8b0:aba:5f3c:9150:7788:2374:b5de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f4f20dsm90601585e9.0.2026.10.25.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:15:59 -0700 (PDT)
Message-ID: <1f4c6cf178dd2b78c6e970c5f46817da8838e13b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH RFC 2/3] build: Attach a log catcher to
 tasks and save their records
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mathieu.dubois-briand@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Sun, 25 Oct 2026 14:15:58 +0000
In-Reply-To: <20261024-mathieu-debug-replay-v4-v1-2-3f7f52a3b8e6@bootlin.com>
References: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
	 <20261024-mathieu-debug-replay-v4-v1-2-3f7f52a3b8e6@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sun, 25 Oct 2026 14:16:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20377

On Sat, 2026-10-24 at 14:33 +0200, Mathieu Dubois-Briand via lists.openembe=
dded.org wrote:
> Every task gets a LogCatcher which records its warnings and errors during
> execution. Right after the task body, and before the postfuncs, the
> records are written to ${T}/logrecords.<task>.json. The sstate packaging
> postfunc reads the current task's file to bundle the messages for replay
> when the task is later restored from the sstate cache.
>=20
> Writing the file before the postfuncs makes both the current task's own
> record and the files of already finished dependency tasks readable from
> the same place.
>=20
> AI-Generated: Uses opencode (DeepSeek V4 Flash)
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
> =C2=A0lib/bb/build.py | 13 +++++++++++++
> =C2=A01 file changed, 13 insertions(+)
>=20
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 8b49721d60f8..033e5b1c3f30 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -21,6 +21,7 @@ import time
> =C2=A0import re
> =C2=A0import stat
> =C2=A0import datetime
> +import json
> =C2=A0import bb
> =C2=A0import bb.msg
> =C2=A0import bb.process
> @@ -656,6 +657,11 @@ def _exec_task(fn, task, d, quieterr):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except OSError:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 # Task log records, for sstate log replay. Written ri=
ght after the task
> +=C2=A0=C2=A0=C2=A0 # body, before the postfuncs, so the sstate packaging=
 postfunc can read them.
> +=C2=A0=C2=A0=C2=A0 logrecords =3D os.path.join(tempdir, 'logrecords.{0}.=
json'.format(task))
> +=C2=A0=C2=A0=C2=A0 bb.utils.remove(logrecords)
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 prefuncs =3D localdata.getVarFlag(task, 'prefunc=
s', expand=3DTrue)
> =C2=A0=C2=A0=C2=A0=C2=A0 postfuncs =3D localdata.getVarFlag(task, 'postfu=
ncs', expand=3DTrue)
> =C2=A0
> @@ -698,6 +704,9 @@ def _exec_task(fn, task, d, quieterr):
> =C2=A0=C2=A0=C2=A0=C2=A0 errchk =3D ErrorCheckHandler()
> =C2=A0=C2=A0=C2=A0=C2=A0 bblogger.addHandler(errchk)
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 tasklogcatcher =3D bb.utils.LogCatcher()
> +=C2=A0=C2=A0=C2=A0 bblogger.addHandler(tasklogcatcher)
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 localdata.setVar('BB_LOGFILE', logfn)
> =C2=A0=C2=A0=C2=A0=C2=A0 localdata.setVar('BB_RUNTASK', task)
> =C2=A0=C2=A0=C2=A0=C2=A0 localdata.setVar('BB_TASK_LOGGER', bblogger)
> @@ -711,6 +720,9 @@ def _exec_task(fn, task, d, quieterr):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
for func in (prefuncs or '').split():
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exec_func(func, localdata)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
exec_func(task, localdata)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ta=
sklogcatcher.records:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 with open(logrecords, 'w') as f:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 json.dump(tasklogcatcher.records=
, f)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
for func in (postfuncs or '').split():
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exec_func(func, localdata)

I was going to ask if this should unconditionally rewrite the file even
if there are no records, else messages might persist if you fix
warnings output for example? I then see you delete the file above.

If there is no log output, I guess the question is whether we should
write an empty file or not...

Cheers,

Richard
