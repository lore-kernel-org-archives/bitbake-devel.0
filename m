Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27807.1794835974148286330
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Nov 2026 05:32:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LNHVjqFf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so10798785e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Nov 2026 05:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794835972; x=1795440772; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p4OntRONRFo5KcbRoj02rKdNYlewyZuGYDXHpiqlAvg=;
        b=LNHVjqFfKJAa++ksuiD1rHgg9B5ukDgK5eYoC9OoDvrqFBjz3EYyofIN4GCZvrqDqn
         TW8p9kDNR/vfCcbfjB57Mj8UNu+KdzCwuYn+UDdllbBK+pvcnOc4hDnrI3MMzMfcAIfe
         ui+ru5ZMAORv62Gua/ckhUn485eMpbjC4O8MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835972; x=1795440772;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p4OntRONRFo5KcbRoj02rKdNYlewyZuGYDXHpiqlAvg=;
        b=s7qNyNuBYAsw1lldKUvHKggYKxGrhjhUEIkAPCbHueRPfDLyEjdp0HhWoPM105/Hlo
         B8jITcH6k7Cojo1GoqypoxJJhM+6h5t60+JKlfK8mGIHNOpmf/Wb8Q4Ef8yeitWGehRJ
         xd60sqJsh9Iw1tSS+rDyghXrL1w5CdITtQ4vOyHnKBqP9Sy4cOt4jhf96Zhvfn+KiodT
         IqB3l1Ezbnlwi/E6QxotZUfz+EfDpUEzPeJND/zFByXcy5B6QiEZjc9R3vjM7ypHeyfz
         Ag1a9S7YXfYK9CGS/p8ZT9i69EQjqJsgvsHaB7FuqQWqw1eaMNiw5hfbrM8WEOzxok+H
         H4DA==
X-Forwarded-Encrypted: i=1; AL+hErFfj7ZhI36usBn3nORQ0/G3L5PWFMvgCrPP3KAvMmHqJIax0apCg2QWPJwBiygK9oE64ZNwlEQv9GVIC1Dh@lists.openembedded.org
X-Gm-Message-State: APuU4Z9BK6VCOAbbLQ1bUXLUiLTc1M/nT/CIHB0wsz1LQZRKtM2EPaqm
	UM6Ew4ON9sEzlSajYKHgDbSAxle8tFRAfMXNyVQSNfSMThFEH0sO1m7NdeIlYpyGujY=
X-Gm-Gg: AYBFou2sQW75dvTsxNgq6KvFagMZlJa5FdY1BVIQS2mvgeF4E2459z2ond/W1n/rDvO
	QVl+6kOXDgzPKM5nDNx6MXdUpASHr9CsqFwoek4u8s/jwYUrSj1ftkSRm9oVm2AhicEWKvOYqMC
	xUGD0tYCaB37uGPb3ruZ6kOhLn/TfTpCUg3YeqqnP6XDGyvuXw8WTZkpS+LKAqON4vvkpGcuIXA
	s/Qm59oSNFFnuhQSN9r1RTTPS9MIgdV1DQMrCohWtlIh28TjV7feSLMnoy33bC9K2mxuLb6L/9W
	j92COw5Nlouqhtiq/HUTN6J6ZdpNSPaDOkhtPKbss4ZMjZ5jojjBy4lKkiwlckyCWVf1KLlQ2sd
	Uz6fGG3PwPxtKIFlqmzcQJgKWIJNT4gpgVEF8Z2VeyQBHyKM1wd3AJSRZlJHbhVgcfVrHEGfkj1
	qUrhoQtE3fCObHEbmiPIGc94runK4WmlHkGwpd8aNvcG9ae04wUu1CvCpuS13qLc407apW8THXe
	gDAIbo+yCsmRZK9c+zm3giPJblfjvItsYf1BPBFu5HVcn5vXvd+Q6eEY2ZY6smsaJiSbjEWn95Z
	55LbsBvgif94+YO96dxLA7XZ/8NPsslZ52la60N5uVsBjc+N7ZjBZOyldaktn7TU+J6Xvt6Uzhe
	fc6uQpVHCtVnV
X-Received: by 2002:a05:600c:638e:b0:4bb:5bf3:8ee9 with SMTP id 5b1f17b1804b1-4bb5bf390e3mr197202585e9.31.1794835972165;
        Mon, 16 Nov 2026 05:32:52 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:e765:5fb4:66be:d7? ([2001:8b0:aba:5f3c:e765:5fb4:66be:d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb679b7e1asm285762225e9.6.2026.11.16.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:32:51 -0800 (PST)
Message-ID: <c2030ad5623676d77adb9af2670235d134b6fede.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Don't defer setscene tasks
 behind already completed tasks
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mark.hatle@amd.com, bitbake-devel@lists.openembedded.org
Date: Mon, 16 Nov 2026 13:32:50 +0000
In-Reply-To: <20261115220956.758312-1-mark.hatle@amd.com>
References: <20261115220956.758312-1-mark.hatle@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 16 Nov 2026 13:32:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20439

On Sun, 2026-11-15 at 15:09 -0700, Mark Hatle via bitbake-devel wrote:
> When a task completes, the first setscene task deferred against it is
> released and any others are re-deferred behind that task. If the released
> task had already completed (e.g. its setscene was skipped due to a valid
> stamp), it never completes again, so the re-deferred tasks are never
> released. Setscene then can't finish until the deadlock fallback forces
> each one, printing "Runqueue deadlocked on deferred tasks".
>=20
> This shows up with three or more multiconfigs sharing a task hash. Skip
> already completed tasks when picking the new blocker.
>=20
> AI-Generated: Uses GitHub Copilot
> Signed-off-by: Mark Hatle <mark.hatle@amd.com>
> ---
> =C2=A0lib/bb/runqueue.py | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index ef95eb46b..2a6b099b8 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -2112,6 +2112,10 @@ class RunQueueExecute:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.debug(1, "Deferred task=
 %s now buildable" % t)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 del self.sq_deferred[t]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_scenequeue_data([t]=
, self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, su=
mmary=3DFalse)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # A task which already completed=
 will never complete again so must
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # not become the new blocker, el=
se the remaining tasks never get released
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if t in self.runq_complete:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found =3D t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.debug(1, "Deferring %s =
after %s" % (t, found))

This doesn't look quite right to me.

If you do that, you need to also then follow through and handle
anything that has a dependency on t.

Also, the code above this is the only codepath where
self.runq_complete.add(task) is called. For something to be in
runq_complete, this function has to have been called for t, so that
deferral should have already been handled too.

I have a different suspicion. I think the loop ordering is subtly
wrong, which is leading to the deadlocking.

We need to process deferred tasks in multilib order. The main code
already does this but this section just has a sorted() call. I think it
may need to be:

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 63615ac6c..b098ac170 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2109,7 +2109,10 @@ class RunQueueExecute:
                 logger.debug("Marking task %s as buildable", revdep)
=20
         found =3D None
-        for t in sorted(self.sq_deferred.copy()):
+        for mc in sorted(self.sqdata.multiconfigs):
+          for t in sorted(self.sq_deferred.copy()):
+            if mc_from_tid(t) !=3D mc:
+                continue
             if self.sq_deferred[t] =3D=3D task:
                 # Allow the next deferred task to run. Any other deferred =
tasks should be deferred after that task.
                 # We shouldn't allow all to run at once as it is prone to =
races.

which then matches the other code. We probably need a small helper
function to give that sorting. (yes, I know the indentation needs
fixing, I left it like this for clarity on what the change is).

Can you see if that helps please?

Thanks,

Richard


