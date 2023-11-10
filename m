Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4DBC4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 13:34:35 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.27117.1699623273351803489
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 05:34:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=okzaC1hL;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4D1269C3290;
	Fri, 10 Nov 2023 08:34:32 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id l_s-MeUknE8Q; Fri, 10 Nov 2023 08:34:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 481239C3423;
	Fri, 10 Nov 2023 08:34:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 481239C3423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699623271; bh=O71drGUSYmUCQOT3+xew6QCiCwPwVZt/5BuLLiUwdhc=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=okzaC1hLovkws14OQApb1ty2h/Ir6lAGt9r3w1PPItg16S3X5zvxeIXnW++rnOJHs
	 qKXuJerzd74TteJm0Vbe2FdwuWWdyFNRuwBpjnLFWoZndeykdqz0qhPzWF8Yzh3qCu
	 zZp2r3JCEzSqdknYUfoTZv3ISmgNzmHZ//MWoRVG/VWy8jNmSg00V5cqKRCNYFs2ek
	 NJpkne1ztTb6XzzB26rjIbnjdF2fpWUidOdp7APISD/REZfh1w3TMYc2yX8ea9KRoO
	 bIgsHtTp32OKQvyYZOiGtmRb4UI3lkBAyrhWG9YnGeGaXT96DzmT6F85syAb1jlVE1
	 qSeTurZo3aniw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id mD-KErftcvqE; Fri, 10 Nov 2023 08:34:31 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 321649C3290;
	Fri, 10 Nov 2023 08:34:31 -0500 (EST)
Date: Fri, 10 Nov 2023 08:34:30 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <545651085.595635.1699623270831.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <20231110080943ba6dd2d1@mail.local>
References: <20231109221517.110357-1-alassane.yattara@savoirfairelinux.com> <20231110080943ba6dd2d1@mail.local>
Subject: Re: [bitbake-devel] [PATCH v3 1/3] Toaster: Write UI TestCase
 create new project
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC117 (Linux)/8.8.15_GA_4570)
Thread-Topic: Toaster: Write UI TestCase create new project
Thread-Index: O+mBWAuHi8FqfBlSMGXp8fcn7eN5BQ==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 13:34:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15493

Hello Alexander,

There is no difference, that's same patch.
=20
Sorry about duplicate, my commandeline '$git send-email' was block when sen=
ding the patch series,
I canceled the process, then try again, but the first patch 1/3 was already=
 sent in first process.

Thanks!
Alassane.
----- Mail original -----
De: "Alexandre Belloni via lists.openembedded.org" <alexandre.belloni=3Dboo=
tlin.com@lists.openembedded.org>
=C3=80: "Alassane Yattara" <alassane.yattara@savoirfairelinux.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Envoy=C3=A9: Vendredi 10 Novembre 2023 09:09:43
Objet: Re: [bitbake-devel] [PATCH v3 1/3] Toaster: Write UI TestCase create=
 new project

Hello Alassane,

On 09/11/2023 23:15:15+0100, Alassane Yattara wrote:
> Test create new project using:
> - Project Name: Any string
> - Release: Master/Kirkstone/Dunfell/Local
> - Merge Toaster settings: False/True
>=20
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---

Please include a changelog here. At least, explain why you are sending
multiple versions of the series on the same day, this would make the
maintainers job easier.

Thanks!

