Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BEAC4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 17:23:25 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.13542.1705080203589636853
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 09:23:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gZLaL+M7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3373a30af67so5777360f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 09:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705080202; x=1705685002; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sk3MD0v2qITJowSYOb2X9E9qFWeTU7GRxd84RejbN4U=;
        b=gZLaL+M7C3OzVfPEjQ2UOeABilc/6ChlpWS4ioR6DueRQ5lTY3raQqFkM875u2mAJS
         hbpkKZcuNqfwPBU1ZBY5SopQ2Exppr+FUWgYZEoHqAXLaSJzLQjWWQVsClL2vWPmZtD8
         VdlnsL+5agcMYt7TdBODTxJplwl7Wbmys7zH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705080202; x=1705685002;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sk3MD0v2qITJowSYOb2X9E9qFWeTU7GRxd84RejbN4U=;
        b=Ne3oX2Q94wMai4r7v5B5lfdnjLuF5O2T70EHil7F79Z+EdaUg/QB5zBHtJU7vEWtR+
         rjWnNnavXRcpEn7G/Pt5C/7D31bdoVmH65UPFzUH4lFSe9Nk3+Rk08FdjJzRjAsCMpDA
         PizbDf44HfDMllGdOytWioSRAwOxuC+S0X1P5LRutm2syddYqnd5zzMJBOrKeytFdAIJ
         UvZ5WehxHNlYyDYWxU1Z39Ybg15pduVq1jWs87V9cOMQ0YXdY8NbJ32HU27hVHn1tkY2
         qNrkRUiKZ2gBTpKjC22rMiMIkpMG0/h8VqciBTOkv9eub8mvVXQ9CSNkD02JGUg5GIjN
         +diw==
X-Gm-Message-State: AOJu0YzZCiUxHoHg6PB0FhTcnpT/0S2kULw5GHA55v7D6UdBsrfkjgks
	JIILisG4aQgZUGucnGGLzu/70/pelcV0yg==
X-Google-Smtp-Source: AGHT+IEw6SJZVlzYNr+w3+4n5pRdkQHQv4lryDGQL1SjAlZgH3lRfYzA13wXwmbYNDP/Ick4EC652A==
X-Received: by 2002:a5d:6250:0:b0:337:6805:6d19 with SMTP id m16-20020a5d6250000000b0033768056d19mr761914wrv.32.1705080201977;
        Fri, 12 Jan 2024 09:23:21 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:54d1:179:7c44:2de? ([2001:8b0:aba:5f3c:54d1:179:7c44:2de])
        by smtp.gmail.com with ESMTPSA id d15-20020adf9c8f000000b00336c43b366fsm4455702wre.12.2024.01.12.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 09:23:21 -0800 (PST)
Message-ID: <ff0dc8f8d2d4fd86e8d9483004ee02191aa94d64.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Got "ValueError: filedescriptor out of range in
 select" on bitbake v1.46.0
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: roro.cui@broadcom.com, bitbake-devel@lists.openembedded.org
Date: Fri, 12 Jan 2024 17:23:20 +0000
In-Reply-To: <CAHBa6FM=C=yZYEVY8yp_j8rXkZ2Fq=n-4b78N2uiFS7=6rgpOw@mail.gmail.com>
References: 
	<CAHBa6FM=C=yZYEVY8yp_j8rXkZ2Fq=n-4b78N2uiFS7=6rgpOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 17:23:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15790

On Fri, 2024-01-12 at 11:40 -0500, Roro Cui via lists.openembedded.org wrot=
e:
> hi, Dear Sir or Madam
>=20
> I hit this issue when building the target in yocto dunfell on our new ser=
ver(512 cpu cores)
> The cooker daemon=C2=A0process quits abnormally. Here is the output
>=20
> Command Completed
> Running command ['getVariable', 'BBINCLUDELOGS']
> Command Completed
> Running command ['getVariable', 'BBINCLUDELOGS_LINES']
> Command Completed
> Running command ['getSetVariable', 'BB_CONSOLELOG']
> Command Completed
> Running command ['getSetVariable', 'BB_LOGCONFIG']
> Command Completed
> Running command ['getUIHandlerNum']
> Command Completed
> Running command ['setEventMask', 1, 20, {'BitBake.RunQueue.HashEquiv': 19=
, 'BitBake.SigGen.HashEquiv': 19}, ['bb.runqueue.runQueueExitWait', 'bb.eve=
nt.LogExecTTY', 'logging.LogRecord', 'bb.build.TaskFailed', 'bb.build.TaskB=
ase', 'bb.event.ParseStarted', 'bb.event.ParseProgress', 'bb.event.ParseCom=
pleted', 'bb.event.CacheLoadStarted', 'bb.event.CacheLoadProgress', 'bb.eve=
nt.CacheLoadCompleted', 'bb.command.CommandFailed', 'bb.command.CommandExit=
', 'bb.command.CommandCompleted', 'bb.cooker.CookerExit', 'bb.event.Multipl=
eProviders', 'bb.event.NoProvider', 'bb.runqueue.sceneQueueTaskStarted', 'b=
b.runqueue.runQueueTaskStarted', 'bb.runqueue.runQueueTaskFailed', 'bb.runq=
ueue.sceneQueueTaskFailed', 'bb.event.BuildBase', 'bb.build.TaskStarted', '=
bb.build.TaskSucceeded', 'bb.build.TaskFailedSilent', 'bb.build.TaskProgres=
s', 'bb.event.ProcessStarted', 'bb.event.ProcessProgress', 'bb.event.Proces=
sFinished']]
> Command Completed
> Running command ['setConfig', 'cmd', 'fetch']
> Command Completed
> Running command ['buildTargets', ['quilt-native'], 'fetch']
> Command Completed
> Process ProcessServer-1:
> Traceback (most recent call last):
> =C2=A0 File "/usr/lib/python3.8/multiprocessing/process.py", line 315, in=
 _bootstrap
> =C2=A0 =C2=A0 self.run()
> =C2=A0 File "/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/=
bitbake/lib/bb/server/process.py", line 115, in run
> =C2=A0 =C2=A0 ret =3D self.main()
> =C2=A0 File "/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/=
bitbake/lib/bb/server/process.py", line 232, in main
> =C2=A0 =C2=A0 ready =3D self.idle_commands(.1, fds)
> =C2=A0 File "/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/=
bitbake/lib/bb/server/process.py", line 334, in idle_commands
> =C2=A0 =C2=A0 return select.select(fds,[],[],nextsleep)[0]
> ValueError: filedescriptor out of range in select()
> Var <PATH[:=3D]>:1: SyntaxWarning: "is not" with a literal. Did you mean =
"!=3D"?
>=20
> Is this a known issue?=C2=A0

It isn't an issue we've been tracking, no. It sounds like your 512 core
machine has probably run more tasks that bitbake can manage correctly.
Try lower values of BB_NUMBER_THREADS and BB_NUMBER_PARSE_THREADS?

You could also open a bug in bugzilla. There are probably ways to
improve the code to avoid select() calls but those will be invasive.

Cheers,

Richard

