Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DEEE8FDB5
	for <webhook@archiver.kernel.org>; Fri, 26 Dec 2025 19:21:49 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.157610.1766776908627171980
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Dec 2025 11:21:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NZULlVbq;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so71846556d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Dec 2025 11:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766776907; x=1767381707; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKAZqEPIE1Ae27Wu8kt/h9Nue/7O7kZRk4MEU2xY80A=;
        b=NZULlVbqTJLSRqJofUXtU+2U/47D2l29cLvyI/vDGowRqNxFuFBj3ZlZGRtLv2G6Gh
         PuP/NIgLIouJj5o9F0gRAjb5Traj2z1Rr0jQbqehqBEexMt9FnBuWrtCpZKqYmVPPi5O
         W8wrzH/lwuaswensO+Z/9eAbhQUYCVAw9TcGDM6ERaUqXe/4MbuhYdKuBeor94KrzD/U
         v4VV6BOWb23CMkDOAPj3s4Fb6plgxA92knPbWD9xANrLvLEPPV4P5N0QPXWvP32wMA/I
         VcKt9X1roh8ancbZVCfYPifaDEwo7ITi62YGEqPFe1Rt/IkOnh07kd1lNRmAFUXOwMOx
         bq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766776907; x=1767381707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKAZqEPIE1Ae27Wu8kt/h9Nue/7O7kZRk4MEU2xY80A=;
        b=V+NTGf+cbrFEl4d3Uq+qUMTm/oMvZbKLEBHO53ZyMHPJ/rcIktnUJaNaFeXeqjkGba
         1PZP+eTqQkEx7QhwO0lc4GqMJWxDCeJZxO53/OV1HeJYGJYytZwDSPnJVshTPXOicbZj
         3VcqRPv1RB6jgLv/NKcr2RO6aUo5PVBFChxcTnU+VFRnhhbUrMORVpvVZk6lo1j3+K62
         1QuQPnt/vkmn3v5ymmBYSmEtqU4IqomVAXIuWbA/hSqVDoqUUXMxGjIL4dbXMyyP38f+
         tCZm3bVuCEeB+xQ8UcRUeHaPCn0OppYlsPmlmUgbuT4jotO7+VkqSRTt/IS/rusN0x4f
         8KCQ==
X-Gm-Message-State: AOJu0YzqHgf4lA5iQJZuPQj/mA5ygsrQraEc1H5ac8zhflVkdVyD1F66
	L9PzryyzthbzzOZi2pjP/f376gT2s9P574d/zWWkQlujPc577CfY/OWE2PX+2oKCIEJ2fc2opHZ
	C6OsOWSA6ne2u4yD3FN6XugRaXsFN3rJIMg==
X-Gm-Gg: AY/fxX6LzH9Kz+4jRgsBKBh7x3Fn4jBlocWoNdc5TgU44w39bvvWasYl1/doRGgaBfK
	ren2WPiUIjJsNAMb9LFu7q+twoagkVLQ/UPLDOSeq6Wfq36Byp0iuiGTnecCrd3ehJu2OQtrxPA
	ZXVJ6oZNhzFtQ2bhK7I5F6jBBA4l9N7cC62+0TIbq6OIpFq6uLq7j/U0Az5TZPeTzFF91GeQj/1
	09zq9f03IVI+FCuYxAzWRna8MDDS/eeoFg0Z/a/KoF15leBSpm5bvX+JdYkBjtKUX9YnQ==
X-Google-Smtp-Source: AGHT+IGsx7HfI2xyxYPZOvec3JKuX5m8DO0QH45yGrNxWNOABVxdklsla3+xEdzs944iO6iXSKVRbhmfBjHTgQeVod8=
X-Received: by 2002:a0c:fc10:0:b0:78e:ea84:768f with SMTP id
 6a1803df08f44-88d82234fc8mr259691916d6.30.1766776907562; Fri, 26 Dec 2025
 11:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20251226172034.1091465-1-adrian.freihofer@siemens.com> <20251226172034.1091465-2-adrian.freihofer@siemens.com>
In-Reply-To: <20251226172034.1091465-2-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 26 Dec 2025 20:21:35 +0100
X-Gm-Features: AQt7F2oVzIKBfFKOh5X-Hf2bMcAcgQkyUuUeGxV814qd1WFfaolQfFgikAobkuQ
Message-ID: <CANNYZj-dcbO2YiFwJLrWZ9nr83UVU1NVRWAxWnZzGYHM1wjyVw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/1] bitbake-setup: Initialize build
 environment after setup/update
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Dec 2025 19:21:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18654

On Fri, 26 Dec 2025 at 18:21, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
> Add verify_and_prepare_environment() function to source the init-build-env
> script after configuration setup or updates. This ensures the build
> environment is properly initialized and IDE configuration files (such as
> .vscode/settings.json) are created before the user starts the IDE.

Should we rather call oe-setup-vscode directly from bitbake-setup? I'm
somewhat torn, but leaning towards doing that instead.

The problem is that oe-init-build-env, for historical reasons, has two
disjointed functions:
- add some variables into the environment so that bitbake can run;
- run assorted 'magic scripts' (such as copying templates into
build/conf with oe-setup-builddir or calling oe-setup-vscode to make
the needed settings file for vscode)

In this case, neither the first function (adding to environment), nor
the template copying is actually necessary or useful;
oe-init-build-env is only ran for the vscode stuff. I'd say let's do
it directly. Opinions?

Alex