>  .../functional/test_create_new_project.py     | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 lib/toaster/tests/functional/test_create_new_project.=
py
>=20
> diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
> new file mode 100644
> index 00000000..81355eaf
> --- /dev/null
> +++ b/lib/toaster/tests/functional/test_create_new_project.py
> @@ -0,0 +1,134 @@
> +#! /usr/bin/env python3 #
> +# BitBake Toaster UI tests implementation
> +#
> +# Copyright (C) 2023 Savoir-faire Linux
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +import re
> +import pytest
> +from django.urls import reverse
> +from selenium.webdriver.support.ui import Select
> +from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
> +from orm.models import Project
> +from selenium.webdriver.common.by import By
> +
> +@pytest.mark.django_db
> +class TestCreateNewProject(SeleniumFunctionalTestCase):
> +
> +    def _create_test_new_project(
> +        self,
> +        project_name,
> +        release,
> +        release_title,
> +        merge_toaster_settings,
> +    ):
> +        """ Create/Test new project using:
> +          - Project Name: Any string
> +          - Release: Any string
> +          - Merge Toaster settings: True or False
> +        """
> +        self.get(reverse('newproject'))
> +        self.driver.find_element(By.ID,
> +                                 "new-project-name").send_keys(project_n=
ame)
> +
> +        select =3D Select(self.find('#projectversion'))
> +        select.select_by_value(release)
> +
> +        # check merge toaster settings
> +        checkbox =3D self.find('.checkbox-mergeattr')
> +        if merge_toaster_settings:
> +            if not checkbox.is_selected():
> +                checkbox.click()
> +        else:
> +            if checkbox.is_selected():
> +                checkbox.click()
> +
> +        self.driver.find_element(By.ID, "create-project-button").click()
> +
> +        element =3D self.wait_until_visible('#project-created-notificati=
on')
> +        self.assertTrue(
> +            self.element_exists('#project-created-notification'),=20
> +            f"Project:{project_name} creation notification not shown"
> +        )
> +        self.assertTrue(
> +            project_name in element.text,
> +            f"New project name:{project_name} not in new project notific=
ation"
> +        )
> +        self.assertTrue(
> +            Project.objects.filter(name=3Dproject_name).count(),=20
> +            f"New project:{project_name} not found in database"
> +        )
> +
> +        # check release
> +        self.assertTrue(re.search(
> +            release_title,
> +            self.driver.find_element(By.XPATH,
> +                                     "//span[@id=3D'project-release-titl=
e']"
> +                                     ).text),
> +                        'The project release is not defined')
> +
> +    def test_create_new_project_master(self):
> +        """ Test create new project using:
> +          - Project Name: Any string
> +          - Release: Yocto Project master (option value: 3)
> +          - Merge Toaster settings: False
> +        """
> +        release =3D '3'
> +        release_title =3D 'Yocto Project master'
> +        project_name =3D 'projectmaster'
> +        self._create_test_new_project(
> +            project_name,
> +            release,
> +            release_title,
> +            False,
> +        )
> +
> +    def test_create_new_project_kirkstone(self):
> +        """ Test create new project using:
> +          - Project Name: Any string
> +          - Release: Yocto Project 4.0 "Kirkstone" (option value: 1)
> +          - Merge Toaster settings: True
> +        """
> +        release =3D '1'
> +        release_title =3D 'Yocto Project 4.0 "Kirkstone"'
> +        project_name =3D 'projectkirkstone'
> +        self._create_test_new_project(
> +            project_name,
> +            release,
> +            release_title,
> +            True,
> +        )
> +
> +    def test_create_new_project_dunfull(self):
> +        """ Test create new project using:
> +          - Project Name: Any string
> +          - Release: Yocto Project 3.1 "Dunfell" (option value: 5)
> +          - Merge Toaster settings: False
> +        """
> +        release =3D '5'
> +        release_title =3D 'Yocto Project 3.1 "Dunfell"'
> +        project_name =3D 'projectdunfull'
> +        self._create_test_new_project(
> +            project_name,
> +            release,
> +            release_title,
> +            False,
> +        )
> +   =20
> +    def test_create_new_project_local(self):
> +        """ Test create new project using:
> +          - Project Name: Any string
> +          - Release: Local Yocto Project (option value: 2)
> +          - Merge Toaster settings: True
> +        """
> +        release =3D '2'
> +        release_title =3D 'Local Yocto Project'
> +        project_name =3D 'projectlocal'
> +        self._create_test_new_project(
> +            project_name,
> +            release,
> +            release_title,
> +            True,
> +        )
> --=20
> 2.34.1
>=20

>=20
>=20
>=20


--=20
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#15490): https://lists.openembedded.org/g/bitbake-devel/=
message/15490
Mute This Topic: https://lists.openembedded.org/mt/102496102/7896845
Group Owner: bitbake-devel+owner@lists.openembedded.org
Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alassane=
.yattara@savoirfairelinux.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

