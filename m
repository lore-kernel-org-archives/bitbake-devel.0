Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848DC77B7A
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 11:41:39 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
 by mx.groups.io with SMTP id smtpd.web11.9441.1685014896400130764
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 04:41:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=V48YAuSv;
 spf=pass (domain: gmail.com, ip: 209.85.221.179, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-456d6ef4449so133664e0c.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685014895; x=1687606895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JGfg8GuT+I9G/T4MwHbpyExmcDIs6rQqn7j1EV1vKE=;
        b=V48YAuSvgON4gHnM04DlTScIwRZGAEjjas6Xp3Za/5S6B69BRDKQGc1H7fPB0er/HB
         yukT2Uig0I5DmvaOsO5zuKsf80nwkGOota7uIrL26VLYWM0q69OiukHNzSfqwAt/b+hU
         mpyynyKeRJLUY5VM23me4WGQIzuczZ+2fS3hwby0P0I35/tDEMf3cqfMAd2wxRRl4msI
         MlpqfPF8Woj0rrmLuc0v/BiYT5Q1Q43zPrebMb+jniTX8mmT6KHY6NoEoiliImwgQ1jX
         2qdU6TcotImDg06AhxtYl1dqyvYmpXhZF7CvA0Htxa7fym6PAQGFlVG329MRSAg8o+6m
         ceKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685014895; x=1687606895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JGfg8GuT+I9G/T4MwHbpyExmcDIs6rQqn7j1EV1vKE=;
        b=BeHnRd8Ehx8sZqzXmGQG9KD/Yf4nAPJeapVEy8kNru/W3kWDynmjIjlORalBwbMNNs
         LsXL4QOT2hrB0dGBPjMAmRYZG0Vj/ZvFkLIkVEKUZy0j6b968eWczsM+XE9JHUwprpzh
         JxGMoXNFnanE3BU4yDDrNhtounig6vQG+ckFq9GYM+wPvUKqejbv0ztrIm4TzrvzAIVZ
         8riVXFi3qbNxNZuKXxYTT8hRGMvDwJ9+YQml/n8J6mP8qd7Wr07Vm2vrtqg0RgM9fLgA
         mBQeHUj+cUqbuXWxOpg+jBvG1T7+JrOdy1wch0R6UvPLVDE1WWYJd+k9zpeWseGPCl72
         z38w==
X-Gm-Message-State: AC+VfDzgV+J5e/WxX4Ysjag5s6rypJA74TNnS7JlPpd8Bok/MVYKhRIR
	JuQdea9MEbp6ejq2235s1kPxWqcmIzOgZiIVoFk=
X-Google-Smtp-Source: ACHHUZ5s3RWTF/NFlWXT5eNUz6Z7bo6KU4aqujnUsA7cAueV3r2MWk8bka2BNqOTpZi3yM9HgEz4LpIwahNLWFTRVQc=
X-Received: by 2002:a1f:6046:0:b0:456:ffb8:8901 with SMTP id
 u67-20020a1f6046000000b00456ffb88901mr6769346vkb.15.1685014893734; Thu, 25
 May 2023 04:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230525102105.1480610-1-michalwsieron@gmail.com>
 <ZG88JxkZkP4z3kR5@nuoska> <CANNYZj8HQvGOFCx_jLXPBhcSCgGdF5j8=oBvKFU42btQoZNT=w@mail.gmail.com>
In-Reply-To: <CANNYZj8HQvGOFCx_jLXPBhcSCgGdF5j8=oBvKFU42btQoZNT=w@mail.gmail.com>
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Date: Thu, 25 May 2023 13:44:53 +0200
Message-ID: <CAJkqNs2iyuVXRU-Wva+9pC58XixbM5YPC6c8hfgNuDY+9aYaRg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Add task timeout support
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, Michal Sieron <michalwsieron@gmail.com>, 
	bitbake-devel@lists.openembedded.org, 
	Mateusz Marciniec <mateuszmar2@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002eb29b05fc831a72"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 11:41:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14809

--0000000000002eb29b05fc831a72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
let me give some more context on the patch. We use self hosted gerrit and
artifactory (with git-lfs content and tarballs with source code) instances
which tend to be slow sometimes due to some overloads and other reasons. We
have a 3h timeout for the whole build. Now let's assume do_fetch tasks take
already 60 hours instead of 10 minutes. With the timeout solution proposed
by Micha=C5=82 we can detect it quite fast and stop the build job and unblo=
ck
the jenkins nodes for other builds or just retry the build in case the
fetch on the second run would take less time. Now without that and with
timeout on the whole bitbake process we're still holding the jenkins node
for another 2-3 hours even though we know this build has no future.

Best regards,
Tomasz Dziendzielski

--0000000000002eb29b05fc831a72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello,<br>let me give some more context o=
n the patch. We use self hosted gerrit and artifactory (with git-lfs conten=
t and tarballs with source code) instances which tend to be slow sometimes =
due to some overloads and other reasons. We have a 3h timeout for the whole=
 build. Now let&#39;s assume do_fetch tasks take already 60 hours instead o=
f 10 minutes. With the timeout solution proposed by Micha=C5=82 we can dete=
ct it quite fast and stop the build job and unblock the jenkins nodes for o=
ther builds or just retry the build in case the fetch on the second=C2=A0ru=
n would take less time. Now without that and with timeout on the whole bitb=
ake process we&#39;re still holding the jenkins node for another 2-3 hours =
even though we know this build has no future.</div><div><br>Best regards,</=
div><div>Tomasz Dziendzielski</div></div>

--0000000000002eb29b05fc831a72--

