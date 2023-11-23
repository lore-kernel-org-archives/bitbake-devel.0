Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A4FC624B4
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 12:10:47 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.89263.1700741440609871396
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Nov 2023 04:10:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TXMwqxlR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4079ed65471so5328425e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Nov 2023 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700741439; x=1701346239; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4u0IFLsVVhjdFEBaU7/7Ds4bxt36bwS2DDZHQXcZVg=;
        b=TXMwqxlRDkyFsONKcBNbkgrCJSmNNTmdxYTnrGpXhwLltMe7gwktgLs8o5y407r5sC
         V/v+VYJeo084yfgsiga5bOFLGpMyjGy0i1VcvjgVcIyFMc9uXzKrem+bi5W4JBtK6aJs
         hIH8Cgtva+C9x8nlxTjHyNoIGMs5UHW/SScMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700741439; x=1701346239;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4u0IFLsVVhjdFEBaU7/7Ds4bxt36bwS2DDZHQXcZVg=;
        b=eOD6r1cEJUaXTkkbDBr1ZP8r9xjIP0p6iYrkY3O13aI4Gib31VUY4Z2o617E/49wd1
         Nmxqx1c//gu8W2IfYjr/qQ0Cs1NsAPDvQfRDvfAXLEw64DMpkBgf4qBBiSbn6xnoxMv4
         fzvp7fDQ1b4qWMMQrXkrnGsfHRtWHx5eFfifeZVHhJNQl2q/86Jjur/v6SLz4ZyY8c+j
         y5UoDfJ01Plf+j8t+6wCo4jOojPci2t5OhEg0PubVBAzNqBl1hAnq1yarb8orjAIJYsV
         TU6BDtE5aN7u/VHiLqtMIKIWPy5S7x8EnTbqvHDTHpvQ+9i/B/ev0BkQx5gzSoM89bkp
         ZAeQ==
X-Gm-Message-State: AOJu0YyMlbK3g5FSKMn+TPkAiaBE8BFmP0ET5T3B09gW/C0vUrA1GgeN
	NQ1lNwhn9sBhjlyNiDzk66eeAA==
X-Google-Smtp-Source: AGHT+IGdZfk86LJMBYOh8fTdYKnXD/S1v5IHy0irxQDIn0CCQ2H4FQUmzL61j3Thrd1cvOF4EWREcw==
X-Received: by 2002:a05:600c:3147:b0:40b:3803:e4c6 with SMTP id h7-20020a05600c314700b0040b3803e4c6mr334287wmo.8.1700741438886;
        Thu, 23 Nov 2023 04:10:38 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:c511:4d31:367c:ab3c? ([2001:8b0:aba:5f3c:c511:4d31:367c:ab3c])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b0040b360cc65csm1810295wmq.0.2023.11.23.04.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:10:38 -0800 (PST)
Message-ID: <33255f18bffaaf54ff6337c0d3917e34929cc5d0.camel@linuxfoundation.org>
Subject: Re: [Toaster] [PATCH 1/3] Toaster: Toaster: Write UI TestCase ->
 Visualize all projects
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	toaster@lists.yoctoproject.org, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 23 Nov 2023 12:10:37 +0000
In-Reply-To: <20231121134729.95095-1-alassane.yattara@savoirfairelinux.com>
References: <20231121134729.95095-1-alassane.yattara@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Nov 2023 12:10:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15565

Hi Alassane,

On Tue, 2023-11-21 at 14:47 +0100, Alassane Yattara wrote:
>=20
> @@ -205,3 +218,24 @@ class TestAllProjectsPage(SeleniumTestCase):
>          expected_url =3D reverse('project', args=3D(self.project.id,))
>          msg =3D 'link on project name should point to configuration but =
was %s' % link_url
>          self.assertTrue(link_url.endswith(expected_url), msg)
> +
> +    def test_allProject_table_search_box(self):
> +        """ Test the search box in the all project table on the all proj=
ects page """
> +        self._create_projects()
> +
> +        url =3D reverse('all-projects')
> +        self.get(url)
> +
> +        # Chseck search box is present and works
> +        self.wait_until_present('#projectstable tbody tr')
> +        search_box =3D self.find('#search-input-projectstable')
> +        self.assertTrue(search_box.is_displayed())
> +
> +        # Check that we can search for a project by project name
> +        search_box.send_keys('test project 10')
> +        search_btn =3D self.find('#search-submit-projectstable')
> +        search_btn.click()
> +        self.wait_until_present('#projectstable tbody tr')
> +        time.sleep(1)
> +        rows =3D self.find_all('#projectstable tbody tr')
> +        self.assertTrue(len(rows) =3D=3D 1)


I've merged these with some tweaks to the commit messages, basically
changing "Toaster:" to "toaster/tests:" and "->" to "-" to make things
more consistent with our other commits.=20

The time.sleep() calls in these tests worry me a bit as the values are
a little arbitrary. I noticed one does have to increase the timeout
depending on how much work is being done. Does the test framework not
have a better way to handle this such as a settle function or something
similar? I'm thinking this could be fixed in a follow up commit.

Cheers,

Richard



