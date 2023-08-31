Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5188C83F29
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 08:56:44 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.12394.1693472196370777799
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Aug 2023 01:56:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Sqq2BvH2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.181, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b974031aeaso11440571fa.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693472194; x=1694076994; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7I7vhe0tylYSTfJSx1Xo1pKHMEIwnguH/FhT6mqmQ4w=;
        b=Sqq2BvH2H6YWGgQFNpqQPaZiEmhMFsai5hTDIX1GUD8xsq7DHHJG7Y+cVTk1NLMMmV
         pqa3ab0/WZ84CARdOTd1JQ67kXa2WFcuCevW9/CyhuAdanSGDzP/Inrfx3WiVnx3eWlX
         SA7zJeem/oCob90ms+vhs9dZCveo9nR+gTQX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693472194; x=1694076994;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7I7vhe0tylYSTfJSx1Xo1pKHMEIwnguH/FhT6mqmQ4w=;
        b=MRUJpgPPziL7ZioW/6eWaYqJAEUtlG2WLqh5J6M+Twufxjw4Ue4bNpKMMxuRydAueh
         xnW5BF021NH0te9L2+z+JZrgiInOkBQwsavKZGnyJGkV1uvNKKMn39LFsVBjHRXNKTB3
         oM62s/ok0GR7yGh7X/wKIwkkUk01gepzlzqNvM2uMJZuzqYMX7E5kIYqKm45BglmREGI
         bCx46bjTX+FhpUmzD5xK3ca+GyXV2oMein2LU3KvUJ4KEPA65P8G8JztYG9wsrJ0e/Mg
         T94GgQOMiRDwgSEstB3ioCiubaJ/YmYmxmK4gdU+PTyWi6IlWF2giWa5J0JkeB7GW0oP
         86Iw==
X-Gm-Message-State: AOJu0YxoNCUc6eZwoaQXdh6ytJlO8dpFPVu1YrfIMLlsvudyOz7g1lhn
	nCCncWe9H6lFo79yVhVGpi36SkWV3tjv0A43OFg=
X-Google-Smtp-Source: AGHT+IGmxeZ2uYaAOKuGlGtCMTi76ww0ffo3Q69QRd+n9o0ctkk9TheR3pqxQVQykcOnCTu7ZT0QLw==
X-Received: by 2002:a2e:9195:0:b0:2b9:f13b:613c with SMTP id f21-20020a2e9195000000b002b9f13b613cmr3784084ljg.2.1693472194473;
        Thu, 31 Aug 2023 01:56:34 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:22b:9179:6474:7878? ([2001:8b0:aba:5f3c:22b:9179:6474:7878])
        by smtp.gmail.com with ESMTPSA id q12-20020adffecc000000b00316eb7770b8sm1497858wrs.5.2023.08.31.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:56:34 -0700 (PDT)
Message-ID: <90096957449e6a35b3f2b349cb07132e0ef6a951.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] command: Avoid time intensive
 distractions for ping
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2023 09:56:33 +0100
In-Reply-To: <ZPBUpN6GaATE+zbz@nuoska>
References: <20230830213303.2043607-1-richard.purdie@linuxfoundation.org>
	 <ZPBUpN6GaATE+zbz@nuoska>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 08:56:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14995

On Thu, 2023-08-31 at 11:51 +0300, Mikko Rapeli wrote:
> Hi,
>=20
> On Wed, Aug 30, 2023 at 10:33:03PM +0100, Richard Purdie wrote:
> > We noticed some users were seeing very slow ping response times which
> > caused 'server timeout' issues. There were some function calls in runCo=
mmand
> > which could be slow such as the inotify callback processing.
>=20
> I guess the error looks like:
>=20
> Timeout while waiting for a reply from the bitbake server (60s)
>=20
> and happens right after a succesful build to me when I try to run any bit=
bake
> command.
>=20
> Hope this fixes it. Thanks!

That is the message however the cause may be different in your case. It
sounds like the server may be taking a long time to shut down for you
and it can't connect or start a new one whilst that is happening.

If you have the bitbake-cookerdaemon log for your case I can see if
that sheds any light if this doesn't work for you.

Cheers,

Richard

