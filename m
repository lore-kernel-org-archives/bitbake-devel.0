Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035E3C54E41
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 23:32:06 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.10731.1709767915801886132
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Mar 2024 15:31:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b/HZPZuq;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d28051376eso3407711fa.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Mar 2024 15:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709767914; x=1710372714; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBvo/1gykYd3yNICdAJTQJcpuwr+EvJk/lWiIN3zUSY=;
        b=b/HZPZuq01srSuAo9ESSHBnmj07EQ0rnt4pmihdxN0uNcEjEAxejtBjeMhsGWXH4U2
         NH7f55rfHXzSnTIirw+zVn1M5Bxw5JI0W/RYyjvldPf0F4ZllikGfdTyrMzGJAeCDhTl
         ylnr2+B55PIZTk7QFZuJIaguzqg0w+DVNL1PQZPFg580rz+s3+fJHYgyLkgTHW2IXq4Q
         7ef7h338pZJ7CA9PFEe80RbJ0Ahx91/hUrNWdIUsAtYL2UqUZXEqpIU3K3FyOX3pstV+
         2LSGyDJhUCawdUPK69dFoZVaAOtYbR3hMWMdPvTSOdwcrEOviGsqSbdoCs8usJs6ua5q
         Rcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767914; x=1710372714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBvo/1gykYd3yNICdAJTQJcpuwr+EvJk/lWiIN3zUSY=;
        b=mQSFEjttEMsNU4MlYcoUmeB1/WwHLVg4+o0SzF6gDz5NQa+9gsVPjNfs8ktx9pL0Bg
         IwcCeGgsWA99Pm3rZev11RrHBnrDsgDynJJlUS8y7zOp+IBCKP5BpKRqlFs/7JtKrKv0
         XPf9INiYPgP4ikHE9WzIrrowOEgkvkKnlfo9EkluOpfKiHH7YqTVtnjG0ymibx6F3jrS
         JH+7UvU/K1CiiOm8cyOYi/2R0Phf+aEmCYL8PDwtuRVKLfgcwqh7daRA0obtkV64vzoT
         aKRgml5N8Wxj8lQYK3P4vRoFHlhkes9iXGNt3OnJhFBN1FjCMdnoQWjR70wEEETSrN7q
         9P5w==
X-Gm-Message-State: AOJu0YyZFFMm0MmIhj0e5djcPVkS07NiOZN/rJTQq+gNk9UHS3Zz8Cqq
	at86liE3mCldWyj2+JNLLAeGYH7f8j0HdXYd1QnofpcsZ5vsyfBD/F72bmizVQ2H2kXfqTZHK2Z
	vj9iq50pXn6ccuFI2XwxmAU2j2YM=
X-Google-Smtp-Source: AGHT+IFM2v0HNB/DS9k8kTkmZFYK/g9KIuUkL02dPthZwL9wPSd2wEj2ugMflDGZVUahGal7DPAGbRRA8V0tmpRRh4s=
X-Received: by 2002:a2e:9911:0:b0:2d3:1c1c:265e with SMTP id
 v17-20020a2e9911000000b002d31c1c265emr263030lji.45.1709767913531; Wed, 06 Mar
 2024 15:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20240306171144.1874798-1-michael.opdenacker@bootlin.com>
In-Reply-To: <20240306171144.1874798-1-michael.opdenacker@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 6 Mar 2024 16:31:41 -0700
Message-ID: <CAJdd5GZ1RkHzaFhSmVYZmBsK=z9Y3Sge5d5=-SdsJjneiOp1gg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] prserv: remove dead code in exception handling
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Mar 2024 23:32:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15991

On Wed, Mar 6, 2024 at 10:12=E2=80=AFAM Michael Opdenacker via
lists.openembedded.org
<michael.opdenacker=3Dbootlin.com@lists.openembedded.org> wrote:
>
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> As explained in https://docs.python.org/3/reference/compound_stmts.html#e=
lse-clause,
> the code after the "else" statement won't be run as there is a "return"
> in the "try" block.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> ---
>
> See the whole code on
> https://git.openembedded.org/bitbake/tree/lib/prserv/serv.py#n38
> ---
>  lib/prserv/serv.py | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 5fc8863f7..5032f7cd7 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -40,8 +40,6 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection)=
:
>          except:
>              self.table.sync()
>              raise
> -        else:
> -            self.table.sync_if_dirty()

It is correct this will not run, should self.table.sync() be in a
finally block instead to make sure the DB is always synced? (the
except can also be removed then)

>
>      async def handle_get_pr(self, request):
>          version =3D request['version']
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15990): https://lists.openembedded.org/g/bitbake-deve=
l/message/15990
> Mute This Topic: https://lists.openembedded.org/mt/104770220/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

