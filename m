Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D2FC83F1A
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 15:21:19 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.1619.1752765674957939982
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Jul 2025 08:21:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CthnJBJd;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553d771435fso1250007e87.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Jul 2025 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752765673; x=1753370473; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MynX0I5YBcgmjfL0QbA68mwkUAUgNw61Sfce0tKIs1w=;
        b=CthnJBJdXGk0U74RXRIX29dfkAspk/g119YFQvWgB3a8Ker1N5WU5e3/M3qH89P0ss
         uNcG7tabSvV4n+3ikTjcqAsvPaQYk5tAvnNIZ2GkCbtRtijHHSxDUuUI2wGyZey+6IKx
         vyBpiqGUviBAUKDGsjEFru3QfM1W5LryRzXk7v82Twlr4wKtxWevLV0ULi+/7unDbGR7
         DFFmbUsBGxXhKUvrAoK2vpwDcJjs8jXFct9AhtgFkc0IMSdHeAnRRys/oiscf+pBwkml
         R5NV25dgSJSac0Mw1+sXy/ELtcYhg5LdqVmWzndRoG4KGdueB/CU38FlpV9HgNypLf5R
         z7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765673; x=1753370473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MynX0I5YBcgmjfL0QbA68mwkUAUgNw61Sfce0tKIs1w=;
        b=Law2c4nT8Msxo8RuS1KA48NAgDKAvX6HGmf03bYT1SAkGWrEX1ytUnITQfKGgYcQ20
         kS2X5jcZpxgrFxM8bDkqen6K32eV6j5gByCrbIb9Kkgf/GvwE7Ak3b+9ZxWdINAmTVZp
         Dl6WtSk/9+tCpcXlkEqo2WZfILsRrhJpMKTQmajVH93UKskq6tRTv7KZWJZBRArED/wA
         fOKXfdtwhDxdkwUJLIv09sw0CUKB9KRsTxhgl7TH5T0Df/N6ONlp6ObmaTMtR3tSgm96
         egaytiA236+asDNZDsMBM3l8XpqFQxCXBN8r7VXOa0Jzg2xRj89cSLTkbVuyG4qKT3C2
         7v1A==
X-Gm-Message-State: AOJu0YwCjDz4/Y62YirB1pWa1/BR7iVtJw5yx2WJ108ALio0csJ6ZkPt
	hyB5Do8jtM/5MwQ6wLRUCz/sEO6kcxLx9CQf7jdFVevTJXHqNX4NC3TV7JsCM1IeYSsZDaPTHWV
	qbFqOBjTU1B9lucwKdmtkqUDQWX4JEKA=
X-Gm-Gg: ASbGncuWilwivYqUXLLoaxDVKfh9N6cn7y1jVdEyQKQPmHHXAJlf6T24rl+zVzf0ATZ
	lkWDhqIEhINdxb2FN0n4gymuqc7uUrv8PJTuaKNsTRZY0VQwDMo3uW+gc0tjETste7Cm6ud4r0j
	6fysI4VK3CXc6cEyEa/cZ4BkbngG7w+EdltaxBv1YNS0lc1XtPPUoqLefh1da0Jisk1+R5J9c8L
	scXDDjni8QKyGd8zEXygCfDWpj+fwxc
X-Google-Smtp-Source: AGHT+IHb2aP/BKVvXy5UIikM7CAfW1HejJVLqHU6EENtf+RxmQ3fUfC4eA1F2aYliyiOB84U9ENncOL5kHvTQlw5wEQ=
X-Received: by 2002:a05:651c:e15:b0:30b:d156:9e7e with SMTP id
 38308e7fff4ca-3308e352446mr15464661fa.2.1752765672592; Thu, 17 Jul 2025
 08:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 17 Jul 2025 09:20:59 -0600
X-Gm-Features: Ac12FXzDPBtC_DqCXhOQwHqBSQP_8z9C-qYf0C_FN8EDfctacdwiESXNLuzKhZI
Message-ID: <CAJdd5GaM=Q0pa4e9Jz--GnO6ZqLdE4ZqsoDwYtTwunkLGQwrRQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] asyncrpc: Avoid file not found
 traceback in logs
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Jul 2025 15:21:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17785

LGTM

Reviewed-by: Joshua Watt <JPEWhacker@gmail.com>

On Wed, Jul 16, 2025 at 9:22=E2=80=AFAM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> If the server is quickly stopped, we see tracebacks in the locks
> due to the file not existing. Hide these as they're not errors.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/asyncrpc/serv.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
> index 667217c5c1b..35e93f7c969 100644
> --- a/lib/bb/asyncrpc/serv.py
> +++ b/lib/bb/asyncrpc/serv.py
> @@ -211,7 +211,10 @@ class UnixStreamServer(StreamServer):
>          self.server.close()
>
>      def cleanup(self):
> -        os.unlink(self.path)
> +        try:
> +            os.unlink(self.path)
> +        except FileNotFoundError:
> +            pass
>
>
>  class WebsocketsServer(object):
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17779): https://lists.openembedded.org/g/bitbake-deve=
l/message/17779
> Mute This Topic: https://lists.openembedded.org/mt/114186786/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

