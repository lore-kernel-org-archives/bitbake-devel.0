Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A78C021BE
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 02:12:07 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.2013.1740535918761562405
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 18:11:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X7na8Md6;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-546267ed92fso7176281e87.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 18:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740535917; x=1741140717; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNbns+3/TCDMMvVT6EQ4LJqtkkf3xhET1IYFaGiMT/I=;
        b=X7na8Md6GQn7Ay8S0/Aj7jp+5zj8zJgu7yMwjJwUnL2X9qnzL2gp2i1dDmXZYQ3MDf
         6r/ZG0UcdUmQqM9duQY2Y0wFE3tQYX2zgZETjeo6ErTKZ8LGcSnjmLVvGiWCVb12Rvzi
         On3Gm3z17h3BiR0T4o/UJ479IJSTEhKPKU7KrQJ17gV+vCBwFOhM20hTs4pyfJsYiMXh
         SOCPHUOuc+UxTEQm0BL9JG2cmul1LqJS1dtMAKWyJ8q3pZUqw7n7UzlU5xTULgAAB2t4
         SrmC255d8LCbQrk+70Llub6rNbcvkdTyCuHx2czMZszpHxQkTFMPCR/AcBUrPuNX7e4y
         0qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740535917; x=1741140717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNbns+3/TCDMMvVT6EQ4LJqtkkf3xhET1IYFaGiMT/I=;
        b=VL2ZPV5ScfcALWPugDFWeskqk6uG4BsXsOgJ5K4ZCWZZP8mMwpouhDNV8VBa07VSYi
         5QI6qxmbmzL4Dp1tPWypsk2OGBzRi2bdtU2lDAPN7j3qHJ31rOm5GTPLEmZi7J4k86L2
         DtqSo9MhTiAu2x7nsLN4+pF4NU60bFtjqK3XXZtZqryGwKi7Hk6YFCyh7ysktXwA9Uc+
         5SIOA5zL1RX1yR4JXRA4S30iD7xBj0w1Cwz5b7zyi/dfNYG7O1gZN1jpGnRb1j5ne4yv
         +8F7ixroaPSXd5nUY/qlWIIrzjajokc9AJASDn2bqJu4TbrK37BPGYlUHaLpTYRQ8Abn
         XpRw==
X-Gm-Message-State: AOJu0YylXtrrjqBI1Cr3tw1g0EK1hazEiNOCuH++yBwPxQ7m07KQ+6rV
	fSr628En53Q51KdTg2xErU0Pnl4NWcz+ZI4aM15S9GLu+U22NmCP0jmzJkvOy7cTZUkTEQOTIld
	dRJxmjCHNTkZ4wSbHfrL8GJxecUk=
X-Gm-Gg: ASbGncumUz32hO+q8U014lCCDfyUbrwpSYsTuoESMz6bo+aWzsLebLIJvWUntRtmjKf
	KbnP228L8IINgoP4jsHF7cHPMWzkzzWwCcpRAwlpXfixuA7zniHml1z++LfSQxhpuPfE+CNawS5
	GiodadhCPAHj12N2jOkT8XcQ==
X-Google-Smtp-Source: AGHT+IHKzpOURz2B1lvPY9pTI1Jv6/X14VXlwbN/i0lvxaQLUVKcmYJQHEHnuwU7p2304OxIihAzLYQW62h2kFqBIc8=
X-Received: by 2002:a05:6512:6d6:b0:545:1082:918d with SMTP id
 2adb3069b0e04-548510e9ad4mr3975709e87.41.1740535916531; Tue, 25 Feb 2025
 18:11:56 -0800 (PST)
MIME-Version: 1.0
References: <GV1P193MB2055A662964438F153F844E5F8C32@GV1P193MB2055.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P193MB2055A662964438F153F844E5F8C32@GV1P193MB2055.EURP193.PROD.OUTLOOK.COM>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 25 Feb 2025 19:11:43 -0700
X-Gm-Features: AQ5f1JoKgwZg2Z159ahJkk9mlVici7ihtP9uCd-INftcxj5bTW-v5_g_Kp3Lmn0
Message-ID: <CAJdd5GY94n1iwg6F=33gZEJDCMJg_qEobTxSwtbcQSjvLfk1Mg@mail.gmail.com>
Subject: Re: [bitbake-devel] Clarification on Cleaning Up a Remote Hash
 Equivalence DB
To: Alexandre.Marques@criticaltechworks.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Helios <Helios@criticaltechworks.com>, 
	"node0-integration-build@list.bmw.com" <node0-integration-build@list.bmw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 02:12:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17323

On Tue, Feb 25, 2025 at 11:44=E2=80=AFAM Alexandre Marques via
lists.openembedded.org
<Alexandre.Marques=3Dcriticaltechworks.com@lists.openembedded.org>
wrote:
>
> Hello there,
>
> We are using a remote hash equivalence server and need to clean up irrele=
vant hashes. Currently, we
> iterate over a list of hashes, marking each as "alive" using "bitbake-has=
hclient gc-mark", followed by
> "bitbake-hashclient gc-sweep <marker>." This process is inefficient, taki=
ng about 9 minutes for 12,000
> hashes.
>
> We are wondering what would be the best way to go about improving this..
>
> We propose extending "gc-mark" to support a "bulk-mode" for efficiency.

It already does this. If you specify multiple KEY VALUE pairs on the
command line, it will send all of them to the server in a single
message. Granted, this is not the most useful on the command line. It
might be possible to extend the command to take a file/stdin list of
KEY VALUE pairs and automatically "chunk" them into the appropriate
number of messages (maybe, 50 - 100 at a time?). Then you could
probably have some script that finds all the files you want to keep
and do something like:

  find-sstate-files | bitbake-hashclient gc-mark-stream

>
> Additionally, we obtain hashes from sstate files and were considering ada=
pting the client to also accept
> a list of files, possibly through a new command or flag. However the clie=
nt seems to act as a one-to-one
> frontend to the server API calls. It's unclear if this is intentional or =
by design, and if it would be of interest
> adding such a feature?

It's useful to be able to invoke individual server APIs with the tool,
but the intent was not to limit it to just that (see the stress test).
That said, the streaming command outlined above might be sufficient,
and would mean that different users could implement a different filter
on the front end instead of trying to code one logic that works for
everyone in bitbake-hashclient. That said, if you do write a front end
script like that, please consider sharing it with the rest of us :)

>
> Thank you,
>
> Best regards,
> Alexandre Marques
>
>
> The information in this communication may contain confidential or legally=
 privileged information. It is intended solely for the use of the individua=
l or entity it addresses and others authorized to receive it. If you are no=
t an intended recipient, you are hereby notified that any disclosure, copyi=
ng, distribution or action in reliance on the contents of this information =
is strictly prohibited and may be unlawful. If you have received this commu=
nication by error, please notify us immediately by responding to this e-mai=
l and then delete it from your system. Critical TechWorks is not liable for=
 the proper and complete transmission of the information in this communicat=
ion nor for any delay in its receipt
>
> This e-mail is environmentally friendly, just like Critical TechWorks, wh=
ich lives in a paper-free atmosphere. Therefore, please consider the enviro=
nment before printing it!
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17322): https://lists.openembedded.org/g/bitbake-deve=
l/message/17322
> Mute This Topic: https://lists.openembedded.org/mt/111382632/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

