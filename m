Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC515C77B7C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 14:07:36 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.23627.1751551645182819918
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jul 2025 07:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jwlUSs58;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b60de463so6452565e87.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751551643; x=1752156443; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTBaQvExxf2JDUPXJW5hbJRdpnHD0ZCX886d2CnR1NE=;
        b=jwlUSs58ZLdjz3QXO4NI1TvAfpk0EOQE6cNHITY6oFLM4LLvC/sUZz7+n6FxP/mxAK
         vIf8oTnAlczb1ifu5PJxLLfBhWLdT5V33AXTNEc9wQ7uMA61k4w8yKoZgMe3cwkPQH6+
         u/f3ZrZWM3pzjGhw7uDk0YNSt5g0JXh/qJHulr84wmIQX0fpf3VH9q9kE58EgmhTk5YG
         XQP9x79LkMGI93DG9IYaU+9S3BdzvtZVdE98bqHVonRL5o2DW8yxqkoz4P7G6EBpI52G
         Twa+sgWORFv+zi8mPfVrAaO4rKyonY8ZjubQlnQUQw4sMd3ZWfx5x5G5GdjNK8tRcW6M
         z/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751551643; x=1752156443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTBaQvExxf2JDUPXJW5hbJRdpnHD0ZCX886d2CnR1NE=;
        b=B6PgQ1gHxUeZRNX7pJ3UPJ+LMvAlIaEqvf8OCxpA72v8qGI20fkBxIqUbfoB2JI/vh
         x/neAQOaSpbeFXrpoIMBOJR5OFehn0DUZlpcxGx98UWdfxigtPp2h0Mv1j/d7F8KlrrV
         rh6YlXDn5YjYCwJPipI7jqoiChIGki8yuW3DghZhd1ljW9w97GnVmZ31bWHIp66mwk+L
         k642Qt15F54C3xcX5CGOtimQSVd2zrQo2WR0z8dD7iy8QR5T6QYGoJM5TdKlU9oIBIcn
         PZm8C30KE8U51ZszJ+YeH9d/rX74EA7Lbnw9rWZXrOqNQZb7JL3K6gTGCfX8Icx8RU8u
         cxwA==
X-Gm-Message-State: AOJu0Ywx3sJdUjbyZy5wLhca0gNmdRktUW7p1vWEm1f+5s4bwvDk8HZH
	WWFs2nBE+ors0MoMobsHwGQbYbWqZKhbVdCH020HbzZb3gALmxkXPgiIvFgHaDNHYbJuhCAGp50
	j7WOxbJGFBLlO+hsHKhv3zDIv7DD1cgY=
X-Gm-Gg: ASbGnctaIS5IjAZvhFJy0MYpH3GKI8VE4UdxW4/1nulLNt2evnuMSC64wgcbCKTtonS
	0N1mlo8MVp9akkMEn9uF1L5cW3KsW5r/E6epEeKqjBJ7IYmREjP5/MMNID+xaTXHe7oBc6KlqUK
	3EMN7W/RPMalNIKyeUUvBAbVbWxBnw0veT8af2DuB0VVdmkhxNNhqJAceshw==
X-Google-Smtp-Source: AGHT+IGmOYQzn4ZokKxp0j4GRBmhU12HWw18Yn8UELirSJkNNn3JIuqnEXrAjyE8oI2wIpVDCr9PqzLCAgii7LaVU78=
X-Received: by 2002:a05:6512:15a7:b0:553:241d:4e77 with SMTP id
 2adb3069b0e04-5562ee4f22amr1256685e87.22.1751551641267; Thu, 03 Jul 2025
 07:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250702222437.3733042-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250702222437.3733042-1-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 3 Jul 2025 08:07:07 -0600
X-Gm-Features: Ac12FXw8cQlvGILZR5iqIAdfMXj4kMtkRnFKwOsNgaQtzd05rlexPZHQFr7VNCA
Message-ID: <CAJdd5GY+t-1+g_XgCCy4eEGF7_1z5tAB767TmnwaqPE2xhreWA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] cooker: Try and avoid parseing hangs
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 14:07:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17742

LGTM

Reviewed-by: Joshua Watt <JPEWhacker@gmail.com>

On Wed, Jul 2, 2025 at 4:24=E2=80=AFPM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> We sometimes see hangs in parsing during automated testing. It appears th=
at
> SIGINT was sent to the underlying processes which see KeyboardInterrupt b=
ut
> they're stuck trying to write into the results pipe. The SIGINT was proba=
bly
> from some kind of parsing failure which doens't happen often, hence the h=
ang
> being rare (in the incompatible license selftests from OE).
>
> This patch:
>   * sets a flag to indicate exit upon SIGINT so the exit is more graceful
>     and a defined exit path
>   * empties the results queue after we send the quit event
>   * empties the results queue after the SIGINT for good measure
>   * increases the 0.5s timeout to 2s since we now have some very slow to
>     parse recipes due to class extensions (ptests)
>
> This should hopefully make the parsing failure codepaths more robust.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 1810bcc6049..91e3ee025ea 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -2009,6 +2009,7 @@ class Parser(multiprocessing.Process):
>          self.queue_signals =3D False
>          self.signal_received =3D []
>          self.signal_threadlock =3D threading.Lock()
> +        self.exit =3D False
>
>      def catch_sig(self, signum, frame):
>          if self.queue_signals:
> @@ -2021,7 +2022,7 @@ class Parser(multiprocessing.Process):
>              signal.signal(signal.SIGTERM, signal.SIG_DFL)
>              os.kill(os.getpid(), signal.SIGTERM)
>          elif signum =3D=3D signal.SIGINT:
> -            signal.default_int_handler(signum, frame)
> +            self.exit =3D True
>
>      def run(self):
>
> @@ -2059,7 +2060,7 @@ class Parser(multiprocessing.Process):
>          pending =3D []
>          havejobs =3D True
>          try:
> -            while havejobs or pending:
> +            while (havejobs or pending) and not self.exit:
>                  if self.quit.is_set():
>                      break
>
> @@ -2196,11 +2197,12 @@ class CookerParser(object):
>
>          # Cleanup the queue before call process.join(), otherwise there =
might be
>          # deadlocks.
> -        while True:
> -            try:
> -               self.result_queue.get(timeout=3D0.25)
> -            except queue.Empty:
> -                break
> +        def read_results():
> +            while True:
> +                try:
> +                   self.result_queue.get(timeout=3D0.25)
> +                except queue.Empty:
> +                    break
>
>          def sync_caches():
>              for c in self.bb_caches.values():
> @@ -2212,15 +2214,19 @@ class CookerParser(object):
>
>          self.parser_quit.set()
>
> +        read_results()
> +
>          for process in self.processes:
> -            process.join(0.5)
> +            process.join(2)
>
>          for process in self.processes:
>              if process.exitcode is None:
>                  os.kill(process.pid, signal.SIGINT)
>
> +        read_results()
> +
>          for process in self.processes:
> -            process.join(0.5)
> +            process.join(2)
>
>          for process in self.processes:
>              if process.exitcode is None:
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17737): https://lists.openembedded.org/g/bitbake-deve=
l/message/17737
> Mute This Topic: https://lists.openembedded.org/mt/113957082/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

