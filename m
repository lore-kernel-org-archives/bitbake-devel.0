Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0128DC04E85
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 14:43:46 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.122878.1699541022223818238
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 06:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FSCa6nlN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-409299277bbso6264005e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 06:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699541020; x=1700145820; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QeI896pGLJzw4p2RDLhc+Qy2xLLeKGlaUswFYZc7U4=;
        b=FSCa6nlNNqSSdlL+CA/ZbefzpeCZq00U52VWEBGPDn28pLMYf8oEBAU098yd0DJgGo
         NBLGT14Flf288vkPiIPUMfQ4BN0flcC1QAbQ1pmCv4QnIJl4MIPQDSOCig2AHHmblhGo
         MEEgonZA1Z/Vw4xPOs18CkwxOQdfZT5U1oDcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699541020; x=1700145820;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QeI896pGLJzw4p2RDLhc+Qy2xLLeKGlaUswFYZc7U4=;
        b=e1JTk0hJbQktu8KxHp/KwUZR6O9dwZT0JkAiLhylY1JfdjHq/Xnmvb/IkaiA0c5bov
         h9c8cBkkvqVDo11fOVJB9gT1CMpF+s4upfexGUpHA4QKHDnU1UTR8xpnxh9gofF59YAu
         gpygMxaKX3dPBnyoN3JXvQVpQ1yhNKojOwktpvAi9Q32IaymuysVcMyEbejyrPwmfCV+
         1LOkRkN28nyZ/2Z8KmnMCdCnc2LZBRmr4geekyzV22FzEHs6/6qgBiKZoVRYHFBqnCwk
         cdHp5uFcPlq4tvgezMSnpabVN/+IlAiCCjZmoFalXshqTkHe/TRuOJwQnIBRXU+ZtkXn
         xEow==
X-Gm-Message-State: AOJu0YyRicJB3IOCKlhO+AQOwturFQwV87AliTWKIRCkiLjKm7GZno08
	i7CZ2Cc2QhMJy3pmHC1rPsLUSA==
X-Google-Smtp-Source: AGHT+IGkAuym1uCye6pjbWgbwlN3Xfbt4HR85k+zAByaOSLtqZcgL+hnwHvk6kk9jzw/Iimeq/UnGA==
X-Received: by 2002:a05:600c:1988:b0:401:c338:ab94 with SMTP id t8-20020a05600c198800b00401c338ab94mr4686198wmq.29.1699541020527;
        Thu, 09 Nov 2023 06:43:40 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7d6a:4777:87ed:703e? ([2001:8b0:aba:5f3c:7d6a:4777:87ed:703e])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b004094c5d929asm2324941wmq.10.2023.11.09.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 06:43:40 -0800 (PST)
Message-ID: <729f89c9e871bc97e24d70715208386020268539.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 5/8] Toaster: Write UI TestCase create
 new Dunfell project
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 09 Nov 2023 14:43:39 +0000
In-Reply-To: <20231101221314.236173-5-alassane.yattara@savoirfairelinux.com>
References: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
	 <20231101221314.236173-5-alassane.yattara@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 14:43:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15459

On Wed, 2023-11-01 at 23:13 +0100, Alassane Yattara wrote:
> Test create new project using:
>   - Project Name: Any string
>   - Release: Yocto Project 3.1 "Dunfell" (option value: 5)
>   - Merge Toaster settings: False
>=20
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  .../functional/test_create_new_project.py     | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
> index c6345e5b..cd690e1a 100644
> --- a/lib/toaster/tests/functional/test_create_new_project.py
> +++ b/lib/toaster/tests/functional/test_create_new_project.py
> @@ -132,3 +132,41 @@ class TestCreateNewProject(SeleniumFunctionalTestCas=
e):
>                                       "//span[@id=3D'project-release-titl=
e']"
>                                       ).text),
>                          'The project release is not defined')
> +
> +    def test_create_new_project_dunfull(self):
> +        """ Test create new project using:
> +          - Project Name: Any string
> +          - Release: Yocto Project 3.1 "Dunfell" (option value: 5)
> +          - Merge Toaster settings: False
> +        """
> +        release =3D 'Yocto Project 3.1 "Dunfell"'
> +        project_name =3D 'projectdunfull'
> +        self.get(reverse('newproject'))
> +        self.driver.find_element(By.ID,
> +                                 "new-project-name").send_keys(project_n=
ame)
> +
> +        select =3D Select(self.find('#projectversion'))
> +        select.select_by_value(str(5))
> +
> +        # check merge toaster settings
> +        checkbox =3D self.find('.checkbox-mergeattr')
> +        if checkbox.is_selected():
> +            checkbox.click()
> +
> +        self.driver.find_element(By.ID, "create-project-button").click()
> +
> +        element =3D self.wait_until_visible('#project-created-notificati=
on')
> +        self.assertTrue(self.element_exists('#project-created-notificati=
on'),
> +                        'Project creation notification not shown')
> +        self.assertTrue(project_name in element.text,
> +                        "New project name not in new project notificatio=
n")
> +        self.assertTrue(Project.objects.filter(name=3Dproject_name).coun=
t(),
> +                        "New project not found in database")
> +
> +        # check release
> +        self.assertTrue(re.search(
> +            release,
> +            self.driver.find_element(By.XPATH,
> +                                     "//span[@id=3D'project-release-titl=
e']"
> +                                     ).text),
> +                        'The project release is not defined')

Since there are a number of similar tests here, shouldn't they share a
common function which we pass the release/other details into?

I'd also skip mickledore right now since it is about to go end of life
and be replaced by nanbield.

Cheers,

Richard


