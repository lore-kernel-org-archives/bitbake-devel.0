Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAF3EE2091
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 11:47:02 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9507.1770378412798438022
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Feb 2026 03:46:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iYsIOP1H;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5014b7de222so18396841cf.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 03:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770378412; cv=none;
        d=google.com; s=arc-20240605;
        b=K/yDDlwiTRHiN/FwT5PvWh3+u4tlCEEECq5ltP8EXI5KUl2+uvR7Ze6TmtxCzSkVIl
         uCsCJ3PJGW1y3xbf15tEob2NRXo3odfZpgr8NwnDyE/YwdQLophXS28G4Lip0hieXVFP
         bZsNbQ/DQR5pkR539sgL00Rm58NLs0SZrn76tWHsfJnljC2Yhho3s8ASvtJNQ0pSwl3T
         aUwmvuSd9TwtGLaVL0qv/wpzDoGJQSOv/g9C/Md0c0lG/om1RaJMDtBILdu3Swpsoj1J
         2QSnOTrxYtdFuffYJazL0EONBN8WU12Mtwo708kDbvGeFUqypkIwmHeiO1lz0qhD7e1t
         +ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mVPhPeduX3Z+HAm6nvvZYNKeWZiBOvbQPPzs4x0Cujg=;
        fh=AzhvQHsntPIv1eM1lpjGIR2sWw2cIaM7npVj0FDUl9k=;
        b=c53FTOU81Ro8dIULgq3LpNJgeJn8XM4z+5K8cSxnbdqUjsGA+1TKeHqHgvkxgBsxyc
         DqQlNwTIZnSM3G/1pFq/xo+rwi64GCpb6jcwY5r5bu1V+dBpPeeH4cWl8lFbOgwRKUMH
         1HY/cAPBF6RnCFk8neTOUIYYZqJsSgXVbqjcg3u+kRNoA3N+3nB+U/RHdIzg2No6lUBT
         oKWC/uyW5Q4i1x75b4c3W/guva05+ptkj6agRheCBbVGXhQee9MjKhapELXIC/Gpchpu
         0SkxETbzcP/iaKWxCSAqxNXrKswIxjxSLhqdH9/HVks+eXitl2gAYmLTVNoblxJzn1+1
         RNuw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770378412; x=1770983212; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mVPhPeduX3Z+HAm6nvvZYNKeWZiBOvbQPPzs4x0Cujg=;
        b=iYsIOP1H+6Ao+SYBKJk0LY7Z8pwsW1uD10RLfpOdu0/82tns/5ZlGXy1FTl/vEjEpK
         vfTfXCY2DprTNU74ortLMP/C1zorW8XACTI0JPi4pnJ/juSD245WSoTY57uIXpj1SM4D
         T7bw9VnQYNpappkInIOgIEaugMeelAUDQsxCLHYHWslg61xM2EfbKH3u8MsU2qMAn7Rp
         inNB1dO4Dzxsr3h1Qj+SAFPCdSTMy3axkTdfsPZT0UySXFcoB+kq84mUtUqNK5v0R1od
         5QUh13aKgxSM/sEAEWOgFpSIyGFHRTnm35qTGfBCoQZWSs3vsYYme+lJwowl6Sxi0utS
         ltew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770378412; x=1770983212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVPhPeduX3Z+HAm6nvvZYNKeWZiBOvbQPPzs4x0Cujg=;
        b=RECFIKAHYc2wH5waA3Ttv53DMZoVD6d4+tc+XFL6ZsRq8ZQElE5H+05ZhvyQOt4YWu
         PbprmMYcfbiRTaU05YBUn0MxyzeoJsBXJrJYURxGCWxrIs7N3DnQcaI3sH7YblY+rw0Z
         t/GyCZKDMdH7gR8UskaoZudAgj/b/qcz0ok7nclU3SOez4tNJ5RElkMGRI+crwMteruo
         p7+yClOp22upQ6NB/VBuyn6rOBOhGdyvsB0AMEKwpP4a3LnK+7/JnhkDL1OdHo11n0Zy
         fkZ+VCc9IzodzAS+z0t+F5D1WcsL2ROE6IZmWfTlb9nYKhX/5pnev/e65b982F1DQH+0
         tqaw==
X-Gm-Message-State: AOJu0YznN++HQb9mIZqq0c1KfQh6nJdPCW7ay/MW+oeASFcR2qgm0MgB
	0aJuD1wvQwLqmmAb2f4lKaQubUjFR7VymxFwJSyeWGvGvqzvQ+utNg8SNPn558r9MVFUnvsUcj0
	qWdZVX23wi7Tf+R5lbCLRMYgwxXhTTOOGYA==
X-Gm-Gg: AZuq6aKbAABCxTorxnaTXKWTNzPfLU1azH0Wx6ap79NXyJUfJuoD+6uW7ShUAO+Hkn9
	iBloa6S16C1Elm8sT6aXCK9IVqrd7arqZ3C4btDcqWG/f1NmofRee2pmbBxzGBJoIRjHsrVXOxm
	M5OiZsMlXvaKkZLS4DJrdJ+49LnYRFs+jt/Kmoltl3wHGAxPeCTfmssa76WXTMrH9jdFdjAutkJ
	9k20VDKWVKtpO21PG1eIGgo8OU8MQy8g9eUlgKuEmi0TaBiYstWcCQEyWjEpZJHV1wt9QZHln9v
	W6kVgsxIQDWsXad9yPIxJn6aCVVCYQ==
X-Received: by 2002:a05:622a:143:b0:501:46b7:22b2 with SMTP id
 d75a77b69052e-50639a283abmr26594661cf.82.1770378411770; Fri, 06 Feb 2026
 03:46:51 -0800 (PST)
MIME-Version: 1.0
References: <20260206075522.5620-1-liuyd.fnst@fujitsu.com>
In-Reply-To: <20260206075522.5620-1-liuyd.fnst@fujitsu.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 6 Feb 2026 12:46:40 +0100
X-Gm-Features: AZwV_QgchquyDY6IBwI93Ss5of_2fwZnBkOlAtbjeXWi1mpPiofbxlu4chNnwDg
Message-ID: <CANNYZj-O91BPn5KMaO0FVcpLqdtU7MF5RfVLQmJQyXvEjfd0Xw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] bitbake-setup: Add strip to value from settings.conf
To: liuyd.fnst@fujitsu.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 11:47:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18980

On Fri, 6 Feb 2026 at 08:55, Yiding Liu (Fujitsu) via
lists.openembedded.org <liuyd.fnst=fujitsu.com@lists.openembedded.org>
wrote:
> +        for section in settings.sections():
> +            for key in settings[section]:
> +                value = settings[section][key]
> +                settings[section][key] = value.strip('"')

I think this is okay, but should we strip both single ' and double "
quotes? Sorry I didn't realize this earlier.

Alex

